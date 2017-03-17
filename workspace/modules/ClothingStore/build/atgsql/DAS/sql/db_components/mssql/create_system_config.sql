


--  @version $Id: //product/DAS/version/11.2/templates/DAS/sql/create_system_config.xml#1 $$Change: 946917 $

create table das_sys_config (
	parameter_key	varchar(50)	not null,
	parameter_value	varchar(255)	not null
,constraint das_sys_config_p primary key (parameter_key))



go
