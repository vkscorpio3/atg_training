


--  @version $Id: //product/DPS/version/11.2/templates/DPS/sql/personalization_ddl.xml#1 $$Change: 946917 $
-- This file contains create table statements needed to configure your database for personzalization assets.This script will create tables and indexes associated with the user segment list manager.

create table dps_seg_list (
	segment_list_id	varchar2(40)	not null,
	display_name	varchar2(256)	null,
	description	varchar2(1024)	null,
	folder_id	varchar2(40)	null
,constraint dps_seg_list_p primary key (segment_list_id));


create table dps_seg_list_name (
	segment_list_id	varchar2(40)	not null,
	seq	number(10)	not null,
	group_name	varchar2(256)	not null
,constraint dps_s_l_n_p primary key (segment_list_id,seq)
,constraint dps_s_l_n_f1 foreign key (segment_list_id) references dps_seg_list (segment_list_id));


create table dps_seg_list_folder (
	folder_id	varchar2(40)	not null,
	display_name	varchar2(256)	null,
	description	varchar2(1024)	null,
	parent_folder_id	varchar2(40)	null
,constraint dps_s_l_f_p primary key (folder_id)
,constraint dps_s_l_f_f1 foreign key (parent_folder_id) references dps_seg_list_folder (folder_id));

create index dps_sgmlstfldr1_x on dps_seg_list_folder (parent_folder_id);



