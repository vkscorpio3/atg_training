


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/dcs_mappers.xml#1 $$Change: 946917 $

create table dcs_cart_event (
	id	varchar2(40)	not null,
	timestamp	timestamp	null,
	orderid	varchar2(40)	null,
	itemid	varchar2(40)	null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null,
	quantity	integer	null,
	amount	number(19,7)	null,
	profileid	varchar2(40)	null);


create table dcs_submt_ord_evt (
	id	varchar2(40)	not null,
	clocktime	timestamp	null,
	orderid	varchar2(40)	null,
	profileid	varchar2(40)	null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null);


create table dcs_prom_used_evt (
	id	varchar2(40)	not null,
	clocktime	timestamp	null,
	orderid	varchar2(40)	null,
	profileid	varchar2(40)	null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null,
	promotionid	varchar2(40)	null,
	order_amount	number(26,7)	null,
	discount	number(26,7)	null);


create table dcs_ord_merge_evt (
	id	varchar2(40)	not null,
	clocktime	timestamp	null,
	sourceorderid	varchar2(40)	null,
	destorderid	varchar2(40)	null,
	profileid	varchar2(40)	null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null,
	sourceremoved	number(1,0)	null
,constraint dcs_ordmergeevt_ck check (sourceremoved in (0,1)));


create table dcs_promo_rvkd (
	id	varchar2(40)	not null,
	time_stamp	timestamp	null,
	promotionid	varchar2(254)	not null,
	profileid	varchar2(254)	not null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null);


create table dcs_promo_grntd (
	id	varchar2(40)	not null,
	time_stamp	timestamp	null,
	promotionid	varchar2(254)	not null,
	profileid	varchar2(254)	not null,
	sessionid	varchar2(100)	null,
	parentsessionid	varchar2(100)	null);




