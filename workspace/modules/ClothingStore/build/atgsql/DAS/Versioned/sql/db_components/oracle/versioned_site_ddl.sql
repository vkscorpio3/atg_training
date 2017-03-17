


--  @version $Id: //product/DAS/version/11.2/templates/DAS/sql/site_ddl.xml#3 $$Change: 1179550 $
-- This file contains create table statements, which will configureyour database for use MultiSite

create table site_template (
	id	varchar2(40)	not null,
	name	varchar2(254)	not null,
	description	varchar2(254)	not null,
	item_mapping_id	varchar2(40)	not null
,constraint site_template1_p primary key (id));


create table site_configuration (
	asset_version	number(19)	not null,
	workspace_id	varchar2(40)	not null,
	branch_id	varchar2(40)	not null,
	is_head	number(1)	not null,
	version_deleted	number(1)	not null,
	version_editable	number(1)	not null,
	pred_version	number(19)	null,
	checkin_date	timestamp	null,
	id	varchar2(40)	not null,
	type	number(10)	null,
	name	varchar2(254)	not null,
	description	varchar2(254)	null,
	template	varchar2(40)	null,
	production_url	varchar2(254)	null,
	enabled	number(1)	not null,
	site_down_url	varchar2(254)	null,
	open_date	date	null,
	pre_opening_url	varchar2(254)	null,
	closing_date	date	null,
	post_closing_url	varchar2(254)	null,
	modification_time	date	null,
	creation_time	date	null,
	author	varchar2(254)	null,
	last_modified_by	varchar2(254)	null,
	site_icon	varchar2(254)	null,
	favicon	varchar2(254)	null,
	site_priority	number(10)	null,
	context_root	varchar2(254)	null,
	access_level	number(10)	null,
	realm_id	varchar2(40)	null,
	endeca_site_id	varchar2(254)	null
,constraint site_configurat1_p primary key (id,asset_version));

create index site_configura_wsx on site_configuration (workspace_id);
create index site_configura_cix on site_configuration (checkin_date);

create table site_additional_urls (
	asset_version	number(19)	not null,
	id	varchar2(40)	not null,
	additional_production_url	varchar2(254)	null,
	idx	number(10)	not null
,constraint siteadditio_url1_p primary key (id,idx,asset_version));


create table site_types (
	asset_version	number(19)	not null,
	id	varchar2(40)	not null,
	site_type	varchar2(254)	not null
,constraint site_types1_p primary key (id,site_type,asset_version));


create table site_group (
	asset_version	number(19)	not null,
	workspace_id	varchar2(40)	not null,
	branch_id	varchar2(40)	not null,
	is_head	number(1)	not null,
	version_deleted	number(1)	not null,
	version_editable	number(1)	not null,
	pred_version	number(19)	null,
	checkin_date	timestamp	null,
	id	varchar2(40)	not null,
	display_name	varchar2(254)	not null,
	type	number(10)	null
,constraint site_group1_p primary key (id,asset_version));

create index site_group_wsx on site_group (workspace_id);
create index site_group_cix on site_group (checkin_date);

create table site_group_sites (
	asset_version	number(19)	not null,
	site_id	varchar2(40)	not null,
	site_group_id	varchar2(40)	not null
,constraint site_group_sites_p primary key (site_id,site_group_id,asset_version));


create table site_group_shareable_types (
	asset_version	number(19)	not null,
	shareable_types	varchar2(254)	not null,
	site_group_id	varchar2(40)	not null
,constraint site_group_share_p primary key (shareable_types,site_group_id,asset_version));




