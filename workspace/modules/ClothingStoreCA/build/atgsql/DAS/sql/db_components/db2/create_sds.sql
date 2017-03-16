


--  @version $Id: //product/DAS/version/11.2/templates/DAS/sql/create_sds.xml#1 $$Change: 946917 $

create table das_sds (
	sds_name	varchar(50)	not null,
	curr_ds_name	varchar(50)	default null,
	dynamo_server	varchar(80)	default null,
	last_modified	timestamp	default null
,constraint das_sds_p primary key (sds_name));

commit;


