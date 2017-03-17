


--     @version$Id: //product/DAS/version/11.2/templates/DAS/sql/dynamic_metadata_ddl.xml#1 $  
-- Tables for Dynamic Repository Metadata storage

create table das_gsa_dyn_type (
	id	varchar(40)	not null,
	type_name	varchar(254)	null,
	item_descriptor	varchar(254)	null,
	root_item_descriptor	varchar(254)	null,
	repository	varchar(254)	null,
	sub_type_value	varchar(254)	null,
	sub_type_num	integer	null,
	removed	tinyint	null
,constraint das_gsa_dyn_type_p primary key (id));


create table das_gsa_dyn_type_attr (
	id	varchar(40)	not null,
	attribute_key	varchar(254)	not null,
	attribute_value	varchar(254)	not null
,constraint das_gsa_dyn_type_attr_p primary key (id,attribute_key));


create table das_gsa_dyn_prop (
	id	varchar(40)	not null,
	property_name	varchar(254)	not null,
	item_descriptor	varchar(254)	null,
	repository	varchar(254)	null,
	data_type	varchar(254)	null,
	backing_map	varchar(254)	null,
	removed	tinyint	null
,constraint das_gsa_dyn_prop_p primary key (id));


create table das_gsa_dyn_prop_enum (
	id	varchar(40)	not null,
	enumeration_values	varchar(254)	not null,
	enumeration_value_num	integer	not null
,constraint das_gsa_dyn_prop_enum_p primary key (id,enumeration_values));


create table das_gsa_dyn_prop_eorder (
	id	varchar(40)	not null,
	seq_num	integer	not null,
	enumeration_order	varchar(254)	not null
,constraint das_gsa_dyn_prop_eorder_p primary key (id,seq_num));


create table das_gsa_dyn_prop_attr (
	id	varchar(40)	not null,
	attribute_key	varchar(254)	not null,
	attribute_value	varchar(254)	not null
,constraint das_gsa_dyn_prop_attr_p primary key (id,attribute_key));

commit;


