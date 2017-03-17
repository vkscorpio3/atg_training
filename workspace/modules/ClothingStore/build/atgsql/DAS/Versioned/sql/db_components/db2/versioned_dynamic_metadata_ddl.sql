


--     @version$Id: //product/DAS/version/11.2/templates/DAS/sql/dynamic_metadata_ddl.xml#1 $  
-- Tables for Dynamic Repository Metadata storage

create table das_gsa_dyn_type (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	numeric(1)	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	default null,
	checkin_date	timestamp	default null,
	id	varchar(40)	not null,
	type_name	varchar(254)	default null,
	item_descriptor	varchar(254)	default null,
	root_item_descriptor	varchar(254)	default null,
	repository	varchar(254)	default null,
	sub_type_value	varchar(254)	default null,
	sub_type_num	integer	default null,
	removed	numeric(1)	default null
,constraint das_gsa_dyn_type_p primary key (id,asset_version));

create index das_gsa_dyn_ty_wsx on das_gsa_dyn_type (workspace_id);
create index das_gsa_dyn_ty_cix on das_gsa_dyn_type (checkin_date);

create table das_gsa_dyn_type_attr (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	attribute_key	varchar(254)	not null,
	attribute_value	varchar(254)	not null
,constraint das_gsa_dyn_type_attr_p primary key (id,attribute_key,asset_version));


create table das_gsa_dyn_prop (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	numeric(1)	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	default null,
	checkin_date	timestamp	default null,
	id	varchar(40)	not null,
	property_name	varchar(254)	not null,
	item_descriptor	varchar(254)	default null,
	repository	varchar(254)	default null,
	data_type	varchar(254)	default null,
	backing_map	varchar(254)	default null,
	removed	numeric(1)	default null
,constraint das_gsa_dyn_prop_p primary key (id,asset_version));

create index das_gsa_dyn_pr_wsx on das_gsa_dyn_prop (workspace_id);
create index das_gsa_dyn_pr_cix on das_gsa_dyn_prop (checkin_date);

create table das_gsa_dyn_prop_enum (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	enumeration_values	varchar(254)	not null,
	enumeration_value_num	integer	not null
,constraint das_gsa_dyn_prop_enum_p primary key (id,enumeration_values,asset_version));


create table das_gsa_dyn_prop_eorder (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	seq_num	integer	not null,
	enumeration_order	varchar(254)	not null
,constraint das_gsa_dyn_prop_eorder_p primary key (id,seq_num,asset_version));


create table das_gsa_dyn_prop_attr (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	attribute_key	varchar(254)	not null,
	attribute_value	varchar(254)	not null
,constraint das_gsa_dyn_prop_attr_p primary key (id,attribute_key,asset_version));

commit;


