
-- the source for this section is 
-- internal_scenario_ddl.sql





create table dsi_coll_scenario (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	default null,
	modification_time	numeric(19,0)	default null,
	segment_name	varchar(255)	default null,
	creator_id	varchar(25)	default null,
	state	varchar(16)	default null
,constraint dsi_coll_scenari_p primary key (id));

-- user_id references the user table but because it is a backwards referencewe cannot have a REFERENCES(dps_user) here.

create table dsi_ind_scenario (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	default null,
	modification_time	numeric(19,0)	default null,
	segment_name	varchar(255)	default null,
	creator_id	varchar(25)	default null,
	state	varchar(16)	default null,
	user_id	varchar(25)	not null
,constraint dsi_ind_scenario_p primary key (id));

create index dsi_indscenario1_x on dsi_ind_scenario (modification_time);

create table dsi_scenario_strs (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_str	varchar(255)	default null
,constraint dsi_scenario_str_p primary key (id,tag)
,constraint dsi_scenrstrsid_f foreign key (id) references dsi_ind_scenario (id));


create table dsi_scenario_bools (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_bool	numeric(1,0)	default null
,constraint dsi_scenario_boo_p primary key (id,tag)
,constraint dsi_scenrblsid_f foreign key (id) references dsi_ind_scenario (id));


create table dsi_scenario_longs (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_long	numeric(19,0)	default null
,constraint dsi_scenario_lon_p primary key (id,tag)
,constraint dsi_scenrlngsid_f foreign key (id) references dsi_ind_scenario (id));


create table dsi_scenario_dbls (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_dbl	numeric(15,4)	default null
,constraint dsi_scenario_dbl_p primary key (id,tag)
,constraint dsi_scenrdblsid_f foreign key (id) references dsi_ind_scenario (id));


create table dsi_scenario_dates (
	id	varchar(25)	not null,
	tag	varchar(25)	not null,
	context_date	timestamp	default null
,constraint dsi_scenario_dat_p primary key (id,tag)
,constraint dsi_scenrdtsid_f foreign key (id) references dsi_ind_scenario (id));


create table dpi_user_scenario (
	id	varchar(40)	not null,
	ind_scenario_id	varchar(25)	not null
,constraint dpi_user_scenari_p primary key (ind_scenario_id)
,constraint dpi_usrscnrid_f foreign key (id) references dpi_user (id)
,constraint dpi_usrsind_scnr_f foreign key (ind_scenario_id) references dsi_ind_scenario (id));

create index dpi_uscn_u_idx on dpi_user_scenario (id);

create table dsi_scenario_info (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	default null,
	scenario_status	integer	default null,
	modification_time	numeric(19,0)	default null,
	creation_time	numeric(19,0)	default null,
	author	varchar(254)	default null,
	last_modified_by	varchar(254)	default null,
	sdl	blob(1048576)	default null,
	psm_version	integer	default null
,constraint dsi_scenario_inf_p primary key (id));

create unique index dsi_scenario_inf_x on dsi_scenario_info (scenario_name);

create table dsi_scen_mig_info (
	id	varchar(25)	not null,
	scenario_info_id	varchar(25)	not null,
	scenario_name	varchar(255)	default null,
	modification_time	numeric(19,0)	default null,
	psm_version	integer	default null,
	sdl	blob(1048576)	default null,
	migration_status	integer	default null
,constraint dsi_scenmiginfo_pk primary key (id)
,constraint dsi_scenmiginfo_fk foreign key (scenario_info_id) references dsi_scenario_info (id));

create index dsi_scenmiginfo_id on dsi_scen_mig_info (scenario_info_id);

create table dsi_mig_info_seg (
	id	varchar(25)	not null,
	idx	integer	not null,
	segment_name	varchar(255)	default null
,constraint dsi_mig_infoseg_pk primary key (id,idx)
,constraint dsi_mig_infoseg_fk foreign key (id) references dsi_scen_mig_info (id));


create table dsi_template_info (
	id	varchar(25)	not null,
	template_name	varchar(255)	default null,
	modification_time	numeric(19,0)	default null,
	creation_time	numeric(19,0)	default null,
	author	varchar(254)	default null,
	last_modified_by	varchar(254)	default null,
	sdl	blob(1048576)	default null
,constraint dsi_template_inf_p primary key (id));

create unique index dsi_template_inf_x on dsi_template_info (template_name);

create table dsi_coll_trans (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	default null,
	modification_time	numeric(19,0)	default null,
	server_id	varchar(80)	default null,
	message_bean	blob(1048576)	default null,
	event_type	varchar(255)	default null,
	segment_name	varchar(255)	default null,
	state	varchar(16)	default null,
	coll_scenario_id	varchar(25)	default null,
	step	integer	default null,
	current_count	integer	default null,
	last_query_id	varchar(25)	default null
,constraint dsi_coll_trans_p primary key (id)
,constraint dsi_collcoll_scn_f foreign key (coll_scenario_id) references dsi_coll_scenario (id));

create index dsi_ctrcid_idx on dsi_coll_trans (coll_scenario_id);

create table dsi_ind_trans (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	default null,
	modification_time	numeric(19,0)	default null,
	server_id	varchar(80)	default null,
	message_bean	blob(1048576)	default null,
	event_type	varchar(255)	default null,
	segment_name	varchar(255)	default null,
	state	varchar(16)	default null,
	last_query_id	varchar(25)	default null
,constraint dsi_ind_trans_p primary key (id));


create table dsi_deletion (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	default null,
	modification_time	numeric(19,0)	default null
,constraint dsi_deletion_p primary key (id));


create table dsi_server_id (
	server_id	varchar(80)	not null,
	server_type	integer	not null
,constraint dsi_server_id_p primary key (server_id));


create table dsi_del_seg_name (
	id	varchar(25)	not null,
	idx	integer	not null,
	segment_name	varchar(255)	default null
,constraint dsi_del_seg_name_p primary key (id,idx));

-- migration_info_id references the migration info table, but we don't have aREFERENCES dsi_scen_mig_info(id) here, because we want to be ableto delete the migration info without deleting this row

create table dsi_migration (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	default null,
	old_mod_time	numeric(19,0)	default null,
	new_mod_time	numeric(19,0)	default null,
	migration_info_id	varchar(25)	default null
,constraint dsi_migration_pk primary key (id));


create table dsi_mig_seg_name (
	id	varchar(25)	not null,
	idx	integer	not null,
	segment_name	varchar(255)	default null
,constraint dsi_mig_segname_pk primary key (id,idx)
,constraint dsi_mig_segname_fk foreign key (id) references dsi_migration (id));


create table dsi_xref (
	id	varchar(25)	not null,
	scenario_name	varchar(255)	default null,
	reference_type	varchar(25)	default null,
	reference_target	varchar(255)	default null
,constraint dsi_xref_p primary key (id));

-- user_id references the user table but because it is a backwards referencewe cannot have a REFERENCES(dpi_user) here.

create table dsi_profile_slot (
	id	varchar(25)	not null,
	slot_name	varchar(255)	default null,
	item_offset	numeric(19,0)	default null,
	user_id	varchar(25)	not null
,constraint dsi_profile_slot_p primary key (id));


create table dpi_user_slot (
	id	varchar(40)	not null,
	profile_slot_id	varchar(25)	not null
,constraint dpi_user_slot_p primary key (id,profile_slot_id)
,constraint dpi_usrsltid_f foreign key (id) references dpi_user (id)
,constraint dpi_usrsprofl_sl_f foreign key (profile_slot_id) references dsi_profile_slot (id));

create index dpi_usr_sltprfl_id on dpi_user_slot (profile_slot_id);

create table dsi_slot_items (
	slot_id	varchar(25)	not null,
	item_id	varchar(255)	default null,
	idx	integer	not null
,constraint dsi_slot_items_p primary key (slot_id,idx)
,constraint dsi_slotslot_d_f foreign key (slot_id) references dsi_profile_slot (id));


create table dsi_slot_priority (
	slot_id	varchar(25)	not null,
	idx	integer	not null,
	priority	numeric(19,0)	not null
,constraint dsi_slot_priorit_p primary key (slot_id,idx)
,constraint dsi_slotpslot_d_f foreign key (slot_id) references dsi_profile_slot (id));


create table dpi_scenario_value (
	id	varchar(40)	not null,
	tag	varchar(42)	not null,
	scenario_value	varchar(100)	default null
,constraint dpi_scenario_val_p primary key (id,tag)
,constraint dpi_scenrvlid_f foreign key (id) references dpi_user (id));

create index dpi_scenval_id on dpi_scenario_value (id);
commit;


