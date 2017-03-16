


create or replace procedure pr_dcs_sku_sites
(commit_size IN number
,generate_invalid_cache_ids IN number)
as
commit_count number:=0;
begin
if generate_invalid_cache_ids=1
then
insert into dcs_invalidated_sku_ids (sku_id) select distinct sku_id from (
(select distinct prdsku.sku_id, prdsites.site_id
  from dcs_prd_chldsku prdSku,
  dcs_product_sites prdsites
  where prdsku.product_id = prdsites.product_id
 minus
 select sku_id, site_id from dcs_sku_sites)
UNION
(select sku_id, site_id from dcs_sku_sites
minus
select distinct prdsku.sku_id, prdsites.site_id
  from dcs_prd_chldsku prdSku,
  dcs_product_sites prdsites
  where prdsku.product_id = prdsites.product_id)
) where sku_id not in (select sku_id from dcs_invalidated_sku_ids);
end if;

commit_count := 0;
execute immediate 'truncate table dcs_sku_sites';

for i in (select distinct prdsku.sku_id, prdsites.site_id
  from dcs_prd_chldsku prdSku,
  dcs_product_sites prdsites
  where prdsku.product_id = prdsites.product_id)
loop
  insert into dcs_sku_sites (sku_id,site_id) values (i.sku_id, i.site_id);
  if commit_count > commit_size
  then
    COMMIT;
    commit_count := 0;
  else
    commit_count := commit_count + 1;
  end if;
end loop;
commit;
end;

/

create or replace procedure pr_dcs_prd_prnt_cats
(include_dynamic_children_num IN number
,commit_size IN number
,generate_invalid_asset_ids IN number)
as
prev_product_id dcs_cat_chldprd.child_prd_id%TYPE;
prev_catalog_id dcs_cat_catalogs.catalog_id%TYPE;
prev_category_id dcs_cat_catalogs.catalog_id%TYPE;
prev_existing_category_id dcs_cat_catalogs.catalog_id%TYPE;
check_category_id dcs_prd_prnt_cats.category_id%TYPE;
max_category_id dcs_prd_prnt_cats.category_id%TYPE;
is_valid_category boolean;
records_were_returned boolean := false;
commit_count number := 0;
TYPE SimpleStringArray IS TABLE OF VARCHAR2(40);
catalog_id_array SimpleStringArray := SimpleStringArray();
category_id_array SimpleStringArray := SimpleStringArray();
product_id_array SimpleStringArray := SimpleStringArray();
existing_category_id_array SimpleStringArray := SimpleStringArray();
mainSelect varchar2(2000);
currentCatalogId varchar2(40);
currentCategoryId varchar2(40);
currentProductId varchar2(40);
currentExistingCategoryId varchar2(40);
TYPE t_ref_cursor IS REF CURSOR;
myCursor  t_ref_cursor;
invalidIdCount number := 0;
begin
  if (include_dynamic_children_num=1) 
  then
  mainSelect:='select a.catalog_id,
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
  mainSelect:='select a.catalog_id,
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

open myCursor for mainSelect;
loop
  fetch myCursor into currentCatalogId, currentCategoryId, currentProductId, currentExistingCategoryId;
  EXIT WHEN myCursor%NOTFOUND;
  if (prev_product_id is not null) and ((currentProductId <> prev_product_id) or (currentCatalogId <> prev_catalog_id))
  then
    -- The existing category will be the same across a group of catalog/product. Was there a line
    -- in the group where 'existing category id' matched 'category id'? If there was then we know
    -- the existing line is valid. If there wasn't then we'll need to add a row if it was missing
    -- or update a row if it existed but didn't have an acceptable category.
   is_valid_category:=FALSE;
    FOR x IN 1..category_id_array.COUNT LOOP
       if category_id_array(x)=existing_category_id_array(x) then
         -- the line we had was valid, exit loop
         is_valid_category:=TRUE;
         exit;
       end if;
    END LOOP;

  if not is_valid_category then
    -- Did the product/catalog combination exist at all in the target table?
    -- If it didn't, we add a row. If it did we update the row.
    if existing_category_id_array(1) is null
    then
      insert into dcs_prd_prnt_cats (catalog_id, category_id, product_id)
        values (prev_catalog_id, max_category_id, prev_product_id);
      commit_count := commit_count + 1;
      if generate_invalid_asset_ids = 1
      then
        select count(*) into invalidIdCount  from dcs_invalidated_prd_ids where product_id = prev_product_id;
        if (invalidIdCount =0 )
        then
          insert into dcs_invalidated_prd_ids (product_id) values (prev_product_id);
        end if;
      end if;
    else
      -- update based on max category
      update dcs_prd_prnt_cats
        SET category_id = max_category_id
        WHERE catalog_id = prev_catalog_id
        AND product_id = prev_product_id;
      commit_count := commit_count + 1;
      if generate_invalid_asset_ids = 1
        then
          select count(*) into invalidIdCount  from dcs_invalidated_prd_ids where product_id = prev_product_id;
          if (invalidIdCount =0 )
          then
            insert into dcs_invalidated_prd_ids (product_id) values (prev_product_id);
          end if;
      end if;
    end if;
  end if;

 -- clear the arrays, reset max category
 max_category_id := null;
 catalog_id_array.Delete();
 category_id_array.Delete();
 product_id_array.Delete();
 existing_category_id_array.Delete();
end if;

records_were_returned:=TRUE;

-- Store the values from the current row.
catalog_id_array.Extend();
category_id_array.Extend();
product_id_array.Extend();
existing_category_id_array.Extend();
catalog_id_array(catalog_id_array.COUNT):=currentCatalogId;
category_id_array(catalog_id_array.COUNT):=currentCategoryId;
product_id_array(catalog_id_array.COUNT):=currentProductId;
existing_category_id_array(catalog_id_array.COUNT):=currentExistingCategoryId;

prev_catalog_id:=currentCatalogId;
prev_product_id:=currentProductId;

if (max_category_id is null) or (currentCategoryId > max_category_id)
then
  max_category_id:=currentCategoryId;
end if;

if mod(commit_count, commit_size)=0
then
  commit;
  commit_count := 0;
end if;
end loop;

-- Deal with the final record:
-- The existing category will be the same across a group. Was there a line
-- in the group where 'existing category' matched 'category'?
is_valid_category:=FALSE;
FOR x IN 1..category_id_array.COUNT LOOP
  if category_id_array(x)=existing_category_id_array(x) then
    -- the line we had was valid, exit loop
    is_valid_category:=TRUE;
    exit;
  end if;
END LOOP;

if not is_valid_category and records_were_returned
then
  if existing_category_id_array(1) is null
  then
    insert into dcs_prd_prnt_cats (catalog_id, category_id, product_id)
      values (prev_catalog_id, max_category_id, prev_product_id);
    commit_count := commit_count + 1;
    if generate_invalid_asset_ids = 1
    then
      select count(*) into invalidIdCount  from dcs_invalidated_prd_ids where product_id = prev_product_id;
      if (invalidIdCount =0 )
      then
        insert into dcs_invalidated_prd_ids (product_id) values (prev_product_id);
      end if;
    end if;
  else
    -- update based on max category
    update dcs_prd_prnt_cats
    SET category_id = max_category_id
    WHERE catalog_id = prev_catalog_id
    AND product_id = prev_product_id;
    if generate_invalid_asset_ids = 1
    then
      select count(*) into invalidIdCount  from dcs_invalidated_prd_ids where product_id = prev_product_id;
      if (invalidIdCount =0 )
      then
        insert into dcs_invalidated_prd_ids (product_id) values (prev_product_id);
      end if;
    end if;
  end if;
end if;
commit;
-- We need to do two things - store the ids of any assets which are no longer needed in the CMS table,
-- and delete those assets from the table.
-- So we left outer join the CMS table to the current results from the main CMS query. This means the
-- CMS table contents will appear whether there was a match in the query results or not. We know that
-- any time the results are null on the source query side, we can remove that row.
-- We further join the CMS table to the invalid assets table, this time including all the results in the asset table
-- whether there was a match or not
-- We know that if we have decided to delete a row from the CMS table (see above) and there was no entry for that
-- asset in the invalid assets table, we should add the asset id.
for i in (select TARGET_TABLE.catalog_id as targetCatalogId, TARGET_TABLE.category_id as targetCategoryId, TARGET_TABLE.product_id as targetProductId,
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
   TARGET_TABLE.product_id = SOURCE_QUERY.product_id))
loop
  if i.sourceProductId is null 
  then
    delete from dcs_prd_prnt_cats WHERE product_id=i.targetProductId AND
                                           catalog_id=i.targetCatalogId AND
                                           category_id=i.targetCategoryId;
    if generate_invalid_asset_ids = 1 then
      merge into dcs_invalidated_prd_ids invalid_id_table
      using (
        select i.targetProductId as id_to_insert
        from dual
      ) t on (invalid_id_table.product_id = t.id_to_insert) 
      when not matched then
      insert (invalid_id_table.product_id)
      values (t.id_to_insert);
    end if;
  end if;
end loop;
commit;
end;

/

create or replace procedure pr_dcs_prd_anc_cats
(include_dynamic_children_num IN number
,commit_size IN number
,gen_invalid_cache_ids IN number)
as
curr_product_id varchar2(40);
prev_product_id varchar2(40) := '%%FIRST LOOP%%';
currentCategoryId varchar2(40);
currentProductId varchar2(40);
sequence_no number := 0;
commit_count number := 0;
mainSelect varchar(2000);
TYPE t_ref_cursor IS REF CURSOR;
myCursor t_ref_cursor;
genInvalidCacheIdsQuery varchar(2500);
begin
  if (include_dynamic_children_num=1)
  then
    mainSelect:='select distinct category_id, product_id from (select catAncCats.anc_category_id as category_id, 0 as sequence_num, catChldPrd1.child_prd_id as product_id
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
  from dcs_cat_dynprd catDynPrd1)';
  else
    mainSelect:='select distinct category_id, product_id from (select catAncCats.anc_category_id as category_id, 0 as sequence_num, catChldPrd1.child_prd_id as product_id
    from dcs_cat_anc_cats  catAncCats, 
         dcs_cat_chldprd   catChldPrd1 
    where catAncCats.category_id = catChldPrd1.category_id 
    union 
    select catChldPrd2.category_id as category_id, 0 as sequence_num, catChldPrd2.child_prd_id as product_id
    from dcs_cat_chldprd catChldPrd2)';
  end if;

  if (gen_invalid_cache_ids = 1)
  then
    genInvalidCacheIdsQuery:='insert into dcs_invalidated_prd_ids (product_id) select distinct product_id from (
(((' || mainSelect || ')) minus
(select category_id,product_id from dcs_prd_anc_cats))
union
((select category_id, product_id from dcs_prd_anc_cats)
minus
(' || mainSelect || '))
) where product_id not in (select product_id from dcs_invalidated_prd_ids)';
   execute immediate genInvalidCacheIdsQuery;
  end if;

execute immediate 'truncate table dcs_prd_anc_cats';

-- Ordering wasn't useful in computing invalid cache assets but it is required when considered with sequencing
-- so add in an order by clause
mainSelect := mainSelect || ' order by product_id asc';

open myCursor for mainSelect;
loop
  fetch myCursor into currentCategoryId, currentProductId;
  EXIT WHEN myCursor%NOTFOUND;

  curr_product_id := currentProductId;
  if curr_product_id <> prev_product_id then
    sequence_no := 0;
  else
    sequence_no := sequence_no + 1;
  end if;

  insert into dcs_prd_anc_cats (category_id, sequence_num, product_id)
    values (currentCategoryId, sequence_no, currentProductId);
  commit;
  if commit_count >= commit_size then
    COMMIT;
    commit_count := 0;
  else
    commit_count := commit_count + 1;
  end if;
  prev_product_id := curr_product_id;
end loop;
COMMIT;
end;
   
/

create or replace procedure pr_dcs_product_sites
(include_dynamic_children_num IN number
,commit_size IN number
,generate_invalid_asset_ids IN number)
as
commit_count number := 0;
mainSelect varchar2(2000);
currentProductId varchar2(40);
currentSiteId varchar2(40);
TYPE t_ref_cursor IS REF CURSOR;
myCursor  t_ref_cursor;
genInvalidAssetIdsQuery varchar2(2500);
begin
  -- 1 is considered to be true, any other number is considered to be false
  if (include_dynamic_children_num=1)
  then
    mainSelect := 'select product_id, site_id from
    (select catprd.child_prd_id  product_id,
      catsites.site_id site_id
    from dcs_cat_chldprd catprd,
      dcs_category_sites catsites
    where  catprd.category_id = catsites.category_id)
    union
    (select dynprd.product_id product_id,
       catsites1.site_id site_id
    from  dcs_cat_dynprd dynprd,
          dcs_category_sites catsites1
    where dynprd.category_id = catsites1.category_id)';
  else
    mainSelect := 'select distinct product_id, site_id from (select catprd.child_prd_id product_id,
      catsites.site_id site_id
    from dcs_cat_chldprd catprd,
         dcs_category_sites catsites
    where catprd.category_id = catsites.category_id)';
  end if;

  if (generate_invalid_asset_ids = 1)
  then
    genInvalidAssetIdsQuery := 'insert into dcs_invalidated_prd_ids select distinct product_id from (
((' || mainSelect || ')
minus
select product_id,site_id from dcs_product_sites)
UNION
(select product_id,site_id from dcs_product_sites
minus
' || mainSelect || ')
) where product_id not in (select product_id from dcs_invalidated_prd_ids)';
  execute immediate genInvalidAssetIdsQuery;
  end if;

  execute immediate 'truncate table dcs_product_sites';

  open myCursor for mainSelect;
  loop
    fetch myCursor into currentProductId, currentSiteId;
    EXIT WHEN myCursor%NOTFOUND;

    insert into dcs_product_sites (product_id,site_id) values (currentProductId, currentSiteId);
    if commit_count >= commit_size
    then
      COMMIT;
      commit_count := 0;
    else
      commit_count := commit_count + 1;
      end if;
  end loop;
  COMMIT;
end;
  
/

create or replace procedure pr_dcs_prd_catalogs
(include_dynamic_children_num IN number
,commit_size IN number
,generate_invalid_cache_ids IN number)
as
commit_count number := 0;
currentProductId varchar(40);
currentCatalogId varchar(40);
mainSelect varchar(2000);
TYPE t_ref_cursor IS REF CURSOR;
myCursor  t_ref_cursor;
genInvalidCacheIdsQuery varchar(2000);
begin
  if (include_dynamic_children_num=1)
  then
    mainSelect := 'select catChldPrd.child_prd_id as product_id, catCatalogs.catalog_id as catalog_id
      from dcs_cat_catalogs catCatalogs, 
           dcs_cat_chldprd catChldPrd 
      where catCatalogs.category_id = catChldPrd.category_id
      union
      select catDynPrd.product_id as product_id, catCatalogs1.catalog_id
      from dcs_cat_catalogs catCatalogs1, 
           dcs_cat_dynprd catDynPrd 
      where catCatalogs1.category_id = catDynPrd.category_id';
  else
    mainSelect := 'select distinct catChldPrd.child_prd_id as product_id, catCatalogs.catalog_id as catalog_id
      from dcs_cat_catalogs catCatalogs, 
           dcs_cat_chldprd catChldPrd 
      where catCatalogs.category_id = catChldPrd.category_id';
  end if;

  if (generate_invalid_cache_ids = 1)
  then
    genInvalidCacheIdsQuery := 'insert into dcs_invalidated_prd_ids select distinct product_id from (
((' || mainSelect || ')
minus
(select product_id, catalog_id from dcs_prd_catalogs))
union
((select product_id, catalog_id from dcs_prd_catalogs)
minus
(' || mainSelect || '))
) where product_id not in (select product_id from dcs_invalidated_prd_ids)';
   execute immediate genInvalidCacheIdsQuery;
  end if;

  execute immediate 'truncate table dcs_prd_catalogs';

  open myCursor for mainSelect;
  loop
    fetch myCursor into currentProductId, currentCatalogId;
    EXIT WHEN myCursor%NOTFOUND;

    insert into dcs_prd_catalogs (product_id,catalog_id) values (currentProductId, currentCatalogId);
    if commit_count >= commit_size then
      COMMIT;
      commit_count := 0;
    else
      commit_count := commit_count + 1;
    end if;
  end loop;
commit;
end;

/

create or replace procedure pr_dcs_sku_catalogs
(commit_size IN number
,generate_invalid_cache_ids IN number)
as
commit_count number := 0;
begin

if (generate_invalid_cache_ids=1)
then
insert into dcs_invalidated_sku_ids (sku_id) select distinct sku_id from (
(select distinct prdCat.catalog_id, prdChldSku.sku_id
  from dcs_prd_catalogs prdCat,
       dcs_prd_chldsku prdChldSku
  where prdCat.product_id = prdChldSku.product_id
 minus
select catalog_id, sku_id from dcs_sku_catalogs)
UNION
(select catalog_id, sku_id from dcs_sku_catalogs
minus
select distinct prdCat.catalog_id, prdChldSku.sku_id
  from dcs_prd_catalogs prdCat,
       dcs_prd_chldsku prdChldSku
  where prdCat.product_id = prdChldSku.product_id)
) where sku_id not in (select sku_id from dcs_invalidated_sku_ids);
end if;

execute immediate 'truncate table dcs_sku_catalogs';

for i in (select distinct prdCat.catalog_id, prdChldSku.sku_id
  from dcs_prd_catalogs prdCat,
       dcs_prd_chldsku prdChldSku
  where prdCat.product_id = prdChldSku.product_id)
loop
  insert into dcs_sku_catalogs (sku_id,catalog_id) values (i.sku_id, i.catalog_id);
  if commit_count >= commit_size
  then
    COMMIT;
    commit_count := 0;
  else
    commit_count := commit_count + 1;
  end if;
end loop;
commit;
end;
      
/


