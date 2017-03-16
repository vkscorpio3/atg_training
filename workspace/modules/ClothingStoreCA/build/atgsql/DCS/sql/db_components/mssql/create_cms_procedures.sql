


create procedure pr_dcs_sku_sites
(@commit_size int
,@generate_invalid_cache_ids int)
as
BEGIN
  SET NOCOUNT ON
  declare @commit_size_local integer = @commit_size
  if @generate_invalid_cache_ids=1
  begin
    BEGIN TRANSACTION
    insert into dcs_invalidated_sku_ids (sku_id) select distinct sku_id from (
     (select distinct prdsku.sku_id, prdsites.site_id
      from dcs_prd_chldsku prdSku,
      dcs_product_sites prdsites
      where prdsku.product_id = prdsites.product_id
      except
      select sku_id, site_id from dcs_sku_sites)
    UNION
    (select sku_id, site_id from dcs_sku_sites
    except 
    select distinct prdsku.sku_id, prdsites.site_id
    from dcs_prd_chldsku prdSku, 
    dcs_product_sites prdsites
    where prdsku.product_id = prdsites.product_id)
   ) sub where sku_id not in (select sku_id from dcs_invalidated_sku_ids)
     COMMIT TRANSACTION
  end

  truncate table dcs_sku_sites;

  declare @currentSkuId varchar(40)
  declare @currentSiteId varchar(40)
  declare @commit_count int = 0
  declare skuSitesCursor cursor for select distinct prdsku.sku_id, prdsites.site_id
      from dcs_prd_chldsku prdSku,
           dcs_product_sites prdsites
      where prdsku.product_id = prdsites.product_id

  BEGIN TRANSACTION
  open skuSitesCursor
  fetch skuSitesCursor into @currentSkuId, @currentSiteId
  
  while @@FETCH_STATUS=0
  begin
    insert into dcs_sku_sites (sku_id,site_id) values (@currentSkuId, @currentSiteId)
    if @commit_count >= @commit_size_local
    begin
      COMMIT TRANSACTION
      BEGIN TRANSACTION
      set @commit_count = 0;
    end
    else
    begin
      set @commit_count = @commit_count + 1
    end
  fetch skuSitesCursor into @currentSkuId, @currentSiteId
  end
  COMMIT TRANSACTION
  close skuSitesCursor
  deallocate skuSitesCursor
END

go

create procedure pr_dcs_prd_prnt_cats
(@include_dynamic_children_num int
,@commit_size int
,@generate_invalid_asset_ids int)
as
BEGIN
  SET NOCOUNT ON
  declare @commit_size_local integer = @commit_size
  declare @prev_product_id varchar(40)
  declare @prev_catalog_id varchar(40)
  declare @prev_category_id varchar(40)
  declare @prev_existing_category_id varchar(40)
  declare @check_category_id varchar(40)
  declare @max_category_id varchar(40)
  declare @is_valid_category bit = 0;
  declare @records_were_returned bit = 0;
  declare @commit_count int = 0;
  declare @catalog_id_array table(catalog_id varchar(40));
  declare @category_id_array table(category_id varchar(40));
  declare @product_id_array table(product_id varchar(40));
  declare @existing_category_id_array table(existing_category_id varchar(40));
  declare @currentCatalogId varchar(40)
  declare @currentCategoryId varchar(40)
  declare @currentProductId varchar(40)
  declare @currentExistingCategoryId varchar(40);
  declare @prdPrntCatsCursor cursor;
  declare @invalidIdCount int;
  if @include_dynamic_children_num=1
  begin
    set @prdPrntCatsCursor=cursor for select a.catalog_id,
           a.category_id,
           a.product_id,
           catValidPrntCategory.category_id as existing_category_id
    from (
      (select catCatalogs.catalog_id as catalog_id,
              catChldPrd.category_id as category_id,
              catChldPrd.child_prd_id as product_id
       from dcs_cat_chldprd catChldPrd
       join dcs_cat_catalogs catCatalogs
       on catChldPrd.category_id = catCatalogs.category_id
       union
       select catCatalogs1.catalog_id, catDynPrd.category_id, catDynPrd.product_id as product_id
        from dcs_cat_dynprd catDynPrd,
             dcs_cat_catalogs catCatalogs1
        where catDynPrd.category_id = catCatalogs1.category_id
      ) a
      left outer join dcs_prd_prnt_cats catValidPrntCategory
      on catValidPrntCategory.catalog_id = a.catalog_id
      and catValidPrntCategory.product_id = a.product_id)
      order by a.product_id, a.catalog_id
  end
  else
  begin
    set @prdPrntCatsCursor = cursor for select a.catalog_id,
         a.category_id,
         a.product_id,
         catValidPrntCategory.category_id as existing_category_id
     from (
      (select catCatalogs.catalog_id as catalog_id,
            catChldPrd.category_id as category_id,
            catChldPrd.child_prd_id as product_id
       from dcs_cat_chldprd catChldPrd
       join dcs_cat_catalogs catCatalogs
       on catChldPrd.category_id = catCatalogs.category_id
      ) a
      left outer join dcs_prd_prnt_cats catValidPrntCategory
      on catValidPrntCategory.catalog_id = a.catalog_id
      and catValidPrntCategory.product_id = a.product_id)
      order by a.product_id, a.catalog_id
  end
  BEGIN TRANSACTION
  open @prdPrntCatsCursor
  fetch @prdPrntCatsCursor into @currentCatalogId, @currentCategoryId, @currentProductId, @currentExistingCategoryId
  while @@FETCH_STATUS=0
  begin
     if (@prev_product_id is not null) and ((@currentProductId <> @prev_product_id) or (@currentCatalogId <> @prev_catalog_id))
     begin
        -- The existing category will be the same across a group of catalog/product. Was there a line
        -- in the group where 'existing category id' matched 'category id'? If there was then we know
        -- the existing line is valid. If there wasn't then we'll need to add a row if it was missing
        -- or update a row if it existed but didn't have an acceptable category.
        set @is_valid_category = 0
        declare @matching_category_id varchar(40)
        select @matching_category_id = max(category_id) from @category_id_array,@existing_category_id_array where category_id=existing_category_id
        if @matching_category_id is not null
        begin
          set @is_valid_category=1
        end

        -- Did the product/catalog combination exist at all in the target table?
        -- If it didn't, we add a row. If it did we update the row.
        if @is_valid_category=0
        begin
          declare @existing_category_id_count int;
          select @existing_category_id_count = count(*) from @existing_category_id_array
          if @existing_category_id_count=0
          begin
            insert into dcs_prd_prnt_cats (catalog_id, category_id, product_id)
              values (@prev_catalog_id, @max_category_id, @prev_product_id);
            set @commit_count = @commit_count + 1;
          end
          else
          begin  
            -- update based on max category
            update dcs_prd_prnt_cats
              SET category_id = @max_category_id
              WHERE catalog_id = @prev_catalog_id
              AND product_id = @prev_product_id;
            set @commit_count = @commit_count + 1;
          end
          if @generate_invalid_asset_ids = 1
          begin
            select @invalidIdCount = count(*) from dcs_invalidated_prd_ids where product_id = @prev_product_id;
             if (@invalidIdCount =0 )
             begin
               insert into dcs_invalidated_prd_ids (product_id) values (@prev_product_id);
             end
          end
        end

        -- clear the arrays, reset max category
        set @max_category_id = null;
        delete from @catalog_id_array
        delete from @category_id_array
        delete from @product_id_array
        delete from @existing_category_id_array
    end

    set @records_were_returned = 1;
    
    -- Store the values from the current row.
    insert into @catalog_id_array values (@currentCatalogId)
    insert into @category_id_array values (@currentCategoryId)
    insert into @product_id_array values (@currentProductId)

    if @currentExistingCategoryId is not null
    begin
      insert into @existing_category_id_array values (@currentExistingCategoryId)
    end

    set @prev_catalog_id = @currentCatalogId
    set @prev_product_id = @currentProductId

    if (@max_category_id is null) or (@currentCategoryId > @max_category_id)
    begin
      set @max_category_id = @currentCategoryId
    end

    if (@commit_count %@commit_size_local)=0
    begin
      COMMIT TRANSACTION
      BEGIN TRANSACTION
      set @commit_count = 0
    end
    fetch @prdPrntCatsCursor into @currentCatalogId, @currentCategoryId, @currentProductId, @currentExistingCategoryId;
  end

  -- Deal with the final record:
  -- The existing category will be the same across a group. Was there a line
  -- in the group where 'existing category' matched 'category'?
  set @is_valid_category = 0;
  select @matching_category_id = max(category_id) from @category_id_array,@existing_category_id_array where category_id=existing_category_id
  if @matching_category_id is not null
  begin
    set @is_valid_category=1
  end

  if (@is_valid_category=0) and (@records_were_returned=1)
  begin
    select @existing_category_id_count = count(*) from @existing_category_id_array
    if (@existing_category_id_count=0)
    begin
      insert into dcs_prd_prnt_cats (catalog_id, category_id, product_id)
        values (@prev_catalog_id, @max_category_id, @prev_product_id);
    end
    else
    begin
      update dcs_prd_prnt_cats
        SET category_id = @max_category_id
        WHERE catalog_id = @prev_catalog_id
        AND product_id = @prev_product_id
    end
    if @generate_invalid_asset_ids = 1
    begin
      select @invalidIdCount = count(*) from dcs_invalidated_prd_ids where product_id = @prev_product_id;
      if (@invalidIdCount =0 )
      begin
        insert into dcs_invalidated_prd_ids (product_id) values (@prev_product_id);
      end
    end
  end
  COMMIT TRANSACTION
  BEGIN TRANSACTION
-- We need to do two more things - store the ids of any assets which are no longer needed in the CMS table,
-- and delete those assets from the table.
-- So we left outer join the CMS table to the current results from the main CMS query. This means the
-- CMS table contents will appear whether there was a match in the query results or not. We know that
-- any time the results are null on the source query side, we can remove that row.
-- We further join the CMS table to the invalid assets table, this time including all the results in the asset table
-- whether there was a match or not
-- We know that if we have decided to delete a row from the CMS table (see above) and there was no entry for that
-- asset in the invalid assets table, we should add the asset id.
declare @targetCatalogId varchar(40)
declare @targetCategoryId varchar(40)
declare @targetProductId varchar(40)
declare @sourceCatalogId varchar(40)
declare @sourceCategoryId varchar(40)
declare @sourceProductId varchar(40)
declare @assetId varchar(40)

declare @removeAssetsCursor cursor
set @removeassetscursor = cursor for (select target_table.catalog_id as targetcatalogid, target_table.category_id as targetcategoryid, target_table.product_id as targetproductid,
                 source_query.catalog_id as sourcecatalogid, source_query.category_id as sourcecategoryid, source_query.product_id as sourceproductid
                 from (
(select catalog_id,category_id,product_id from dcs_prd_prnt_cats) target_table
left outer join
(select catcatalogs.catalog_id as catalog_id,
      catchldprd.category_id as category_id,
      catchldprd.child_prd_id as product_id
  from dcs_cat_chldprd catchldprd
  join dcs_cat_catalogs catcatalogs
  on catchldprd.category_id = catcatalogs.category_id) source_query
on target_table.catalog_id = source_query.catalog_id and
   target_table.category_id = source_query.category_id and
   target_table.product_id = source_query.product_id))
open @removeassetscursor
fetch @removeassetscursor into @targetcatalogid, @targetcategoryid, @targetproductid, @sourcecatalogid, @sourcecategoryid, @sourceproductid
while @@fetch_status=0
begin
  if @sourceproductid is null
  begin
    delete from dcs_prd_prnt_cats where product_id=@targetproductid and
                                           catalog_id=@targetcatalogid and
                                           category_id=@targetcategoryid;

    if @generate_invalid_asset_ids =1 
	begin
	  insert into dcs_invalidated_prd_ids (product_id) select @targetproductid where not exists 
	              (select product_id from dcs_invalidated_prd_ids where product_id = @targetProductId)
	end
  end
  
  fetch @removeassetscursor into @targetcatalogid, @targetcategoryid, @targetproductid, @sourcecatalogid, @sourcecategoryid, @sourceproductid
end;


  COMMIT TRANSACTION
close @prdPrntCatsCursor
deallocate @prdPrntCatsCursor
close @removeAssetsCursor
deallocate @removeAssetsCursor
end 

go

create procedure pr_dcs_prd_anc_cats
(@include_dynamic_children_num int
,@commit_size int
,@gen_invalid_cache_ids int)
as
BEGIN  
  SET NOCOUNT ON
  declare @commit_size_local integer = @commit_size
  declare @curr_product_id varchar(40)
  declare @prev_product_id varchar(40) = '%%FIRST LOOP%%'
  declare @currentCategoryId varchar(40)
  declare @currentProductId varchar(40)
  declare @sequence_no int = 0
  declare @commit_count int= 0
  declare @mainSelect varchar(2000)
  declare @genInvalidCacheIdsQuery varchar(2500);

  if @include_dynamic_children_num=1
  begin
    set @mainSelect = 'select distinct subQuery.category_id, subQuery.product_id from (select catAncCats.anc_category_id as category_id, 0 as sequence_num, catChldPrd1.child_prd_id as product_id
        from dcs_cat_anc_cats  catAncCats, 
        dcs_cat_chldprd   catChldPrd1 
        where catAncCats.category_id = catChldPrd1.category_id 
        union 
        select catChldPrd2.category_id as category_id, 0 as sequence_num, catChldPrd2.child_prd_id as product_id
        from dcs_cat_chldprd catChldPrd2
        union
        select catAncCats1.anc_category_id as category_id, 0 as sequence_num, catDynPrd.product_id as product_id
        from dcs_cat_anc_cats  catAncCats1, 
        dcs_cat_dynprd   catDynPrd 
        where catAncCats1.category_id = catDynPrd.category_id
        union 
        select catDynPrd1.category_id as category_id, 0 as sequence_num, catDynPrd1.product_id as product_id
        from dcs_cat_dynprd catDynPrd1) subQuery'
  end
  else
  begin
    set @mainSelect = 'select distinct subQuery.category_id, subQuery.product_id from (select catAncCats.anc_category_id as category_id, 0 as sequence_num, catChldPrd1.child_prd_id as product_id
        from dcs_cat_anc_cats  catAncCats, 
        dcs_cat_chldprd   catChldPrd1 
        where catAncCats.category_id = catChldPrd1.category_id 
        union 
        select catChldPrd2.category_id as category_id, 0 as sequence_num, catChldPrd2.child_prd_id as product_id
        from dcs_cat_chldprd catChldPrd2) subQuery'
  end

    if (@gen_invalid_cache_ids = 1)
    begin
      set @genInvalidCacheIdsQuery = 'insert into dcs_invalidated_prd_ids (product_id) select distinct product_id from (
(((' + @mainSelect + ')) except
(select category_id,product_id from dcs_prd_anc_cats))
union
((select category_id, product_id from dcs_prd_anc_cats)
except
(' + @mainSelect + '))
) invalid where product_id not in (select product_id from dcs_invalidated_prd_ids)'     
     exec(@genInvalidCacheIdsQuery);
    end

  truncate table dcs_prd_anc_cats

  -- Ordering wasn't useful in computing invalid cache assets but it is required when considered with sequencing
  -- so add in an order by clause
  set @mainSelect = @mainSelect + ' order by product_id asc'

  declare @cursorStatement nvarchar(2000)
  set @cursorStatement = 'declare prdAncCatsCursor cursor for '+@mainSelect
  exec sp_executesql @cursorStatement

  open prdAncCatsCursor
  fetch next from prdAncCatsCursor into @currentCategoryId, @currentProductId
  begin transaction -- begin transaction here
  while @@FETCH_STATUS = 0
  begin
    set @curr_product_id = @currentProductId;
    if @curr_product_id <> @prev_product_id
    begin
      set @sequence_no = 0
    end
    else 
    begin
      set @sequence_no = @sequence_no + 1
    end

    insert into dcs_prd_anc_cats (category_id, sequence_num, product_id)
      values (@currentCategoryId, @sequence_no, @currentProductId);

    if @commit_count >= @commit_size_local
    begin
      COMMIT TRANSACTION
      BEGIN TRANSACTION
      set @commit_count = 0
    end
    else
    begin
      set @commit_count = @commit_count + 1
    end
    set @prev_product_id = @curr_product_id
    fetch next from prdAncCatsCursor into @currentCategoryId, @currentProductId
  end
  COMMIT TRANSACTION
  close prdAncCatsCursor
  deallocate prdAncCatsCursor
end

go

create procedure pr_dcs_product_sites
(@include_dynamic_children_num int
,@commit_size int
,@generate_invalid_cache_ids int)
as
BEGIN  
SET NOCOUNT ON
declare @commit_size_local integer = @commit_size
declare @commit_count int=0
declare @currentProductId varchar(40)
declare @currentSiteId varchar(40)
declare @mainSelect varchar(2000)
declare @genInvalidAssetIdsQuery varchar(2000)


if @include_dynamic_children_num=1
begin
  set @mainSelect = 'select subQuery.product_id, subQuery.site_id from
  (select catprd.child_prd_id  product_id,
      catsites.site_id site_id
  from dcs_cat_chldprd catprd,
       dcs_category_sites catsites
   where  catprd.category_id = catsites.category_id
  union
  select dynprd.product_id product_id,
         catsites1.site_id site_id
  from dcs_cat_dynprd dynprd,
       dcs_category_sites catsites1
  where dynprd.category_id = catsites1.category_id) subQuery'
end
else
begin
  set @mainSelect = 'select distinct subQuery.product_id, subQuery.site_id from (select catprd.child_prd_id product_id,
        catsites.site_id site_id
    from dcs_cat_chldprd catprd,
         dcs_category_sites catsites
    where catprd.category_id = catsites.category_id) subQuery'
end

  if (@generate_invalid_cache_ids = 1)
  begin
    set @genInvalidAssetIdsQuery = 'insert into dcs_invalidated_prd_ids select distinct product_id from (
((' + @mainSelect + ')
except
select product_id,site_id from dcs_product_sites)
UNION
(select product_id,site_id from dcs_product_sites
except
' + @mainSelect + ')
) invalids where product_id not in (select product_id from dcs_invalidated_prd_ids)';
  exec(@genInvalidAssetIdsQuery);
  end;


  BEGIN TRANSACTION

truncate table dcs_product_sites

declare @cursorStatement nvarchar(2000)
set @cursorStatement = 'declare prdSitesCursor cursor for ' + @mainSelect
exec sp_executesql @cursorStatement

open prdSitesCursor;
fetch prdSitesCursor into @currentProductId, @currentSiteId

while @@FETCH_STATUS=0
begin        
  insert into dcs_product_sites (product_id,site_id) values (@currentProductId, @currentSiteId);
  if @commit_count >= @commit_size_local
  begin
    COMMIT TRANSACTION;
    BEGIN TRANSACTION
    set @commit_count = 0;
  end
  else
  begin
    set @commit_count = @commit_count + 1
  end
  fetch prdSitesCursor into @currentProductId, @currentSiteId
end
   COMMIT TRANSACTION;  
close prdSitesCursor
deallocate prdSitesCursor
END

go

create procedure pr_dcs_prd_catalogs
(@include_dynamic_children_num int
,@commit_size int
,@generate_invalid_asset_ids int)
as
BEGIN
SET NOCOUNT ON
declare @commit_size_local integer = @commit_size
declare @commit_count int = 0
declare @currentProductId varchar(40)
declare @currentCatalogId varchar(40)
declare @mainSelect varchar(2000)
declare @genInvalidCacheIdsQuery varchar(2000)

if @include_dynamic_children_num=1
begin
  set @mainSelect = 'select catChldPrd.child_prd_id as product_id, catCatalogs.catalog_id as catalog_id
from dcs_cat_catalogs catCatalogs, 
         dcs_cat_chldprd catChldPrd 
    where catCatalogs.category_id = catChldPrd.category_id
    union
    select catDynPrd.product_id as product_id, catCatalogs1.catalog_id
from dcs_cat_catalogs catCatalogs1, 
           dcs_cat_dynprd catDynPrd 
      where catCatalogs1.category_id = catDynPrd.category_id'
end
else
begin
  set @mainSelect = 'select distinct catChldPrd.child_prd_id as product_id, catCatalogs.catalog_id as catalog_id
from dcs_cat_catalogs catCatalogs, 
         dcs_cat_chldprd catChldPrd 
    where catCatalogs.category_id = catChldPrd.category_id'
end;

if (@generate_invalid_asset_ids = 1)
begin
  set @genInvalidCacheIdsQuery = 'insert into dcs_invalidated_prd_ids select distinct product_id from (
((' + @mainSelect + ')
except
(select product_id, catalog_id from dcs_prd_catalogs))
union
((select product_id, catalog_id from dcs_prd_catalogs)
except
(' + @mainSelect + '))
) invalids where product_id not in (select product_id from dcs_invalidated_prd_ids)';
 exec(@genInvalidCacheIdsQuery);
end

truncate table dcs_prd_catalogs

declare @cursorStatement nvarchar(2000);
set @cursorStatement = 'declare prdCatalogsCursor cursor for ' + @mainSelect
exec sp_executesql @cursorStatement

  BEGIN TRANSACTION

open prdCatalogsCursor
fetch next from prdCatalogsCursor into @currentProductId, @currentCatalogId

while @@fetch_status = 0    
begin       
  insert into dcs_prd_catalogs (product_id, catalog_id) values (@currentProductId, @currentCatalogId);
  if @commit_count >= @commit_size_local
  begin
    COMMIT TRANSACTION
    BEGIN TRANSACTION
    set @commit_count=0;
  end      
  else
  begin
    set @commit_count = @commit_count + 1;
  end
  fetch next from prdCatalogsCursor into @currentProductId, @currentCatalogId      
end
  COMMIT TRANSACTION
close prdCatalogsCursor
deallocate prdCatalogsCursor
END

go

create procedure pr_dcs_sku_catalogs
(@commit_size int
,@generate_invalid_asset_ids int)
as
BEGIN
SET NOCOUNT ON
declare @commit_size_local integer = @commit_size
if (@generate_invalid_asset_ids=1)
begin
  BEGIN TRANSACTION
  insert into dcs_invalidated_sku_ids (sku_id) select distinct sku_id from (
(select distinct prdCat.catalog_id, prdChldSku.sku_id
  from dcs_prd_catalogs prdCat,
       dcs_prd_chldsku prdChldSku
  where prdCat.product_id = prdChldSku.product_id
 except
select catalog_id, sku_id from dcs_sku_catalogs)
UNION
(select catalog_id, sku_id from dcs_sku_catalogs
except
select distinct prdCat.catalog_id, prdChldSku.sku_id
  from dcs_prd_catalogs prdCat,
       dcs_prd_chldsku prdChldSku
  where prdCat.product_id = prdChldSku.product_id)
) sub where sku_id not in (select sku_id from dcs_invalidated_sku_ids);
  COMMIT TRANSACTION
end

truncate table dcs_sku_catalogs

DECLARE @commit_count int = 0
DECLARE @currentSkuId varchar(40)
DECLARE @currentCatalogId varchar(40)
  BEGIN TRANSACTION
declare skuCatalogsCursor cursor for select distinct prdChldSku.sku_id, prdCat.catalog_id
  from dcs_prd_catalogs prdCat, 
       dcs_prd_chldsku prdChldSku 
  where prdCat.product_id = prdChldSku.product_id

open skuCatalogsCursor
fetch skuCatalogsCursor into @currentSkuId, @currentCatalogId

while @@FETCH_STATUS = 0
begin  
  insert into dcs_sku_catalogs (sku_id,catalog_id) values (@currentSkuId, @currentCatalogId)

  if @commit_count >= @commit_size_local 
  begin
    COMMIT TRANSACTION;
    BEGIN TRANSACTION
    set @commit_count = 0;
  end
  else
  begin
    set @commit_count = @commit_count + 1
  end
  fetch skuCatalogsCursor into @currentSkuId, @currentCatalogId
end
   COMMIT TRANSACTION;  
close skuCatalogsCursor
deallocate skuCatalogsCursor   
end

go


