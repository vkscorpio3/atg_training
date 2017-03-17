


--  @version $Id: //product/DAS/version/11.2/templates/DAS/sql/usage_tracking_ddl.xml#1 $$Change: 946917 $
-- This file contains create table statements, which will configureyour database for usage tracking

create table das_usage_metric (
	usage_metric_id	bigint	not null,
	server_identifier	varchar(100)	not null,
	usage_date	datetime	not null,
	usage_hour_of_day	tinyint	not null,
	usage_value	integer	default 0 not null
,constraint das_usage_metric_p primary key (usage_metric_id));

commit;


