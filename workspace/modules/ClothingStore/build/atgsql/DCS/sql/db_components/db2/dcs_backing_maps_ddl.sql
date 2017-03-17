


--     @version$Id: //product/DCS/version/11.2/templates/DCS/sql/dcs_backing_maps_ddl.xml#1 $  
-- Tables for backing maps for item descriptors enables for dynamic properties in product catalog repository

create table dcs_dyn_prop_map_str (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	varchar(400)	default null
,constraint dcs_dyn_prop_map_str_p primary key (id,prop_name));


create table dcs_dyn_prop_map_big_str (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	clob	default null
,constraint dcs_dyn_prop_map_big_str_p primary key (id,prop_name));


create table dcs_dyn_prop_map_double (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19,7)	default null
,constraint dcs_dyn_prop_map_double_p primary key (id,prop_name));


create table dcs_dyn_prop_map_long (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19)	default null
,constraint dcs_dyn_prop_map_long_p primary key (id,prop_name));

-- Tables for backing maps for sku item descriptor

create table dcs_sku_dyn_prop_map_str (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	varchar(400)	default null
,constraint dcs_sku_dyn_prop_map_str_p primary key (id,prop_name));


create table dcs_sku_dyn_prop_map_big_str (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	clob	default null
,constraint dcs_sku_dynmc_prp_mp_bg_str_p primary key (id,prop_name));


create table dcs_sku_dyn_prop_map_double (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19,7)	default null
,constraint dcs_sku_dyn_prp_mp_dbl_p primary key (id,prop_name));


create table dcs_sku_dyn_prop_map_long (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19)	default null
,constraint dcs_sku_dyn_prp_mp_lng_p primary key (id,prop_name));

commit;


