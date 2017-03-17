


--     @version$Id: //product/DAS/version/11.2/templates/DAS/sql/dynamic_metadata_ddl.xml#1 $  
-- Tables for Dynamic Repository Metadata storage

create table das_gsa_dyn_type (
	asset_version	number(19)	not null,
	workspace_id	varchar2(40)	not null,
	branch_id	varchar2(40)	not null,
	is_head	number(1)	not null,
	version_deleted	number(1)	not null,
	version_editable	number(1)	not null,
	pred_version	number(19)	null,
	checkin_date	timestamp	null,
	id	varchar2(40)	not null,
	type_name	varchar2(254)	null,
	item_descriptor	varchar2(254)	null,
	root_item_descriptor	varchar2(254)	null,
	repository	varchar2(254)	null,
	sub_type_value	varchar2(254)	null,
	sub_type_num	number(10)	null,
	removed	number(1)	null
,constraint das_gsa_dyn_type_p primary key (id,asset_version));

create index das_gsa_dyn_ty_wsx on das_gsa_dyn_type (workspace_id);
create index das_gsa_dyn_ty_cix on das_gsa_dyn_type (checkin_date);

create table das_gsa_dyn_type_attr (
	asset_version	number(19)	not null,
	id	varchar2(40)	not null,
	attribute_key	varchar2(254)	not null,
	attribute_value	varchar2(254)	not null
,constraint das_gsa_dyn_type_attr_p primary key (id,attribute_key,asset_version));


create table das_gsa_dyn_prop (
	asset_version	number(19)	not null,
	workspace_id	varchar2(40)	not null,
	branch_id	varchar2(40)	not null,
	is_head	number(1)	not null,
	version_deleted	number(1)	not null,
	version_editable	number(1)	not null,
	pred_version	number(19)	null,
	checkin_date	timestamp	null,
	id	varchar2(40)	not null,
	property_name	varchar2(254)	not null,
	item_descriptor	varchar2(254)	null,
	repository	varchar2(254)	null,
	data_type	varchar2(254)	null,
	backing_map	varchar2(254)	null,
	removed	number(1)	null
,constraint das_gsa_dyn_prop_p primary key (id,asset_version));

create index das_gsa_dyn_pr_wsx on das_gsa_dyn_prop (workspace_id);
create index das_gsa_dyn_pr_cix on das_gsa_dyn_prop (checkin_date);

create table das_gsa_dyn_prop_enum (
	asset_version	number(19)	not null,
	id	varchar2(40)	not null,
	enumeration_values	varchar2(254)	not null,
	enumeration_value_num	number(10)	not null
,constraint das_gsa_dyn_prop_enum_p primary key (id,enumeration_values,asset_version));


create table das_gsa_dyn_prop_eorder (
	asset_version	number(19)	not null,
	id	varchar2(40)	not null,
	seq_num	number(10)	not null,
	enumeration_order	varchar2(254)	not null
,constraint das_gsa_dyn_prop_eorder_p primary key (id,seq_num,asset_version));


create table das_gsa_dyn_prop_attr (
	asset_version	number(19)	not null,
	id	varchar2(40)	not null,
	attribute_key	varchar2(254)	not null,
	attribute_value	varchar2(254)	not null
,constraint das_gsa_dyn_prop_attr_p primary key (id,attribute_key,asset_version));




