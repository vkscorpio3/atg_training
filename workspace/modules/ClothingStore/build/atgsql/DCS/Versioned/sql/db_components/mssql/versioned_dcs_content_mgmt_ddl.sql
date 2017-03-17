


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/dcs_content_mgmt_ddl.xml#1 $$Change: 953229 $
-- This file contains create table statements, which will configure your database for use with the Content Management schema.

create table dcs_wcm_media_rltd_prod (
	asset_version	numeric(19)	not null,
	media_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_product_id	varchar(40)	not null
,constraint wcm_media_rltd_product_p primary key (media_id,sequence_num,asset_version))


create table dcs_wcm_media_rltd_ctgy (
	asset_version	numeric(19)	not null,
	media_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_category_id	varchar(40)	not null
,constraint wcm_media_rltd_category_p primary key (media_id,sequence_num,asset_version))


create table dcs_wcm_article_rltd_prod (
	asset_version	numeric(19)	not null,
	article_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_product_id	varchar(40)	not null
,constraint wcm_article_rltd_product_p primary key (article_id,sequence_num,asset_version))


create table dcs_wcm_article_rltd_ctgy (
	asset_version	numeric(19)	not null,
	article_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_category_id	varchar(40)	not null
,constraint wcm_article_rltd_category_p primary key (article_id,sequence_num,asset_version))



go
