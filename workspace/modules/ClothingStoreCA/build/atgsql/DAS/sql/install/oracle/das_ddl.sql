
-- the source for this section is 
-- id_generator.sql





create table das_id_generator (
	id_space_name	varchar2(60)	not null,
	seed	number(19,0)	not null,
	batch_size	integer	not null,
	prefix	varchar2(10)	null,
	suffix	varchar2(10)	null
,constraint das_id_generator_p primary key (id_space_name));


create table das_secure_id_gen (
	id_space_name	varchar2(60)	not null,
	seed	number(19,0)	not null,
	batch_size	integer	not null,
	ids_per_batch	integer	null,
	prefix	varchar2(10)	null,
	suffix	varchar2(10)	null
,constraint das_secure_id_ge_p primary key (id_space_name));





-- the source for this section is 
-- cluster_name_ddl.sql





create table das_cluster_name (
	cluster_name	varchar2(255)	not null,
	saved_date	number(19)	not null);





-- the source for this section is 
-- dms_limbo_ddl.sql




-- This table is where limbo instance/clients identify themselves. --There should only be one entry in this table for each Dynamo running PatchBay with message delays enabled.

create table dms_limbo (
	limbo_name	varchar2(250)	not null,
	limbo_id	number(19,0)	not null
,constraint limbo_pk primary key (limbo_name));

-- The following four tables comprise the parts of the stored messages.

create table dms_limbo_msg (
	msg_id	number(19,0)	not null,
	limbo_id	number(19,0)	not null,
	delivery_date	number(19,0)	not null,
	delivery_count	number(2,0)	not null,
	msg_src_name	varchar2(250)	not null,
	port_name	varchar2(250)	not null,
	msg_class	varchar2(250)	not null,
	msg_class_type	number(1,0)	not null,
	jms_type	varchar2(250)	null,
	jms_expiration	number(19,0)	null,
	jms_correlationid	varchar2(250)	null
,constraint limbo_msg_pk primary key (msg_id));

create index dms_limbo_read_idx on dms_limbo_msg (limbo_id,delivery_date);
-- If serialized reply-to destinations are known to be small enough, this binary column's size can be reduced for efficiency.  The size here has been chosen to work with local dms and SQL-JMS.

create table dms_limbo_replyto (
	msg_id	number(19,0)	not null,
	jms_replyto	blob	null
,constraint limbo_replyto_pk primary key (msg_id));

-- If serialized message bodies are known to be small enough, this binary column's size can be reduced for efficiency.  The size here has been chosen to work with almost all types of messages but may be larger than necessary.  Actual usage analysis is recommended for finding the optimal binary column size.

create table dms_limbo_body (
	msg_id	number(19,0)	not null,
	msg_body	blob	null
,constraint limbo_body_pk primary key (msg_id));

-- This table represents a map of properties for messages stored above, i.e.  there can be multiple rows in this table for a single row in the preceeding tables.

create table dms_limbo_props (
	msg_id	number(19,0)	not null,
	prop_name	varchar2(250)	not null,
	prop_value	varchar2(250)	not null
,constraint limbo_props_pk primary key (msg_id,prop_name));


create table dms_limbo_ptypes (
	msg_id	number(19,0)	not null,
	prop_name	varchar2(250)	not null,
	prop_type	number(1,0)	not null
,constraint dms_limbo_ptypes_p primary key (msg_id,prop_name));


create table dms_limbo_delay (
	msg_id	number(19,0)	not null,
	delay	number(19,0)	not null,
	max_attempts	number(2,0)	not null,
	failure_port	varchar2(250)	not null,
	jms_timestamp	number(19,0)	null,
	jms_deliverymode	number(10,0)	null,
	jms_priority	number(10,0)	null,
	jms_messageid	varchar2(250)	null,
	jms_redelivered	number(1,0)	null,
	jms_destination	blob	null
,constraint limbo_delay_pk primary key (msg_id));





-- the source for this section is 
-- create_sql_jms_ddl.sql





create table dms_client (
	client_name	varchar2(250)	not null,
	client_id	number(19,0)	null
,constraint dms_client_p primary key (client_name));


create table dms_queue (
	queue_name	varchar2(250)	null,
	queue_id	number(19,0)	not null,
	temp_id	number(19,0)	null
,constraint dms_queue_p primary key (queue_id));


create table dms_queue_recv (
	client_id	number(19,0)	null,
	receiver_id	number(19,0)	not null,
	queue_id	number(19,0)	null
,constraint dms_queue_recv_p primary key (receiver_id));


create table dms_queue_entry (
	queue_id	number(19,0)	not null,
	msg_id	number(19,0)	not null,
	delivery_date	number(19,0)	null,
	handling_client_id	number(19,0)	null,
	read_state	number(19,0)	null
,constraint dms_queue_entry_p primary key (queue_id,msg_id));

create index dms_queue_msg_idx on dms_queue_entry (msg_id);

create table dms_topic (
	topic_name	varchar2(250)	null,
	topic_id	number(19,0)	not null,
	temp_id	number(19,0)	null
,constraint dms_topic_p primary key (topic_id));


create table dms_topic_sub (
	client_id	number(19,0)	null,
	subscriber_name	varchar2(250)	null,
	subscriber_id	number(19,0)	not null,
	topic_id	number(19,0)	null,
	durable	number(1,0)	null,
	active	number(1,0)	null
,constraint dms_topic_sub_p primary key (subscriber_id));


create table dms_topic_entry (
	subscriber_id	number(19,0)	not null,
	msg_id	number(19,0)	not null,
	delivery_date	number(19,0)	null,
	read_state	number(19,0)	null
,constraint dms_topic_entry_p primary key (subscriber_id,msg_id));

create index dms_topic_msg_idx on dms_topic_entry (msg_id,subscriber_id);
create index dms_topic_read_idx on dms_topic_entry (read_state,delivery_date);

create table dms_msg (
	msg_class	varchar2(250)	null,
	has_properties	number(1,0)	null,
	reference_count	number(10,0)	null,
	msg_id	number(19,0)	not null,
	timestamp	number(19,0)	null,
	correlation_id	varchar2(250)	null,
	reply_to	number(19,0)	null,
	destination	number(19,0)	null,
	delivery_mode	number(1,0)	null,
	redelivered	number(1,0)	null,
	type	varchar2(250)	null,
	expiration	number(19,0)	null,
	priority	number(1,0)	null,
	small_body	blob	null,
	large_body	blob	null
,constraint dms_msg_p primary key (msg_id));


create table dms_msg_properties (
	msg_id	number(19,0)	not null,
	data_type	number(1,0)	null,
	name	varchar2(250)	not null,
	value	varchar2(250)	null
,constraint dms_msg_properti_p primary key (msg_id,name));

create or replace procedure dms_queue_flag
(Pbatch_size    IN NUMBER
,Pread_lock     IN NUMBER
,Pdelivery_date IN NUMBER
,Pclient_id     IN NUMBER
,Pqueue_id      IN NUMBER
,Pupdate_count  OUT NUMBER)
as
             Begin
    UPDATE dms_queue_entry qe
    SET qe.handling_client_id = Pclient_id, 
        qe.read_state = Pread_lock 
    WHERE ROWNUM < Pbatch_size
      AND qe.handling_client_id < 0 
      AND qe.delivery_date < Pdelivery_date 
      AND qe.queue_id = Pqueue_id;
    Pupdate_count := SQL%ROWCOUNT;
  END;
         
/

create or replace procedure dms_topic_flag
(Pbatch_size    IN NUMBER
,Pread_lock     IN NUMBER
,Pdelivery_date IN NUMBER
,Psubscriber_id IN NUMBER
,Pupdate_count  OUT NUMBER)
as
             Begin
    UPDATE dms_topic_entry te 
    SET te.read_state = Pread_lock 
    WHERE ROWNUM < Pbatch_size
      AND te.delivery_date < Pdelivery_date 
      AND te.read_state = 0 
      AND te.subscriber_id = Psubscriber_id;
    Pupdate_count := SQL%ROWCOUNT;
  END; 
         
/



-- the source for this section is 
-- create_staff_ddl.sql




-- SQL for creating the Dynamo Staff Repository for the GSA
-- Primary account table.
--  Type=1 is a login account.  The first_name, last_name, and password         fields are valid for this type of account.
-- Type=2 is a group account.  The description field is valid for        this type of account.
-- Type=4 is a privilege account.  The description field is valid for        this type of account.

create table das_account (
	account_name	varchar2(254)	not null,
	type	integer	not null,
	first_name	varchar2(254)	null,
	last_name	varchar2(254)	null,
	password	varchar2(254)	null,
	description	varchar2(254)	null,
	lastpwdupdate	date	null,
	password_kdf	varchar2(250)	null
,constraint das_account_p primary key (account_name));


create table das_group_assoc (
	account_name	varchar2(254)	not null,
	sequence_num	integer	not null,
	group_name	varchar2(254)	not null
,constraint das_grp_asc_p primary key (account_name,sequence_num));

-- Adding the previous password information

create table das_acct_prevpwd (
	account_name	varchar2(254)	not null,
	seq_num	number(10)	not null,
	prevpwd	varchar2(70)	null
,constraint das_prevpwd_p primary key (account_name,seq_num)
,constraint das_prvpwd_d_f foreign key (account_name) references das_account (account_name));





-- the source for this section is 
-- create_gsa_subscribers_ddl.sql





create table das_gsa_subscriber (
	id	integer	not null,
	address	varchar2(50)	not null,
	port	integer	not null,
	repository	varchar2(256)	not null,
	itemdescriptor	varchar2(256)	not null
,constraint das_gsa_subscrib_p primary key (id));





-- the source for this section is 
-- create_sds.sql





create table das_sds (
	sds_name	varchar2(50)	not null,
	curr_ds_name	varchar2(50)	null,
	dynamo_server	varchar2(80)	null,
	last_modified	date	null
,constraint das_sds_p primary key (sds_name));





-- the source for this section is 
-- integration_data_ddl.sql





create table if_integ_data (
	item_id	varchar2(40)	not null,
	descriptor	varchar2(64)	not null,
	repository	varchar2(255)	not null,
	state	number(10)	not null,
	last_import	date	null,
	version	number(10)	not null
,constraint if_int_data_p primary key (item_id,descriptor,repository));





-- the source for this section is 
-- nucleus_security_ddl.sql





create table das_nucl_sec (
	func_name	varchar2(254)	not null,
	policy	varchar2(254)	not null
,constraint func_name_pk primary key (func_name));


create table das_ns_acls (
	id	varchar2(254)	not null,
	index_num	number(10)	not null,
	acl	varchar2(254)	not null
,constraint id_index_pk primary key (id,index_num));





-- the source for this section is 
-- media_ddl.sql




--     media content repository tables.  

create table media_folder (
	folder_id	varchar2(40)	not null,
	version	integer	not null,
	creation_date	date	null,
	description	varchar2(254)	null,
	name	varchar2(254)	not null,
	path	varchar2(254)	not null,
	parent_folder_id	varchar2(40)	null
,constraint md_folder_p primary key (folder_id)
,constraint md_foldparnt_fl_f foreign key (parent_folder_id) references media_folder (folder_id));

create index fldr_mfldrid_idx on media_folder (parent_folder_id);
create index md_fldr_path_idx on media_folder (path);

create table media_base (
	media_id	varchar2(40)	not null,
	version	integer	not null,
	creation_date	date	null,
	description	varchar2(254)	null,
	name	varchar2(254)	not null,
	path	varchar2(254)	not null,
	parent_folder_id	varchar2(40)	not null,
	media_type	integer	null
,constraint media_p primary key (media_id)
,constraint medparnt_fl_f foreign key (parent_folder_id) references media_folder (folder_id));

create index med_mfldrid_idx on media_base (parent_folder_id);
create index media_path_idx on media_base (path);
create index media_type_idx on media_base (media_type);

create table media_ext (
	media_id	varchar2(40)	not null,
	url	varchar2(254)	not null
,constraint media_ext_p primary key (media_id)
,constraint medxtmed_d_f foreign key (media_id) references media_base (media_id));


create table media_bin (
	media_id	varchar2(40)	not null,
	length	integer	not null,
	last_modified	date	not null,
	data	blob	not null
,constraint media_bin_p primary key (media_id)
,constraint medbnmed_d_f foreign key (media_id) references media_base (media_id));


create table media_txt (
	media_id	varchar2(40)	not null,
	length	integer	not null,
	last_modified	date	not null,
	data	clob	not null
,constraint media_txt_p primary key (media_id)
,constraint medtxtmed_d_f foreign key (media_id) references media_base (media_id));





-- the source for this section is 
-- deployment_ddl.sql




--     These tables are for the daf deployment system  

create table das_deployment (
	deployment_id	varchar2(40)	not null,
	version	number(10)	not null,
	start_time	date	null,
	end_time	date	null,
	failure_time	date	null,
	status	number(10)	null,
	prev_status	number(10)	null,
	status_detail	varchar2(255)	null,
	current_phase	number(10)	null,
	rep_high_mark	number(10)	null,
	rep_marks_avail	number(10)	null,
	file_high_mark	number(10)	null,
	file_marks_avail	number(10)	null,
	thread_batch_size	number(10)	null,
	failure_count	number(10)	null,
	purge_deploy_data	number(1)	null
,constraint daf_depl_pk primary key (deployment_id));

create index das_dpl_start_idx on das_deployment (start_time);

create table das_depl_progress (
	deployment_id	varchar2(40)	not null,
	version	number(10)	not null,
	work_completed	number(10)	null,
	total_work	number(10)	null
,constraint daf_depl_prg_pk primary key (deployment_id));


create table das_thread_batch (
	thread_batch_id	varchar2(40)	not null,
	version	number(10)	not null,
	deployment	varchar2(40)	null,
	type	number(10)	null,
	owner	varchar2(255)	null,
	thread_name	varchar2(255)	null,
	lower_bound	number(10)	null,
	upper_bound	number(10)	null,
	last_update_time	timestamp	null,
	running	number(1,0)	not null
,constraint das_dpl_tb_pk primary key (thread_batch_id));

create index das_tb_deployment on das_thread_batch (deployment);
create index das_tb_owner on das_thread_batch (owner);
create index das_tb_thread_nam on das_thread_batch (thread_name);

create table das_deploy_data (
	deploy_data_id	varchar2(40)	not null,
	version	number(10)	not null,
	type	number(10)	null,
	source	varchar2(255)	null,
	destination	varchar2(255)	null,
	dest_server	varchar2(255)	null,
	deployment	varchar2(40)	null
,constraint deploy_data_pk primary key (deploy_data_id)
,constraint dd_deployment_fk foreign key (deployment) references das_deployment (deployment_id));

create index dd_deployment_idx on das_deploy_data (deployment);

create table das_deploy_mark (
	marker_id	varchar2(40)	not null,
	version	number(10)	not null,
	type	number(10)	null,
	status	number(10)	null,
	index_number	number(10)	null,
	marker_action	number(10)	null,
	f_src_devline_id	varchar2(40)	null,
	r_src_devline_id	varchar2(40)	null,
	deployment_id	varchar2(40)	null,
	deployment_data	varchar2(40)	null
,constraint marker_pk primary key (marker_id));

create index marker_index_idx on das_deploy_mark (index_number);
create index marker_data_idx on das_deploy_mark (deployment_data);

create table das_rep_mark (
	rep_marker_id	varchar2(40)	not null,
	item_desc_name	varchar2(255)	null,
	item_id	varchar2(255)	null
,constraint rep_marker_pk primary key (rep_marker_id));


create table das_file_mark (
	file_marker_id	varchar2(40)	not null,
	file_path	varchar2(1000)	null
,constraint file_marker_pk primary key (file_marker_id));


create table das_depl_depldat (
	deployment_id	varchar2(40)	not null,
	sequence_num	number(10)	not null,
	deployment_data	varchar2(40)	null
,constraint das_dpl_depdat_pk primary key (deployment_id,sequence_num));


create table das_depl_options (
	deployment_id	varchar2(40)	not null,
	tag	varchar2(255)	not null,
	optionValue	varchar2(255)	null
,constraint das_dpl_depopt_pk primary key (deployment_id,tag));


create table das_depl_repmaps (
	deployment_id	varchar2(40)	not null,
	source	varchar2(255)	not null,
	destination	varchar2(255)	null
,constraint das_dpl_repmap_pk primary key (deployment_id,source));


create table das_depl_item_ref (
	item_ref_id	varchar2(40)	not null,
	version	number(10)	not null,
	deployment_id	varchar2(40)	null,
	repository	varchar2(255)	null,
	item_desc_name	varchar2(255)	null,
	item_id	varchar2(255)	null,
	item_index	number(10)	null
,constraint das_dpl_itmref_pk primary key (item_ref_id));

create index das_dpl_itmx_idx on das_depl_item_ref (item_index);
create index das_dpl_dplid_idx on das_depl_item_ref (deployment_id);

create table das_dd_markers (
	deploy_data_id	varchar2(40)	not null,
	sequence_num	number(10)	not null,
	marker	varchar2(40)	null
,constraint das_dpl_dd_mrk_pk primary key (deploy_data_id,sequence_num)
,constraint marker_fk foreign key (marker) references das_deploy_mark (marker_id));

create index marker_idx on das_dd_markers (marker);

create table das_dep_fail_info (
	id	varchar2(40)	not null,
	deployment_id	varchar2(40)	not null,
	marker_id	varchar2(40)	null,
	severity	varchar2(40)	null,
	failure_message	varchar2(255)	null,
	failure_time	timestamp	null,
	error_code	varchar2(40)	null,
	cause	clob	null
,constraint das_dp_fl_inf_pk primary key (id));

create index das_dep_fl_dp_idx on das_dep_fail_info (deployment_id);




-- the source for this section is 
-- sitemap_ddl.sql




-- Table for siteindex repository item

create table das_siteindex (
	siteindex_id	varchar2(40)	not null,
	lastmod	date	null,
	filename	varchar2(100)	null,
	xml	clob	null
,constraint siteindex_pk primary key (siteindex_id));

-- Table for sitemap repository item

create table das_sitemap (
	sitemap_id	varchar2(40)	not null,
	lastmod	date	null,
	filename	varchar2(100)	null,
	xml	clob	null
,constraint sitemap_pk primary key (sitemap_id));





-- the source for this section is 
-- seo_ddl.sql




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





-- the source for this section is 
-- site_ddl.sql




-- This file contains create table statements, which will configureyour database for use MultiSite

create table site_template (
	id	varchar2(40)	not null,
	name	varchar2(254)	not null,
	description	varchar2(254)	not null,
	item_mapping_id	varchar2(40)	not null
,constraint site_template1_p primary key (id));


create table site_configuration (
	id	varchar2(40)	not null,
	type	number(10)	null,
	name	varchar2(254)	not null,
	description	varchar2(254)	null,
	template	varchar2(40)	null,
	production_url	varchar2(254)	null,
	enabled	number(1)	not null,
	site_down_url	varchar2(254)	null,
	open_date	date	null,
	pre_opening_url	varchar2(254)	null,
	closing_date	date	null,
	post_closing_url	varchar2(254)	null,
	modification_time	date	null,
	creation_time	date	null,
	author	varchar2(254)	null,
	last_modified_by	varchar2(254)	null,
	site_icon	varchar2(254)	null,
	favicon	varchar2(254)	null,
	site_priority	number(10)	null,
	context_root	varchar2(254)	null,
	access_level	number(10)	null,
	realm_id	varchar2(40)	null,
	endeca_site_id	varchar2(254)	null
,constraint site_configurat1_p primary key (id));


create table site_additional_urls (
	id	varchar2(40)	not null,
	additional_production_url	varchar2(254)	null,
	idx	number(10)	not null
,constraint siteadditio_url1_p primary key (id,idx));


create table site_types (
	id	varchar2(40)	not null,
	site_type	varchar2(254)	not null
,constraint site_types1_p primary key (id,site_type));


create table site_group (
	id	varchar2(40)	not null,
	display_name	varchar2(254)	not null,
	type	number(10)	null
,constraint site_group1_p primary key (id));


create table site_group_sites (
	site_id	varchar2(40)	not null,
	site_group_id	varchar2(40)	not null
,constraint site_group_sites_p primary key (site_id,site_group_id)
,constraint site_group_site1_f foreign key (site_id) references site_configuration (id)
,constraint site_group_site2_f foreign key (site_group_id) references site_group (id));

create index site_group_site1_x on site_group_sites (site_id);
create index site_group_site2_x on site_group_sites (site_group_id);

create table site_group_shareable_types (
	shareable_types	varchar2(254)	not null,
	site_group_id	varchar2(40)	not null
,constraint site_group_share_p primary key (shareable_types,site_group_id)
,constraint site_group_shar1_f foreign key (site_group_id) references site_group (id));

create index site_group_shar1_x on site_group_shareable_types (site_group_id);




-- the source for this section is 
-- create_system_config.sql





create table das_sys_config (
	parameter_key	varchar2(50)	not null,
	parameter_value	varchar2(255)	not null
,constraint das_sys_config_p primary key (parameter_key));





-- the source for this section is 
-- purge_ddl.sql




-- 
-- Purge Progress Tables
-- $Id: //product/DAS/version/11.2/templates/DAS/sql/purge_ddl.xml#1 $
-- 

create table das_purge_progress (
	purge_progress_id	varchar2(40)	not null,
	item_type	varchar2(254)	not null,
	start_timestamp	timestamp	null,
	update_timestamp	timestamp	null,
	end_timestamp	timestamp	null,
	status	number(10)	not null,
	success_items	number(10)	default 0 not null,
	skipped_items	number(10)	default 0 not null,
	skipped_on_error_items	number(10)	default 0 not null,
	error_items	number(10)	default 0 not null,
	processed_items	number(10)	default 0 not null,
	estimated_items	number(10)	default 0 not null,
	total_items	number(10)	default 0 not null,
	owner	varchar2(254)	null,
	criteria	varchar2(4000)	null,
	related_criteria	varchar2(4000)	null,
	error_message	clob	null
,constraint das_purge_pr_p primary key (purge_progress_id));





-- the source for this section is 
-- dynamic_metadata_ddl.sql




-- Tables for Dynamic Repository Metadata storage

create table das_gsa_dyn_type (
	id	varchar2(40)	not null,
	type_name	varchar2(254)	null,
	item_descriptor	varchar2(254)	null,
	root_item_descriptor	varchar2(254)	null,
	repository	varchar2(254)	null,
	sub_type_value	varchar2(254)	null,
	sub_type_num	number(10)	null,
	removed	number(1)	null
,constraint das_gsa_dyn_type_p primary key (id));


create table das_gsa_dyn_type_attr (
	id	varchar2(40)	not null,
	attribute_key	varchar2(254)	not null,
	attribute_value	varchar2(254)	not null
,constraint das_gsa_dyn_type_attr_p primary key (id,attribute_key));


create table das_gsa_dyn_prop (
	id	varchar2(40)	not null,
	property_name	varchar2(254)	not null,
	item_descriptor	varchar2(254)	null,
	repository	varchar2(254)	null,
	data_type	varchar2(254)	null,
	backing_map	varchar2(254)	null,
	removed	number(1)	null
,constraint das_gsa_dyn_prop_p primary key (id));


create table das_gsa_dyn_prop_enum (
	id	varchar2(40)	not null,
	enumeration_values	varchar2(254)	not null,
	enumeration_value_num	number(10)	not null
,constraint das_gsa_dyn_prop_enum_p primary key (id,enumeration_values));


create table das_gsa_dyn_prop_eorder (
	id	varchar2(40)	not null,
	seq_num	number(10)	not null,
	enumeration_order	varchar2(254)	not null
,constraint das_gsa_dyn_prop_eorder_p primary key (id,seq_num));


create table das_gsa_dyn_prop_attr (
	id	varchar2(40)	not null,
	attribute_key	varchar2(254)	not null,
	attribute_value	varchar2(254)	not null
,constraint das_gsa_dyn_prop_attr_p primary key (id,attribute_key));





-- the source for this section is 
-- backing_maps_ddl.sql




-- Tables for backing maps for item descriptors enables for dynamic properties

create table das_dyn_prop_map_str (
	id	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	varchar2(400)	null
,constraint das_dyn_prop_map_str_p primary key (id,prop_name));


create table das_dyn_prop_map_big_str (
	id	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	clob	null
,constraint das_dyn_prop_map_big_str_p primary key (id,prop_name));


create table das_dyn_prop_map_double (
	id	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	number(19,7)	null
,constraint das_dyn_prop_map_double_p primary key (id,prop_name));


create table das_dyn_prop_map_long (
	id	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	number(19)	null
,constraint das_dyn_prop_map_long_p primary key (id,prop_name));


create table das_dyn_prop_map_str_2 (
	id1	varchar2(40)	not null,
	id2	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	varchar2(400)	null
,constraint das_dyn_prop_map_str_2_p primary key (id1,id2,prop_name));


create table das_dyn_prop_map_big_str_2 (
	id1	varchar2(40)	not null,
	id2	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	clob	null
,constraint das_dyn_prop_mp_bg_str_2_p primary key (id1,id2,prop_name));


create table das_dyn_prop_map_double_2 (
	id1	varchar2(40)	not null,
	id2	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	number(19,7)	null
,constraint das_dyn_prop_mp_dbl_2_p primary key (id1,id2,prop_name));


create table das_dyn_prop_map_long_2 (
	id1	varchar2(40)	not null,
	id2	varchar2(40)	not null,
	prop_name	varchar2(254)	not null,
	prop_value	number(19)	null
,constraint das_dyn_prop_mp_lng_2_p primary key (id1,id2,prop_name));




