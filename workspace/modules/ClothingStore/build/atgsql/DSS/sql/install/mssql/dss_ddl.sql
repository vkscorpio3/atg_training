
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
