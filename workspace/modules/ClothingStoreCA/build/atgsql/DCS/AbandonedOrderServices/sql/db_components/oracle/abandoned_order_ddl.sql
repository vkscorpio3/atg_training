


-- $Id: //product/DCS/version/11.2/templates/DCS/AbandonedOrderServices/sql/abandoned_order_ddl.xml#1 $

create table dcspp_ord_abandon (
	abandonment_id	varchar2(40)	not null,
	version	number(10)	not null,
	order_id	varchar2(40)	not null,
	ord_last_updated	timestamp	null,
	abandon_state	varchar2(40)	null,
	abandonment_count	number(10)	null,
	abandonment_date	timestamp	null,
	reanimation_date	timestamp	null,
	convert_date	timestamp	null,
	lost_date	timestamp	null
,constraint dcspp_ord_abndn_p primary key (abandonment_id));

create index dcspp_ordabandn1_x on dcspp_ord_abandon (order_id);

create table dcs_user_abandoned (
	id	varchar2(40)	not null,
	order_id	varchar2(40)	not null,
	profile_id	varchar2(40)	not null
,constraint dcs_usr_abndnd_p primary key (id));


create table drpt_conv_order (
	order_id	varchar2(40)	not null,
	converted_date	timestamp	not null,
	amount	number(19,7)	not null,
	promo_count	number(10)	not null,
	promo_value	number(19,7)	not null
,constraint drpt_conv_order_p primary key (order_id));


create table drpt_session_ord (
	dataset_id	varchar2(40)	not null,
	order_id	varchar2(40)	not null,
	date_time	timestamp	not null,
	amount	number(19,7)	not null,
	submitted	number(10)	not null,
	order_persistent	number(1)	null,
	session_id	varchar2(40)	null,
	parent_session_id	varchar2(40)	null
,constraint drpt_session_ord_p primary key (order_id));




