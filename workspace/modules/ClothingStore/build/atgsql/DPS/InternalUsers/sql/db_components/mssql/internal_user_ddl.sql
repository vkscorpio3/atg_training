


--  @version $Id: //product/DPS/version/11.2/templates/DPS/InternalUsers/sql/internal_user_ddl.xml#3 $$Change: 1179550 $
-- This file contains create table statements, which will configure your database for use with the new DPS schema.
-- Add the organization definition.  It's out of place, but since dpi_user references it, it's got to be defined up here

create table dpi_organization (
	org_id	varchar(40)	not null,
	name	varchar(254)	not null,
	description	varchar(254)	null,
	parent_org	varchar(40)	null
,constraint dpi_organization_p primary key (org_id)
,constraint dpi_organization_u unique (name)
,constraint dpi_orgnparnt_rg_f foreign key (parent_org) references dpi_organization (org_id))

create index dpi_orgparent_org on dpi_organization (parent_org)
-- Default Profile User Template
-- Basic user info.  note: the password field size must be at a minimum 70 characters       if DPS stores a hash of the password and not the actual value.

create table dpi_user (
	id	varchar(40)	not null,
	login	varchar(40)	not null,
	auto_login	numeric(1,0)	null,
	password	varchar(200)	null,
	password_salt	varchar(250)	null,
	password_kdf	varchar(40)	null,
	member	numeric(1,0)	null,
	first_name	varchar(40)	null,
	middle_name	varchar(40)	null,
	last_name	varchar(40)	null,
	user_type	integer	null,
	locale	integer	null,
	lastactivity_date	datetime	null,
	lastpwdupdate	datetime	null,
	generatedpwd	tinyint	null,
	registration_date	datetime	null,
	email	varchar(255)	null,
	email_status	integer	null,
	receive_email	integer	null,
	last_emailed	datetime	null,
	gender	integer	null,
	date_of_birth	datetime	null,
	securityStatus	integer	null,
	description	varchar(254)	null
,constraint dpi_user_p primary key (id)
,constraint dpi_user_u unique (login)
,constraint dpi_user1_c check (auto_login in (0,1))
,constraint dpi_user2_c check (member in (0,1)))


create table dpi_contact_info (
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
,constraint dpi_contact_info_p primary key (id))


create table dpi_user_address (
	id	varchar(40)	not null,
	home_addr_id	varchar(40)	null,
	billing_addr_id	varchar(40)	null,
	shipping_addr_id	varchar(40)	null
,constraint dpi_user_address_p primary key (id)
,constraint dpi_usrddrssid_f foreign key (id) references dpi_user (id))

create index dpi_usr_adr_shp_id on dpi_user_address (shipping_addr_id)
create index dpi_usr_blng_ad_id on dpi_user_address (billing_addr_id)
create index dpi_usr_home_ad_id on dpi_user_address (home_addr_id)

create table dpi_other_addr (
	user_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	address_id	varchar(40)	not null
,constraint dpi_other_addr_p primary key (user_id,tag)
,constraint dpi_othrddrusr_d_f foreign key (user_id) references dpi_user (id))


create table dpi_mailing (
	id	varchar(40)	not null,
	name	varchar(255)	null,
	subject	varchar(80)	null,
	uniq_server_id	varchar(255)	null,
	from_address	varchar(255)	null,
	replyto	varchar(255)	null,
	template_URL	varchar(255)	null,
	alt_template_URL	varchar(255)	null,
	batch_exec_id	varchar(40)	null,
	cc	varchar(2000)	null,
	bcc	varchar(2000)	null,
	send_as_html	integer	null,
	send_as_text	integer	null,
	params	image	null,
	start_time	datetime	null,
	end_time	datetime	null,
	status	integer	null,
	num_profiles	integer	null,
	num_sent	integer	null,
	num_bounces	integer	null,
	num_soft_bounces	integer	null,
	num_errors	integer	null,
	num_skipped	integer	null,
	fill_from_templ	numeric(1,0)	null,
	is_batched	tinyint	null,
	ignore_fatigue	tinyint	null,
	batch_size	integer	null
,constraint dpi_mailing_p primary key (id))


create table dpi_mail_trackdata (
	mailing_id	varchar(40)	not null,
	map_key	varchar(254)	not null,
	map_value	varchar(254)	null
,constraint dpi_mail_trackd_p primary key (mailing_id,map_key)
,constraint dpi_mail_trackd_f foreign key (mailing_id) references dpi_mailing (id))


create table dpi_mail_batch (
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
,constraint dpi_mail_batch_p primary key (mailing_id,start_idx)
,constraint dpi_mailbatch_d_f foreign key (mailing_id) references dpi_mailing (id))


create table dpi_mail_server (
	uniq_server_id	varchar(254)	not null,
	last_updated	datetime	null
,constraint dpi_mail_server_p primary key (uniq_server_id))


create table dpi_user_mailing (
	mailing_id	varchar(40)	not null,
	user_id	varchar(40)	not null,
	idx	integer	not null
,constraint dpi_user_mailing_p primary key (mailing_id,user_id)
,constraint dpi_usrmmalng_d_f foreign key (mailing_id) references dpi_mailing (id)
,constraint dpi_usrmlngusr_d_f foreign key (user_id) references dpi_user (id))

create index dpi_u_mail_uid on dpi_user_mailing (user_id)

create table dpi_email_address (
	mailing_id	varchar(40)	not null,
	email_address	varchar(255)	not null,
	idx	integer	not null
,constraint dpi_email_addres_p primary key (mailing_id,idx)
,constraint dpi_emldmalng_d_f foreign key (mailing_id) references dpi_mailing (id))

-- Organizations/roles

create table dpi_role (
	role_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	name	varchar(254)	not null,
	description	varchar(254)	null
,constraint dpi_role_p primary key (role_id))


create table dpi_template_role (
	role_id	varchar(40)	not null,
	template_role_id	varchar(40)	not null
,constraint dpi_tmplate_role_p primary key (role_id,template_role_id)
,constraint dpi_tpltrlrl_rl_f foreign key (template_role_id) references dpi_role (role_id)
,constraint dpi_tpltrltpl_d_f foreign key (role_id) references dpi_role (role_id))

create index dpi_tmplt_role_id on dpi_template_role (template_role_id)

create table dpi_access_right (
	access_right_id	varchar(40)	not null,
	right_type	integer	not null,
	right_scope	integer	not null,
	version	integer	not null,
	name	varchar(254)	not null,
	display_name	varchar(254)	null,
	description	varchar(254)	null
,constraint dpi_access_right_p primary key (access_right_id))


create table dpi_role_right (
	role_id	varchar(40)	not null,
	access_right_id	varchar(40)	not null
,constraint dpi_role_right_p primary key (role_id,access_right_id)
,constraint dpi_rlrightrt_rl_f foreign key (access_right_id) references dpi_access_right (access_right_id)
,constraint dpi_rlrightrl_d_f foreign key (role_id) references dpi_role (role_id))

create index dpi_access_rt_id on dpi_role_right (access_right_id)
-- Extending the user profile to include references to the roles that are assigned to this user

create table dpi_user_roles (
	user_id	varchar(40)	not null,
	atg_role	varchar(40)	not null
,constraint dpi_user_roles_p primary key (user_id,atg_role)
,constraint dpi_usrrlsatg_rl_f foreign key (atg_role) references dpi_role (role_id)
,constraint dpi_usrrlsusr_d_f foreign key (user_id) references dpi_user (id))

create index dpi_usr_roles_id on dpi_user_roles (atg_role)

create table dpi_org_role (
	org_id	varchar(40)	not null,
	atg_role	varchar(40)	not null
,constraint dpi_org_role_p primary key (org_id,atg_role)
,constraint dpi_orgrlorg_d_f foreign key (org_id) references dpi_organization (org_id)
,constraint dpi_orgrlatg_rl_f foreign key (atg_role) references dpi_role (role_id))

create index dpi_org_rolerole on dpi_org_role (atg_role)

create table dpi_role_rel_org (
	organization	varchar(40)	not null,
	sequence_num	integer	not null,
	role_id	varchar(40)	not null
,constraint dpi_role_rel_org_p primary key (organization,sequence_num)
,constraint dpi_rolrorgnztn_f foreign key (organization) references dpi_organization (org_id)
,constraint dpi_rolrlrgrol_d_f foreign key (role_id) references dpi_role (role_id))

create index dpi_role_rel_org on dpi_role_rel_org (role_id)

create table dpi_relativerole (
	role_id	varchar(40)	not null,
	dps_function	varchar(40)	not null,
	relative_to	varchar(40)	not null
,constraint dpi_relativerole_p primary key (role_id)
,constraint dpi_reltreltv_t_f foreign key (relative_to) references dpi_organization (org_id)
,constraint dpi_reltvrlrol_d_f foreign key (role_id) references dpi_role (role_id))

create index dpi_relativerole on dpi_relativerole (relative_to)

create table dpi_user_site_groups (
	user_id	varchar(40)	not null,
	site_group_id	varchar(40)	not null,
	access_level	integer	not null)


create table dpi_user_sites (
	user_id	varchar(40)	not null,
	site_id	varchar(40)	not null,
	access_level	integer	not null)


create table dpi_user_org (
	organization	varchar(40)	not null,
	user_id	varchar(40)	not null
,constraint dpi_user_org_p primary key (organization,user_id)
,constraint dpi_usrrgorgnztn_f foreign key (organization) references dpi_organization (org_id)
,constraint dpi_usrrgusr_d_f foreign key (user_id) references dpi_user (id))

create index dpi_usr_orgusr_id on dpi_user_org (user_id)

create table dpi_user_sec_orgs (
	user_id	varchar(40)	not null,
	secondary_org_id	varchar(40)	not null
,constraint dpi_usr_sec_orgs_p primary key (user_id,secondary_org_id)
,constraint dpi_usrsecorg_rl_f foreign key (secondary_org_id) references dpi_organization (org_id)
,constraint dpi_usrsorgusr_d_f foreign key (user_id) references dpi_user (id))

create index dpi_usr_sec_org_id on dpi_user_sec_orgs (secondary_org_id)

create table dpi_user_org_anc (
	user_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_org	varchar(40)	not null
,constraint dpi_user_org_anc_p primary key (user_id,sequence_num)
,constraint dpi_usrranc_rg_f foreign key (anc_org) references dpi_organization (org_id)
,constraint dpi_usrrgncusr_d_f foreign key (user_id) references dpi_user (id))

create index dpi_usr_org_ancanc on dpi_user_org_anc (anc_org)

create table dpi_org_chldorg (
	org_id	varchar(40)	not null,
	child_org_id	varchar(40)	not null
,constraint dpi_org_chldorg_p primary key (org_id,child_org_id)
,constraint dpi_orgcchild_rg_f foreign key (child_org_id) references dpi_organization (org_id)
,constraint dpi_orgcorg_d_f foreign key (org_id) references dpi_organization (org_id))

create index dpi_org_chldorg_id on dpi_org_chldorg (child_org_id)

create table dpi_org_ancestors (
	org_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_org	varchar(40)	not null
,constraint dpi_org_ancestor_p primary key (org_id,sequence_num)
,constraint dpi_orgnanc_rg_f foreign key (anc_org) references dpi_organization (org_id)
,constraint dpi_orgnorg_d_f foreign key (org_id) references dpi_organization (org_id))

create index dpi_org_ancanc_org on dpi_org_ancestors (anc_org)
-- Adding the folder information

create table dpi_folder (
	folder_id	varchar(40)	not null,
	type	integer	not null,
	name	varchar(254)	not null,
	parent	varchar(40)	null,
	description	varchar(254)	null
,constraint dpi_folder_p primary key (folder_id)
,constraint dpi_foldrparnt_f foreign key (parent) references dpi_folder (folder_id))

create index dpi_folderparent on dpi_folder (parent)

create table dpi_child_folder (
	folder_id	varchar(40)	not null,
	child_folder_id	varchar(40)	not null
,constraint dpi_child_folder_p primary key (folder_id,child_folder_id)
,constraint dpi_chilchild_fl_f foreign key (child_folder_id) references dpi_folder (folder_id)
,constraint dpi_chilfoldr_d_f foreign key (folder_id) references dpi_folder (folder_id))

create index dpi_chld_fldr_fld on dpi_child_folder (child_folder_id)

create table dpi_rolefold_chld (
	rolefold_id	varchar(40)	not null,
	role_id	varchar(40)	not null
,constraint dpi_rolefold_chl_p primary key (rolefold_id,role_id)
,constraint dpi_rolfrolfld_d_f foreign key (rolefold_id) references dpi_folder (folder_id)
,constraint dpi_rolfrol_d_f foreign key (role_id) references dpi_role (role_id))

create index dpi_rolfldchldrole on dpi_rolefold_chld (role_id)
-- Adding the previous password information

create table dpi_user_prevpwd (
	id	varchar(40)	not null,
	seq_num	integer	not null,
	prevpwd	varchar(200)	null
,constraint dpi_prevpwd_p primary key (id,seq_num)
,constraint dpi_prvpwd_d_f foreign key (id) references dpi_user (id))



go
