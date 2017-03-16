


-- This file contains create table statements, which will configureyour database for use MultiSite

create table dcs_site (
	id	varchar2(40)	not null,
	catalog_id	varchar2(40)	null,
	list_pricelist_id	varchar2(40)	null,
	sale_pricelist_id	varchar2(40)	null,
	max_num_coupons	number(10)	null,
	max_num_coupons_per_order	number(10)	null
,constraint dcs_site_p primary key (id));




