


--  @version $Id: //product/DAS/version/11.2/templates/DAS/sql/id_generator.xml#1 $$Change: 946917 $

create table das_id_generator (
	id_space_name	varchar(60)	not null,
	seed	numeric(19,0)	not null,
	batch_size	integer	not null,
	prefix	varchar(10)	default null,
	suffix	varchar(10)	default null
,constraint das_id_generator_p primary key (id_space_name));


create table das_secure_id_gen (
	id_space_name	varchar(60)	not null,
	seed	numeric(19,0)	not null,
	batch_size	integer	not null,
	ids_per_batch	integer	default null,
	prefix	varchar(10)	default null,
	suffix	varchar(10)	default null
,constraint das_secure_id_ge_p primary key (id_space_name));

commit;


