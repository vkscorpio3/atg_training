


-- This file contains create table statements, which will configureyour database for use MultiSite

create table dcs_site (
	id	varchar(40)	not null,
	catalog_id	varchar(40)	null,
	list_pricelist_id	varchar(40)	null,
	sale_pricelist_id	varchar(40)	null,
	max_num_coupons	integer	null,
	max_num_coupons_per_order	integer	null
,constraint dcs_site_p primary key (id))



go
