


--  @version $Id: //product/DAS/version/11.2/templates/DAS/sql/create_sds.xml#1 $$Change: 946917 $

create table das_sds (
	sds_name	varchar(50)	not null,
	curr_ds_name	varchar(50)	null,
	dynamo_server	varchar(80)	null,
	last_modified	datetime	null
,constraint das_sds_p primary key (sds_name))



go
