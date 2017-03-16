


--  @version $Id: //product/DSS/version/11.2/templates/DSS/sql/das_mappers.xml#1 $$Change: 946917 $

create table dss_das_event (
	id	varchar(32)	not null,
	timestamp	datetime	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null)


create table dss_das_form (
	id	varchar(32)	not null,
	clocktime	datetime	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	formname	varchar(254)	null)



go
