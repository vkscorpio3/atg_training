


--  @version $Id: //product/DSS/version/11.2/templates/DSS/sql/business_process_rpt_ddl.xml#1 $$Change: 946917 $

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
