


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/location_ddl.xml#2 $$Change: 953229 $

create table dcs_location (
	location_id	varchar(40)	not null,
	ext_loc_id	varchar(40)	null,
	type	integer	not null,
	version	integer	not null,
	name	varchar(254)	null,
	start_date	datetime	null,
	end_date	datetime	null,
	latitude	numeric(19,7)	not null,
	longitude	numeric(19,7)	not null
,constraint dcs_location_p primary key (location_id));


create table dcs_location_sites (
	location_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_location_sites_pk primary key (location_id,site_id));

create index location_site_id_idx on dcs_location_sites (site_id);

create table dcs_loc_site_grps (
	location_id	varchar(40)	not null,
	site_group_id	varchar(40)	not null
,constraint dcs_loc_sgrps_pk primary key (location_id,site_group_id)
,constraint dcs_loc_sgrps1_d_f foreign key (location_id) references dcs_location (location_id)
,constraint dcs_loc_sgrps2_d_f foreign key (site_group_id) references site_group (id));

create index dcs_loc_sgrps2_x on dcs_loc_site_grps (site_group_id);

create table dcs_location_store (
	location_id	varchar(40)	not null,
	hours	varchar(64)	null
,constraint dcs_loc_store_p primary key (location_id));


create table dcs_location_addr (
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
,constraint dcspp_loc_addr_p primary key (location_id)
,constraint dcspp_loc_addr_f foreign key (location_id) references dcs_location (location_id));


create table dcs_location_rltd_media (
	location_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_media_id	varchar(40)	not null
,constraint dcs_location_rltd_media_p primary key (location_id,sequence_num)
,constraint dcs_location_rltd_media1_f foreign key (location_id) references dcs_location (location_id)
,constraint dcs_location_rltd_media2_f foreign key (related_media_id) references wcm_media_content (id));

create index dcs_location_rltd_media_idx on dcs_location_rltd_media (related_media_id);

create table dcs_location_rltd_article (
	location_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_article_id	varchar(40)	not null
,constraint dcs_location_rltd_article_p primary key (location_id,sequence_num)
,constraint dcs_location_rltd_article1_f foreign key (location_id) references dcs_location (location_id)
,constraint dcs_location_rltd_article2_f foreign key (related_article_id) references wcm_article (id));

create index dcs_location_rltd_article_idx on dcs_location_rltd_article (related_article_id);
commit;


