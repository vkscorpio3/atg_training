
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
