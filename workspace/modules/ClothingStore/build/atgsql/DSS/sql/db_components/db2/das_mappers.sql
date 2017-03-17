


--  @version $Id: //product/DSS/version/11.2/templates/DSS/sql/das_mappers.xml#1 $$Change: 946917 $

create table dss_das_event (
	id	varchar(32)	not null,
	timestamp	timestamp	default null,
	sessionid	varchar(100)	default null,
	parentsessionid	varchar(100)	default null);


create table dss_das_form (
	id	varchar(32)	not null,
	clocktime	timestamp	default null,
	sessionid	varchar(100)	default null,
	parentsessionid	varchar(100)	default null,
	formname	varchar(254)	default null);

commit;


