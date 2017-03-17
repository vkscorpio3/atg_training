


--     @version$Id: //product/DAS/version/11.2/templates/DAS/sql/backing_maps_ddl.xml#1 $  
-- Tables for backing maps for item descriptors enables for dynamic properties

create table das_dyn_prop_map_str (
	asset_version	number(19)	not null,
	id	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	varchar2(400)	null
,constraint das_dyn_prop_map_str_p primary key (id,prop_name,asset_version));


create table das_dyn_prop_map_big_str (
	asset_version	number(19)	not null,
	id	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	clob	null
,constraint das_dyn_prop_map_big_str_p primary key (id,prop_name,asset_version));


create table das_dyn_prop_map_double (
	asset_version	number(19)	not null,
	id	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	number(19,7)	null
,constraint das_dyn_prop_map_double_p primary key (id,prop_name,asset_version));


create table das_dyn_prop_map_long (
	asset_version	number(19)	not null,
	id	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	number(19)	null
,constraint das_dyn_prop_map_long_p primary key (id,prop_name,asset_version));


create table das_dyn_prop_map_str_2 (
	asset_version	number(19)	not null,
	id1	varchar2(40)	not null,
	id2	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	varchar2(400)	null
,constraint das_dyn_prop_map_str_2_p primary key (id1,id2,prop_name,asset_version));


create table das_dyn_prop_map_big_str_2 (
	asset_version	number(19)	not null,
	id1	varchar2(40)	not null,
	id2	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	clob	null
,constraint das_dyn_prop_mp_bg_str_2_p primary key (id1,id2,prop_name,asset_version));


create table das_dyn_prop_map_double_2 (
	asset_version	number(19)	not null,
	id1	varchar2(40)	not null,
	id2	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	number(19,7)	null
,constraint das_dyn_prop_mp_dbl_2_p primary key (id1,id2,prop_name,asset_version));


create table das_dyn_prop_map_long_2 (
	asset_version	number(19)	not null,
	id1	varchar2(40)	not null,
	id2	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	number(19)	null
,constraint das_dyn_prop_mp_lng_2_p primary key (id1,id2,prop_name,asset_version));




