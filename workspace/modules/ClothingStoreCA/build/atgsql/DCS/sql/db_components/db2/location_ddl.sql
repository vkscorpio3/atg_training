


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/location_ddl.xml#2 $$Change: 953229 $

create table dcs_location (
	location_id	varchar(40)	not null,
	ext_loc_id	varchar(40)	default null,
	type	integer	not null,
	version	integer	not null,
	name	varchar(254)	default null,
	start_date	timestamp	default null,
	end_date	timestamp	default null,
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
	hours	varchar(64)	default null
,constraint dcs_loc_store_p primary key (location_id));


create table dcs_location_addr (
	location_id	varchar(40)	not null,
	address_1	varchar(50)	default null,
	address_2	varchar(50)	default null,
	address_3	varchar(50)	default null,
	city	varchar(40)	default null,
	county	varchar(40)	default null,
	state_addr	varchar(40)	default null,
	postal_code	varchar(10)	default null,
	country	varchar(40)	default null,
	phone_number	varchar(40)	default null,
	fax_number	varchar(40)	default null,
	email	varchar(255)	default null
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


