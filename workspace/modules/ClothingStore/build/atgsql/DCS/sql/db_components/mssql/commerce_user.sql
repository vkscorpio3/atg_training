


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/commerce_user.xml#1 $$Change: 946917 $

create table dps_credit_card (
	id	varchar(40)	not null,
	credit_card_number	varchar(80)	null,
	credit_card_type	varchar(40)	null,
	expiration_month	varchar(20)	null,
	exp_day_of_month	varchar(20)	null,
	expiration_year	varchar(20)	null,
	billing_addr	varchar(40)	null
,constraint dps_credit_card_p primary key (id))

create index dps_crcdba_idx on dps_credit_card (billing_addr)

create table dbc_cost_center (
	id	varchar(40)	not null,
	identifier	varchar(40)	not null,
	description	varchar(254)	null,
	user_id	varchar(40)	null
,constraint dbc_cost_center_p primary key (id))


create table dcs_user (
	user_id	varchar(40)	not null,
	allow_partial_ship	numeric(1,0)	null,
	default_creditcard	varchar(40)	null,
	daytime_phone_num	varchar(30)	null,
	express_checkout	numeric(1,0)	null,
	default_carrier	varchar(256)	null,
	price_list	varchar(40)	null,
	user_catalog	varchar(40)	null,
	sale_price_list	varchar(40)	null,
	dflt_cost_center	varchar(40)	null,
	order_price_limit	numeric(19,7)	null,
	approval_required	numeric(1,0)	null
,constraint dcs_user_p primary key (user_id)
,constraint dcs_usrdeflt_cr_f foreign key (default_creditcard) references dps_credit_card (id)
,constraint dcs_usrdflt_cos_f foreign key (dflt_cost_center) references dbc_cost_center (id)
,constraint dcs_user1_c check (allow_partial_ship in (0,1))
,constraint dcs_user2_c check (express_checkout in (0,1)))

create index dcs_usrdcc_idx on dcs_user (default_creditcard)
create index usr_defcstctr_idx on dcs_user (dflt_cost_center)

create table dps_usr_creditcard (
	user_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	credit_card_id	varchar(40)	not null
,constraint dps_usr_creditca_p primary key (user_id,tag)
,constraint dps_usrccredt_cr_f foreign key (credit_card_id) references dps_credit_card (id)
,constraint dps_usrcusr_d_f foreign key (user_id) references dps_user (id))

create index dps_ucccid_idx on dps_usr_creditcard (credit_card_id)
create index dps_uccuid_idx on dps_usr_creditcard (user_id)

create table dbc_buyer_costctr (
	user_id	varchar(40)	not null,
	seq	integer	not null,
	cost_center_id	varchar(40)	not null
,constraint dbc_buyer_costct_p primary key (user_id,seq)
,constraint dbc_buyrcost_cnt_f foreign key (cost_center_id) references dbc_cost_center (id))

create index dbc_byr_costctr_id on dbc_buyer_costctr (cost_center_id)
--  Multi-table associating a Buyer with one or more order approvers.  Approvers are required to be registered users of the site so they can perform online approvals. 

create table dbc_buyer_approver (
	user_id	varchar(40)	not null,
	approver_id	varchar(40)	not null,
	seq	integer	not null
,constraint dbc_buyer_approv_p primary key (user_id,seq)
,constraint dbc_buyrapprvr_d_f foreign key (approver_id) references dps_user (id)
,constraint dbc_buyrusr_d_f foreign key (user_id) references dps_user (id))

create index buyer_approver_idx on dbc_buyer_approver (approver_id)

create table dbc_buyer_prefvndr (
	user_id	varchar(40)	not null,
	vendor	varchar(100)	not null,
	seq	integer	not null
,constraint dbc_buyer_prefvn_p primary key (user_id,seq)
,constraint dbc_byrprfndusrd_f foreign key (user_id) references dps_user (id))


create table dbc_buyer_plist (
	user_id	varchar(40)	not null,
	list_id	varchar(40)	not null,
	tag	integer	not null
,constraint dbc_buyer_plist_p primary key (user_id,tag))


create table dcs_user_favstores (
	user_id	varchar(40)	not null,
	seq	integer	not null,
	location_id	varchar(40)	null
,constraint dcs_user_fvstore_p primary key (user_id,seq)
,constraint dcs_favstoreusrd_f foreign key (user_id) references dps_user (id))



go
