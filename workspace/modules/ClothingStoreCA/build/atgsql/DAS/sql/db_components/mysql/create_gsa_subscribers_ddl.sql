


--  @version $Id: //product/DAS/version/11.2/templates/DAS/sql/create_gsa_subscribers_ddl.xml#1 $$Change: 946917 $

create table das_gsa_subscriber (
	id	integer	not null,
	address	varchar(50)	not null,
	port	integer	not null,
	repository	varchar(256)	not null,
	itemdescriptor	varchar(256)	not null
,constraint das_gsa_subscrib_p primary key (id));

commit;


