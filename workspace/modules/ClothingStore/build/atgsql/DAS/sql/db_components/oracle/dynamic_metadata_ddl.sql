


--     @version$Id: //product/DAS/version/11.2/templates/DAS/sql/dynamic_metadata_ddl.xml#1 $  
-- Tables for Dynamic Repository Metadata storage

create table das_gsa_dyn_type (
	id	varchar2(40)	not null,
	type_name	varchar2(254)	null,
	item_descriptor	varchar2(254)	null,
	root_item_descriptor	varchar2(254)	null,
	repository	varchar2(254)	null,
	sub_type_value	varchar2(254)	null,
	sub_type_num	number(10)	null,
	removed	number(1)	null
,constraint das_gsa_dyn_type_p primary key (id));


create table das_gsa_dyn_type_attr (
	id	varchar2(40)	not null,
	attribute_key	varchar2(254)	not null,
	attribute_value	varchar2(254)	not null
,constraint das_gsa_dyn_type_attr_p primary key (id,attribute_key));


create table das_gsa_dyn_prop (
	id	varchar2(40)	not null,
	property_name	varchar2(254)	not null,
	item_descriptor	varchar2(254)	null,
	repository	varchar2(254)	null,
	data_type	varchar2(254)	null,
	backing_map	varchar2(254)	null,
	removed	number(1)	null
,constraint das_gsa_dyn_prop_p primary key (id));


create table das_gsa_dyn_prop_enum (
	id	varchar2(40)	not null,
	enumeration_values	varchar2(254)	not null,
	enumeration_value_num	number(10)	not null
,constraint das_gsa_dyn_prop_enum_p primary key (id,enumeration_values));


create table das_gsa_dyn_prop_eorder (
	id	varchar2(40)	not null,
	seq_num	number(10)	not null,
	enumeration_order	varchar2(254)	not null
,constraint das_gsa_dyn_prop_eorder_p primary key (id,seq_num));


create table das_gsa_dyn_prop_attr (
	id	varchar2(40)	not null,
	attribute_key	varchar2(254)	not null,
	attribute_value	varchar2(254)	not null
,constraint das_gsa_dyn_prop_attr_p primary key (id,attribute_key));




