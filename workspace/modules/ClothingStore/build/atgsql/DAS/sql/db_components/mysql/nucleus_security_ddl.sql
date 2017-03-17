


--  @version $Id: //product/DAS/version/11.2/templates/DAS/sql/nucleus_security_ddl.xml#1 $$Change: 946917 $

create table das_nucl_sec (
	func_name	nvarchar(254)	not null,
	policy	nvarchar(254)	not null
,constraint func_name_pk primary key (func_name));


create table das_ns_acls (
	id	nvarchar(254)	not null,
	index_num	integer	not null,
	acl	nvarchar(254)	not null
,constraint id_index_pk primary key (id,index_num));

commit;


