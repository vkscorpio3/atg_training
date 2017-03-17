
-- the source for this section is 
-- user_ddl.sql




-- This file contains create table statements, which will configure your database for use with the new DPS schema.
-- Add the organization definition.  It's out of place, but since dps_user references it, it's got to be defined up here

create table dps_organization (
	org_id	varchar(40)	not null,
	name	nvarchar(254)	not null,
	description	nvarchar(254)	null,
	parent_org	varchar(40)	null
,constraint dps_organization_p primary key (org_id)
,constraint dps_orgnparnt_rg_f foreign key (parent_org) references dps_organization (org_id));

create index dps_orgparent_org on dps_organization (parent_org);
-- Default Profile User Template
-- Basic user info.  note: the password field size must be at a minimum 70 characters       if DPS stores a hash of the password and not the actual value.

create table dps_user (
	id	varchar(40)	not null,
	login	nvarchar(40)	not null,
	auto_login	tinyint	null,
	password	varchar(200)	null,
	password_salt	varchar(250)	null,
	password_kdf	varchar(40)	null,
	realm_id	varchar(40)	null,
	member	tinyint	null,
	first_name	nvarchar(40)	null,
	middle_name	nvarchar(40)	null,
	last_name	nvarchar(40)	null,
	user_type	integer	null,
	locale	integer	null,
	lastactivity_date	datetime	null,
	lastpwdupdate	datetime	null,
	generatedpwd	tinyint	null,
	registration_date	datetime	null,
	email	nvarchar(255)	null,
	email_status	integer	null,
	receive_email	integer	null,
	last_emailed	datetime	null,
	gender	integer	null,
	date_of_birth	date	null,
	securityStatus	integer	null,
	description	nvarchar(254)	null
,constraint dps_user_p primary key (id)
,constraint dps_user1_c check (auto_login in (0,1))
,constraint dps_user2_c check (member in (0,1)));

create unique index dps_user_u on dps_user (login,realm_id);

create table dps_contact_info (
	id	varchar(40)	not null,
	user_id	varchar(40)	null,
	prefix	nvarchar(40)	null,
	first_name	nvarchar(40)	null,
	middle_name	nvarchar(40)	null,
	last_name	nvarchar(40)	null,
	suffix	nvarchar(40)	null,
	job_title	nvarchar(100)	null,
	company_name	nvarchar(40)	null,
	address1	nvarchar(50)	null,
	address2	nvarchar(50)	null,
	address3	nvarchar(50)	null,
	city	nvarchar(30)	null,
	state	nvarchar(20)	null,
	postal_code	nvarchar(10)	null,
	county	nvarchar(40)	null,
	country	nvarchar(40)	null,
	phone_number	nvarchar(30)	null,
	fax_number	nvarchar(30)	null
,constraint dps_contact_info_p primary key (id));


create table dps_user_address (
	id	varchar(40)	not null,
	home_addr_id	varchar(40)	null,
	billing_addr_id	varchar(40)	null,
	shipping_addr_id	varchar(40)	null
,constraint dps_user_address_p primary key (id)
,constraint dps_usrddrssid_f foreign key (id) references dps_user (id));

create index dps_usr_adr_shp_id on dps_user_address (shipping_addr_id);
create index dps_usr_blng_ad_id on dps_user_address (billing_addr_id);
create index dps_usr_home_ad_id on dps_user_address (home_addr_id);

create table dps_other_addr (
	user_id	varchar(40)	not null,
	tag	nvarchar(42)	not null,
	address_id	varchar(40)	not null
,constraint dps_other_addr_p primary key (user_id,tag)
,constraint dps_othrddrusr_d_f foreign key (user_id) references dps_user (id));


create table dps_mailing (
	id	varchar(40)	not null,
	name	nvarchar(255)	null,
	subject	nvarchar(80)	null,
	uniq_server_id	varchar(255)	null,
	from_address	nvarchar(255)	null,
	replyto	nvarchar(255)	null,
	template_URL	varchar(255)	null,
	alt_template_URL	varchar(255)	null,
	batch_exec_id	varchar(40)	null,
	cc	longtext	null,
	bcc	longtext	null,
	send_as_html	integer	null,
	send_as_text	integer	null,
	params	longblob	null,
	start_time	datetime	null,
	end_time	datetime	null,
	status	integer	null,
	num_profiles	integer	null,
	num_sent	integer	null,
	num_bounces	integer	null,
	num_soft_bounces	integer	null,
	num_errors	integer	null,
	num_skipped	integer	null,
	fill_from_templ	tinyint	null,
	is_batched	tinyint	null,
	ignore_fatigue	tinyint	null,
	batch_size	integer	null,
	site_id	varchar(40)	null
,constraint dps_mailing_p primary key (id));


create table dps_mail_trackdata (
	mailing_id	varchar(40)	not null,
	map_key	varchar(254)	not null,
	map_value	varchar(254)	null
,constraint dps_mail_trackd_p primary key (mailing_id,map_key)
,constraint dps_mail_trackd_f foreign key (mailing_id) references dps_mailing (id));


create table dps_mail_batch (
	mailing_id	varchar(40)	not null,
	start_idx	integer	not null,
	uniq_server_id	varchar(254)	null,
	start_time	datetime	null,
	end_time	datetime	null,
	status	integer	null,
	num_profiles	integer	null,
	num_sent	integer	null,
	num_bounces	integer	null,
	num_errors	integer	null,
	num_skipped	integer	null,
	is_summarized	tinyint	null
,constraint dps_mail_batch_p primary key (mailing_id,start_idx)
,constraint dps_mailbatch_d_f foreign key (mailing_id) references dps_mailing (id));


create table dps_mail_server (
	uniq_server_id	varchar(254)	not null,
	last_updated	datetime	null
,constraint dps_mail_server_p primary key (uniq_server_id));


create table dps_user_mailing (
	mailing_id	varchar(40)	not null,
	user_id	varchar(40)	not null,
	idx	integer	not null
,constraint dps_user_mailing_p primary key (mailing_id,user_id)
,constraint dps_usrmmalng_d_f foreign key (mailing_id) references dps_mailing (id)
,constraint dps_usrmlngusr_d_f foreign key (user_id) references dps_user (id));

create index dps_u_mail_uid on dps_user_mailing (user_id);

create table dps_email_address (
	mailing_id	varchar(40)	not null,
	email_address	varchar(255)	not null,
	idx	integer	not null
,constraint dps_email_addres_p primary key (mailing_id,idx)
,constraint dps_emldmalng_d_f foreign key (mailing_id) references dps_mailing (id));

-- Organizations/roles

create table dps_role (
	role_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	name	nvarchar(254)	not null,
	description	nvarchar(254)	null
,constraint dps_role_p primary key (role_id));

-- Extending the user profile to include references to the roles that are assigned to this user

create table dps_user_roles (
	user_id	varchar(40)	not null,
	atg_role	varchar(40)	not null
,constraint dps_user_roles_p primary key (user_id,atg_role)
,constraint dps_usrrlsatg_rl_f foreign key (atg_role) references dps_role (role_id)
,constraint dps_usrrlsusr_d_f foreign key (user_id) references dps_user (id));

create index dps_usr_roles_id on dps_user_roles (atg_role);

create table dps_org_role (
	org_id	varchar(40)	not null,
	atg_role	varchar(40)	not null
,constraint dps_org_role_p primary key (org_id,atg_role)
,constraint dps_orgrlorg_d_f foreign key (org_id) references dps_organization (org_id)
,constraint dps_orgrlatg_rl_f foreign key (atg_role) references dps_role (role_id));

create index dps_org_rolerole on dps_org_role (atg_role);

create table dps_role_rel_org (
	organization	varchar(40)	not null,
	sequence_num	integer	not null,
	role_id	varchar(40)	not null
,constraint dps_role_rel_org_p primary key (organization,sequence_num)
,constraint dps_rolrorgnztn_f foreign key (organization) references dps_organization (org_id)
,constraint dps_rolrlrgrol_d_f foreign key (role_id) references dps_role (role_id));

create index dps_role_rel_org on dps_role_rel_org (role_id);

create table dps_relativerole (
	role_id	varchar(40)	not null,
	dps_function	nvarchar(40)	not null,
	relative_to	varchar(40)	not null
,constraint dps_relativerole_p primary key (role_id)
,constraint dps_reltreltv_t_f foreign key (relative_to) references dps_organization (org_id)
,constraint dps_reltvrlrol_d_f foreign key (role_id) references dps_role (role_id));

create index dps_relativerole on dps_relativerole (relative_to);

create table dps_user_org (
	organization	varchar(40)	not null,
	user_id	varchar(40)	not null
,constraint dps_user_org_p primary key (organization,user_id)
,constraint dps_usrrgorgnztn_f foreign key (organization) references dps_organization (org_id)
,constraint dps_usrrgusr_d_f foreign key (user_id) references dps_user (id));

create index dps_usr_orgusr_id on dps_user_org (user_id);

create table dps_user_org_anc (
	user_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_org	varchar(40)	not null
,constraint dps_user_org_anc_p primary key (user_id,sequence_num)
,constraint dps_usrranc_rg_f foreign key (anc_org) references dps_organization (org_id)
,constraint dps_usrrgncusr_d_f foreign key (user_id) references dps_user (id));

create index dps_usr_org_ancanc on dps_user_org_anc (anc_org);

create table dps_org_chldorg (
	org_id	varchar(40)	not null,
	child_org_id	varchar(40)	not null
,constraint dps_org_chldorg_p primary key (org_id,child_org_id)
,constraint dps_orgcchild_rg_f foreign key (child_org_id) references dps_organization (org_id)
,constraint dps_orgcorg_d_f foreign key (org_id) references dps_organization (org_id));

create index dps_org_chldorg_id on dps_org_chldorg (child_org_id);

create table dps_org_ancestors (
	org_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_org	varchar(40)	not null
,constraint dps_org_ancestor_p primary key (org_id,sequence_num)
,constraint dps_orgnanc_rg_f foreign key (anc_org) references dps_organization (org_id)
,constraint dps_orgnorg_d_f foreign key (org_id) references dps_organization (org_id));

create index dps_org_ancanc_org on dps_org_ancestors (anc_org);
-- Secondary organizations information

create table dps_user_sec_orgs (
	user_id	varchar(40)	not null,
	secondary_org_id	varchar(40)	not null
,constraint dps_usr_sec_orgs_p primary key (user_id,secondary_org_id)
,constraint dps_usrsecorg_rl_f foreign key (secondary_org_id) references dps_organization (org_id)
,constraint dps_usrsorgusr_d_f foreign key (user_id) references dps_user (id));

create index dps_usr_sec_org_id on dps_user_sec_orgs (secondary_org_id);
-- Adding the folder information

create table dps_folder (
	folder_id	varchar(40)	not null,
	type	integer	not null,
	name	nvarchar(254)	not null,
	parent	varchar(40)	null,
	description	nvarchar(254)	null
,constraint dps_folder_p primary key (folder_id)
,constraint dps_foldrparnt_f foreign key (parent) references dps_folder (folder_id));

create index dps_folderparent on dps_folder (parent);

create table dps_child_folder (
	folder_id	varchar(40)	not null,
	child_folder_id	varchar(40)	not null
,constraint dps_child_folder_p primary key (folder_id,child_folder_id)
,constraint dps_chilchild_fl_f foreign key (child_folder_id) references dps_folder (folder_id)
,constraint dps_chilfoldr_d_f foreign key (folder_id) references dps_folder (folder_id));

create index dps_chld_fldr_fld on dps_child_folder (child_folder_id);

create table dps_rolefold_chld (
	rolefold_id	varchar(40)	not null,
	role_id	varchar(40)	not null
,constraint dps_rolefold_chl_p primary key (rolefold_id,role_id)
,constraint dps_rolfrolfld_d_f foreign key (rolefold_id) references dps_folder (folder_id)
,constraint dps_rolfrol_d_f foreign key (role_id) references dps_role (role_id));

create index dps_rolfldchldrole on dps_rolefold_chld (role_id);
-- Adding the previous password information

create table dps_user_prevpwd (
	id	varchar(40)	not null,
	seq_num	integer	not null,
	prevpwd	varchar(200)	null
,constraint dps_prevpwd_p primary key (id,seq_num)
,constraint dps_prvpwd_d_f foreign key (id) references dps_user (id));


create table dps_profile_realm (
	id	varchar(40)	not null,
	name	nvarchar(255)	null,
	description	nvarchar(255)	null
,constraint dps_prfl_rlm_p primary key (id));

commit;



-- the source for this section is 
-- logging_ddl.sql




-- This file contains create table statements needed to configure your database for use with the DPS logging/reporting subsystem.This script will create tables and indexes associated with the newlogging and reporting subsystem. To initialize these tables run thelogging_init.sql script.
-- Tables for storing logging data for reports

create table dps_event_type (
	id	integer	not null,
	name	varchar(32)	not null
,constraint dps_event_type_p primary key (id)
,constraint dps_event_type_u unique (name));


create table dps_user_event (
	id	bigint	not null,
	timestamp	datetime	not null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	eventtype	integer	not null,
	profileid	varchar(25)	null,
	member	tinyint	default 0 not null
,constraint dps_user_event_p primary key (id)
,constraint dps_usrvevnttyp_f foreign key (eventtype) references dps_event_type (id)
,constraint dps_user_event_c check (member in (0,1)));

create index dps_user_event_ix on dps_user_event (eventtype);
create index dps_ue_ts on dps_user_event (timestamp);

create table dps_user_event_sum (
	eventtype	integer	not null,
	summarycount	integer	not null,
	fromtime	datetime	not null,
	totime	datetime	not null
,constraint dps_usrsuevnttyp_f foreign key (eventtype) references dps_event_type (id));

create index dps_user_ev_sum_ix on dps_user_event_sum (eventtype);
create index dps_ues_ft on dps_user_event_sum (fromtime,totime,eventtype);

create table dps_request (
	id	bigint	not null,
	timestamp	datetime	not null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	name	varchar(255)	not null,
	member	tinyint	default 0 not null
,constraint dps_request_p primary key (id)
,constraint dps_request_c check (member in (0,1)));

create index dps_r_ts on dps_request (timestamp);

create table dps_reqname_sum (
	name	varchar(255)	not null,
	member	tinyint	default 0 not null,
	summarycount	integer	not null,
	fromtime	datetime	not null,
	totime	datetime	not null
,constraint dps_reqname_sum_c check (member in (0,1)));

create index dps_rns_ft on dps_reqname_sum (fromtime,totime);

create table dps_session_sum (
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	member	tinyint	default 0 not null,
	summarycount	integer	not null,
	fromtime	datetime	not null,
	totime	datetime	not null
,constraint dps_session_sum_c check (member in (0,1)));

create index dps_rss_ft on dps_session_sum (fromtime,totime,sessionid);

create table dps_con_req (
	id	bigint	not null,
	timestamp	datetime	not null,
	requestid	bigint	null,
	contentid	varchar(255)	not null
,constraint dps_con_req_p primary key (id));

create index dps_cr_ts on dps_con_req (timestamp);

create table dps_con_req_sum (
	contentid	varchar(255)	not null,
	member	tinyint	default 0 not null,
	summarycount	integer	not null,
	fromtime	datetime	not null,
	totime	datetime	not null
,constraint dps_con_req_sum_c check (member in (0,1)));

create index dps_crs_ft on dps_con_req_sum (fromtime,totime);

create table dps_pgrp_req_sum (
	groupname	nvarchar(64)	not null,
	contentname	nvarchar(255)	not null,
	summarycount	integer	not null,
	fromtime	datetime	not null,
	totime	datetime	not null);

create index dps_prs_ft on dps_pgrp_req_sum (fromtime,totime);

create table dps_pgrp_con_sum (
	groupname	nvarchar(64)	not null,
	contentname	nvarchar(64)	not null,
	summarycount	integer	not null,
	fromtime	datetime	not null,
	totime	datetime	not null);

create index dps_pcs_ft on dps_pgrp_con_sum (fromtime,totime);

create table dps_log_id (
	tablename	varchar(30)	not null,
	nextid	bigint	not null
,constraint dps_log_id_p primary key (tablename));

commit;



-- the source for this section is 
-- logging_init.sql




-- This file contains SQL statements which will initialize theDPS logging/reporting tables.
-- Set names of the default user event types, and initialize the log entry id counters

	START TRANSACTION;
	INSERT INTO dps_event_type (id, name) VALUES (0, 'newsession');
	INSERT INTO dps_event_type (id, name) VALUES (1, 'sessionexpiration');
	INSERT INTO dps_event_type (id, name) VALUES (2, 'login');
	INSERT INTO dps_event_type (id, name) VALUES (3, 'registration');
	INSERT INTO dps_event_type (id, name) VALUES (4, 'logout');
	INSERT INTO dps_log_id (tablename, nextid) VALUES ('dps_user_event', 0);
	INSERT INTO dps_log_id (tablename, nextid) VALUES ('dps_request', 0);
	INSERT INTO dps_log_id (tablename, nextid) VALUES ('dps_con_req', 0);
	COMMIT;
        
commit;



-- the source for this section is 
-- personalization_ddl.sql




-- This file contains create table statements needed to configure your database for personzalization assets.This script will create tables and indexes associated with the user segment list manager.

create table dps_seg_list (
	segment_list_id	varchar(40)	not null,
	display_name	varchar(256)	null,
	description	varchar(1024)	null,
	folder_id	varchar(40)	null
,constraint dps_seg_list_p primary key (segment_list_id));


create table dps_seg_list_name (
	segment_list_id	varchar(40)	not null,
	seq	integer	not null,
	group_name	varchar(256)	not null
,constraint dps_s_l_n_p primary key (segment_list_id,seq)
,constraint dps_s_l_n_f1 foreign key (segment_list_id) references dps_seg_list (segment_list_id));


create table dps_seg_list_folder (
	folder_id	varchar(40)	not null,
	display_name	varchar(256)	null,
	description	varchar(1024)	null,
	parent_folder_id	varchar(40)	null
,constraint dps_s_l_f_p primary key (folder_id)
,constraint dps_s_l_f_f1 foreign key (parent_folder_id) references dps_seg_list_folder (folder_id));

create index dps_sgmlstfldr1_x on dps_seg_list_folder (parent_folder_id);
commit;


