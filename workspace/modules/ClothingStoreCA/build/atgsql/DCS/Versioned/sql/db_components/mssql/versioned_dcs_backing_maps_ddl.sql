


--     @version$Id: //product/DCS/version/11.2/templates/DCS/sql/dcs_backing_maps_ddl.xml#1 $  
-- Tables for backing maps for item descriptors enables for dynamic properties in product catalog repository

create table dcs_dyn_prop_map_str (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	varchar(400)	null
,constraint dcs_dyn_prop_map_str_p primary key (id,prop_name,asset_version))


create table dcs_dyn_prop_map_big_str (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	text	null
,constraint dcs_dyn_prop_map_big_str_p primary key (id,prop_name,asset_version))


create table dcs_dyn_prop_map_double (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19,7)	null
,constraint dcs_dyn_prop_map_double_p primary key (id,prop_name,asset_version))


create table dcs_dyn_prop_map_long (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19)	null
,constraint dcs_dyn_prop_map_long_p primary key (id,prop_name,asset_version))

-- Tables for backing maps for sku item descriptor

create table dcs_sku_dyn_prop_map_str (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	varchar(400)	null
,constraint dcs_sku_dyn_prop_map_str_p primary key (id,prop_name,asset_version))


create table dcs_sku_dyn_prop_map_big_str (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	text	null
,constraint dcs_sku_dynmc_prp_mp_bg_str_p primary key (id,prop_name,asset_version))


create table dcs_sku_dyn_prop_map_double (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19,7)	null
,constraint dcs_sku_dyn_prp_mp_dbl_p primary key (id,prop_name,asset_version))


create table dcs_sku_dyn_prop_map_long (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19)	null
,constraint dcs_sku_dyn_prp_mp_lng_p primary key (id,prop_name,asset_version))



go
