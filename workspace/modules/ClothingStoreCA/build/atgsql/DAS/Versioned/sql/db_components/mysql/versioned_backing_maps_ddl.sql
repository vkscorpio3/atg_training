


--     @version$Id: //product/DAS/version/11.2/templates/DAS/sql/backing_maps_ddl.xml#1 $  
-- Tables for backing maps for item descriptors enables for dynamic properties

create table das_dyn_prop_map_str (
	asset_version	bigint	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	nvarchar(400)	null
,constraint das_dyn_prop_map_str_p primary key (id,prop_name,asset_version));


create table das_dyn_prop_map_big_str (
	asset_version	bigint	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	longtext charset utf8	null
,constraint das_dyn_prop_map_big_str_p primary key (id,prop_name,asset_version));


create table das_dyn_prop_map_double (
	asset_version	bigint	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19,7)	null
,constraint das_dyn_prop_map_double_p primary key (id,prop_name,asset_version));


create table das_dyn_prop_map_long (
	asset_version	bigint	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19)	null
,constraint das_dyn_prop_map_long_p primary key (id,prop_name,asset_version));


create table das_dyn_prop_map_str_2 (
	asset_version	bigint	not null,
	id1	varchar(40)	not null,
	id2	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	nvarchar(400)	null
,constraint das_dyn_prop_map_str_2_p primary key (id1,id2,prop_name,asset_version));


create table das_dyn_prop_map_big_str_2 (
	asset_version	bigint	not null,
	id1	varchar(40)	not null,
	id2	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	longtext charset utf8	null
,constraint das_dyn_prop_mp_bg_str_2_p primary key (id1,id2,prop_name,asset_version));


create table das_dyn_prop_map_double_2 (
	asset_version	bigint	not null,
	id1	varchar(40)	not null,
	id2	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19,7)	null
,constraint das_dyn_prop_mp_dbl_2_p primary key (id1,id2,prop_name,asset_version));


create table das_dyn_prop_map_long_2 (
	asset_version	bigint	not null,
	id1	varchar(40)	not null,
	id2	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19)	null
,constraint das_dyn_prop_mp_lng_2_p primary key (id1,id2,prop_name,asset_version));

commit;


