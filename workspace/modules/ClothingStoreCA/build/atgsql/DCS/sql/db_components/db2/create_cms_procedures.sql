


create procedure pr_dcs_sku_sites
(v_cmt_size integer
,v_generate_invalid_asset_ids integer)
BEGIN
  declare v_cmt_count integer default 0;
  declare SQLCODE integer default 0;
  declare v_skuId varchar(40);
  declare v_siteId varchar(40);
  declare v_cursor cursor with hold for select distinct prdsku.sku_id as my_sku_id, prdsites.site_id as my_site_id from dcs_prd_chldsku prdSku, dcs_product_sites prdsites where prdsku.product_id = prdsites.product_id;
  if v_generate_invalid_asset_ids=1 then
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
   ) sub where sku_id not in (select sku_id from dcs_invalidated_sku_ids);
  end if;
  COMMIT;
  truncate table dcs_sku_sites immediate;
  open v_cursor;
  fetch v_cursor into v_skuId, v_siteId;
  while (SQLCODE=0)
  do
    insert into dcs_sku_sites values (v_skuId, v_siteId);
    if v_cmt_count >= v_cmt_size then
      COMMIT;
      set v_cmt_count = 0;
    else
      set v_cmt_count = v_cmt_count + 1;
    end if;
    fetch v_cursor into v_skuId, v_siteId;
 END while;
END

@


create or replace type SimpleStringArray as varchar(40) array[];

create procedure pr_dcs_prd_prnt_cats
(v_include_dynamic_children_num integer
,v_cmt_size integer
,v_generate_invalid_asset_ids integer)
BEGIN
  declare v_prev_product_id varchar(40);
  declare v_prev_catalog_id varchar(40);
  declare v_prev_category_id varchar(40);
  declare v_prev_existing_category_id varchar(40);
  declare v_check_category_id varchar(40);
  declare v_max_category_id varchar(40);
  declare v_is_valid_category boolean default false;
  declare v_records_were_returned boolean default false;
  declare v_cmt_count integer default 0;
  declare SQLCODE integer default 0;
  declare v_matching_category_id varchar(40);  
  declare v_existing_category_id_count integer default 0;
  declare v_currentCatalogId varchar(40);
  declare v_currentCategoryId varchar(40);
  declare v_currentProductId varchar(40);
  declare v_currentExistingCategoryId varchar(40);
  declare v_prdPrntCatsCursor cursor;
  declare v_invalidIdCount integer default 0;
  declare v_targetCatalogId varchar(40);  
  declare v_targetCategoryId varchar(40);
  declare v_targetProductId varchar(40);
  declare v_sourceCatalogId varchar(40);
  declare v_sourceCategoryId varchar(40);
  declare v_sourceProductId varchar(40);
  declare v_assetId varchar(40);
  declare v_removeAssetsCursor cursor;
  declare v_catalog_id_array SimpleStringArray;
  declare v_category_id_array SimpleStringArray;
  declare v_product_id_array SimpleStringArray;
  declare v_existing_category_id_array SimpleStringArray;
  declare v_cardinalityCount integer default 0;
  declare v_mainSelect varchar(2000);
  if v_include_dynamic_children_num=1
  then
    set v_mainSelect = 'select a.catalog_id,
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
      order by a.product_id, a.catalog_id';
  else
    set v_mainSelect = 'select a.catalog_id,
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
      order by a.product_id, a.catalog_id';
  end if;
  prepare s1 from v_mainSelect;
  set v_prdPrntCatsCursor = cursor with hold for s1;
  open v_prdPrntCatsCursor;
  fetch v_prdPrntCatsCursor into v_currentCatalogId, v_currentCategoryId, v_currentProductId, v_currentExistingCategoryId;
  while SQLCODE=0
  do
    if (v_prev_product_id is not null) and ((v_currentProductId <> v_prev_product_id) or (v_currentCatalogId <> v_prev_catalog_id))
    then
      -- The existing category will be the same across a group of catalog/product. Was there a line
      -- in the group where 'existing category id' matched 'category id'? If there was then we know
      -- the existing line is valid. If there wasn't then we'll need to add a row if it was missing
      -- or update a row if it existed but didn't have an acceptable category.
      set v_is_valid_category = false;        
      set (v_matching_category_id) = (select max(a.category_id) from UNNEST(v_category_id_array,v_existing_category_id_array) as A(category_id,existing_category_id) where A.category_id=A.existing_category_id);
      -- Did the product/catalog combination exist at all in the target table?
      -- If it didn't, we add a row. If it did we update the row.
      if v_matching_category_id is null
      then
        set (v_existing_category_id_count) = (select count(*) from UNNEST(v_existing_category_id_array) as A(existing_category_id) where A.existing_category_id is not null);
        if v_existing_category_id_count=0
        then
         insert into dcs_prd_prnt_cats (catalog_id, category_id, product_id)
            values (v_prev_catalog_id, v_max_category_id, v_prev_product_id);
          set v_cmt_count = v_cmt_count + 1;
        else
          --update based on max category
          update dcs_prd_prnt_cats
            SET category_id = v_max_category_id
            WHERE catalog_id = v_prev_catalog_id
            AND product_id = v_prev_product_id;
          set v_cmt_count = v_cmt_count + 1;
        end if;
        if v_generate_invalid_asset_ids = 1
        then
          set (v_invalidIdCount) = (select count(*) from dcs_invalidated_prd_ids where product_id = v_prev_product_id);
          if (v_invalidIdCount = 0)
          then
            insert into dcs_invalidated_prd_ids (product_id) values (v_prev_product_id);
          end if;
        end if;
      end if;
      -- clear the arrays, reset max category
      set v_max_category_id = null;
      set v_catalog_id_array = ARRAY_DELETE(v_catalog_id_array);
      set v_category_id_array = ARRAY_DELETE(v_category_id_array);
      set v_product_id_array = ARRAY_DELETE(v_product_id_array);
      set v_existing_category_id_array = ARRAY_DELETE(v_existing_category_id_array);
    end if;
    set v_records_were_returned = true;
    -- Store the values from the current row.
    set v_cardinalityCount = CARDINALITY(v_existing_category_id_array);
    if (v_cardinalityCount is null)
    then 
      set v_cardinalityCount = 0;
    end if;
    set v_existing_category_id_array[v_cardinalityCount+1]=v_currentExistingCategoryId;    
    set v_cardinalityCount = CARDINALITY(v_catalog_id_array);
    if (v_cardinalityCount is null)
    then
       set v_cardinalityCount = 0;
    end if;    
    set v_catalog_id_array[v_cardinalityCount+1]=v_currentCatalogId;
    set v_cardinalityCount = CARDINALITY(v_category_id_array);
    if (v_cardinalityCount is null)
    then
       set v_cardinalityCount = 0;
    end if;    
    set v_category_id_array[v_cardinalityCount+1]=v_currentCategoryId;
    set v_cardinalityCount = CARDINALITY(v_product_id_array);
    if (v_cardinalityCount is null)
    then
      set v_cardinalityCount = 0;
    end if;    
    set v_product_id_array[v_cardinalityCount+1]=v_currentProductId;   
    set v_prev_catalog_id = v_currentCatalogId;
    set v_prev_product_id = v_currentProductId;
    if (v_max_category_id is null) or (v_currentCategoryId > v_max_category_id)
    then
      set v_max_category_id = v_currentCategoryId;
    end if;
    if (v_cmt_count >= v_cmt_size)
    then
      COMMIT;    
      set v_cmt_count = 0;
    end if;    
    fetch v_prdPrntCatsCursor into v_currentCatalogId, v_currentCategoryId, v_currentProductId, v_currentExistingCategoryId;        
  end while;
  -- Deal with the final record:
  -- The existing category will be the same across a group. Was there a line
  -- in the group where 'existing category' matched 'category'?
  set (v_matching_category_id) = (select max(A.category_id) from UNNEST(v_category_id_array,v_existing_category_id_array) as A(category_id,existing_category_id) where A.category_id=A.existing_category_id);
  if (v_matching_category_id is null) and (v_records_were_returned=true)
  then    
    set (v_existing_category_id_count) = (select count(*) from UNNEST(v_existing_category_id_array) as A(category_id) where A.category_id is not null);
    if (v_existing_category_id_count=0)
    then      
      insert into dcs_prd_prnt_cats (catalog_id, category_id, product_id)
        values (v_prev_catalog_id, v_max_category_id, v_prev_product_id);    
    else
      update dcs_prd_prnt_cats
        SET category_id = v_max_category_id
        WHERE catalog_id = v_prev_catalog_id
        AND product_id = v_prev_product_id;
    end if;
    if v_generate_invalid_asset_ids = 1
    then
      set v_invalidIdCount = (select count(*) from dcs_invalidated_prd_ids where product_id = v_prev_product_id);
      if (v_invalidIdCount = 0)
      then
        insert into dcs_invalidated_prd_ids (product_id) values (v_prev_product_id);
      end if;
    end if;
  end if;
  COMMIT;
  -- We need to do two more things - store the ids of any assets which are no longer needed in the CMS table,
  -- and delete those assets from the table.
  -- So we left outer join the CMS table to the current results from the main CMS query. This means the
  -- CMS table contents will appear whether there was a match in the query results or not. We know that
  -- any time the results are null on the source query side, we can remove that row.
  -- We further join the CMS table to the invalid assets table, this time including all the results in the asset table
  -- whether there was a match or not
  -- We know that if we have decided to delete a row from the CMS table (see above) and there was no entry for that
  -- asset in the invalid assets table, we should add the asset id.
  set v_removeAssetsCursor = cursor with hold for (select TARGET_TABLE.catalog_id as targetCatalogId, TARGET_TABLE.category_id as targetCategoryId, TARGET_TABLE.product_id as targetProductId,
               SOURCE_QUERY.catalog_id as sourceCatalogId, SOURCE_QUERY.category_id as sourceCategoryId, SOURCE_QUERY.product_id as sourceProductId
               from (
  (select catalog_id,category_id,product_id from dcs_prd_prnt_cats) TARGET_TABLE
  left outer join
  (select catCatalogs.catalog_id as catalog_id,
    catChldPrd.category_id as category_id,
    catChldPrd.child_prd_id as product_id
  from dcs_cat_chldprd catChldPrd
  join dcs_cat_catalogs catCatalogs
  on catChldPrd.category_id = catCatalogs.category_id) SOURCE_QUERY
  on TARGET_TABLE.catalog_id = SOURCE_QUERY.catalog_id and
     TARGET_TABLE.category_id = SOURCE_QUERY.category_id and
     TARGET_TABLE.product_id = SOURCE_QUERY.product_id));
  open v_removeAssetsCursor;
  fetch v_removeAssetsCursor into v_targetCatalogId, v_targetCategoryId, v_targetProductId, v_sourceCatalogId, v_sourceCategoryId, v_sourceProductId;
  while SQLCODE=0
  do
    if v_sourceProductId is null 
    then
      delete from dcs_prd_prnt_cats WHERE product_id=v_targetProductId AND
                                          catalog_id=v_targetCatalogId AND
                                          category_id=v_targetCategoryId;
      if v_generate_invalid_asset_ids = 1
      then
        merge into dcs_invalidated_prd_ids invalid_id_table
        using (
          select v_targetProductId as id_to_insert
          from SYSIBM.SYSDUMMY1
        ) t on (invalid_id_table.product_id = t.id_to_insert) 
        when not matched then
        insert (invalid_id_table.product_id)
        values (t.id_to_insert);
      end if;
    end if;
    fetch v_removeAssetsCursor into v_targetCatalogId, v_targetCategoryId, v_targetProductId, v_sourceCatalogId, v_sourceCategoryId, v_sourceProductId;
  end while;
  COMMIT;
end

@

create procedure pr_dcs_prd_anc_cats
(v_include_dynamic_children_num integer
,v_cmt_size integer
,v_gen_invalid_cache_ids integer)
BEGIN  
  declare v_curr_product_id varchar(40);
  declare v_prev_product_id varchar(40) default '%%FIRST LOOP%%';
  declare v_currentCategoryId varchar(40);
  declare v_currentProductId varchar(40);
  declare v_sequence_no integer default 0;
  declare v_cmt_count integer default 0;
  declare v_mainSelect varchar(2000);
  declare v_genInvalidCacheIdsQuery varchar(2500);
  declare v_prdAncCatsCursor cursor;
  declare SQLCODE integer default 0;
  if v_include_dynamic_children_num=1
  then
    set v_mainSelect = 'select distinct subQuery.category_id, subQuery.product_id from (select catAncCats.anc_category_id as category_id, 0 as sequence_num, catChldPrd1.child_prd_id as product_id
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
        from dcs_cat_dynprd catDynPrd1) subQuery';
  else
    set v_mainSelect = 'select distinct subQuery.category_id, subQuery.product_id from (select catAncCats.anc_category_id as category_id, 0 as sequence_num, catChldPrd1.child_prd_id as product_id
        from dcs_cat_anc_cats  catAncCats, 
        dcs_cat_chldprd   catChldPrd1 
        where catAncCats.category_id = catChldPrd1.category_id 
        union 
        select catChldPrd2.category_id as category_id, 0 as sequence_num, catChldPrd2.child_prd_id as product_id
        from dcs_cat_chldprd catChldPrd2) subQuery';
  end if;
    if (v_gen_invalid_cache_ids = 1)
    then
      set v_genInvalidCacheIdsQuery = 'insert into dcs_invalidated_prd_ids (product_id) select distinct product_id from (
(((' || V_mainSelect ||' except
(select category_id,product_id from dcs_prd_anc_cats))
union
((select category_id, product_id from dcs_prd_anc_cats)
except
(' || v_mainSelect || '))))
) invalid where product_id not in (select product_id from dcs_invalidated_prd_ids)';
       prepare s1 from v_genInvalidCacheIdsQuery;
       execute s1;
    end if;
  COMMIT;  
  truncate table dcs_prd_anc_cats immediate;
  -- Ordering wasn't useful in computing invalid cache assets but it is required when considered with sequencing
  -- so add in an order by clause
  set v_mainSelect = v_mainSelect || ' order by product_id asc'; 
  prepare s2 from v_mainSelect;
  set v_prdAncCatsCursor = cursor with hold for s2;
  open v_prdAncCatsCursor;
  fetch v_prdAncCatsCursor into v_currentCategoryId, v_currentProductId;
  while (SQLCODE = 0)
  do
    set v_curr_product_id = v_currentProductId;
    if v_curr_product_id <> v_prev_product_id
    then
      set v_sequence_no = 0;
    else 
      set v_sequence_no = v_sequence_no + 1;
    end if;
    insert into dcs_prd_anc_cats (category_id, sequence_num, product_id)
      values (v_currentCategoryId, v_sequence_no, v_currentProductId);
    if v_cmt_count >= v_cmt_size
    then
      COMMIT;
      set v_cmt_count = 0;    
    else
      set v_cmt_count = v_cmt_count + 1;
    end if;
    set v_prev_product_id = v_curr_product_id;
    fetch v_prdAncCatsCursor into v_currentCategoryId, v_currentProductId;
  end while;
  COMMIT;
end

@

create procedure pr_dcs_product_sites
(v_include_dynamic_children_num integer
,v_cmt_size integer
,v_generate_invalid_asset_ids integer)
BEGIN
declare SQLCODE integer default 0;
declare v_cmt_count integer default  0;
declare v_currentProductId varchar(40);
declare v_currentSiteId varchar(40);
declare v_mainSelect varchar(2000);
declare v_genInvalidAssetIdsQuery varchar(2000);
declare v_prdSitesCursor cursor;
-- 1 is considered to be true, any other number is considered to be false
if v_include_dynamic_children_num=1
then
  set v_mainSelect = 'select subQuery.product_id, subQuery.site_id from
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
  where dynprd.category_id = catsites1.category_id) subQuery';
else
  set v_mainSelect = 'select distinct subQuery.product_id, subQuery.site_id from (select catprd.child_prd_id product_id,
        catsites.site_id site_id
    from dcs_cat_chldprd catprd,
         dcs_category_sites catsites
    where catprd.category_id = catsites.category_id) subQuery';
end if;
if (v_generate_invalid_asset_ids = 1)
then
    set v_genInvalidAssetIdsQuery = 'insert into dcs_invalidated_prd_ids select distinct product_id from (
((' || v_mainSelect || ')
except
select product_id,site_id from dcs_product_sites)
UNION
(select product_id,site_id from dcs_product_sites
except
' || v_mainSelect || ')
) invalids where product_id not in (select product_id from dcs_invalidated_prd_ids)';
  prepare s1 from v_genInvalidAssetIdsQuery;
  execute s1;
end if;
  COMMIT;
  truncate table dcs_product_sites immediate;
  prepare s2 from v_mainSelect;
  set v_prdSitesCursor = cursor with hold for s2;
  open v_prdSitesCursor;
  fetch v_prdSitesCursor into v_currentProductId, v_currentSiteId;
  while (SQLCODE=0)
  do
   insert into dcs_product_sites (product_id,site_id) values (v_currentProductId, v_currentSiteId);
   if v_cmt_count >= v_cmt_size
   then
    COMMIT;
    set v_cmt_count = 0;
   else
    set v_cmt_count = v_cmt_count + 1;
   end if;
   fetch v_prdSitesCursor into v_currentProductId, v_currentSiteId;
   end while;
   COMMIT;
END

@

create procedure pr_dcs_prd_catalogs
(v_include_dynamic_children_num integer
,v_cmt_size integer
,v_generate_invalid_cache_ids integer)
begin
  declare v_cmt_count integer default 0;
  declare v_current_product_id varchar(40);
  declare v_current_catalog_id varchar(40);
  declare v_main_select varchar(2000);
  declare v_my_cursor cursor;
  declare v_genInvalidCacheIdsQuery varchar(2000);
  declare SQLCODE integer default 0;
  if v_include_dynamic_children_num=1
  then
    set v_main_select = 'select catChldPrd.child_prd_id as product_id, catCatalogs.catalog_id as catalog_id
      from dcs_cat_catalogs catCatalogs,
           dcs_cat_chldprd catChldPrd
      where catCatalogs.category_id = catChldPrd.category_id
      union
      select catDynPrd.product_id as product_id, catCatalogs1.catalog_id
      from dcs_cat_catalogs catCatalogs1,
           dcs_cat_dynprd catDynPrd
      where catCatalogs1.category_id = catDynPrd.category_id';
  else
    set v_main_select = 'select distinct catChldPrd.child_prd_id as product_id, catCatalogs.catalog_id as catalog_id
      from dcs_cat_catalogs catCatalogs,
           dcs_cat_chldprd catChldPrd
      where catCatalogs.category_id = catChldPrd.category_id';
  end if;
    if (v_generate_invalid_cache_ids = 1)
  then
    set v_genInvalidCacheIdsQuery = 'insert into dcs_invalidated_prd_ids select distinct product_id from (
((' || v_main_select || ')
except
(select product_id, catalog_id from dcs_prd_catalogs))
union
((select product_id, catalog_id from dcs_prd_catalogs)
except
(' || v_main_select || '))
) where product_id not in (select product_id from dcs_invalidated_prd_ids)';
    prepare s1 from v_genInvalidCacheIdsQuery;
    execute s1;
  end if;
  COMMIT;
  truncate table dcs_prd_catalogs immediate;
  prepare s2 from v_main_select;
  set v_my_cursor = cursor with hold for s2;
  open v_my_cursor;
  fetch v_my_cursor into v_current_product_id, v_current_catalog_id;
  while (SQLCODE=0)
  do
    insert into dcs_prd_catalogs (product_id,catalog_id) values (v_current_product_id, v_current_catalog_id);
    if v_cmt_count >= v_cmt_size then
      COMMIT;
      set v_cmt_count = 0;
    else
      set v_cmt_count = v_cmt_count + 1;
    end if;
    fetch v_my_cursor into v_current_product_id, v_current_catalog_id;
  end while;
  COMMIT;
end

@

create procedure pr_dcs_sku_catalogs
(in v_cmt_size integer
,in v_generate_invalid_asset_ids integer)
BEGIN
  declare SQLCODE integer default 0;
  declare v_cmt_count integer default 0;
  declare v_skuId varchar(40);
  declare v_catalogId varchar(40);
  declare v_cursor cursor with hold for select distinct prdChldSku.sku_id as my_sku_id, prdCat.catalog_id as my_catalog_id from dcs_prd_chldsku prdChldSku, dcs_prd_catalogs prdCat where prdCat.product_id = prdChldSku.product_id;
  if v_generate_invalid_asset_ids=1 then
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
  end if;
  COMMIT;
  truncate table dcs_sku_catalogs immediate;
  open v_cursor;
  fetch v_cursor into v_skuId, v_catalogId;
  while (SQLCODE=0)
  do
    insert into dcs_sku_catalogs (sku_id, catalog_id) values (v_skuId, v_catalogId);
    if v_cmt_count >= v_cmt_size then
      COMMIT;
      set v_cmt_count = 0;
    else
      set v_cmt_count = v_cmt_count + 1;
    end if;
    fetch v_cursor into v_skuId, v_catalogId;
 END while;
END

@

commit;
