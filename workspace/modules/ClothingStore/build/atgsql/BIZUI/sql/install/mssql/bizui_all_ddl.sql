
-- the source for this section is 
-- id_generator.sql





create table das_id_generator (
	id_space_name	varchar(60)	not null,
	seed	numeric(19,0)	not null,
	batch_size	integer	not null,
	prefix	varchar(10)	null,
	suffix	varchar(10)	null
,constraint das_id_generator_p primary key (id_space_name))


create table das_secure_id_gen (
	id_space_name	varchar(60)	not null,
	seed	numeric(19,0)	not null,
	batch_size	integer	not null,
	ids_per_batch	integer	null,
	prefix	varchar(10)	null,
	suffix	varchar(10)	null
,constraint das_secure_id_ge_p primary key (id_space_name))



go

-- the source for this section is 
-- cluster_name_ddl.sql





create table das_cluster_name (
	cluster_name	varchar(255)	not null,
	saved_date	bigint	not null)



go

-- the source for this section is 
-- dms_limbo_ddl.sql




-- This table is where limbo instance/clients identify themselves. --There should only be one entry in this table for each Dynamo running PatchBay with message delays enabled.

create table dms_limbo (
	limbo_name	varchar(250)	not null,
	limbo_id	bigint	not null
,constraint limbo_pk primary key (limbo_name))

-- The following four tables comprise the parts of the stored messages.

create table dms_limbo_msg (
	msg_id	bigint	not null,
	limbo_id	bigint	not null,
	delivery_date	bigint	not null,
	delivery_count	tinyint	not null,
	msg_src_name	varchar(250)	not null,
	port_name	varchar(250)	not null,
	msg_class	varchar(250)	not null,
	msg_class_type	tinyint	not null,
	jms_type	varchar(250)	null,
	jms_expiration	bigint	null,
	jms_correlationid	varchar(250)	null
,constraint limbo_msg_pk primary key (msg_id))

create index dms_limbo_read_idx on dms_limbo_msg (limbo_id,delivery_date)
-- If serialized reply-to destinations are known to be small enough, this binary column's size can be reduced for efficiency.  The size here has been chosen to work with local dms and SQL-JMS.

create table dms_limbo_replyto (
	msg_id	bigint	not null,
	jms_replyto	varbinary(500)	null
,constraint limbo_replyto_pk primary key (msg_id))

-- If serialized message bodies are known to be small enough, this binary column's size can be reduced for efficiency.  The size here has been chosen to work with almost all types of messages but may be larger than necessary.  Actual usage analysis is recommended for finding the optimal binary column size.

create table dms_limbo_body (
	msg_id	bigint	not null,
	msg_body	image	null
,constraint limbo_body_pk primary key (msg_id))

-- This table represents a map of properties for messages stored above, i.e.  there can be multiple rows in this table for a single row in the preceeding tables.

create table dms_limbo_props (
	msg_id	bigint	not null,
	prop_name	varchar(250)	not null,
	prop_value	varchar(250)	not null
,constraint limbo_props_pk primary key (msg_id,prop_name))


create table dms_limbo_ptypes (
	msg_id	numeric(19,0)	not null,
	prop_name	varchar(250)	not null,
	prop_type	tinyint	not null
,constraint dms_limbo_ptypes_p primary key (msg_id,prop_name))


create table dms_limbo_delay (
	msg_id	numeric(19,0)	not null,
	delay	numeric(19,0)	not null,
	max_attempts	numeric(2,0)	not null,
	failure_port	varchar(250)	not null,
	jms_timestamp	numeric(19,0)	null,
	jms_deliverymode	numeric(10,0)	null,
	jms_priority	numeric(10,0)	null,
	jms_messageid	varchar(250)	null,
	jms_redelivered	numeric(1,0)	null,
	jms_destination	varbinary(500)	null
,constraint limbo_delay_pk primary key (msg_id))



go

-- the source for this section is 
-- create_sql_jms_ddl.sql





create table dms_client (
	client_name	varchar(250)	not null,
	client_id	numeric(19,0)	null
,constraint dms_client_p primary key (client_name))


create table dms_queue (
	queue_name	varchar(250)	null,
	queue_id	numeric(19,0)	not null,
	temp_id	numeric(19,0)	null
,constraint dms_queue_p primary key (queue_id))


create table dms_queue_recv (
	client_id	numeric(19,0)	null,
	receiver_id	numeric(19,0)	not null,
	queue_id	numeric(19,0)	null
,constraint dms_queue_recv_p primary key (receiver_id))


create table dms_queue_entry (
	queue_id	numeric(19,0)	not null,
	msg_id	numeric(19,0)	not null,
	delivery_date	numeric(19,0)	null,
	handling_client_id	numeric(19,0)	null,
	read_state	numeric(19,0)	null
,constraint dms_queue_entry_p primary key (queue_id,msg_id))

create index dms_queue_msg_idx on dms_queue_entry (msg_id)

create table dms_topic (
	topic_name	varchar(250)	null,
	topic_id	numeric(19,0)	not null,
	temp_id	numeric(19,0)	null
,constraint dms_topic_p primary key (topic_id))


create table dms_topic_sub (
	client_id	numeric(19,0)	null,
	subscriber_name	varchar(250)	null,
	subscriber_id	numeric(19,0)	not null,
	topic_id	numeric(19,0)	null,
	durable	numeric(1,0)	null,
	active	numeric(1,0)	null
,constraint dms_topic_sub_p primary key (subscriber_id))


create table dms_topic_entry (
	subscriber_id	numeric(19,0)	not null,
	msg_id	numeric(19,0)	not null,
	delivery_date	numeric(19,0)	null,
	read_state	numeric(19,0)	null
,constraint dms_topic_entry_p primary key (subscriber_id,msg_id))

create index dms_topic_msg_idx on dms_topic_entry (msg_id,subscriber_id)
create index dms_topic_read_idx on dms_topic_entry (read_state,delivery_date)

create table dms_msg (
	msg_class	varchar(250)	null,
	has_properties	numeric(1,0)	null,
	reference_count	numeric(10,0)	null,
	msg_id	numeric(19,0)	not null,
	timestamp	numeric(19,0)	null,
	correlation_id	varchar(250)	null,
	reply_to	numeric(19,0)	null,
	destination	numeric(19,0)	null,
	delivery_mode	numeric(1,0)	null,
	redelivered	numeric(1,0)	null,
	type	varchar(250)	null,
	expiration	numeric(19,0)	null,
	priority	numeric(1,0)	null,
	small_body	binary(250)	null,
	large_body	image	null
,constraint dms_msg_p primary key (msg_id))


create table dms_msg_properties (
	msg_id	numeric(19,0)	not null,
	data_type	numeric(1,0)	null,
	name	varchar(200)	not null,
	value	varchar(250)	null
,constraint dms_msg_properti_p primary key (msg_id,name))


go
      
create procedure dms_queue_flag
(@batchSize    INT
,@readLock     NUMERIC(19)
,@deliveryDate NUMERIC(19)
,@clientID     NUMERIC(19)
,@queueID      NUMERIC(19)
,@updateCount  NUMERIC(19) OUTPUT)
as
  SET ROWCOUNT @batchSize
  UPDATE dms_queue_entry 
  SET handling_client_id = @clientID, 
      read_state = @readLock 
  WHERE queue_id = @queueID
    AND handling_client_id < 0 
    AND delivery_date < @deliveryDate
  SELECT @updateCount = @@ROWCOUNT 
         
go

create procedure dms_topic_flag
(@batchSize    INT
,@readLock     NUMERIC(19)
,@deliveryDate NUMERIC(19)
,@subscriberID NUMERIC(19)
,@updateCount  NUMERIC(19) OUTPUT)
as
  SET ROWCOUNT @batchSize
  UPDATE dms_topic_entry 
  SET read_state = @readLock 
  WHERE subscriber_id = @subscriberID
    AND delivery_date < @deliveryDate 
    AND read_state = 0 
  SELECT @updateCount = @@ROWCOUNT 
         
go



-- the source for this section is 
-- create_staff_ddl.sql




-- SQL for creating the Dynamo Staff Repository for the GSA
-- Primary account table.
--  Type=1 is a login account.  The first_name, last_name, and password         fields are valid for this type of account.
-- Type=2 is a group account.  The description field is valid for        this type of account.
-- Type=4 is a privilege account.  The description field is valid for        this type of account.

create table das_account (
	account_name	varchar(254)	not null,
	type	integer	not null,
	first_name	varchar(254)	null,
	last_name	varchar(254)	null,
	password	varchar(254)	null,
	description	varchar(254)	null,
	lastpwdupdate	datetime	null,
	password_kdf	varchar(250)	null
,constraint das_account_p primary key (account_name))


create table das_group_assoc (
	account_name	varchar(254)	not null,
	sequence_num	integer	not null,
	group_name	varchar(254)	not null
,constraint das_grp_asc_p primary key (account_name,sequence_num))

-- Adding the previous password information

create table das_acct_prevpwd (
	account_name	varchar(254)	not null,
	seq_num	integer	not null,
	prevpwd	varchar(70)	null
,constraint das_prevpwd_p primary key (account_name,seq_num)
,constraint das_prvpwd_d_f foreign key (account_name) references das_account (account_name))



go

-- the source for this section is 
-- create_gsa_subscribers_ddl.sql





create table das_gsa_subscriber (
	id	integer	not null,
	address	varchar(50)	not null,
	port	integer	not null,
	repository	varchar(256)	not null,
	itemdescriptor	varchar(256)	not null
,constraint das_gsa_subscrib_p primary key (id))



go

-- the source for this section is 
-- create_sds.sql





create table das_sds (
	sds_name	varchar(50)	not null,
	curr_ds_name	varchar(50)	null,
	dynamo_server	varchar(80)	null,
	last_modified	datetime	null
,constraint das_sds_p primary key (sds_name))



go

-- the source for this section is 
-- integration_data_ddl.sql





create table if_integ_data (
	item_id	varchar(40)	not null,
	descriptor	varchar(64)	not null,
	repository	varchar(255)	not null,
	state	integer	not null,
	last_import	datetime	null,
	version	integer	not null
,constraint if_int_data_p primary key (item_id,descriptor,repository))



go

-- the source for this section is 
-- nucleus_security_ddl.sql





create table das_nucl_sec (
	func_name	varchar(254)	not null,
	policy	varchar(254)	not null
,constraint func_name_pk primary key (func_name))


create table das_ns_acls (
	id	varchar(254)	not null,
	index_num	integer	not null,
	acl	varchar(254)	not null
,constraint id_index_pk primary key (id,index_num))



go

-- the source for this section is 
-- media_ddl.sql




--     media content repository tables.  

create table media_folder (
	folder_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	datetime	null,
	description	varchar(254)	null,
	name	varchar(254)	not null,
	path	varchar(254)	not null,
	parent_folder_id	varchar(40)	null
,constraint md_folder_p primary key (folder_id)
,constraint md_foldparnt_fl_f foreign key (parent_folder_id) references media_folder (folder_id))

create index fldr_mfldrid_idx on media_folder (parent_folder_id)
create index md_fldr_path_idx on media_folder (path)

create table media_base (
	media_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	datetime	null,
	description	varchar(254)	null,
	name	varchar(254)	not null,
	path	varchar(254)	not null,
	parent_folder_id	varchar(40)	not null,
	media_type	integer	null
,constraint media_p primary key (media_id)
,constraint medparnt_fl_f foreign key (parent_folder_id) references media_folder (folder_id))

create index med_mfldrid_idx on media_base (parent_folder_id)
create index media_path_idx on media_base (path)
create index media_type_idx on media_base (media_type)

create table media_ext (
	media_id	varchar(40)	not null,
	url	varchar(254)	not null
,constraint media_ext_p primary key (media_id)
,constraint medxtmed_d_f foreign key (media_id) references media_base (media_id))


create table media_bin (
	media_id	varchar(40)	not null,
	length	integer	not null,
	last_modified	datetime	not null,
	data	image	not null
,constraint media_bin_p primary key (media_id)
,constraint medbnmed_d_f foreign key (media_id) references media_base (media_id))


create table media_txt (
	media_id	varchar(40)	not null,
	length	integer	not null,
	last_modified	datetime	not null,
	data	text	not null
,constraint media_txt_p primary key (media_id)
,constraint medtxtmed_d_f foreign key (media_id) references media_base (media_id))



go

-- the source for this section is 
-- deployment_ddl.sql




--     These tables are for the daf deployment system  

create table das_deployment (
	deployment_id	varchar(40)	not null,
	version	integer	not null,
	start_time	datetime	null,
	end_time	datetime	null,
	failure_time	datetime	null,
	status	integer	null,
	prev_status	integer	null,
	status_detail	varchar(255)	null,
	current_phase	integer	null,
	rep_high_mark	integer	null,
	rep_marks_avail	integer	null,
	file_high_mark	integer	null,
	file_marks_avail	integer	null,
	thread_batch_size	integer	null,
	failure_count	integer	null,
	purge_deploy_data	tinyint	null
,constraint daf_depl_pk primary key (deployment_id))

create index das_dpl_start_idx on das_deployment (start_time)

create table das_depl_progress (
	deployment_id	varchar(40)	not null,
	version	integer	not null,
	work_completed	integer	null,
	total_work	integer	null
,constraint daf_depl_prg_pk primary key (deployment_id))


create table das_thread_batch (
	thread_batch_id	varchar(40)	not null,
	version	integer	not null,
	deployment	varchar(40)	null,
	type	integer	null,
	owner	varchar(255)	null,
	thread_name	varchar(255)	null,
	lower_bound	integer	null,
	upper_bound	integer	null,
	last_update_time	datetime	null,
	running	tinyint	not null
,constraint das_dpl_tb_pk primary key (thread_batch_id))

create index das_tb_deployment on das_thread_batch (deployment)
create index das_tb_owner on das_thread_batch (owner)
create index das_tb_thread_nam on das_thread_batch (thread_name)

create table das_deploy_data (
	deploy_data_id	varchar(40)	not null,
	version	integer	not null,
	type	integer	null,
	source	varchar(255)	null,
	destination	varchar(255)	null,
	dest_server	varchar(255)	null,
	deployment	varchar(40)	null
,constraint deploy_data_pk primary key (deploy_data_id)
,constraint dd_deployment_fk foreign key (deployment) references das_deployment (deployment_id))

create index dd_deployment_idx on das_deploy_data (deployment)

create table das_deploy_mark (
	marker_id	varchar(40)	not null,
	version	integer	not null,
	type	integer	null,
	status	integer	null,
	index_number	integer	null,
	marker_action	integer	null,
	f_src_devline_id	varchar(40)	null,
	r_src_devline_id	varchar(40)	null,
	deployment_id	varchar(40)	null,
	deployment_data	varchar(40)	null
,constraint marker_pk primary key nonclustered  (marker_id))

create index marker_index_idx on das_deploy_mark (index_number)
create index marker_data_idx on das_deploy_mark (deployment_data)

create table das_rep_mark (
	rep_marker_id	varchar(40)	not null,
	item_desc_name	varchar(255)	null,
	item_id	varchar(255)	null
,constraint rep_marker_pk primary key nonclustered  (rep_marker_id))


create table das_file_mark (
	file_marker_id	varchar(40)	not null,
	file_path	varchar(1000)	null
,constraint file_marker_pk primary key nonclustered  (file_marker_id))


create table das_depl_depldat (
	deployment_id	varchar(40)	not null,
	sequence_num	integer	not null,
	deployment_data	varchar(40)	null
,constraint das_dpl_depdat_pk primary key (deployment_id,sequence_num))


create table das_depl_options (
	deployment_id	varchar(40)	not null,
	tag	varchar(255)	not null,
	optionValue	varchar(255)	null
,constraint das_dpl_depopt_pk primary key (deployment_id,tag))


create table das_depl_repmaps (
	deployment_id	varchar(40)	not null,
	source	varchar(255)	not null,
	destination	varchar(255)	null
,constraint das_dpl_repmap_pk primary key (deployment_id,source))


create table das_depl_item_ref (
	item_ref_id	varchar(40)	not null,
	version	integer	not null,
	deployment_id	varchar(40)	null,
	repository	varchar(255)	null,
	item_desc_name	varchar(255)	null,
	item_id	varchar(255)	null,
	item_index	integer	null
,constraint das_dpl_itmref_pk primary key (item_ref_id))

create index das_dpl_itmx_idx on das_depl_item_ref (item_index)
create index das_dpl_dplid_idx on das_depl_item_ref (deployment_id)

create table das_dd_markers (
	deploy_data_id	varchar(40)	not null,
	sequence_num	integer	not null,
	marker	varchar(40)	null
,constraint das_dpl_dd_mrk_pk primary key (deploy_data_id,sequence_num)
,constraint marker_fk foreign key (marker) references das_deploy_mark (marker_id))

create index marker_idx on das_dd_markers (marker)

create table das_dep_fail_info (
	id	varchar(40)	not null,
	deployment_id	varchar(40)	not null,
	marker_id	varchar(40)	null,
	severity	varchar(40)	null,
	failure_message	varchar(255)	null,
	failure_time	datetime	null,
	error_code	varchar(40)	null,
	cause	text	null
,constraint das_dp_fl_inf_pk primary key (id))

create index das_dep_fl_dp_idx on das_dep_fail_info (deployment_id)


go

-- the source for this section is 
-- sitemap_ddl.sql




-- Table for siteindex repository item

create table das_siteindex (
	siteindex_id	varchar(40)	not null,
	lastmod	datetime	null,
	filename	varchar(100)	null,
	xml	text	null
,constraint siteindex_pk primary key (siteindex_id))

-- Table for sitemap repository item

create table das_sitemap (
	sitemap_id	varchar(40)	not null,
	lastmod	datetime	null,
	filename	varchar(100)	null,
	xml	text	null
,constraint sitemap_pk primary key (sitemap_id))



go

-- the source for this section is 
-- versioned_seo_ddl.sql




-- Table for seo-tag repository item

create table das_seo_tag (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	seo_tag_id	varchar(40)	not null,
	display_name	varchar(100)	null,
	title	varchar(254)	null,
	description	varchar(254)	null,
	keywords	varchar(254)	null,
	content_key	varchar(100)	null
,constraint das_seo_tag_pk primary key (seo_tag_id,asset_version))

create index das_seo_tag_wsx on das_seo_tag (workspace_id)
create index das_seo_tag_cix on das_seo_tag (checkin_date)

create table das_seo_sites (
	asset_version	numeric(19)	not null,
	seo_tag_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint das_seo_site_pk primary key (seo_tag_id,site_id,asset_version))



go

-- the source for this section is 
-- versioned_site_ddl.sql




-- This file contains create table statements, which will configureyour database for use MultiSite

create table site_template (
	id	varchar(40)	not null,
	name	varchar(254)	not null,
	description	varchar(254)	not null,
	item_mapping_id	varchar(40)	not null
,constraint site_template1_p primary key (id))


create table site_configuration (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	id	varchar(40)	not null,
	type	integer	null,
	name	varchar(254)	not null,
	description	varchar(254)	null,
	template	varchar(40)	null,
	production_url	varchar(254)	null,
	enabled	tinyint	not null,
	site_down_url	varchar(254)	null,
	open_date	datetime	null,
	pre_opening_url	varchar(254)	null,
	closing_date	datetime	null,
	post_closing_url	varchar(254)	null,
	modification_time	datetime	null,
	creation_time	datetime	null,
	author	varchar(254)	null,
	last_modified_by	varchar(254)	null,
	site_icon	varchar(254)	null,
	favicon	varchar(254)	null,
	site_priority	integer	null,
	context_root	varchar(254)	null,
	access_level	integer	null,
	realm_id	varchar(40)	null,
	endeca_site_id	varchar(254)	null
,constraint site_configurat1_p primary key (id,asset_version))

create index site_configura_wsx on site_configuration (workspace_id)
create index site_configura_cix on site_configuration (checkin_date)

create table site_additional_urls (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	additional_production_url	varchar(254)	null,
	idx	integer	not null
,constraint siteadditio_url1_p primary key (id,idx,asset_version))


create table site_types (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	site_type	varchar(254)	not null
,constraint site_types1_p primary key (id,site_type,asset_version))


create table site_group (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	id	varchar(40)	not null,
	display_name	varchar(254)	not null,
	type	integer	null
,constraint site_group1_p primary key (id,asset_version))

create index site_group_wsx on site_group (workspace_id)
create index site_group_cix on site_group (checkin_date)

create table site_group_sites (
	asset_version	numeric(19)	not null,
	site_id	varchar(40)	not null,
	site_group_id	varchar(40)	not null
,constraint site_group_sites_p primary key (site_id,site_group_id,asset_version))


create table site_group_shareable_types (
	asset_version	numeric(19)	not null,
	shareable_types	varchar(254)	not null,
	site_group_id	varchar(40)	not null
,constraint site_group_share_p primary key (shareable_types,site_group_id,asset_version))



go

-- the source for this section is 
-- create_system_config.sql





create table das_sys_config (
	parameter_key	varchar(50)	not null,
	parameter_value	varchar(255)	not null
,constraint das_sys_config_p primary key (parameter_key))



go

-- the source for this section is 
-- purge_ddl.sql




-- 
-- Purge Progress Tables
-- $Id: //product/DAS/version/11.2/templates/DAS/sql/purge_ddl.xml#1 $
-- 

create table das_purge_progress (
	purge_progress_id	varchar(40)	not null,
	item_type	varchar(254)	not null,
	start_timestamp	datetime	null,
	update_timestamp	datetime	null,
	end_timestamp	datetime	null,
	status	integer	not null,
	success_items	integer	default 0 not null,
	skipped_items	integer	default 0 not null,
	skipped_on_error_items	integer	default 0 not null,
	error_items	integer	default 0 not null,
	processed_items	integer	default 0 not null,
	estimated_items	integer	default 0 not null,
	total_items	integer	default 0 not null,
	owner	varchar(254)	null,
	criteria	varchar(4000)	null,
	related_criteria	varchar(4000)	null,
	error_message	varchar(8000)	null
,constraint das_purge_pr_p primary key (purge_progress_id))



go

-- the source for this section is 
-- versioned_dynamic_metadata_ddl.sql




-- Tables for Dynamic Repository Metadata storage

create table das_gsa_dyn_type (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	id	varchar(40)	not null,
	type_name	varchar(254)	null,
	item_descriptor	varchar(254)	null,
	root_item_descriptor	varchar(254)	null,
	repository	varchar(254)	null,
	sub_type_value	varchar(254)	null,
	sub_type_num	integer	null,
	removed	numeric(1)	null
,constraint das_gsa_dyn_type_p primary key (id,asset_version))

create index das_gsa_dyn_ty_wsx on das_gsa_dyn_type (workspace_id)
create index das_gsa_dyn_ty_cix on das_gsa_dyn_type (checkin_date)

create table das_gsa_dyn_type_attr (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	attribute_key	varchar(254)	not null,
	attribute_value	varchar(254)	not null
,constraint das_gsa_dyn_type_attr_p primary key (id,attribute_key,asset_version))


create table das_gsa_dyn_prop (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	id	varchar(40)	not null,
	property_name	varchar(254)	not null,
	item_descriptor	varchar(254)	null,
	repository	varchar(254)	null,
	data_type	varchar(254)	null,
	backing_map	varchar(254)	null,
	removed	numeric(1)	null
,constraint das_gsa_dyn_prop_p primary key (id,asset_version))

create index das_gsa_dyn_pr_wsx on das_gsa_dyn_prop (workspace_id)
create index das_gsa_dyn_pr_cix on das_gsa_dyn_prop (checkin_date)

create table das_gsa_dyn_prop_enum (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	enumeration_values	varchar(254)	not null,
	enumeration_value_num	integer	not null
,constraint das_gsa_dyn_prop_enum_p primary key (id,enumeration_values,asset_version))


create table das_gsa_dyn_prop_eorder (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	seq_num	integer	not null,
	enumeration_order	varchar(254)	not null
,constraint das_gsa_dyn_prop_eorder_p primary key (id,seq_num,asset_version))


create table das_gsa_dyn_prop_attr (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	attribute_key	varchar(254)	not null,
	attribute_value	varchar(254)	not null
,constraint das_gsa_dyn_prop_attr_p primary key (id,attribute_key,asset_version))



go

-- the source for this section is 
-- versioned_backing_maps_ddl.sql




-- Tables for backing maps for item descriptors enables for dynamic properties

create table das_dyn_prop_map_str (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	varchar(400)	null
,constraint das_dyn_prop_map_str_p primary key (id,prop_name,asset_version))


create table das_dyn_prop_map_big_str (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	text	null
,constraint das_dyn_prop_map_big_str_p primary key (id,prop_name,asset_version))


create table das_dyn_prop_map_double (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19,7)	null
,constraint das_dyn_prop_map_double_p primary key (id,prop_name,asset_version))


create table das_dyn_prop_map_long (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19)	null
,constraint das_dyn_prop_map_long_p primary key (id,prop_name,asset_version))


create table das_dyn_prop_map_str_2 (
	asset_version	numeric(19)	not null,
	id1	varchar(40)	not null,
	id2	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	varchar(400)	null
,constraint das_dyn_prop_map_str_2_p primary key (id1,id2,prop_name,asset_version))


create table das_dyn_prop_map_big_str_2 (
	asset_version	numeric(19)	not null,
	id1	varchar(40)	not null,
	id2	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	text	null
,constraint das_dyn_prop_mp_bg_str_2_p primary key (id1,id2,prop_name,asset_version))


create table das_dyn_prop_map_double_2 (
	asset_version	numeric(19)	not null,
	id1	varchar(40)	not null,
	id2	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19,7)	null
,constraint das_dyn_prop_mp_dbl_2_p primary key (id1,id2,prop_name,asset_version))


create table das_dyn_prop_map_long_2 (
	asset_version	numeric(19)	not null,
	id1	varchar(40)	not null,
	id2	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19)	null
,constraint das_dyn_prop_mp_lng_2_p primary key (id1,id2,prop_name,asset_version))



go

-- the source for this section is 
-- user_ddl.sql




-- This file contains create table statements, which will configure your database for use with the new DPS schema.
-- Add the organization definition.  It's out of place, but since dps_user references it, it's got to be defined up here

create table dps_organization (
	org_id	varchar(40)	not null,
	name	varchar(254)	not null,
	description	varchar(254)	null,
	parent_org	varchar(40)	null
,constraint dps_organization_p primary key (org_id)
,constraint dps_orgnparnt_rg_f foreign key (parent_org) references dps_organization (org_id))

create index dps_orgparent_org on dps_organization (parent_org)
-- Default Profile User Template
-- Basic user info.  note: the password field size must be at a minimum 70 characters       if DPS stores a hash of the password and not the actual value.

create table dps_user (
	id	varchar(40)	not null,
	login	varchar(40)	not null,
	auto_login	numeric(1,0)	null,
	password	varchar(200)	null,
	password_salt	varchar(250)	null,
	password_kdf	varchar(40)	null,
	realm_id	varchar(40)	null,
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
,constraint dps_user_p primary key (id)
,constraint dps_user1_c check (auto_login in (0,1))
,constraint dps_user2_c check (member in (0,1)))

create unique index dps_user_u on dps_user (login,realm_id)

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
,constraint dps_contact_info_p primary key (id))


create table dps_user_address (
	id	varchar(40)	not null,
	home_addr_id	varchar(40)	null,
	billing_addr_id	varchar(40)	null,
	shipping_addr_id	varchar(40)	null
,constraint dps_user_address_p primary key (id)
,constraint dps_usrddrssid_f foreign key (id) references dps_user (id))

create index dps_usr_adr_shp_id on dps_user_address (shipping_addr_id)
create index dps_usr_blng_ad_id on dps_user_address (billing_addr_id)
create index dps_usr_home_ad_id on dps_user_address (home_addr_id)

create table dps_other_addr (
	user_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	address_id	varchar(40)	not null
,constraint dps_other_addr_p primary key (user_id,tag)
,constraint dps_othrddrusr_d_f foreign key (user_id) references dps_user (id))


create table dps_mailing (
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
	batch_size	integer	null,
	site_id	varchar(40)	null
,constraint dps_mailing_p primary key (id))


create table dps_mail_trackdata (
	mailing_id	varchar(40)	not null,
	map_key	varchar(254)	not null,
	map_value	varchar(254)	null
,constraint dps_mail_trackd_p primary key (mailing_id,map_key)
,constraint dps_mail_trackd_f foreign key (mailing_id) references dps_mailing (id))


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
,constraint dps_mailbatch_d_f foreign key (mailing_id) references dps_mailing (id))


create table dps_mail_server (
	uniq_server_id	varchar(254)	not null,
	last_updated	datetime	null
,constraint dps_mail_server_p primary key (uniq_server_id))


create table dps_user_mailing (
	mailing_id	varchar(40)	not null,
	user_id	varchar(40)	not null,
	idx	integer	not null
,constraint dps_user_mailing_p primary key (mailing_id,user_id)
,constraint dps_usrmmalng_d_f foreign key (mailing_id) references dps_mailing (id)
,constraint dps_usrmlngusr_d_f foreign key (user_id) references dps_user (id))

create index dps_u_mail_uid on dps_user_mailing (user_id)

create table dps_email_address (
	mailing_id	varchar(40)	not null,
	email_address	varchar(255)	not null,
	idx	integer	not null
,constraint dps_email_addres_p primary key (mailing_id,idx)
,constraint dps_emldmalng_d_f foreign key (mailing_id) references dps_mailing (id))

-- Organizations/roles

create table dps_role (
	role_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	name	varchar(254)	not null,
	description	varchar(254)	null
,constraint dps_role_p primary key (role_id))

-- Extending the user profile to include references to the roles that are assigned to this user

create table dps_user_roles (
	user_id	varchar(40)	not null,
	atg_role	varchar(40)	not null
,constraint dps_user_roles_p primary key (user_id,atg_role)
,constraint dps_usrrlsatg_rl_f foreign key (atg_role) references dps_role (role_id)
,constraint dps_usrrlsusr_d_f foreign key (user_id) references dps_user (id))

create index dps_usr_roles_id on dps_user_roles (atg_role)

create table dps_org_role (
	org_id	varchar(40)	not null,
	atg_role	varchar(40)	not null
,constraint dps_org_role_p primary key (org_id,atg_role)
,constraint dps_orgrlorg_d_f foreign key (org_id) references dps_organization (org_id)
,constraint dps_orgrlatg_rl_f foreign key (atg_role) references dps_role (role_id))

create index dps_org_rolerole on dps_org_role (atg_role)

create table dps_role_rel_org (
	organization	varchar(40)	not null,
	sequence_num	integer	not null,
	role_id	varchar(40)	not null
,constraint dps_role_rel_org_p primary key (organization,sequence_num)
,constraint dps_rolrorgnztn_f foreign key (organization) references dps_organization (org_id)
,constraint dps_rolrlrgrol_d_f foreign key (role_id) references dps_role (role_id))

create index dps_role_rel_org on dps_role_rel_org (role_id)

create table dps_relativerole (
	role_id	varchar(40)	not null,
	dps_function	varchar(40)	not null,
	relative_to	varchar(40)	not null
,constraint dps_relativerole_p primary key (role_id)
,constraint dps_reltreltv_t_f foreign key (relative_to) references dps_organization (org_id)
,constraint dps_reltvrlrol_d_f foreign key (role_id) references dps_role (role_id))

create index dps_relativerole on dps_relativerole (relative_to)

create table dps_user_org (
	organization	varchar(40)	not null,
	user_id	varchar(40)	not null
,constraint dps_user_org_p primary key (organization,user_id)
,constraint dps_usrrgorgnztn_f foreign key (organization) references dps_organization (org_id)
,constraint dps_usrrgusr_d_f foreign key (user_id) references dps_user (id))

create index dps_usr_orgusr_id on dps_user_org (user_id)

create table dps_user_org_anc (
	user_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_org	varchar(40)	not null
,constraint dps_user_org_anc_p primary key (user_id,sequence_num)
,constraint dps_usrranc_rg_f foreign key (anc_org) references dps_organization (org_id)
,constraint dps_usrrgncusr_d_f foreign key (user_id) references dps_user (id))

create index dps_usr_org_ancanc on dps_user_org_anc (anc_org)

create table dps_org_chldorg (
	org_id	varchar(40)	not null,
	child_org_id	varchar(40)	not null
,constraint dps_org_chldorg_p primary key (org_id,child_org_id)
,constraint dps_orgcchild_rg_f foreign key (child_org_id) references dps_organization (org_id)
,constraint dps_orgcorg_d_f foreign key (org_id) references dps_organization (org_id))

create index dps_org_chldorg_id on dps_org_chldorg (child_org_id)

create table dps_org_ancestors (
	org_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_org	varchar(40)	not null
,constraint dps_org_ancestor_p primary key (org_id,sequence_num)
,constraint dps_orgnanc_rg_f foreign key (anc_org) references dps_organization (org_id)
,constraint dps_orgnorg_d_f foreign key (org_id) references dps_organization (org_id))

create index dps_org_ancanc_org on dps_org_ancestors (anc_org)
-- Secondary organizations information

create table dps_user_sec_orgs (
	user_id	varchar(40)	not null,
	secondary_org_id	varchar(40)	not null
,constraint dps_usr_sec_orgs_p primary key (user_id,secondary_org_id)
,constraint dps_usrsecorg_rl_f foreign key (secondary_org_id) references dps_organization (org_id)
,constraint dps_usrsorgusr_d_f foreign key (user_id) references dps_user (id))

create index dps_usr_sec_org_id on dps_user_sec_orgs (secondary_org_id)
-- Adding the folder information

create table dps_folder (
	folder_id	varchar(40)	not null,
	type	integer	not null,
	name	varchar(254)	not null,
	parent	varchar(40)	null,
	description	varchar(254)	null
,constraint dps_folder_p primary key (folder_id)
,constraint dps_foldrparnt_f foreign key (parent) references dps_folder (folder_id))

create index dps_folderparent on dps_folder (parent)

create table dps_child_folder (
	folder_id	varchar(40)	not null,
	child_folder_id	varchar(40)	not null
,constraint dps_child_folder_p primary key (folder_id,child_folder_id)
,constraint dps_chilchild_fl_f foreign key (child_folder_id) references dps_folder (folder_id)
,constraint dps_chilfoldr_d_f foreign key (folder_id) references dps_folder (folder_id))

create index dps_chld_fldr_fld on dps_child_folder (child_folder_id)

create table dps_rolefold_chld (
	rolefold_id	varchar(40)	not null,
	role_id	varchar(40)	not null
,constraint dps_rolefold_chl_p primary key (rolefold_id,role_id)
,constraint dps_rolfrolfld_d_f foreign key (rolefold_id) references dps_folder (folder_id)
,constraint dps_rolfrol_d_f foreign key (role_id) references dps_role (role_id))

create index dps_rolfldchldrole on dps_rolefold_chld (role_id)
-- Adding the previous password information

create table dps_user_prevpwd (
	id	varchar(40)	not null,
	seq_num	integer	not null,
	prevpwd	varchar(200)	null
,constraint dps_prevpwd_p primary key (id,seq_num)
,constraint dps_prvpwd_d_f foreign key (id) references dps_user (id))


create table dps_profile_realm (
	id	varchar(40)	not null,
	name	varchar(255)	null,
	description	varchar(255)	null
,constraint dps_prfl_rlm_p primary key (id))



go

-- the source for this section is 
-- logging_ddl.sql




-- This file contains create table statements needed to configure your database for use with the DPS logging/reporting subsystem.This script will create tables and indexes associated with the newlogging and reporting subsystem. To initialize these tables run thelogging_init.sql script.
-- Tables for storing logging data for reports

create table dps_event_type (
	id	integer	not null,
	name	varchar(32)	not null
,constraint dps_event_type_p primary key (id)
,constraint dps_event_type_u unique (name))


create table dps_user_event (
	id	numeric(19,0)	not null,
	timestamp	datetime	not null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	eventtype	integer	not null,
	profileid	varchar(25)	null,
	member	numeric(1,0)	default 0 not null
,constraint dps_user_event_p primary key (id)
,constraint dps_usrvevnttyp_f foreign key (eventtype) references dps_event_type (id)
,constraint dps_user_event_c check (member in (0,1)))

create index dps_user_event_ix on dps_user_event (eventtype)
create index dps_ue_ts on dps_user_event (timestamp)

create table dps_user_event_sum (
	eventtype	integer	not null,
	summarycount	integer	not null,
	fromtime	datetime	not null,
	totime	datetime	not null
,constraint dps_usrsuevnttyp_f foreign key (eventtype) references dps_event_type (id))

create index dps_user_ev_sum_ix on dps_user_event_sum (eventtype)
create index dps_ues_ft on dps_user_event_sum (fromtime,totime,eventtype)

create table dps_request (
	id	numeric(19,0)	not null,
	timestamp	datetime	not null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	name	varchar(255)	not null,
	member	numeric(1,0)	default 0 not null
,constraint dps_request_p primary key (id)
,constraint dps_request_c check (member in (0,1)))

create index dps_r_ts on dps_request (timestamp)

create table dps_reqname_sum (
	name	varchar(255)	not null,
	member	numeric(1,0)	default 0 not null,
	summarycount	integer	not null,
	fromtime	datetime	not null,
	totime	datetime	not null
,constraint dps_reqname_sum_c check (member in (0,1)))

create index dps_rns_ft on dps_reqname_sum (fromtime,totime)

create table dps_session_sum (
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	member	numeric(1,0)	default 0 not null,
	summarycount	integer	not null,
	fromtime	datetime	not null,
	totime	datetime	not null
,constraint dps_session_sum_c check (member in (0,1)))

create index dps_rss_ft on dps_session_sum (fromtime,totime,sessionid)

create table dps_con_req (
	id	numeric(19,0)	not null,
	timestamp	datetime	not null,
	requestid	numeric(19,0)	null,
	contentid	varchar(255)	not null
,constraint dps_con_req_p primary key (id))

create index dps_cr_ts on dps_con_req (timestamp)

create table dps_con_req_sum (
	contentid	varchar(255)	not null,
	member	numeric(1,0)	default 0 not null,
	summarycount	integer	not null,
	fromtime	datetime	not null,
	totime	datetime	not null
,constraint dps_con_req_sum_c check (member in (0,1)))

create index dps_crs_ft on dps_con_req_sum (fromtime,totime)

create table dps_pgrp_req_sum (
	groupname	nvarchar(64)	not null,
	contentname	nvarchar(255)	not null,
	summarycount	integer	not null,
	fromtime	datetime	not null,
	totime	datetime	not null)

create index dps_prs_ft on dps_pgrp_req_sum (fromtime,totime)

create table dps_pgrp_con_sum (
	groupname	nvarchar(64)	not null,
	contentname	nvarchar(64)	not null,
	summarycount	integer	not null,
	fromtime	datetime	not null,
	totime	datetime	not null)

create index dps_pcs_ft on dps_pgrp_con_sum (fromtime,totime)

create table dps_log_id (
	tablename	varchar(30)	not null,
	nextid	numeric(19,0)	not null
,constraint dps_log_id_p primary key (tablename))



go

-- the source for this section is 
-- logging_init.sql




-- This file contains SQL statements which will initialize theDPS logging/reporting tables.
-- Set names of the default user event types, and initialize the log entry id counters

	BEGIN TRANSACTION
	INSERT INTO dps_event_type (id, name) VALUES (0, 'newsession')
	INSERT INTO dps_event_type (id, name) VALUES (1, 'sessionexpiration')
	INSERT INTO dps_event_type (id, name) VALUES (2, 'login')
	INSERT INTO dps_event_type (id, name) VALUES (3, 'registration')
	INSERT INTO dps_event_type (id, name) VALUES (4, 'logout')
	INSERT INTO dps_log_id (tablename, nextid)
	VALUES ('dps_user_event', 0)

	INSERT INTO dps_log_id (tablename, nextid)
	VALUES ('dps_request', 0)

	INSERT INTO dps_log_id (tablename, nextid)
	VALUES ('dps_con_req', 0)
	COMMIT
        


go

-- the source for this section is 
-- versioned_personalization_ddl.sql




-- This file contains create table statements needed to configure your database for personzalization assets.This script will create tables and indexes associated with the user segment list manager.

create table dps_seg_list (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	segment_list_id	varchar(40)	not null,
	display_name	varchar(256)	null,
	description	varchar(1024)	null,
	folder_id	varchar(40)	null
,constraint dps_seg_list_p primary key (segment_list_id,asset_version))

create index dps_seg_list_wsx on dps_seg_list (workspace_id)
create index dps_seg_list_cix on dps_seg_list (checkin_date)

create table dps_seg_list_name (
	asset_version	numeric(19)	not null,
	segment_list_id	varchar(40)	not null,
	seq	integer	not null,
	group_name	varchar(256)	not null
,constraint dps_s_l_n_p primary key (segment_list_id,seq,asset_version))


create table dps_seg_list_folder (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	folder_id	varchar(40)	not null,
	display_name	varchar(256)	null,
	description	varchar(1024)	null,
	parent_folder_id	varchar(40)	null
,constraint dps_s_l_f_p primary key (folder_id,asset_version))

create index dps_seg_list_f_wsx on dps_seg_list_folder (workspace_id)
create index dps_seg_list_f_cix on dps_seg_list_folder (checkin_date)


go

-- the source for this section is 
-- internal_user_ddl.sql




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

-- the source for this section is 
-- das_mappers.sql





create table dss_das_event (
	id	varchar(32)	not null,
	timestamp	datetime	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null)


create table dss_das_form (
	id	varchar(32)	not null,
	clocktime	datetime	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	formname	varchar(254)	null)



go

-- the source for this section is 
-- dps_mappers.sql





create table dss_dps_event (
	id	varchar(32)	not null,
	timestamp	datetime	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	profileid	varchar(25)	null,
	scenarioPathInfo	varchar(254)	null)


create table dss_dps_page_visit (
	id	varchar(32)	not null,
	timestamp	datetime	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	path	varchar(255)	null,
	profileid	varchar(25)	null)


create table dss_dps_view_item (
	id	varchar(32)	not null,
	timestamp	datetime	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	repositoryname	varchar(255)	null,
	folder	varchar(255)	null,
	itemtype	varchar(255)	null,
	repositoryid	varchar(255)	null,
	itemdescriptor	varchar(255)	null,
	page	varchar(255)	null,
	profileid	varchar(25)	null)


create table dss_dps_click (
	id	varchar(32)	not null,
	timestamp	datetime	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	destinationpath	varchar(255)	null,
	sourcenames	varchar(255)	null,
	sourcepath	varchar(255)	null,
	profileid	varchar(25)	null)


create table dss_dps_referrer (
	id	varchar(32)	not null,
	timestamp	datetime	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	referrerpath	varchar(255)	null,
	referrersite	varchar(255)	null,
	referrerpage	varchar(255)	null,
	profileid	varchar(25)	null)


create table dss_dps_inbound (
	id	varchar(32)	not null,
	timestamp	datetime	null,
	messagesubject	varchar(255)	null,
	originalsubject	varchar(255)	null,
	messagefrom	varchar(64)	null,
	messageto	varchar(255)	null,
	messagecc	varchar(255)	null,
	messagereplyto	varchar(64)	null,
	receiveddate	numeric(19,0)	null,
	bounced	varchar(6)	null,
	bounceemailaddr	varchar(255)	null,
	bouncereplycode	varchar(10)	null,
	bounceerrormess	varchar(255)	null,
	bouncestatuscode	varchar(10)	null)


create table dss_dps_admin_reg (
	id	varchar(32)	not null,
	clocktime	datetime	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	adminprofileid	varchar(25)	null,
	profileid	varchar(25)	null)


create table dss_dps_property (
	id	varchar(32)	not null,
	clocktime	datetime	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	propertypath	varchar(254)	null,
	oldvalue	varchar(254)	null,
	newvalue	varchar(254)	null,
	changesign	varchar(16)	null,
	changeamount	numeric(19,7)	null,
	changepercentage	numeric(19,7)	null,
	elementsadded	varchar(254)	null,
	elementsremoved	varchar(254)	null,
	profileid	varchar(25)	null)


create table dss_dps_admin_prop (
	id	varchar(32)	not null,
	clocktime	datetime	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	propertypath	varchar(254)	null,
	oldvalue	varchar(254)	null,
	newvalue	varchar(254)	null,
	changesign	varchar(16)	null,
	changeamount	numeric(19,7)	null,
	changepercentage	numeric(19,7)	null,
	elementsadded	varchar(254)	null,
	elementsremoved	varchar(254)	null,
	adminprofileid	varchar(25)	null,
	profileid	varchar(25)	null)


create table dss_dps_update (
	id	varchar(32)	not null,
	clocktime	datetime	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	changedproperties	text	null,
	oldvalues	text	null,
	newvalues	text	null,
	profileid	varchar(25)	null)


create table dss_dps_admin_up (
	id	varchar(32)	not null,
	clocktime	datetime	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	changedproperties	text	null,
	oldvalues	text	null,
	newvalues	text	null,
	adminprofileid	varchar(25)	null,
	profileid	varchar(25)	null)


create table dps_scenario_value (
	id	varchar(40)	not null,
	tag	varchar(42)	not null,
	scenario_value	varchar(100)	null
,constraint dps_scenario_val_p primary key (id,tag)
,constraint dps_scenrvlid_f foreign key (id) references dps_user (id))

create index dps_scenval_id on dps_scenario_value (id)


go

-- the source for this section is 
-- dss_mappers.sql





create table dss_audit_trail (
	id	varchar(32)	not null,
	timestamp	datetime	null,
	label	varchar(255)	null,
	profileid	varchar(25)	null,
	segmentName	varchar(254)	null,
	processName	varchar(254)	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null)



go

-- the source for this section is 
-- scenario_ddl.sql





create table dss_coll_scenario (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	modification_time	numeric(19,0)	null,
	segment_name	varchar(255)	null,
	creator_id	varchar(25)	null,
	state	varchar(16)	null
,constraint dss_coll_scenari_p primary key (id))

-- user_id references the user table but because it is a backwards referencewe cannot have a REFERENCES(dps_user) here.

create table dss_ind_scenario (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	modification_time	numeric(19,0)	null,
	segment_name	varchar(255)	null,
	creator_id	varchar(25)	null,
	state	varchar(16)	null,
	user_id	varchar(25)	not null,
	expiration_time	numeric(19,0)	null
,constraint dss_ind_scenario_p primary key (id))

create index dss_indscenario1_x on dss_ind_scenario (modification_time)

create table dss_scenario_strs (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_str	varchar(255)	null
,constraint dss_scenario_str_p primary key (id,tag)
,constraint dss_scenrstrsid_f foreign key (id) references dss_ind_scenario (id))

create index dss_scn_st_idx on dss_scenario_strs (id)

create table dss_scenario_bools (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_bool	numeric(1,0)	null
,constraint dss_scenario_boo_p primary key (id,tag)
,constraint dss_scenrblsid_f foreign key (id) references dss_ind_scenario (id))

create index dss_scn_bo_idx on dss_scenario_bools (id)

create table dss_scenario_longs (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_long	numeric(19,0)	null
,constraint dss_scenario_lon_p primary key (id,tag)
,constraint dss_scenrlngsid_f foreign key (id) references dss_ind_scenario (id))

create index dss_scn_lg_idx on dss_scenario_longs (id)

create table dss_scenario_dbls (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_dbl	numeric(15,4)	null
,constraint dss_scenario_dbl_p primary key (id,tag)
,constraint dss_scenrdblsid_f foreign key (id) references dss_ind_scenario (id))

create index dss_scn_db_idx on dss_scenario_dbls (id)

create table dss_scenario_dates (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_date	datetime	null
,constraint dss_scenario_dat_p primary key (id,tag)
,constraint dss_scenrdtsid_f foreign key (id) references dss_ind_scenario (id))

create index dss_scn_dt_idx on dss_scenario_dates (id)

create table dps_user_scenario (
	id	varchar(40)	not null,
	ind_scenario_id	varchar(25)	not null
,constraint dps_user_scenari_p primary key (ind_scenario_id)
,constraint dps_usrscnrid_f foreign key (id) references dps_user (id)
,constraint dps_usrsind_scnr_f foreign key (ind_scenario_id) references dss_ind_scenario (id))

create index dps_uscn_u_idx on dps_user_scenario (id)

create table dss_scenario_info (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	scenario_status	integer	null,
	modification_time	numeric(19,0)	null,
	creation_time	numeric(19,0)	null,
	author	varchar(254)	null,
	last_modified_by	varchar(254)	null,
	sdl	image	null,
	psm_version	integer	null
,constraint dss_scenario_inf_p primary key (id))

create unique index dss_scenario_inf_x on dss_scenario_info (scenario_name)

create table dss_scen_mig_info (
	id	varchar(25)	not null,
	scenario_info_id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	modification_time	bigint	null,
	psm_version	integer	null,
	sdl	image	null,
	migration_status	integer	null
,constraint dss_scenmiginfo_pk primary key (id)
,constraint dss_scenmiginfo_fk foreign key (scenario_info_id) references dss_scenario_info (id))

create index dss_scenmiginfo_id on dss_scen_mig_info (scenario_info_id)

create table dss_mig_info_seg (
	id	varchar(25)	not null,
	idx	integer	not null,
	segment_name	varchar(255)	null
,constraint dss_mig_infoseg_pk primary key (id,idx)
,constraint dss_mig_infoseg_fk foreign key (id) references dss_scen_mig_info (id))


create table dss_template_info (
	id	varchar(25)	not null,
	template_name	varchar(255)	null,
	modification_time	numeric(19,0)	null,
	creation_time	numeric(19,0)	null,
	author	varchar(254)	null,
	last_modified_by	varchar(254)	null,
	sdl	image	null
,constraint dss_template_inf_p primary key (id))

create unique index dss_template_inf_x on dss_template_info (template_name)

create table dss_coll_trans (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	modification_time	numeric(19,0)	null,
	server_id	varchar(80)	null,
	message_bean	image	null,
	event_type	varchar(255)	null,
	segment_name	varchar(255)	null,
	state	varchar(16)	null,
	coll_scenario_id	varchar(25)	null,
	step	integer	null,
	current_count	integer	null,
	last_query_id	varchar(25)	null
,constraint dss_coll_trans_p primary key (id)
,constraint dss_collcoll_scn_f foreign key (coll_scenario_id) references dss_coll_scenario (id))

create index dss_ctrcid_idx on dss_coll_trans (coll_scenario_id)

create table dss_ind_trans (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	modification_time	numeric(19,0)	null,
	server_id	varchar(80)	null,
	message_bean	image	null,
	event_type	varchar(255)	null,
	segment_name	varchar(255)	null,
	state	varchar(16)	null,
	last_query_id	varchar(25)	null
,constraint dss_ind_trans_p primary key (id))


create table dss_deletion (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	modification_time	numeric(19,0)	null
,constraint dss_deletion_p primary key (id))


create table dss_server_id (
	server_id	varchar(80)	not null,
	server_type	integer	not null
,constraint dss_server_id_p primary key (server_id))


create table dss_del_seg_name (
	id	varchar(25)	not null,
	idx	integer	not null,
	segment_name	varchar(255)	null
,constraint dss_del_seg_name_p primary key (id,idx))

-- migration_info_id references the migration info table, but we don't have aREFERENCES dss_scen_mig_info(id) here, because we want to be ableto delete the migration info without deleting this row

create table dss_migration (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	old_mod_time	bigint	null,
	new_mod_time	bigint	null,
	migration_info_id	varchar(25)	null
,constraint dss_migration_pk primary key (id))


create table dss_mig_seg_name (
	id	varchar(25)	not null,
	idx	integer	not null,
	segment_name	varchar(255)	null
,constraint dss_mig_segname_pk primary key (id,idx)
,constraint dss_mig_segname_fk foreign key (id) references dss_migration (id))


create table dss_xref (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	reference_type	varchar(30)	null,
	reference_target	varchar(255)	null
,constraint dss_xref_p primary key (id))

-- user_id references the user table but because it is a backwards referencewe cannot have a REFERENCES(dps_user) here.

create table dss_profile_slot (
	id	varchar(25)	not null,
	slot_name	varchar(255)	null,
	item_offset	numeric(19,0)	null,
	user_id	varchar(25)	not null
,constraint dss_profile_slot_p primary key (id))


create table dps_user_slot (
	id	varchar(40)	not null,
	profile_slot_id	varchar(25)	not null
,constraint dps_user_slot_p primary key (id,profile_slot_id)
,constraint dps_usrsltid_f foreign key (id) references dps_user (id)
,constraint dps_usrsprofl_sl_f foreign key (profile_slot_id) references dss_profile_slot (id))

create index dps_usr_sltprfl_id on dps_user_slot (profile_slot_id)

create table dss_slot_items (
	slot_id	varchar(25)	not null,
	item_id	varchar(255)	null,
	idx	integer	not null
,constraint dss_slot_items_p primary key (slot_id,idx)
,constraint dss_slotslot_d_f foreign key (slot_id) references dss_profile_slot (id))


create table dss_slot_priority (
	slot_id	varchar(25)	not null,
	idx	integer	not null,
	priority	numeric(19,0)	not null
,constraint dss_slot_priorit_p primary key (slot_id,idx)
,constraint dss_slotpslot_d_f foreign key (slot_id) references dss_profile_slot (id))



go

-- the source for this section is 
-- markers_ddl.sql





create table dps_markers (
	marker_id	varchar(40)	not null,
	marker_key	varchar(100)	not null,
	marker_value	varchar(100)	null,
	marker_data	varchar(100)	null,
	creation_date	datetime	null,
	version	integer	not null,
	marker_type	integer	null
,constraint dps_markers_p primary key (marker_id))


create table dps_usr_markers (
	profile_id	varchar(40)	not null,
	marker_id	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dps_usr_markers_p primary key (profile_id,sequence_num)
,constraint dpsusrmarkers_u_f foreign key (profile_id) references dps_user (id)
,constraint dpsusrmarkers_m_f foreign key (marker_id) references dps_markers (marker_id))

create index dpsusrmarkers1_ix on dps_usr_markers (marker_id)


go

-- the source for this section is 
-- business_process_rpt_ddl.sql





create table drpt_stage_reached (
	id	varchar(40)	not null,
	owner_id	varchar(40)	not null,
	process_start_time	datetime	not null,
	event_time	datetime	not null,
	bp_name	varchar(255)	not null,
	bp_stage	varchar(255)	null,
	is_transient	tinyint	not null,
	bp_stage_sequence	integer	not null
,constraint drpt_bpstage_c check (is_transient in (0,1)))



go

-- the source for this section is 
-- profile_bp_markers_ddl.sql





create table dss_user_bpmarkers (
	marker_id	varchar(40)	not null,
	profile_id	varchar(40)	not null,
	marker_key	varchar(100)	not null,
	marker_value	varchar(100)	null,
	marker_data	varchar(100)	null,
	creation_date	datetime	null,
	version	integer	not null,
	marker_type	integer	null
,constraint dssprofilebp_p primary key (marker_id,profile_id))



go

-- the source for this section is 
-- internal_scenario_ddl.sql





create table dsi_coll_scenario (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	modification_time	numeric(19,0)	null,
	segment_name	varchar(255)	null,
	creator_id	varchar(25)	null,
	state	varchar(16)	null
,constraint dsi_coll_scenari_p primary key (id))

-- user_id references the user table but because it is a backwards referencewe cannot have a REFERENCES(dps_user) here.

create table dsi_ind_scenario (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	modification_time	numeric(19,0)	null,
	segment_name	varchar(255)	null,
	creator_id	varchar(25)	null,
	state	varchar(16)	null,
	user_id	varchar(25)	not null
,constraint dsi_ind_scenario_p primary key (id))

create index dsi_indscenario1_x on dsi_ind_scenario (modification_time)

create table dsi_scenario_strs (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_str	varchar(255)	null
,constraint dsi_scenario_str_p primary key (id,tag)
,constraint dsi_scenrstrsid_f foreign key (id) references dsi_ind_scenario (id))


create table dsi_scenario_bools (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_bool	numeric(1,0)	null
,constraint dsi_scenario_boo_p primary key (id,tag)
,constraint dsi_scenrblsid_f foreign key (id) references dsi_ind_scenario (id))


create table dsi_scenario_longs (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_long	numeric(19,0)	null
,constraint dsi_scenario_lon_p primary key (id,tag)
,constraint dsi_scenrlngsid_f foreign key (id) references dsi_ind_scenario (id))


create table dsi_scenario_dbls (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_dbl	numeric(15,4)	null
,constraint dsi_scenario_dbl_p primary key (id,tag)
,constraint dsi_scenrdblsid_f foreign key (id) references dsi_ind_scenario (id))


create table dsi_scenario_dates (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_date	datetime	null
,constraint dsi_scenario_dat_p primary key (id,tag)
,constraint dsi_scenrdtsid_f foreign key (id) references dsi_ind_scenario (id))


create table dpi_user_scenario (
	id	varchar(40)	not null,
	ind_scenario_id	varchar(25)	not null
,constraint dpi_user_scenari_p primary key (ind_scenario_id)
,constraint dpi_usrscnrid_f foreign key (id) references dpi_user (id)
,constraint dpi_usrsind_scnr_f foreign key (ind_scenario_id) references dsi_ind_scenario (id))

create index dpi_uscn_u_idx on dpi_user_scenario (id)

create table dsi_scenario_info (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	scenario_status	integer	null,
	modification_time	numeric(19,0)	null,
	creation_time	numeric(19,0)	null,
	author	varchar(254)	null,
	last_modified_by	varchar(254)	null,
	sdl	image	null,
	psm_version	integer	null
,constraint dsi_scenario_inf_p primary key (id))

create unique index dsi_scenario_inf_x on dsi_scenario_info (scenario_name)

create table dsi_scen_mig_info (
	id	varchar(25)	not null,
	scenario_info_id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	modification_time	bigint	null,
	psm_version	integer	null,
	sdl	image	null,
	migration_status	integer	null
,constraint dsi_scenmiginfo_pk primary key (id)
,constraint dsi_scenmiginfo_fk foreign key (scenario_info_id) references dsi_scenario_info (id))

create index dsi_scenmiginfo_id on dsi_scen_mig_info (scenario_info_id)

create table dsi_mig_info_seg (
	id	varchar(25)	not null,
	idx	integer	not null,
	segment_name	varchar(255)	null
,constraint dsi_mig_infoseg_pk primary key (id,idx)
,constraint dsi_mig_infoseg_fk foreign key (id) references dsi_scen_mig_info (id))


create table dsi_template_info (
	id	varchar(25)	not null,
	template_name	varchar(255)	null,
	modification_time	numeric(19,0)	null,
	creation_time	numeric(19,0)	null,
	author	varchar(254)	null,
	last_modified_by	varchar(254)	null,
	sdl	image	null
,constraint dsi_template_inf_p primary key (id))

create unique index dsi_template_inf_x on dsi_template_info (template_name)

create table dsi_coll_trans (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	modification_time	numeric(19,0)	null,
	server_id	varchar(80)	null,
	message_bean	image	null,
	event_type	varchar(255)	null,
	segment_name	varchar(255)	null,
	state	varchar(16)	null,
	coll_scenario_id	varchar(25)	null,
	step	integer	null,
	current_count	integer	null,
	last_query_id	varchar(25)	null
,constraint dsi_coll_trans_p primary key (id)
,constraint dsi_collcoll_scn_f foreign key (coll_scenario_id) references dsi_coll_scenario (id))

create index dsi_ctrcid_idx on dsi_coll_trans (coll_scenario_id)

create table dsi_ind_trans (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	modification_time	numeric(19,0)	null,
	server_id	varchar(80)	null,
	message_bean	image	null,
	event_type	varchar(255)	null,
	segment_name	varchar(255)	null,
	state	varchar(16)	null,
	last_query_id	varchar(25)	null
,constraint dsi_ind_trans_p primary key (id))


create table dsi_deletion (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	modification_time	numeric(19,0)	null
,constraint dsi_deletion_p primary key (id))


create table dsi_server_id (
	server_id	varchar(80)	not null,
	server_type	integer	not null
,constraint dsi_server_id_p primary key (server_id))


create table dsi_del_seg_name (
	id	varchar(25)	not null,
	idx	integer	not null,
	segment_name	varchar(255)	null
,constraint dsi_del_seg_name_p primary key (id,idx))

-- migration_info_id references the migration info table, but we don't have aREFERENCES dsi_scen_mig_info(id) here, because we want to be ableto delete the migration info without deleting this row

create table dsi_migration (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	old_mod_time	bigint	null,
	new_mod_time	bigint	null,
	migration_info_id	varchar(25)	null
,constraint dsi_migration_pk primary key (id))


create table dsi_mig_seg_name (
	id	varchar(25)	not null,
	idx	integer	not null,
	segment_name	varchar(255)	null
,constraint dsi_mig_segname_pk primary key (id,idx)
,constraint dsi_mig_segname_fk foreign key (id) references dsi_migration (id))


create table dsi_xref (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	null,
	reference_type	varchar(30)	null,
	reference_target	varchar(255)	null
,constraint dsi_xref_p primary key (id))

-- user_id references the user table but because it is a backwards referencewe cannot have a REFERENCES(dpi_user) here.

create table dsi_profile_slot (
	id	varchar(25)	not null,
	slot_name	varchar(255)	null,
	item_offset	numeric(19,0)	null,
	user_id	varchar(25)	not null
,constraint dsi_profile_slot_p primary key (id))


create table dpi_user_slot (
	id	varchar(40)	not null,
	profile_slot_id	varchar(25)	not null
,constraint dpi_user_slot_p primary key (id,profile_slot_id)
,constraint dpi_usrsltid_f foreign key (id) references dpi_user (id)
,constraint dpi_usrsprofl_sl_f foreign key (profile_slot_id) references dsi_profile_slot (id))

create index dpi_usr_sltprfl_id on dpi_user_slot (profile_slot_id)

create table dsi_slot_items (
	slot_id	varchar(25)	not null,
	item_id	varchar(255)	null,
	idx	integer	not null
,constraint dsi_slot_items_p primary key (slot_id,idx)
,constraint dsi_slotslot_d_f foreign key (slot_id) references dsi_profile_slot (id))


create table dsi_slot_priority (
	slot_id	varchar(25)	not null,
	idx	integer	not null,
	priority	numeric(19,0)	not null
,constraint dsi_slot_priorit_p primary key (slot_id,idx)
,constraint dsi_slotpslot_d_f foreign key (slot_id) references dsi_profile_slot (id))


create table dpi_scenario_value (
	id	varchar(40)	not null,
	tag	varchar(42)	not null,
	scenario_value	varchar(100)	null
,constraint dpi_scenario_val_p primary key (id,tag)
,constraint dpi_scenrvlid_f foreign key (id) references dpi_user (id))

create index dpi_scenval_id on dpi_scenario_value (id)


go



--  @version $Id: //app/portal/version/11.2/paf/sql/alert_ddl.xml#1 $$Change: 946917 $

create table alt_user (
	id	varchar(40)	not null,
	version	integer	default 0 not null,
	target_id	varchar(40)	not null,
	target_type	varchar(40)	not null,
	source_id	varchar(40)	null,
	msg_type	varchar(255)	null,
	message_bean	image	null,
	creation_date	datetime	null,
	end_date	datetime	null,
	start_date	datetime	null,
	delete_flag	numeric(1,0)	not null
,constraint alt_userpk primary key (id))

create index alt_user_idx on alt_user (target_id,target_type,source_id)

create table alt_group (
	id	varchar(40)	not null,
	version	integer	not null,
	target_id	varchar(40)	not null,
	target_type	varchar(40)	not null,
	source_id	varchar(40)	null,
	msg_type	varchar(255)	null,
	message_bean	image	null,
	creation_date	datetime	null,
	end_date	datetime	null,
	start_date	datetime	null,
	delete_flag	numeric(1,0)	not null
,constraint alt_grouppk primary key (id))

create index alt_group_idx on alt_group (target_id,target_type,source_id)

create table alt_user_alert_rel (
	id	varchar(40)	not null,
	alert_id	varchar(40)	not null
,constraint alt_useralertrel_p primary key (id,alert_id))


create table alt_user_pref (
	id	varchar(40)	not null,
	source_id	varchar(40)	not null,
	source_type	varchar(40)	not null,
	version	integer	not null,
	event_type	varchar(255)	null,
	name	varchar(40)	not null,
	value	varchar(40)	not null
,constraint alt_user_prefpk primary key (id))


create table alt_userpref_rel (
	id	varchar(40)	not null,
	alert_user_pref_id	varchar(40)	not null
,constraint alt_user_relpk primary key (id,alert_user_pref_id))

create index alt_userpref_idx on alt_userpref_rel (alert_user_pref_id)

create table alt_gear (
	id	varchar(40)	not null,
	source_id	varchar(40)	not null,
	source_type	varchar(40)	not null,
	version	integer	not null,
	message_type	varchar(255)	not null,
	name	varchar(40)	not null,
	value	varchar(40)	not null,
	resource_bundle	varchar(255)	not null
,constraint alt_gearpk primary key (id))


create table alt_gear_rel (
	id	varchar(40)	not null,
	name	varchar(40)	not null,
	gear_id	varchar(40)	not null
,constraint alt_gear_relpk primary key (id,gear_id))

create index alt_gear_idx on alt_gear_rel (gear_id)

create table alt_gear_def (
	id	varchar(40)	not null,
	version	integer	not null,
	message_type	varchar(255)	not null,
	name	varchar(40)	not null,
	value	varchar(40)	not null,
	resource_bundle	varchar(255)	not null
,constraint alt_gear_defpk primary key (id))


create table alt_gear_def_rel (
	id	varchar(40)	not null,
	name	varchar(40)	not null,
	gear_def_id	varchar(40)	not null
,constraint alt_def_relpk primary key (id,gear_def_id))

create index alt_gear_def_idx on alt_gear_def_rel (gear_def_id)

create table alt_channel (
	channel_id	varchar(40)	not null,
	version	integer	not null,
	component_name	varchar(255)	not null,
	display_name	varchar(255)	not null
,constraint alt_channel_pk primary key (channel_id))


create table alt_chan_usr_rel (
	alt_user_pref_id	varchar(40)	not null,
	channel_id	varchar(40)	not null
,constraint alt_chnusr_relpk primary key (channel_id,alt_user_pref_id))



go



--  @version $Id: //app/portal/version/11.2/paf/sql/membership_ddl.xml#1 $$Change: 946917 $

create table mem_membership_req (
	id	varchar(40)	not null,
	internal_version	integer	default 0 not null,
	user_id	varchar(40)	not null,
	community_id	varchar(40)	not null,
	request_type	integer	not null,
	creation_date	datetime	not null
,constraint mem_membershiprq_p primary key (id)
,constraint mem_membershiprq_c check (request_type in (0,1)))



go



--  @version $Id: //app/portal/version/11.2/paf/sql/paf_mappers_ddl.xml#1 $$Change: 946917 $

create table paf_page_visit (
	id	varchar(40)	not null,
	tstamp	datetime	null,
	gear_id	varchar(40)	null,
	community_id	varchar(40)	null,
	user_id	varchar(40)	null,
	page_path	varchar(255)	null,
	msg_type	varchar(255)	null)

create index paf_pgvst_comid on paf_page_visit (community_id)
create index paf_pgvst_gearid on paf_page_visit (gear_id)
create index paf_pgvst_usrid on paf_page_visit (user_id)

create table comm_gear_add (
	id	varchar(40)	not null,
	tstamp	datetime	null,
	gear_id	varchar(40)	null,
	community_id	varchar(40)	null,
	user_id	varchar(40)	null,
	msg_type	varchar(255)	null)

create index comm_gearaddcom_id on comm_gear_add (community_id)
create index comm_gearaddgearid on comm_gear_add (gear_id)
create index comm_gearaddusr_id on comm_gear_add (user_id)

create table comm_gear_rem (
	id	varchar(40)	not null,
	tstamp	datetime	null,
	gear_id	varchar(40)	null,
	community_id	varchar(40)	null,
	user_id	varchar(40)	null,
	msg_type	varchar(255)	null)

create index comm_gearremcom_id on comm_gear_rem (community_id)
create index comm_gearremgearid on comm_gear_rem (gear_id)
create index comm_gearremusr_id on comm_gear_rem (user_id)

create table page_gear_add (
	id	varchar(40)	not null,
	tstamp	datetime	null,
	gear_id	varchar(40)	null,
	community_id	varchar(40)	null,
	page_id	varchar(40)	null,
	user_id	varchar(40)	null,
	msg_type	varchar(255)	null)

create index page_gearaddcom_id on page_gear_add (community_id)
create index page_gearaddgearid on page_gear_add (gear_id)
create index page_gearaddpageid on page_gear_add (page_id)
create index page_gearaddusr_id on page_gear_add (user_id)

create table page_gear_rem (
	id	varchar(40)	not null,
	tstamp	datetime	null,
	gear_id	varchar(40)	null,
	community_id	varchar(40)	null,
	page_id	varchar(40)	null,
	user_id	varchar(40)	null,
	msg_type	varchar(255)	null)

create index page_gearremcom_id on page_gear_rem (community_id)
create index page_gearremgearid on page_gear_rem (gear_id)
create index page_gearrempageid on page_gear_rem (page_id)
create index page_gearremusr_id on page_gear_rem (user_id)


go



--  @version $Id: //app/portal/version/11.2/paf/sql/portal_ddl.xml#1 $$Change: 946917 $

create table paf_folder (
	folder_id	varchar(40)	not null,
	internal_version	integer	default 0 not null,
	name	varchar(254)	not null,
	description	varchar(254)	null,
	type	numeric(1,0)	not null,
	parent	varchar(40)	null,
	url_name	varchar(254)	not null
,constraint paf_folderpk primary key (folder_id)
,constraint paf_folder1_f foreign key (parent) references paf_folder (folder_id)
,constraint type_enum check (type in (0,1,2)))

create index paf_folderpnidx on paf_folder (parent,name)

create table paf_folder_acl (
	id	varchar(254)	not null,
	indx	integer	not null,
	acl	varchar(254)	null)


create table paf_child_folder (
	folder_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_folder_id	varchar(40)	not null
,constraint paf_childfolderpk primary key (folder_id,child_folder_id)
,constraint paf_childfolder1_f foreign key (folder_id) references paf_folder (folder_id)
,constraint paf_childfolder2_f foreign key (child_folder_id) references paf_folder (folder_id))

create index paf_cfchldflddlix on paf_child_folder (child_folder_id)

create table paf_fldr_ln_names (
	folder_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_name	varchar(255)	not null
,constraint paf_fldr_lnnamespk primary key (folder_id,locale)
,constraint paf_fldrlnnames1_f foreign key (folder_id) references paf_folder (folder_id))


create table paf_fldr_ln_descs (
	folder_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_desc	varchar(255)	not null
,constraint paf_fldr_lndescspk primary key (folder_id,locale)
,constraint paf_fldrlndescs1_f foreign key (folder_id) references paf_folder (folder_id))


create table paf_gear_param (
	gear_param_id	varchar(40)	not null,
	internal_version	integer	default 0 not null,
	description	varchar(254)	null,
	default_value	varchar(254)	null,
	required	numeric(1,0)	not null,
	isreadonly	numeric(1,0)	default 0 not null
,constraint paf_gearparampk primary key (gear_param_id)
,constraint required_bool check (required in (0,1))
,constraint isreadonly_bool check (isreadonly in (0,1)))


create table paf_gear_prmvals (
	gear_param_id	varchar(40)	not null,
	sequence_num	integer	not null,
	param_value	varchar(254)	null
,constraint paf_gprmvalspk primary key (gear_param_id,sequence_num)
,constraint paf_gprmvals1_f foreign key (gear_param_id) references paf_gear_param (gear_param_id))


create table paf_device_outputs (
	device_outputs_id	varchar(40)	not null,
	internal_version	integer	default 0 not null
,constraint paf_deviceoutspk primary key (device_outputs_id))


create table paf_device_output (
	device_output_id	varchar(40)	not null,
	type	varchar(10)	not null,
	url	varchar(254)	null
,constraint paf_deviceoutpk primary key (device_output_id,type)
,constraint paf_device_out1_f foreign key (device_output_id) references paf_device_outputs (device_outputs_id))


create table paf_display_modes (
	display_modes_id	varchar(40)	not null,
	internal_version	integer	default 0 not null,
	shared_mode	varchar(40)	null,
	full_mode	varchar(40)	null,
	popup_mode	varchar(40)	null
,constraint paf_displaymodespk primary key (display_modes_id)
,constraint paf_displaymode1_f foreign key (shared_mode) references paf_device_outputs (device_outputs_id)
,constraint paf_displaymode2_f foreign key (full_mode) references paf_device_outputs (device_outputs_id)
,constraint paf_displaymode3_f foreign key (popup_mode) references paf_device_outputs (device_outputs_id))

create index paf_dmsmdlix on paf_display_modes (shared_mode)
create index paf_dmfmdlix on paf_display_modes (full_mode)
create index paf_dmpmdlix on paf_display_modes (popup_mode)

create table paf_title_template (
	title_template_id	varchar(40)	not null,
	name	varchar(254)	not null,
	description	varchar(254)	null,
	creation_date	datetime	not null,
	last_modified	datetime	null,
	internal_version	integer	null,
	author	varchar(254)	null,
	version	varchar(254)	null,
	servlet_context	varchar(254)	not null,
	template_dm	varchar(40)	null,
	pre_template_dm	varchar(40)	null,
	post_template_dm	varchar(40)	null,
	small_image_url	varchar(254)	null,
	small_image_alt	varchar(254)	null,
	large_image_url	varchar(254)	null,
	large_image_alt	varchar(254)	null
,constraint paf_titletmplpk primary key (title_template_id)
,constraint paf_title_templ1_u unique (name)
,constraint paf_title_templ1_f foreign key (template_dm) references paf_display_modes (display_modes_id)
,constraint paf_title_templ2_f foreign key (pre_template_dm) references paf_display_modes (display_modes_id)
,constraint paf_title_templ3_f foreign key (post_template_dm) references paf_display_modes (display_modes_id))

create index paf_ttmptmpldlix on paf_title_template (template_dm)
create index paf_ttmppredlix on paf_title_template (pre_template_dm)
create index paf_ttmppstdlix on paf_title_template (post_template_dm)

create table paf_gear_modes (
	gear_modes_id	varchar(40)	not null,
	internal_version	integer	default 0 not null,
	content_mode	varchar(40)	null,
	help_mode	varchar(40)	null,
	about_mode	varchar(40)	null,
	preview_mode	varchar(40)	null,
	user_cfg_mode	varchar(40)	null,
	instance_cfg_mode	varchar(40)	null,
	initial_cfg_mode	varchar(40)	null,
	install_cfg_mode	varchar(40)	null
,constraint paf_gearmodespk primary key (gear_modes_id)
,constraint paf_gear_modes1_f foreign key (content_mode) references paf_display_modes (display_modes_id)
,constraint paf_gear_modes2_f foreign key (help_mode) references paf_display_modes (display_modes_id)
,constraint paf_gear_modes3_f foreign key (about_mode) references paf_display_modes (display_modes_id)
,constraint paf_gear_modes4_f foreign key (preview_mode) references paf_display_modes (display_modes_id)
,constraint paf_gear_modes5_f foreign key (user_cfg_mode) references paf_display_modes (display_modes_id)
,constraint paf_gear_modes6_f foreign key (instance_cfg_mode) references paf_display_modes (display_modes_id)
,constraint paf_gear_modes7_f foreign key (initial_cfg_mode) references paf_display_modes (display_modes_id)
,constraint paf_gear_modes8_f foreign key (install_cfg_mode) references paf_display_modes (display_modes_id))

create index paf_gdcmdlix on paf_gear_modes (content_mode)
create index paf_gdhmdlix on paf_gear_modes (help_mode)
create index paf_gdamdlix on paf_gear_modes (about_mode)
create index paf_gmpredlix on paf_gear_modes (preview_mode)
create index paf_gmusercmdlix on paf_gear_modes (user_cfg_mode)
create index paf_gmancecmdlix on paf_gear_modes (instance_cfg_mode)
create index paf_gminitcmdlix on paf_gear_modes (initial_cfg_mode)
create index paf_gminstcmdlix on paf_gear_modes (install_cfg_mode)

create table paf_gear_def (
	gear_def_id	varchar(40)	not null,
	name	varchar(254)	not null,
	description	varchar(254)	null,
	creation_date	datetime	not null,
	last_modified	datetime	null,
	internal_version	integer	null,
	parent_folder	varchar(40)	not null,
	author	varchar(254)	null,
	version	varchar(254)	null,
	hide	numeric(1,0)	not null,
	timeout	numeric(19,0)	not null,
	jsr168	tinyint	default 0 not null,
	portlet_guid	varchar(254)	null,
	render_async	numeric(1,0)	not null,
	should_cache	numeric(1,0)	not null,
	cache_timeout	numeric(19,0)	null,
	intercept_errors	numeric(1,0)	not null,
	cover_err_cache	numeric(1,0)	not null,
	servlet_context	varchar(254)	not null,
	sharable	numeric(1,0)	not null,
	width	numeric(1,0)	not null,
	height	numeric(1,0)	not null,
	small_image_url	varchar(254)	null,
	small_image_alt	varchar(254)	null,
	large_image_url	varchar(254)	null,
	large_image_alt	varchar(254)	null,
	gear_modes	varchar(40)	null
,constraint paf_geardefpk primary key (gear_def_id)
,constraint paf_gear_def1_f foreign key (parent_folder) references paf_folder (folder_id)
,constraint paf_gear_def2_f foreign key (gear_modes) references paf_gear_modes (gear_modes_id)
,constraint gear_asyncbool check (render_async in (0,1))
,constraint gear_cachebool check (should_cache in (0,1))
,constraint gear_errcachebool check (cover_err_cache in (0,1))
,constraint gear_errorsbool check (intercept_errors in (0,1))
,constraint gear_heightenum check (height in (0,1,2))
,constraint gear_hidebool check (hide in (0,1))
,constraint gear_widthenum check (width in (0,1,2)))

create index paf_gdpfdlix on paf_gear_def (parent_folder)
create index paf_gdgmdlix on paf_gear_def (gear_modes)

create table paf_gd_cprops (
	gear_def_id	varchar(40)	not null,
	sequence_num	integer	not null,
	name	varchar(254)	not null
,constraint paf_gdcpropspk primary key (gear_def_id,sequence_num)
,constraint paf_gd_cprops1_f foreign key (gear_def_id) references paf_gear_def (gear_def_id))


create table paf_gd_iparams (
	gear_def_id	varchar(40)	not null,
	name	varchar(254)	not null,
	gear_param_id	varchar(40)	not null
,constraint paf_gdiparamspk primary key (gear_def_id,gear_param_id)
,constraint paf_gd_iparams1_f foreign key (gear_def_id) references paf_gear_def (gear_def_id)
,constraint paf_gd_iparams2_f foreign key (gear_param_id) references paf_gear_param (gear_param_id))

create index paf_gdipiddlix on paf_gd_iparams (gear_param_id)

create table paf_gd_uparams (
	gear_def_id	varchar(40)	not null,
	name	varchar(254)	not null,
	gear_param_id	varchar(40)	not null
,constraint paf_gduparamspk primary key (gear_def_id,gear_param_id)
,constraint paf_gd_uparams1_f foreign key (gear_def_id) references paf_gear_def (gear_def_id)
,constraint paf_gd_uparams2_f foreign key (gear_param_id) references paf_gear_param (gear_param_id))

create index paf_gdupiddlix on paf_gd_uparams (gear_param_id)

create table paf_gd_l10n_names (
	gear_def_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_name	varchar(255)	not null
,constraint paf_gd_l10nnamespk primary key (gear_def_id,locale)
,constraint paf_gd_l10nname1_f foreign key (gear_def_id) references paf_gear_def (gear_def_id))


create table paf_gd_l10n_descs (
	gear_def_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_desc	varchar(255)	not null
,constraint paf_gd_l10ndescspk primary key (gear_def_id,locale)
,constraint paf_gd_l10ndesc1_f foreign key (gear_def_id) references paf_gear_def (gear_def_id))


create table paf_gear (
	gear_id	varchar(40)	not null,
	internal_version	integer	default 0 not null,
	name	varchar(254)	null,
	description	varchar(254)	null,
	gear_definition	varchar(40)	not null,
	access_level	numeric(1,0)	not null,
	show_title_bars	numeric(1,0)	not null,
	parent_comm_id	varchar(40)	not null,
	is_shared	numeric(1,0)	not null
,constraint paf_gearpk primary key (gear_id)
,constraint paf_gear1_f foreign key (gear_definition) references paf_gear_def (gear_def_id)
,constraint gear_titlebarsbool check (show_title_bars in (0,1)))

create index paf_geargddlix on paf_gear (gear_definition)

create table paf_gear_acl (
	id	varchar(254)	not null,
	indx	integer	not null,
	acl	varchar(254)	null)


create table paf_gear_iparams (
	gear_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	iparam_value	varchar(254)	null
,constraint paf_geariparamspk primary key (gear_id,tag)
,constraint paf_geariparams1_f foreign key (gear_id) references paf_gear (gear_id))


create table paf_gear_ln_names (
	gear_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_name	varchar(255)	not null
,constraint paf_gear_lnnamespk primary key (gear_id,locale)
,constraint paf_gearlnnames1_f foreign key (gear_id) references paf_gear (gear_id))


create table paf_gear_ln_descs (
	gear_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_desc	varchar(255)	not null
,constraint paf_gear_lndescspk primary key (gear_id,locale)
,constraint paf_gearlndescs1_f foreign key (gear_id) references paf_gear (gear_id))


create table paf_region_def (
	region_def_id	varchar(40)	not null,
	internal_version	integer	default 0 not null,
	name	varchar(254)	not null,
	width	numeric(1,0)	not null,
	height	numeric(1,0)	not null
,constraint paf_regiondefpk primary key (region_def_id)
,constraint paf_regiondefuk unique (name)
,constraint paf_regionhtbool check (height in (0,1))
,constraint paf_regionwithbool check (width in (0,1)))

-- Do not use REFERENCES paf_page(page_id) here because of circular references

create table paf_region (
	region_id	varchar(40)	not null,
	internal_version	integer	default 0 not null,
	definition	varchar(40)	not null,
	parent_page_id	varchar(40)	not null,
	fixed	numeric(1,0)	not null
,constraint paf_regionpk primary key (region_id)
,constraint paf_region1_f foreign key (definition) references paf_region_def (region_def_id)
,constraint regionfixedbool check (fixed in (0,1)))

create index paf_regdefdlix on paf_region (definition)

create table paf_region_gears (
	region_id	varchar(40)	not null,
	sequence_num	integer	not null,
	gear_id	varchar(40)	not null
,constraint paf_regiongearspk primary key (region_id,sequence_num)
,constraint paf_regiongears2_f foreign key (gear_id) references paf_gear (gear_id)
,constraint paf_regiongears1_f foreign key (region_id) references paf_region (region_id))

create index paf_reggriddlix on paf_region_gears (gear_id)

create table paf_style (
	style_id	varchar(40)	not null,
	name	varchar(254)	not null,
	description	varchar(254)	null,
	creation_date	datetime	not null,
	last_modified	datetime	null,
	internal_version	integer	null,
	author	varchar(254)	null,
	version	varchar(254)	null,
	servlet_context	varchar(254)	not null,
	css_url	varchar(254)	not null
,constraint paf_stylepk primary key (style_id)
,constraint paf_style1_u unique (name))


create table paf_styl_ln_names (
	style_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_name	varchar(255)	not null
,constraint paf_styl_lnnamespk primary key (style_id,locale)
,constraint paf_styllnnames1_f foreign key (style_id) references paf_style (style_id))


create table paf_styl_ln_descs (
	style_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_desc	varchar(255)	not null
,constraint paf_styl_lndescspk primary key (style_id,locale)
,constraint paf_styllndescs1_f foreign key (style_id) references paf_style (style_id))


create table paf_col_palette (
	palette_id	varchar(40)	not null,
	name	varchar(254)	not null,
	description	varchar(254)	null,
	creation_date	datetime	not null,
	last_modified	datetime	null,
	internal_version	integer	null,
	author	varchar(254)	null,
	version	varchar(254)	null,
	servlet_context	varchar(254)	not null,
	small_image_url	varchar(254)	null,
	small_image_alt	varchar(254)	null,
	large_image_url	varchar(254)	null,
	large_image_alt	varchar(254)	null,
	pg_bg_image_url	varchar(254)	null,
	pg_bg_color	char(6)	null,
	pg_text_color	char(6)	null,
	pg_link_color	char(6)	null,
	pg_alink_color	char(6)	null,
	pg_vlink_color	char(6)	null,
	gt_bg_color	char(6)	null,
	gt_text_color	char(6)	null,
	gear_bg_color	char(6)	null,
	gear_text_color	char(6)	null,
	hl_bg_color	char(6)	null,
	hl_text_color	char(6)	null
,constraint paf_colpalettepk primary key (palette_id)
,constraint paf_col_palette1_u unique (name))


create table paf_cpal_ln_names (
	palette_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_name	varchar(255)	not null
,constraint paf_cpal_lnnamespk primary key (palette_id,locale)
,constraint paf_cpallnnames1_f foreign key (palette_id) references paf_col_palette (palette_id))


create table paf_cpal_ln_descs (
	palette_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_desc	varchar(255)	not null
,constraint paf_cpal_lndescspk primary key (palette_id,locale)
,constraint paf_cpallndescs1_f foreign key (palette_id) references paf_col_palette (palette_id))


create table paf_layout (
	layout_id	varchar(40)	not null,
	name	varchar(254)	not null,
	description	varchar(254)	null,
	creation_date	datetime	not null,
	last_modified	datetime	not null,
	internal_version	integer	null,
	author	varchar(254)	null,
	version	varchar(254)	null,
	small_image_url	varchar(254)	null,
	small_image_alt	varchar(254)	null,
	large_image_url	varchar(254)	null,
	large_image_alt	varchar(254)	null,
	servlet_context	varchar(254)	not null,
	display_modes	varchar(40)	not null
,constraint paf_layoutpk primary key (layout_id)
,constraint paf_layout1_u unique (name)
,constraint paf_layout1_f foreign key (display_modes) references paf_display_modes (display_modes_id))

create index paf_lytdmdlix on paf_layout (display_modes)

create table paf_layout_regdefs (
	layout_id	varchar(40)	not null,
	sequence_num	integer	not null,
	region_def_id	varchar(40)	not null
,constraint paf_layoutregdfpk primary key (layout_id,sequence_num)
,constraint paf_layoutregdf1_f foreign key (layout_id) references paf_layout (layout_id)
,constraint paf_layoutregdf2_f foreign key (region_def_id) references paf_region_def (region_def_id))

create index paf_lytregddlix on paf_layout_regdefs (region_def_id)

create table paf_page_template (
	page_template_id	varchar(40)	not null,
	name	varchar(254)	not null,
	description	varchar(254)	null,
	creation_date	datetime	not null,
	last_modified	datetime	null,
	internal_version	integer	null,
	author	varchar(254)	null,
	version	varchar(254)	null,
	small_image_url	varchar(254)	null,
	small_image_alt	varchar(254)	null,
	large_image_url	varchar(254)	null,
	large_image_alt	varchar(254)	null,
	servlet_context	varchar(254)	not null,
	display_modes	varchar(40)	not null
,constraint paf_pagetmplpk primary key (page_template_id)
,constraint paf_pagetmplate1_u unique (name)
,constraint paf_pagetmplate1_f foreign key (display_modes) references paf_display_modes (display_modes_id))

create index paf_pagetmdmdlix on paf_page_template (display_modes)

create table paf_ptpl_ln_names (
	page_template_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_name	varchar(255)	not null
,constraint paf_ptpl_lnnamespk primary key (page_template_id,locale)
,constraint paf_ptpllnnames1_f foreign key (page_template_id) references paf_page_template (page_template_id))


create table paf_ptpl_ln_descs (
	page_template_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_desc	varchar(255)	not null
,constraint paf_ptpl_lndescspk primary key (page_template_id,locale)
,constraint paf_ptpllndescs1_f foreign key (page_template_id) references paf_page_template (page_template_id))


create table paf_template (
	template_id	varchar(40)	not null,
	name	varchar(254)	not null,
	description	varchar(254)	null,
	creation_date	datetime	not null,
	last_modified	datetime	null,
	internal_version	integer	null,
	author	varchar(254)	null,
	version	varchar(254)	null,
	small_image_url	varchar(254)	null,
	small_image_alt	varchar(254)	null,
	large_image_url	varchar(254)	null,
	large_image_alt	varchar(254)	null,
	servlet_context	varchar(254)	not null,
	device_outputs	varchar(40)	not null
,constraint paf_tmplpk primary key (template_id)
,constraint paf_tmplate1_u unique (name)
,constraint paf_tmplate1_f foreign key (device_outputs) references paf_device_outputs (device_outputs_id))

create index paf_tmpdodlix on paf_template (device_outputs)
-- Cannot have default_page REFERENCES paf_page(page_id) because this is circular

create table paf_community (
	community_id	varchar(40)	not null,
	name	varchar(254)	not null,
	url_name	varchar(254)	not null,
	description	varchar(254)	null,
	creation_date	datetime	not null,
	last_modified	datetime	null,
	internal_version	integer	null,
	enabled	numeric(1,0)	not null,
	access_level	numeric(1,0)	not null,
	parent_folder	varchar(40)	not null,
	page_folder	varchar(40)	not null,
	default_page	varchar(40)	null,
	personalization	numeric(1,0)	not null,
	membership_req	numeric(1,0)	not null,
	page_template	varchar(40)	null,
	title_template	varchar(40)	null,
	li_template	varchar(40)	null,
	lo_template	varchar(40)	null,
	ad_template	varchar(40)	null,
	rg_template	varchar(40)	null,
	up_template	varchar(40)	null,
	ia_template	varchar(40)	null,
	page_style	varchar(40)	null
,constraint paf_communitypk primary key (community_id)
,constraint paf_community1_f foreign key (parent_folder) references paf_folder (folder_id)
,constraint paf_community2_f foreign key (page_folder) references paf_folder (folder_id)
,constraint paf_community3_f foreign key (page_template) references paf_page_template (page_template_id)
,constraint paf_community5_f foreign key (page_style) references paf_style (style_id)
,constraint paf_community10_f foreign key (up_template) references paf_template (template_id)
,constraint paf_community8_f foreign key (ad_template) references paf_template (template_id)
,constraint paf_community9_f foreign key (rg_template) references paf_template (template_id)
,constraint paf_community7_f foreign key (lo_template) references paf_template (template_id)
,constraint paf_community11_f foreign key (ia_template) references paf_template (template_id)
,constraint paf_community6_f foreign key (li_template) references paf_template (template_id)
,constraint paf_community4_f foreign key (title_template) references paf_title_template (title_template_id)
,constraint commenabledbool check (enabled in (0,1))
,constraint membershipreqenum check (membership_req in (0,1,2))
,constraint pers_enum check (personalization in (0,1,2)))

create index paf_commpfdlix on paf_community (parent_folder)
create index paf_commpgfdlix on paf_community (page_folder)
create index paf_commtmpldlix on paf_community (page_template)
create index paf_commstydlix on paf_community (page_style)
create index paf_comntuptmpl_ix on paf_community (up_template)
create index paf_comntadtmpl_ix on paf_community (ad_template)
create index paf_comntrgtmpl_ix on paf_community (rg_template)
create index paf_comntlotmpl_ix on paf_community (lo_template)
create index paf_comntiatmpl_ix on paf_community (ia_template)
create index paf_comntlitmpl_ix on paf_community (li_template)
create index paf_commttmpldlix on paf_community (title_template)

create table paf_comm_gears (
	community_id	varchar(40)	not null,
	gear_id	varchar(40)	not null
,constraint paf_commgearspk primary key (community_id,gear_id)
,constraint paf_comm_gears1_f foreign key (community_id) references paf_community (community_id)
,constraint paf_comm_gears2_f foreign key (gear_id) references paf_gear (gear_id))

create index paf_commgriddlix on paf_comm_gears (gear_id)

create table paf_comm_gfldrs (
	community_id	varchar(40)	not null,
	gear_def_fldr_id	varchar(40)	not null
,constraint paf_commgfldrpk primary key (community_id,gear_def_fldr_id)
,constraint paf_comm_gfldrs1_f foreign key (community_id) references paf_community (community_id)
,constraint paf_comm_gfldrs2_f foreign key (gear_def_fldr_id) references paf_folder (folder_id))

create index paf_comm_gfldrs1_i on paf_comm_gfldrs (gear_def_fldr_id)

create table paf_comm_roles (
	community_id	varchar(40)	not null,
	role_name	varchar(254)	not null,
	role_id	varchar(40)	not null
,constraint paf_comm_roles_pk primary key (community_id,role_name)
,constraint paf_comm_roles_fk foreign key (community_id) references paf_community (community_id))


create table paf_base_comm_role (
	id	varchar(40)	not null,
	role_name	varchar(254)	not null,
	category	varchar(254)	not null
,constraint paf_basecomrole_pk primary key (role_name))


create table paf_gear_roles (
	gear_id	varchar(40)	not null,
	role_name	varchar(254)	not null,
	role_id	varchar(40)	not null
,constraint paf_gear_roles_pk primary key (gear_id,role_name)
,constraint paf_gear_roles_fk foreign key (gear_id) references paf_gear (gear_id))


create table paf_base_gear_role (
	gear_def_id	varchar(40)	not null,
	role_name	varchar(254)	not null
,constraint paf_basegearrolepk primary key (gear_def_id,role_name))


create table paf_community_acl (
	id	varchar(254)	not null,
	indx	integer	not null,
	acl	varchar(254)	null)


create table paf_comm_lnames (
	community_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_name	varchar(255)	not null
,constraint paf_commlnamespk primary key (community_id,locale)
,constraint paf_comm_lnames1_f foreign key (community_id) references paf_community (community_id))


create table paf_comm_ldescs (
	community_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_desc	varchar(255)	not null
,constraint paf_commldescspk primary key (community_id,locale)
,constraint paf_comm_ldescs1_f foreign key (community_id) references paf_community (community_id))


create table paf_page (
	page_id	varchar(40)	not null,
	name	varchar(254)	not null,
	url_name	varchar(254)	not null,
	description	varchar(254)	null,
	creation_date	datetime	not null,
	last_modified	datetime	not null,
	internal_version	integer	null,
	access_level	numeric(1,0)	not null,
	parent_folder	varchar(40)	not null,
	parent_comm_id	varchar(40)	not null,
	layout_id	varchar(40)	not null,
	allow_layout_chgs	numeric(1,0)	not null,
	palette_id	varchar(40)	null,
	fixed	numeric(1,0)	not null,
	wireless_enabled	numeric(1,0)	not null
,constraint paf_pagepk primary key (page_id)
,constraint paf_page3_f foreign key (palette_id) references paf_col_palette (palette_id)
,constraint paf_page2_f foreign key (parent_comm_id) references paf_community (community_id)
,constraint paf_page1_f foreign key (parent_folder) references paf_folder (folder_id)
,constraint paf_page4_f foreign key (layout_id) references paf_layout (layout_id)
,constraint allowchgsbool check (allow_layout_chgs in (0,1))
,constraint fixedisbool check (fixed in (0,1))
,constraint wirelessisbool check (wireless_enabled in (0,1)))

create index paf_pagepaldlix on paf_page (palette_id)
create index paf_pagecommdlix on paf_page (parent_comm_id)
create index paf_pagepfdlix on paf_page (parent_folder)
create index paf_pagelytdlix on paf_page (layout_id)

create table paf_page_ln_names (
	page_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_name	varchar(255)	not null
,constraint paf_page_lnnamespk primary key (page_id,locale)
,constraint paf_pagelnnames1_f foreign key (page_id) references paf_page (page_id))


create table paf_page_ln_descs (
	page_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_desc	varchar(255)	not null
,constraint paf_page_lndescspk primary key (page_id,locale)
,constraint paf_pagelndescs1_f foreign key (page_id) references paf_page (page_id))


create table paf_page_acl (
	id	varchar(254)	not null,
	indx	integer	not null,
	acl	varchar(254)	null)


create table paf_page_regions (
	page_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	region_id	varchar(40)	not null
,constraint paf_pageregionspk primary key (page_id,tag)
,constraint paf_pageregions1_f foreign key (page_id) references paf_page (page_id)
,constraint paf_pageregions2_f foreign key (region_id) references paf_region (region_id))

create index paf_pageriddlix on paf_page_regions (region_id)

create table paf_cf_child_item (
	folder_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_item_id	varchar(40)	not null
,constraint paf_cfchilditempk primary key (folder_id,child_item_id)
,constraint paf_cfchilditem2_f foreign key (child_item_id) references paf_community (community_id)
,constraint paf_cfchilditem1_f foreign key (folder_id) references paf_folder (folder_id))

create index paf_cfchlddlix on paf_cf_child_item (child_item_id)

create table paf_cf_gfldrs (
	comm_folder_id	varchar(40)	not null,
	gear_def_fldr_id	varchar(40)	not null
,constraint paf_cfgfldrspk primary key (comm_folder_id,gear_def_fldr_id)
,constraint paf_cf_gfldrs1_f foreign key (comm_folder_id) references paf_folder (folder_id)
,constraint paf_cf_gfldrs2_f foreign key (gear_def_fldr_id) references paf_folder (folder_id))

create index paf_cfgfldrs1_i on paf_cf_gfldrs (gear_def_fldr_id)

create table paf_pf_child_item (
	folder_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_item_id	varchar(40)	not null
,constraint paf_pfchilditempk primary key (folder_id,child_item_id)
,constraint paf_pfchilditem1_f foreign key (folder_id) references paf_folder (folder_id)
,constraint paf_pfchilditem2_f foreign key (child_item_id) references paf_page (page_id))

create index paf_pfcitemiddlix on paf_pf_child_item (child_item_id)

create table paf_gdf_child_item (
	folder_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_item_id	varchar(40)	not null
,constraint paf_gdfchilditempk primary key (folder_id,child_item_id)
,constraint paf_gdfchlditem1_f foreign key (folder_id) references paf_folder (folder_id)
,constraint paf_gdfchlditem2_f foreign key (child_item_id) references paf_gear_def (gear_def_id))

create index paf_gdfciiddlix on paf_gdf_child_item (child_item_id)

create table paf_comm_template (
	template_id	varchar(40)	not null,
	name	varchar(254)	not null,
	description	varchar(254)	null,
	creation_date	datetime	not null,
	internal_version	integer	null,
	enabled	tinyint	not null,
	access_level	integer	not null,
	parent_folder	varchar(40)	not null,
	page_folder	varchar(40)	not null,
	default_page	varchar(40)	not null,
	personalization	tinyint	not null,
	membership_req	tinyint	not null,
	page_template	varchar(40)	not null,
	title_template	varchar(40)	not null,
	style	varchar(40)	not null
,constraint paf_comtemplate_p primary key (template_id)
,constraint paf_comtemplate_c1 check (enabled in (0,1))
,constraint paf_comtemplate_c2 check (personalization in (0,1,2))
,constraint paf_comtemplate_c3 check (membership_req in (0,1,2)))


create table paf_ct_folder (
	folder_id	varchar(40)	not null,
	internal_version	integer	not null,
	name	varchar(254)	not null,
	description	varchar(254)	null,
	parent	varchar(40)	null,
	url_name	varchar(254)	not null
,constraint paf_ct_folder_p primary key (folder_id)
,constraint paf_ct_folder_u unique (name))

create index paf_ct_fldrpnidx on paf_ct_folder (parent,name)

create table paf_ct_child_fldr (
	folder_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_folder_id	varchar(40)	not null
,constraint paf_ctchild_fldr_p primary key (folder_id,child_folder_id))


create table paf_ct_pagefolder (
	folder_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_item_id	varchar(40)	not null
,constraint paf_ctpagefolder_p primary key (folder_id,child_item_id))


create table paf_ct_page (
	page_id	varchar(40)	not null,
	name	varchar(254)	not null,
	url_name	varchar(254)	not null,
	description	varchar(254)	null,
	creation_date	datetime	not null,
	last_modified	datetime	not null,
	internal_version	integer	null,
	access_level	integer	not null,
	parent_folder	varchar(40)	not null,
	layout_id	varchar(40)	not null,
	allow_layout_chgs	tinyint	not null,
	palette_id	varchar(40)	null,
	fixed	tinyint	not null,
	wireless_enabled	tinyint	not null
,constraint paf_ct_page_p primary key (page_id)
,constraint paf_ct_page_c1 check (allow_layout_chgs in (0,1))
,constraint paf_ct_page_c2 check (fixed in (0,1))
,constraint paf_ct_page_c3 check (wireless_enabled in (0,1)))


create table paf_ct_region (
	region_id	varchar(40)	not null,
	internal_version	integer	not null,
	definition	varchar(40)	not null,
	fixed	tinyint	not null
,constraint paf_ct_region_p primary key (region_id)
,constraint paf_ct_region_c1 check (fixed in (0,1)))


create table paf_ct_pg_regions (
	page_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	region_id	varchar(40)	not null
,constraint paf_ctpg_regions_p primary key (page_id,tag))


create table paf_ct_region_grs (
	region_id	varchar(40)	not null,
	sequence_num	integer	not null,
	gear_id	varchar(40)	not null
,constraint paf_ctregion_grs_p primary key (region_id,sequence_num))


create table paf_ct_gear (
	gear_id	varchar(40)	not null,
	internal_version	integer	not null,
	name	varchar(254)	null,
	description	varchar(254)	null,
	gear_definition	varchar(40)	not null,
	access_level	integer	not null,
	show_title_bars	tinyint	not null,
	is_shared	tinyint	not null,
	orig_gear_id	varchar(40)	null
,constraint paf_ct_gear_p primary key (gear_id)
,constraint paf_ct_gear_c1 check (show_title_bars in (0,1)))


create table paf_ct_gr_iparams (
	gear_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	iparam_value	varchar(254)	not null
,constraint paf_ctgr_iparams_p primary key (gear_id,tag))


create table paf_ct_gr_ln_names (
	gear_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_name	varchar(255)	not null
,constraint paf_ctgrln_names_p primary key (gear_id,locale))


create table paf_ct_gr_ln_descs (
	gear_id	varchar(40)	not null,
	locale	varchar(30)	not null,
	localized_desc	varchar(255)	not null
,constraint paf_ctgrln_descs_p primary key (gear_id,locale))


create table paf_ct_gr_fldrs (
	template_id	varchar(40)	not null,
	gear_def_folder_id	varchar(40)	not null
,constraint paf_ct_gr_fldrs_p primary key (template_id,gear_def_folder_id))


create table paf_ct_gears (
	template_id	varchar(40)	not null,
	gear_id	varchar(40)	not null
,constraint paf_ct_gears_p primary key (template_id,gear_id))


create table paf_ct_alt_gear (
	id	varchar(40)	not null,
	source_id	varchar(40)	not null,
	source_type	varchar(40)	not null,
	version	integer	not null,
	message_type	varchar(255)	not null,
	name	varchar(40)	not null,
	value	varchar(40)	not null,
	resource_bundle	varchar(255)	not null
,constraint paf_ct_alt_gear_p primary key (id))


create table paf_ct_alt_gr_rel (
	id	varchar(40)	not null,
	name	varchar(40)	not null,
	gear_id	varchar(40)	not null
,constraint paf_ctalt_gr_rel_p primary key (id,gear_id))


create table paf_ct_roles (
	template_id	varchar(40)	not null,
	role_name	varchar(254)	not null,
	role_id	varchar(40)	not null
,constraint paf_ct_roles_pk primary key (template_id,role_name)
,constraint paf_ct_roles_fk foreign key (template_id) references paf_comm_template (template_id))


create table paf_ct_gr_acl (
	id	varchar(254)	not null,
	indx	integer	not null,
	acl	varchar(254)	not null)


create table paf_ct_gr_roles (
	gear_id	varchar(40)	not null,
	role_name	varchar(254)	not null,
	role_id	varchar(40)	not null
,constraint paf_ct_gr_roles_pk primary key (gear_id,role_name)
,constraint paf_ct_gr_roles_fk foreign key (gear_id) references paf_ct_gear (gear_id))



go



--  @version $Id: //product/Publishing/version/11.2/pws/sql/xml/publishing_ddl.xml#1 $
--     The tables here are for the various parts of the epublishing system.  

create table epub_history (
	history_id	varchar(40)	not null,
	profile	varchar(40)	null,
	timestamp	datetime	null,
	action	varchar(255)	null,
	action_type	varchar(255)	null,
	description	text	null
,constraint history_pk primary key (history_id))

create index his_profile_idx on epub_history (profile)
create index his_timestamp_idx on epub_history (timestamp)
create index his_action_idx on epub_history (action)

create table epub_his_act_parm (
	history_id	varchar(40)	not null,
	action_param	varchar(255)	null,
	sequence_num	bigint	not null
,constraint epub_his_ac_pk primary key (history_id,sequence_num)
,constraint epub_hisact_id_fk foreign key (history_id) references epub_history (history_id))


create table epub_taskinfo (
	taskinfo_id	varchar(40)	not null,
	version	bigint	not null,
	process_id	varchar(40)	not null,
	process_name	varchar(255)	not null,
	segment_name	varchar(255)	not null,
	task_element_id	varchar(255)	not null,
	acl	text	null,
	priority	bigint	null,
	owner_name	varchar(255)	null,
	last_actor_name	varchar(255)	null,
	last_action_date	datetime	null,
	last_outcome_id	varchar(255)	null
,constraint taskinfo_pk primary key (taskinfo_id))

create index taskinfo_pname_ix on epub_taskinfo (process_name)

create table epub_agent_trnprt (
	transport_id	varchar(40)	not null,
	version	bigint	not null,
	transport_type	tinyint	not null,
	jndi_name	varchar(255)	null,
	rmi_uri	varchar(255)	null)


create table epub_agent (
	agent_id	varchar(40)	not null,
	version	bigint	not null,
	creation_time	datetime	null,
	display_name	varchar(255)	null,
	description	varchar(1024)	null,
	main_agent_id	varchar(40)	null,
	transport	varchar(40)	not null
,constraint target_agent_pk primary key (agent_id))


create table epub_target (
	target_id	varchar(40)	not null,
	snapshot_name	varchar(255)	null,
	version	bigint	not null,
	creation_time	datetime	null,
	main_target_id	varchar(40)	null,
	display_name	varchar(255)	null,
	description	varchar(1024)	null,
	halted	tinyint	null,
	flag_agents	tinyint	null,
	target_type	tinyint	null
,constraint targets_pk primary key (target_id))


create table epub_tr_dest (
	target_id	varchar(40)	not null,
	target_source	varchar(100)	not null,
	target_destination	varchar(100)	not null
,constraint epub_trd_id_pk primary key (target_id,target_source))


create table epub_table_mapping (
	mapping_id	varchar(40)	not null,
	version	bigint	not null,
	type	integer	not null
,constraint table_mapping_pk primary key (mapping_id))


create table epub_tbl_map_onln (
	mapping_id	varchar(40)	not null,
	prefix_str	varchar(255)	null,
	suffix_str	varchar(255)	null
,constraint o_tbl_mapping_pk primary key (mapping_id)
,constraint tr_tbl_o_mp_id_fk foreign key (mapping_id) references epub_table_mapping (mapping_id))


create table epub_table_map_sw (
	mapping_id	varchar(40)	not null,
	frst_dat_src_name	varchar(255)	not null,
	first_prefix_str	varchar(255)	null,
	first_suffix_str	varchar(255)	null,
	scnd_dat_src_name	varchar(255)	not null,
	scnd_prefix_str	varchar(255)	null,
	scnd_suffix_str	varchar(255)	null
,constraint sw_tbl_mapping_pk primary key (mapping_id)
,constraint tr_tbl_s_mp_id_fk foreign key (mapping_id) references epub_table_mapping (mapping_id))


create table epub_tr_rep_tbl_mp (
	target_id	varchar(40)	not null,
	source_repo	varchar(255)	not null,
	mapping_id	varchar(40)	not null
,constraint epub_tr_tb_id_pk primary key (target_id,source_repo)
,constraint tr_tbl_pr_id_fk foreign key (target_id) references epub_target (target_id))


create table epub_topology (
	topology_id	varchar(40)	not null,
	version	bigint	not null,
	primary_tl	tinyint	null
,constraint topology_pk primary key (topology_id))


create table epub_tl_targets (
	topology_id	varchar(40)	not null,
	target_id	varchar(40)	not null,
	sequence_num	bigint	not null
,constraint pr_tp_tr_pk primary key (topology_id,target_id))


create table epub_tr_agents (
	target_id	varchar(40)	not null,
	agent_id	varchar(40)	not null
,constraint pr_ag_pk primary key (target_id,agent_id)
,constraint pt_tr_pr_id_fk foreign key (target_id) references epub_target (target_id)
,constraint pt_ag_ag_id_fk foreign key (agent_id) references epub_agent (agent_id))

create index epub_tr_agents_x on epub_tr_agents (agent_id)

create table epub_princ_asset (
	agent_id	varchar(40)	not null,
	principal_assets	varchar(40)	not null
,constraint princ_asset_pk primary key (agent_id,principal_assets)
,constraint princ_aset_id_fk foreign key (agent_id) references epub_agent (agent_id))


create table epub_includ_asset (
	agent_id	varchar(40)	not null,
	include_assets	varchar(255)	not null
,constraint includ_asset_pk primary key (agent_id,include_assets)
,constraint includ_aset_id_fk foreign key (agent_id) references epub_agent (agent_id))


create table epub_exclud_asset (
	agent_id	varchar(40)	not null,
	exclude_assets	varchar(255)	not null
,constraint exclud_asset_pk primary key (agent_id,exclude_assets)
,constraint exclud_aset_id_fk foreign key (agent_id) references epub_agent (agent_id))


create table epub_dest_map (
	agent_id	varchar(40)	not null,
	source	varchar(255)	not null,
	destination	varchar(255)	not null
,constraint dest_map_pk primary key (agent_id,source)
,constraint dest_map_id_fk foreign key (agent_id) references epub_agent (agent_id))


create table epub_project (
	project_id	varchar(40)	not null,
	version	bigint	not null,
	acl	text	null,
	display_name	varchar(255)	null,
	description	text	null,
	creator	varchar(40)	null,
	workspace	varchar(255)	not null,
	workflow_id	varchar(40)	null,
	checked_in	tinyint	null,
	locked	tinyint	null,
	editable	tinyint	null,
	status	bigint	null,
	status_detail	varchar(255)	null,
	checkin_date	datetime	null,
	creation_date	datetime	null,
	completion_date	datetime	null
,constraint project_pk primary key (project_id)
,constraint pr_editable_chk check (editable in (0,1)))

create index pr_workspace_idx on epub_project (workspace)
create index pr_disp_name_idx on epub_project (display_name)
create index pr_creator_idx on epub_project (creator)
create index pr_creat_date_idx on epub_project (creation_date)
create index pr_comp_date_idx on epub_project (completion_date)

create table epub_prj_targt_ws (
	project_id	varchar(40)	not null,
	target_id	varchar(40)	not null,
	workspace_id	varchar(40)	null
,constraint epub_prw_id_pk primary key (project_id,target_id))


create table epub_pr_tg_status (
	project_id	varchar(40)	not null,
	target_id	varchar(40)	not null,
	status_code	tinyint	null
,constraint epub_pr_ap_id_pk primary key (project_id,target_id))


create table epub_prj_tg_snsht (
	project_id	varchar(40)	not null,
	target_id	varchar(40)	not null,
	snapshot_id	varchar(40)	null
,constraint epub_prs_id_pk primary key (project_id,target_id))


create table epub_pr_tg_dp_ts (
	project_id	varchar(40)	not null,
	target_id	varchar(40)	not null,
	deployment_time	datetime	null
,constraint epub_pr_dt_id_pk primary key (project_id,target_id))


create table epub_pr_tg_dp_id (
	project_id	varchar(40)	not null,
	target_id	varchar(40)	not null,
	deployment_id	varchar(40)	null
,constraint epub_pr_dp_id_pk primary key (project_id,target_id))


create table epub_pr_tg_ap_ts (
	project_id	varchar(40)	not null,
	target_id	varchar(40)	not null,
	approval_time	datetime	null
,constraint epub_ap_ts_id_pk primary key (project_id,target_id))


create table epub_pr_history (
	project_id	varchar(40)	not null,
	sequence_num	bigint	not null,
	history	varchar(40)	not null
,constraint pr_hist_pk primary key (project_id,sequence_num)
,constraint pt_hist_id_fk foreign key (project_id) references epub_project (project_id)
,constraint pt_hist_hist_fk foreign key (history) references epub_history (history_id))

create index pr_hist_hist_idx on epub_pr_history (history)

create table epub_process (
	process_id	varchar(40)	not null,
	version	numeric(19)	not null,
	acl	text	null,
	display_name	varchar(255)	null,
	description	text	null,
	creator	varchar(40)	null,
	project	varchar(40)	null,
	process_data	varchar(40)	null,
	workflow_id	varchar(40)	null,
	activity	varchar(255)	null,
	site_id	varchar(40)	null,
	status	numeric(19)	null,
	status_detail	varchar(255)	null,
	creation_date	datetime	null,
	completion_date	datetime	null
,constraint process_pk primary key (process_id))

create index prc_disp_name_idx on epub_process (display_name)
create index prc_creator_idx on epub_process (creator)
create index prc_creat_date_idx on epub_process (creation_date)
create index prc_comp_date_idx on epub_process (completion_date)
create index prc_project_idx on epub_process (project)

create table epub_proc_prv_prj (
	process_id	varchar(40)	not null,
	sequence_num	numeric(19)	not null,
	project_id	varchar(40)	not null
,constraint proc_prv_prj_pk primary key (process_id,sequence_num)
,constraint prc_pvprj_pcid_fk foreign key (process_id) references epub_process (process_id)
,constraint prc_prv_prj_id_fk foreign key (project_id) references epub_project (project_id))

create index epub_prv_prj_id_x on epub_proc_prv_prj (project_id)

create table epub_proc_history (
	process_id	varchar(40)	not null,
	sequence_num	numeric(19)	not null,
	history	varchar(40)	not null
,constraint proc_hist_pk primary key (process_id,sequence_num)
,constraint proc_hist_id_fk foreign key (process_id) references epub_process (process_id)
,constraint proc_hist_hist_fk foreign key (history) references epub_history (history_id))

create index epub_proc_hist_x on epub_proc_history (history)

create table epub_proc_taskinfo (
	id	varchar(40)	not null,
	taskinfo_id	varchar(40)	not null
,constraint prc_ti_pk primary key (taskinfo_id)
,constraint prc_ti_prc_id_fk foreign key (id) references epub_process (process_id)
,constraint prc_ti_ti_id_fk foreign key (taskinfo_id) references epub_taskinfo (taskinfo_id))

create index epub_prctaskinfo_x on epub_proc_taskinfo (id)

create table epub_deployment (
	deployment_id	varchar(40)	not null,
	version	bigint	not null,
	target_id	varchar(255)	null,
	deploy_time	datetime	not null,
	create_time	datetime	not null,
	creator	varchar(40)	null,
	uri	varchar(100)	null,
	next_dep_id	varchar(40)	null,
	previous_dep_id	varchar(40)	null,
	force_full	tinyint	null,
	dep_type	tinyint	null,
	status	numeric(3)	null,
	message_code	varchar(255)	null,
	strict_file_op	tinyint	null,
	strict_repo_op	tinyint	null
,constraint deployment_pk primary key (deployment_id))

create index depl_time_idx on epub_deployment (deploy_time)

create table epub_deploy_proj (
	deployment_id	varchar(40)	not null,
	project_id	varchar(40)	not null,
	sequence_num	bigint	not null
,constraint epub_dep_proj_pk primary key (deployment_id,project_id))


create table epub_dep_err_parm (
	deployment_id	varchar(40)	not null,
	error_param	varchar(255)	null,
	sequence_num	bigint	not null
,constraint epub_dep_er_pk primary key (deployment_id,sequence_num)
,constraint epub_dep_id_fk foreign key (deployment_id) references epub_deployment (deployment_id))

--     Log of deployments that have occured. See the epub repository  
--     definition file for more details  

create table epub_dep_log (
	log_id	varchar(40)	not null,
	dep_id	varchar(40)	not null,
	target_name	varchar(255)	not null,
	log_time	datetime	not null,
	begin_time	datetime	not null,
	end_time	datetime	not null,
	actor_id	varchar(40)	null,
	type	integer	not null,
	dep_mode	integer	not null,
	status	integer	not null,
	deli_proj_ids	varchar(255)	null,
	delimiter	varchar(5)	not null,
	strict_file_op	tinyint	null,
	strict_repo_op	tinyint	null
,constraint dep_log_pk primary key (log_id))



go



--  @version $Id: //product/Publishing/version/11.2/pws/sql/xml/process_data_ddl.xml#1 $
--     These tables are for the ProcessDataRepository  

create table epub_process_data (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	process_data_id	varchar(40)	not null,
	type	numeric(19)	not null
,constraint process_data_pk primary key (process_data_id,asset_version))

create index epub_process_d_wsx on epub_process_data (workspace_id)
create index epub_process_d_cix on epub_process_data (checkin_date)


go



--  @version $Id: //product/Publishing/version/11.2/pws/sql/xml/versionmanager_ddl.xml#1 $
--     These tables are for the version manager  

create table avm_devline (
	id	varchar(40)	not null,
	type	numeric(19)	not null,
	name	varchar(255)	not null,
	parent	varchar(40)	null,
	date_created	datetime	null
,constraint avm_devline_pk primary key (id)
,constraint avm_dl_name_unq unique (name))

create index avm_devline_pt_idx on avm_devline (parent)

create table avm_workspace (
	ws_id	varchar(40)	not null,
	checked_in	numeric(1)	not null,
	ci_time	datetime	null,
	userid	varchar(255)	null,
	locked	numeric(1)	not null,
	editable	numeric(1)	not null,
	change_was	text	null
,constraint avm_workspace_pk primary key (ws_id)
,constraint avm_workspace_fk foreign key (ws_id) references avm_devline (id))


create table avm_asset_lock (
	repository_name	varchar(255)	not null,
	descriptor_name	varchar(255)	not null,
	repository_id	varchar(255)	not null,
	workspace_id	varchar(40)	not null
,constraint avm_lock_pk primary key (repository_name,descriptor_name,repository_id)
,constraint avm_lock_ws_fk foreign key (workspace_id) references avm_workspace (ws_id))

create index avm_asset_lock_x on avm_asset_lock (workspace_id)


go



--  @version $Id: //product/Publishing/version/11.2/pws/sql/xml/file_repository_ddl.xml#1 $
--     These tables are for the storing versioned files for Publishing  

create table epub_file_folder (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	folder_id	varchar(40)	not null,
	acl	text	null,
	folder_name	varchar(255)	not null,
	parent_folder	varchar(40)	null
,constraint content_folder_pk primary key (folder_id,asset_version))

create index ff_folder_name_idx on epub_file_folder (folder_name)
create index epub_file_fold_wsx on epub_file_folder (workspace_id)
create index epub_file_fold_cix on epub_file_folder (checkin_date)

create table epub_file_asset (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	file_asset_id	varchar(40)	not null,
	type	numeric(19)	not null,
	acl	text	null,
	filename	varchar(255)	not null,
	last_modified	datetime	null,
	size_bytes	numeric(19)	null,
	checksum	bigint	null,
	parent_folder	varchar(40)	null
,constraint file_asset_pk primary key (file_asset_id,asset_version))

create index fa_folder_name_idx on epub_file_asset (filename)
create index fa_parent_fldr_idx on epub_file_asset (parent_folder)
create index fa_size_idx on epub_file_asset (size_bytes)
create index fa_last_mod_idx on epub_file_asset (last_modified)
create index epub_file_asse_wsx on epub_file_asset (workspace_id)
create index epub_file_asse_cix on epub_file_asset (checkin_date)

create table epub_text_file (
	asset_version	numeric(19)	not null,
	text_file_id	varchar(40)	not null,
	text_content	text	null
,constraint tf_file_id_pk primary key (text_file_id,asset_version))


create table epub_binary_file (
	asset_version	numeric(19)	not null,
	binary_file_id	varchar(40)	not null,
	binary_content	image	null
,constraint bf_file_id_pk primary key (binary_file_id,asset_version))



go



--  @version $Id: //product/Publishing/version/11.2/pws/sql/xml/workflow_ddl.xml#1 $
--     Collective workflow process instances.  These instances represent  
--     all subjects (processes) going through the workflow process.  

create table epub_coll_workflow (
	id	varchar(40)	not null,
	workflow_name	varchar(255)	null,
	modification_time	numeric(19)	null,
	segment_name	varchar(255)	null,
	creator_id	varchar(40)	null,
	state	varchar(16)	null,
	num_retries	integer	null
,constraint epub_coll_wf_pkey primary key (id))

--     Individual workflow process instances.  Each of these instances  
--     represents a single subject (process) going through the workflow  
--     process.  

create table epub_ind_workflow (
	id	varchar(40)	not null,
	workflow_name	varchar(255)	null,
	modification_time	numeric(19)	null,
	segment_name	varchar(255)	null,
	creator_id	varchar(40)	null,
	state	varchar(16)	null,
	process_id	varchar(40)	not null,
	num_retries	integer	null
,constraint epub_ind_wf_pkey primary key (id)
,constraint epub_ind_wf_fkey foreign key (process_id) references epub_process (process_id))

create index epub_indworkflow_x on epub_ind_workflow (process_id)
--     Indices are needed on these tables to prevent table locks from being  
--     acquired.  The primary key indices do not prevent this since they  
--     are on multiple keys.  
-- 
--     String context variables associated with individual workflow  
--     process instances.  

create table epub_workflow_strs (
	id	varchar(40)	not null,
	tag	varchar(25)	not null,
	context_str	varchar(255)	null
,constraint epub_wf_str_pkey primary key (id,tag)
,constraint epub_wf_str_fkey foreign key (id) references epub_ind_workflow (id))

--     Boolean context variables associated with individual workflow  
--     process instances.  

create table epub_workflow_bls (
	id	varchar(40)	not null,
	tag	varchar(25)	not null,
	context_bool	numeric(1)	null
,constraint epub_wf_bl_pkey primary key (id,tag)
,constraint epub_wf_bl_fkey foreign key (id) references epub_ind_workflow (id))

--     Long context variables associated with individual workflow process  
--     instances.  

create table epub_workflow_lngs (
	id	varchar(40)	not null,
	tag	varchar(25)	not null,
	context_long	numeric(19)	null
,constraint epub_wf_lng_pkey primary key (id,tag)
,constraint epub_wf_lng_fkey foreign key (id) references epub_ind_workflow (id))

--     Double context variables associated with individual workflow  
--     process instances.  

create table epub_workflow_dbls (
	id	varchar(40)	not null,
	tag	varchar(25)	not null,
	context_dbl	numeric(15,4)	null
,constraint epub_wf_dbl_pkey primary key (id,tag)
,constraint epub_wf_dbl_fkey foreign key (id) references epub_ind_workflow (id))

--     Date context variables associated with individual workflow process  
--     instances.  

create table epub_workflow_dats (
	id	varchar(40)	not null,
	tag	varchar(25)	not null,
	context_date	datetime	null
,constraint epub_wf_dat_pkey primary key (id,tag)
,constraint epub_wf_dat_fkey foreign key (id) references epub_ind_workflow (id))

--     Repository item context variables associated with individual   
--     workflow process instances.  

create table epub_workflow_ris (
	id	varchar(40)	not null,
	tag	varchar(255)	not null,
	context_item	varchar(255)	null
,constraint epub_wf_ri_pkey primary key (id,tag)
,constraint epub_wf_ri_fkey foreign key (id) references epub_ind_workflow (id))

--     Virtual file context variables associated with individual   
--     workflow process instances.  

create table epub_workflow_vfs (
	id	varchar(40)	not null,
	tag	varchar(25)	not null,
	context_file	varchar(255)	null
,constraint epub_wf_vf_pkey primary key (id,tag)
,constraint epub_wf_vf_fkey foreign key (id) references epub_ind_workflow (id))

--     Workflow infos.  Each of these infos corresponds to a workflow  
--     process definition created via the ACC UI.  

create table epub_workflow_info (
	id	varchar(40)	not null,
	workflow_name	varchar(255)	null,
	workflow_status	integer	null,
	modification_time	numeric(19)	null,
	creation_time	numeric(19)	null,
	author	varchar(254)	null,
	last_modified_by	varchar(254)	null,
	psm_version	integer	null,
	wdl	image	null
,constraint epub_wf_info_pkey primary key (id))

create unique index epub_wf_info_x on epub_workflow_info (workflow_name)

create table epub_wf_mig_info (
	id	varchar(40)	not null,
	workflow_info_id	varchar(40)	not null,
	workflow_name	varchar(255)	null,
	modification_time	numeric(19)	null,
	psm_version	integer	null,
	migration_status	integer	null,
	wdl	image	null
,constraint epub_wf_mig_inf_pk primary key (id)
,constraint epub_wf_mig_inf_fk foreign key (workflow_info_id) references epub_workflow_info (id))

create index epub_wf_mig_info_x on epub_wf_mig_info (workflow_info_id)

create table epub_wf_mg_inf_seg (
	id	varchar(40)	not null,
	idx	integer	not null,
	segment_name	varchar(255)	null
,constraint epub_wf_mginfs_pk primary key (id,idx)
,constraint epub_wf_mginfs_fk foreign key (id) references epub_wf_mig_info (id))

--     Workflow template infos.  Each of these infos corresponds to a  
--     workflow template process definition created via the ACC UI.  

create table epub_wf_templ_info (
	id	varchar(40)	not null,
	template_name	varchar(255)	null,
	modification_time	numeric(19)	null,
	creation_time	numeric(19)	null,
	author	varchar(254)	null,
	last_modified_by	varchar(254)	null,
	wdl	image	null
,constraint epub_tl_info_pkey primary key (id))

create unique index epub_tl_info_x on epub_wf_templ_info (template_name)
--     Pending collective transitions associated with workflow processes.  

create table epub_wf_coll_trans (
	id	varchar(40)	not null,
	workflow_name	varchar(255)	null,
	modification_time	numeric(19)	null,
	server_id	varchar(80)	null,
	event_type	varchar(255)	null,
	segment_name	varchar(255)	null,
	state	varchar(16)	null,
	coll_workflow_id	varchar(40)	null,
	step	integer	null,
	current_count	integer	null,
	last_query_id	varchar(40)	null,
	message_bean	image	null
,constraint epub_wf_ctran_pkey primary key (id)
,constraint epub_wf_ctran_fkey foreign key (coll_workflow_id) references epub_coll_workflow (id))

create index epub_wfcolltrans_x on epub_wf_coll_trans (coll_workflow_id)
--     Pending individual transitions associated with workflow processes.  

create table epub_wf_ind_trans (
	id	varchar(40)	not null,
	workflow_name	varchar(255)	null,
	modification_time	numeric(19)	null,
	server_id	varchar(80)	null,
	event_type	varchar(255)	null,
	segment_name	varchar(255)	null,
	state	varchar(16)	null,
	last_query_id	varchar(40)	null,
	message_bean	image	null
,constraint epub_wf_itran_pkey primary key (id))

--     Pending deletions associated with workflow processes.  

create table epub_wf_deletion (
	id	varchar(40)	not null,
	workflow_name	varchar(255)	null,
	modification_time	numeric(19)	null
,constraint epub_wf_del_pkey primary key (id))


create table epub_wf_del_segs (
	id	varchar(40)	not null,
	idx	integer	not null,
	segment_name	varchar(255)	null
,constraint epub_wf_delsg_pkey primary key (id,idx)
,constraint epub_wf_delsg_fkey foreign key (id) references epub_wf_deletion (id))

--     Pending migrations associated with workflow processes.  

create table epub_wf_migration (
	id	varchar(40)	not null,
	workflow_name	varchar(255)	null,
	old_mod_time	numeric(19)	null,
	new_mod_time	numeric(19)	null,
	migration_info_id	varchar(40)	null
,constraint epub_wf_mig_pkey primary key (id))


create table epub_wf_mig_segs (
	id	varchar(40)	not null,
	idx	integer	not null,
	segment_name	varchar(255)	null
,constraint epub_wf_migsg_pkey primary key (id,idx)
,constraint epub_wf_migsg_fkey foreign key (id) references epub_wf_migration (id))

--     Table that keeps track of how the various workflow process manager  
--     servers are classified.  

create table epub_wf_server_id (
	server_id	varchar(80)	not null,
	server_type	integer	not null
,constraint epub_wf_server_pk primary key (server_id))



go



--  @version $Id: //product/Publishing/version/11.2/pws/sql/xml/internal_user_profile_ddl.xml#1 $
--     The tables here are for the user profile extensions needed by EPublishing.  

create table epub_int_user (
	user_id	varchar(40)	not null,
	title	varchar(255)	null,
	expert	numeric(1)	null,
	def_listing	numeric(19)	null,
	allow_applets	numeric(1)	null
,constraint epub_int_user_pk primary key (user_id))


create table epub_int_prj_hist (
	user_id	varchar(40)	not null,
	sequence_num	numeric(19)	not null,
	project_id	varchar(40)	not null
,constraint user_i_prj_hist_pk primary key (user_id,sequence_num)
,constraint user_i_prj_hist_fk foreign key (user_id) references dpi_user (id))



go

-- the source for this section is 
-- viewmapping_ddl.sql




--     ItemMapping    Mapps a component path + item name to that item's views.  

create table vmap_im (
	id	varchar(40)	not null,
	name	varchar(64)	null,
	description	varchar(1024)	null,
	item_path	varchar(255)	not null,
	item_name	varchar(64)	not null,
	is_readonly	numeric(1)	null,
	form_handler	varchar(40)	null,
	mode_id	varchar(40)	not null
,constraint vmap_im_pk primary key (id))

create index vmap_im_item on vmap_im (item_path,item_name,name)
--     FormHandler  

create table vmap_fh (
	id	varchar(40)	not null,
	name	varchar(64)	null,
	description	varchar(2048)	null,
	component_path	varchar(1024)	null
,constraint vmap_fh_pk primary key (id))

--     MapMode  

create table vmap_mode (
	id	varchar(40)	not null,
	name	varchar(64)	not null,
	description	varchar(1024)	null,
	fallback_id	varchar(40)	null)

--     ItemViewMapping  

create table vmap_ivm (
	id	varchar(40)	not null,
	name	varchar(64)	not null,
	display_name	varchar(64)	not null,
	description	varchar(1024)	null,
	view_id	varchar(40)	null
,constraint vmap_ivm_pk primary key (id))

--     ItemMapping -> view ItemViewMapping relation  

create table vmap_im2ivm_rel (
	item_id	varchar(40)	not null,
	sequence_num	integer	not null,
	view_id	varchar(40)	not null
,constraint vmap_im2ivm_pk primary key (item_id,sequence_num))

--     ItemView  

create table vmap_iv (
	id	varchar(40)	not null,
	name	varchar(64)	not null,
	description	varchar(1024)	not null,
	uri	varchar(255)	null,
	view_component	varchar(255)	null,
	app_name	varchar(255)	null,
	mode_id	varchar(40)	not null
,constraint vmap_iv_pk primary key (id))

--     PropertyView  

create table vmap_pv (
	id	varchar(40)	not null,
	name	varchar(64)	not null,
	type	varchar(128)	not null,
	component_type	varchar(128)	null,
	description	varchar(1024)	not null,
	uri	varchar(255)	null,
	view_component	varchar(255)	null,
	app_name	varchar(255)	null,
	mode_id	varchar(40)	not null,
	container_family	varchar(128)	null,
	is_default	numeric(1)	null,
	is_readonly	numeric(1)	null,
	is_component	numeric(1)	null
,constraint vmap_pv_pk primary key (id))

create index vmap_pv_unique on vmap_pv (type,name,mode_id,is_component)
--     The relationship between an ItemViewMapping and its    PropertyViewMapping items  

create table vmap_ivm2pvm_rel (
	ivm_id	varchar(40)	not null,
	pvm_id	varchar(40)	not null,
	name	varchar(64)	not null)

--     PropertyViewMapping  

create table vmap_pvm (
	id	varchar(40)	not null,
	description	varchar(1024)	null,
	pview_id	varchar(40)	null,
	cpview_id	varchar(40)	null
,constraint vmap_pvm_pk primary key (id))

--     AttributeValue  

create table vmap_attrval (
	id	varchar(40)	not null,
	attr_value	varchar(2048)	null
,constraint vmap_attrval_pk primary key (id))

--     A table that provides the mapping between mapping items    and AttributeValue items  

create table vmap_attrval_rel (
	mapper_id	varchar(40)	not null,
	attribute_id	varchar(40)	not null,
	name	varchar(64)	not null
,constraint vmap_attvl_rel_pk primary key (mapper_id,attribute_id))

--     A table that provides the mapping between mapping items    and component AttributeValue items  

create table vmap_cattrval_rel (
	mapper_id	varchar(40)	not null,
	attribute_id	varchar(40)	not null,
	name	varchar(64)	not null
,constraint vmap_ctvl_rel_pk primary key (mapper_id,attribute_id))

--     ItemView -> ItemViewAttributeDefinition relation  

create table vmap_iv2ivad_rel (
	view_id	varchar(40)	not null,
	attr_id	varchar(40)	not null,
	name	varchar(64)	not null
,constraint vmap_iv2iva_pk primary key (view_id,name))

--     ItemViewAttributeDefinition  

create table vmap_ivattrdef (
	id	varchar(40)	not null,
	description	varchar(1024)	null,
	default_value	varchar(1024)	null
,constraint vmap_ivatdef_pk primary key (id))

--     PropertyView -> PropertyViewAttributeDefinition relation  

create table vmap_pv2pvad_rel (
	view_id	varchar(40)	not null,
	attr_id	varchar(40)	not null,
	name	varchar(64)	not null)

--     PropertyViewAttributeDefinition  

create table vmap_pvattrdef (
	id	varchar(40)	not null,
	description	varchar(1024)	null,
	default_value	varchar(1024)	null
,constraint vmap_pvatdef_pk primary key (id))



go
