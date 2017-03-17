


--  @version $Id: //product/DAS/version/11.2/templates/DAS/sql/create_sql_jms_ddl.xml#1 $$Change: 946917 $

create table dms_client (
	client_name	varchar2(250)	not null,
	client_id	number(19,0)	null
,constraint dms_client_p primary key (client_name));


create table dms_queue (
	queue_name	varchar2(250)	null,
	queue_id	number(19,0)	not null,
	temp_id	number(19,0)	null
,constraint dms_queue_p primary key (queue_id));


create table dms_queue_recv (
	client_id	number(19,0)	null,
	receiver_id	number(19,0)	not null,
	queue_id	number(19,0)	null
,constraint dms_queue_recv_p primary key (receiver_id));


create table dms_queue_entry (
	queue_id	number(19,0)	not null,
	msg_id	number(19,0)	not null,
	delivery_date	number(19,0)	null,
	handling_client_id	number(19,0)	null,
	read_state	number(19,0)	null
,constraint dms_queue_entry_p primary key (queue_id,msg_id));

create index dms_queue_msg_idx on dms_queue_entry (msg_id);

create table dms_topic (
	topic_name	varchar2(250)	null,
	topic_id	number(19,0)	not null,
	temp_id	number(19,0)	null
,constraint dms_topic_p primary key (topic_id));


create table dms_topic_sub (
	client_id	number(19,0)	null,
	subscriber_name	varchar2(250)	null,
	subscriber_id	number(19,0)	not null,
	topic_id	number(19,0)	null,
	durable	number(1,0)	null,
	active	number(1,0)	null
,constraint dms_topic_sub_p primary key (subscriber_id));


create table dms_topic_entry (
	subscriber_id	number(19,0)	not null,
	msg_id	number(19,0)	not null,
	delivery_date	number(19,0)	null,
	read_state	number(19,0)	null
,constraint dms_topic_entry_p primary key (subscriber_id,msg_id));

create index dms_topic_msg_idx on dms_topic_entry (msg_id,subscriber_id);
create index dms_topic_read_idx on dms_topic_entry (read_state,delivery_date);

create table dms_msg (
	msg_class	varchar2(250)	null,
	has_properties	number(1,0)	null,
	reference_count	number(10,0)	null,
	msg_id	number(19,0)	not null,
	timestamp	number(19,0)	null,
	correlation_id	varchar2(250)	null,
	reply_to	number(19,0)	null,
	destination	number(19,0)	null,
	delivery_mode	number(1,0)	null,
	redelivered	number(1,0)	null,
	type	varchar2(250)	null,
	expiration	number(19,0)	null,
	priority	number(1,0)	null,
	small_body	blob	null,
	large_body	blob	null
,constraint dms_msg_p primary key (msg_id));


create table dms_msg_properties (
	msg_id	number(19,0)	not null,
	data_type	number(1,0)	null,
	name	varchar2(250)	not null,
	value	varchar2(250)	null
,constraint dms_msg_properti_p primary key (msg_id,name));

create or replace procedure dms_queue_flag
(Pbatch_size    IN NUMBER
,Pread_lock     IN NUMBER
,Pdelivery_date IN NUMBER
,Pclient_id     IN NUMBER
,Pqueue_id      IN NUMBER
,Pupdate_count  OUT NUMBER)
as
             Begin
    UPDATE dms_queue_entry qe
    SET qe.handling_client_id = Pclient_id, 
        qe.read_state = Pread_lock 
    WHERE ROWNUM < Pbatch_size
      AND qe.handling_client_id < 0 
      AND qe.delivery_date < Pdelivery_date 
      AND qe.queue_id = Pqueue_id;
    Pupdate_count := SQL%ROWCOUNT;
  END;
         
/

create or replace procedure dms_topic_flag
(Pbatch_size    IN NUMBER
,Pread_lock     IN NUMBER
,Pdelivery_date IN NUMBER
,Psubscriber_id IN NUMBER
,Pupdate_count  OUT NUMBER)
as
             Begin
    UPDATE dms_topic_entry te 
    SET te.read_state = Pread_lock 
    WHERE ROWNUM < Pbatch_size
      AND te.delivery_date < Pdelivery_date 
      AND te.read_state = 0 
      AND te.subscriber_id = Psubscriber_id;
    Pupdate_count := SQL%ROWCOUNT;
  END; 
         
/


