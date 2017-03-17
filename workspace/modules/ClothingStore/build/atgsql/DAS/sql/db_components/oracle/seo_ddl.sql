


--     @version $Id: //product/DAS/version/11.2/templates/DAS/sql/seo_ddl.xml#1 $  
-- Table for seo-tag repository item

create table das_seo_tag (
	seo_tag_id	varchar2(40)	not null,
	display_name	varchar2(100)	null,
	title	varchar2(254)	null,
	description	varchar2(254)	null,
	keywords	varchar2(254)	null,
	content_key	varchar2(100)	null
,constraint das_seo_tag_pk primary key (seo_tag_id));


create table das_seo_sites (
	seo_tag_id	varchar2(40)	not null,
	site_id	varchar2(40)	not null
,constraint das_seo_site_pk primary key (seo_tag_id,site_id));




