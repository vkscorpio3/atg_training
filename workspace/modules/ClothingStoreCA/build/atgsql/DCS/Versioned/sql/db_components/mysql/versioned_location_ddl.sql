


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/location_ddl.xml#2 $$Change: 953229 $

create table dcs_location (
	asset_version	bigint	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	tinyint	not null,
	version_editable	tinyint	not null,
	pred_version	bigint	null,
	checkin_date	datetime	null,
	location_id	varchar(40)	not null,
	ext_loc_id	varchar(40)	null,
	type	integer	not null,
	version	integer	not null,
	name	varchar(254)	null,
	start_date	datetime	null,
	end_date	datetime	null,
	latitude	numeric(19,7)	not null,
	longitude	numeric(19,7)	not null
,constraint dcs_location_p primary key (location_id,asset_version));

create index dcs_location_wsx on dcs_location (workspace_id);
create index dcs_location_cix on dcs_location (checkin_date);

create table dcs_location_sites (
	asset_version	bigint	not null,
	location_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_location_sites_pk primary key (location_id,site_id,asset_version));

create index location_site_id_idx on dcs_location_sites (site_id);

create table dcs_loc_site_grps (
	asset_version	bigint	not null,
	location_id	varchar(40)	not null,
	site_group_id	varchar(40)	not null
,constraint dcs_loc_sgrps_pk primary key (location_id,site_group_id,asset_version));


create table dcs_location_store (
	asset_version	bigint	not null,
	location_id	varchar(40)	not null,
	hours	varchar(64)	null
,constraint dcs_loc_store_p primary key (location_id,asset_version));


create table dcs_location_addr (
	asset_version	bigint	not null,
	location_id	varchar(40)	not null,
	address_1	nvarchar(50)	null,
	address_2	nvarchar(50)	null,
	address_3	nvarchar(50)	null,
	city	nvarchar(40)	null,
	county	nvarchar(40)	null,
	state_addr	nvarchar(40)	null,
	postal_code	nvarchar(10)	null,
	country	nvarchar(40)	null,
	phone_number	nvarchar(40)	null,
	fax_number	nvarchar(40)	null,
	email	nvarchar(255)	null
,constraint dcspp_loc_addr_p primary key (location_id,asset_version));


create table dcs_location_rltd_media (
	asset_version	bigint	not null,
	location_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_media_id	varchar(40)	not null
,constraint dcs_location_rltd_media_p primary key (location_id,sequence_num,asset_version));


create table dcs_location_rltd_article (
	asset_version	bigint	not null,
	location_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_article_id	varchar(40)	not null
,constraint dcs_location_rltd_article_p primary key (location_id,sequence_num,asset_version));

commit;


