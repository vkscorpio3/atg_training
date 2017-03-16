


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/location_ddl.xml#2 $$Change: 953229 $

create table dcs_location (
	asset_version	number(19)	not null,
	workspace_id	varchar2(40)	not null,
	branch_id	varchar2(40)	not null,
	is_head	number(1)	not null,
	version_deleted	number(1)	not null,
	version_editable	number(1)	not null,
	pred_version	number(19)	null,
	checkin_date	timestamp	null,
	location_id	varchar2(40)	not null,
	ext_loc_id	varchar2(40)	null,
	type	number(10)	not null,
	version	number(10)	not null,
	name	varchar2(254)	null,
	start_date	date	null,
	end_date	date	null,
	latitude	number(19,7)	not null,
	longitude	number(19,7)	not null
,constraint dcs_location_p primary key (location_id,asset_version));

create index dcs_location_wsx on dcs_location (workspace_id);
create index dcs_location_cix on dcs_location (checkin_date);

create table dcs_location_sites (
	asset_version	number(19)	not null,
	location_id	varchar2(40)	not null,
	site_id	varchar2(40)	not null
,constraint dcs_location_sites_pk primary key (location_id,site_id,asset_version));

create index location_site_id_idx on dcs_location_sites (site_id);

create table dcs_loc_site_grps (
	asset_version	number(19)	not null,
	location_id	varchar2(40)	not null,
	site_group_id	varchar2(40)	not null
,constraint dcs_loc_sgrps_pk primary key (location_id,site_group_id,asset_version));


create table dcs_location_store (
	asset_version	number(19)	not null,
	location_id	varchar2(40)	not null,
	hours	varchar2(64)	null
,constraint dcs_loc_store_p primary key (location_id,asset_version));


create table dcs_location_addr (
	asset_version	number(19)	not null,
	location_id	varchar2(40)	not null,
	address_1	varchar2(50)	null,
	address_2	varchar2(50)	null,
	address_3	varchar2(50)	null,
	city	varchar2(40)	null,
	county	varchar2(40)	null,
	state_addr	varchar2(40)	null,
	postal_code	varchar2(10)	null,
	country	varchar2(40)	null,
	phone_number	varchar2(40)	null,
	fax_number	varchar2(40)	null,
	email	varchar2(255)	null
,constraint dcspp_loc_addr_p primary key (location_id,asset_version));


create table dcs_location_rltd_media (
	asset_version	number(19)	not null,
	location_id	varchar2(40)	not null,
	sequence_num	integer	not null,
	related_media_id	varchar2(40)	not null
,constraint dcs_location_rltd_media_p primary key (location_id,sequence_num,asset_version));


create table dcs_location_rltd_article (
	asset_version	number(19)	not null,
	location_id	varchar2(40)	not null,
	sequence_num	integer	not null,
	related_article_id	varchar2(40)	not null
,constraint dcs_location_rltd_article_p primary key (location_id,sequence_num,asset_version));




