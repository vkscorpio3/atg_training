


--  @version $Id: //product/DAS/version/11.2/templates/DAS/sql/dms_limbo_ddl.xml#1 $$Change: 946917 $
-- This table is where limbo instance/clients identify themselves. --There should only be one entry in this table for each Dynamo running PatchBay with message delays enabled.

create table dms_limbo (
	limbo_name	varchar2(250)	not null,
	limbo_id	number(19,0)	not null
,constraint limbo_pk primary key (limbo_name));

-- The following four tables comprise the parts of the stored messages.

create table dms_limbo_msg (
	msg_id	number(19,0)	not null,
	limbo_id	number(19,0)	not null,
	delivery_date	number(19,0)	not null,
	delivery_count	number(2,0)	not null,
	msg_src_name	varchar2(250)	not null,
	port_name	varchar2(250)	not null,
	msg_class	varchar2(250)	not null,
	msg_class_type	number(1,0)	not null,
	jms_type	varchar2(250)	null,
	jms_expiration	number(19,0)	null,
	jms_correlationid	varchar2(250)	null
,constraint limbo_msg_pk primary key (msg_id));

create index dms_limbo_read_idx on dms_limbo_msg (limbo_id,delivery_date);
-- If serialized reply-to destinations are known to be small enough, this binary column's size can be reduced for efficiency.  The size here has been chosen to work with local dms and SQL-JMS.

create table dms_limbo_replyto (
	msg_id	number(19,0)	not null,
	jms_replyto	blob	null
,constraint limbo_replyto_pk primary key (msg_id));

-- If serialized message bodies are known to be small enough, this binary column's size can be reduced for efficiency.  The size here has been chosen to work with almost all types of messages but may be larger than necessary.  Actual usage analysis is recommended for finding the optimal binary column size.

create table dms_limbo_body (
	msg_id	number(19,0)	not null,
	msg_body	blob	null
,constraint limbo_body_pk primary key (msg_id));

-- This table represents a map of properties for messages stored above, i.e.  there can be multiple rows in this table for a single row in the preceeding tables.

create table dms_limbo_props (
	msg_id	number(19,0)	not null,
	prop_name	varchar2(250)	not null,
	prop_value	varchar2(250)	not null
,constraint limbo_props_pk primary key (msg_id,prop_name));


create table dms_limbo_ptypes (
	msg_id	number(19,0)	not null,
	prop_name	varchar2(250)	not null,
	prop_type	number(1,0)	not null
,constraint dms_limbo_ptypes_p primary key (msg_id,prop_name));


create table dms_limbo_delay (
	msg_id	number(19,0)	not null,
	delay	number(19,0)	not null,
	max_attempts	number(2,0)	not null,
	failure_port	varchar2(250)	not null,
	jms_timestamp	number(19,0)	null,
	jms_deliverymode	number(10,0)	null,
	jms_priority	number(10,0)	null,
	jms_messageid	varchar2(250)	null,
	jms_redelivered	number(1,0)	null,
	jms_destination	blob	null
,constraint limbo_delay_pk primary key (msg_id));




