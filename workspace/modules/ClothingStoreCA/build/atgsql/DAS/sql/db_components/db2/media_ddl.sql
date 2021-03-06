


--     @version $Id: //product/DAS/version/11.2/templates/DAS/sql/media_ddl.xml#1 $$Change: 946917 $  
--     media content repository tables.  

create table media_folder (
	folder_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	timestamp	default null,
	description	varchar(254)	default null,
	name	varchar(254)	not null,
	path	varchar(254)	not null,
	parent_folder_id	varchar(40)	default null
,constraint md_folder_p primary key (folder_id)
,constraint md_foldparnt_fl_f foreign key (parent_folder_id) references media_folder (folder_id));

create index fldr_mfldrid_idx on media_folder (parent_folder_id);
create index md_fldr_path_idx on media_folder (path);

create table media_base (
	media_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	timestamp	default null,
	description	varchar(254)	default null,
	name	varchar(254)	not null,
	path	varchar(254)	not null,
	parent_folder_id	varchar(40)	not null,
	media_type	integer	default null
,constraint media_p primary key (media_id)
,constraint medparnt_fl_f foreign key (parent_folder_id) references media_folder (folder_id));

create index med_mfldrid_idx on media_base (parent_folder_id);
create index media_path_idx on media_base (path);
create index media_type_idx on media_base (media_type);

create table media_ext (
	media_id	varchar(40)	not null,
	url	varchar(254)	not null
,constraint media_ext_p primary key (media_id)
,constraint medxtmed_d_f foreign key (media_id) references media_base (media_id));


create table media_bin (
	media_id	varchar(40)	not null,
	length	integer	not null,
	last_modified	timestamp	not null,
	data	blob(1048576)	not null
,constraint media_bin_p primary key (media_id)
,constraint medbnmed_d_f foreign key (media_id) references media_base (media_id));


create table media_txt (
	media_id	varchar(40)	not null,
	length	integer	not null,
	last_modified	timestamp	not null,
	data	varchar(20480)	not null
,constraint media_txt_p primary key (media_id)
,constraint medtxtmed_d_f foreign key (media_id) references media_base (media_id));

commit;


