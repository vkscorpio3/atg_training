


--  @version $Id: //product/DSS/version/11.2/templates/DSS/sql/dps_mappers.xml#1 $$Change: 946917 $

create table dss_dps_event (
	id	varchar2(32)	not null,
	timestamp	date	null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null,
	profileid	varchar2(25)	null,
	scenarioPathInfo	varchar2(254)	null);


create table dss_dps_page_visit (
	id	varchar2(32)	not null,
	timestamp	date	null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null,
	path	varchar2(255)	null,
	profileid	varchar2(25)	null);


create table dss_dps_view_item (
	id	varchar2(32)	not null,
	timestamp	date	null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null,
	repositoryname	varchar2(255)	null,
	folder	varchar2(255)	null,
	itemtype	varchar2(255)	null,
	repositoryid	varchar2(255)	null,
	itemdescriptor	varchar2(255)	null,
	page	varchar2(255)	null,
	profileid	varchar2(25)	null);


create table dss_dps_click (
	id	varchar2(32)	not null,
	timestamp	date	null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null,
	destinationpath	varchar2(255)	null,
	sourcenames	varchar2(255)	null,
	sourcepath	varchar2(255)	null,
	profileid	varchar2(25)	null);


create table dss_dps_referrer (
	id	varchar2(32)	not null,
	timestamp	date	null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null,
	referrerpath	varchar2(255)	null,
	referrersite	varchar2(255)	null,
	referrerpage	varchar2(255)	null,
	profileid	varchar2(25)	null);


create table dss_dps_inbound (
	id	varchar2(32)	not null,
	timestamp	date	null,
	messagesubject	varchar2(255)	null,
	originalsubject	varchar2(255)	null,
	messagefrom	varchar2(64)	null,
	messageto	varchar2(255)	null,
	messagecc	varchar2(255)	null,
	messagereplyto	varchar2(64)	null,
	receiveddate	number(19,0)	null,
	bounced	varchar2(6)	null,
	bounceemailaddr	varchar2(255)	null,
	bouncereplycode	varchar2(10)	null,
	bounceerrormess	varchar2(255)	null,
	bouncestatuscode	varchar2(10)	null);


create table dss_dps_admin_reg (
	id	varchar2(32)	not null,
	clocktime	date	null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null,
	adminprofileid	varchar2(25)	null,
	profileid	varchar2(25)	null);


create table dss_dps_property (
	id	varchar2(32)	not null,
	clocktime	date	null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null,
	propertypath	varchar2(254)	null,
	oldvalue	varchar2(254)	null,
	newvalue	varchar2(254)	null,
	changesign	varchar2(16)	null,
	changeamount	number(19,7)	null,
	changepercentage	number(19,7)	null,
	elementsadded	varchar2(254)	null,
	elementsremoved	varchar2(254)	null,
	profileid	varchar2(25)	null);


create table dss_dps_admin_prop (
	id	varchar2(32)	not null,
	clocktime	date	null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null,
	propertypath	varchar2(254)	null,
	oldvalue	varchar2(254)	null,
	newvalue	varchar2(254)	null,
	changesign	varchar2(16)	null,
	changeamount	number(19,7)	null,
	changepercentage	number(19,7)	null,
	elementsadded	varchar2(254)	null,
	elementsremoved	varchar2(254)	null,
	adminprofileid	varchar2(25)	null,
	profileid	varchar2(25)	null);


create table dss_dps_update (
	id	varchar2(32)	not null,
	clocktime	date	null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null,
	changedproperties	varchar2(4000)	null,
	oldvalues	varchar2(4000)	null,
	newvalues	varchar2(4000)	null,
	profileid	varchar2(25)	null);


create table dss_dps_admin_up (
	id	varchar2(32)	not null,
	clocktime	date	null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null,
	changedproperties	varchar2(4000)	null,
	oldvalues	varchar2(4000)	null,
	newvalues	varchar2(4000)	null,
	adminprofileid	varchar2(25)	null,
	profileid	varchar2(25)	null);


create table dps_scenario_value (
	id	varchar2(40)	not null,
	tag	varchar2(42)	not null,
	scenario_value	varchar2(100)	null
,constraint dps_scenario_val_p primary key (id,tag)
,constraint dps_scenrvlid_f foreign key (id) references dps_user (id));

create index dps_scenval_id on dps_scenario_value (id);



