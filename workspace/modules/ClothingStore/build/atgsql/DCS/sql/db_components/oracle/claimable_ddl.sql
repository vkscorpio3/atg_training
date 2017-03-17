


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/claimable_ddl.xml#1 $$Change: 946917 $

create table dcspp_claimable (
	claimable_id	varchar2(40)	not null,
	version	integer	not null,
	type	integer	not null,
	status	integer	null,
	start_date	timestamp	null,
	expiration_date	timestamp	null,
	last_modified	timestamp	null
,constraint dcspp_claimable_p primary key (claimable_id));


create table dcspp_giftcert (
	giftcertificate_id	varchar2(40)	not null,
	amount	double precision	not null,
	amount_authorized	double precision	not null,
	amount_remaining	double precision	not null,
	purchaser_id	varchar2(40)	null,
	purchase_date	timestamp	null,
	last_used	timestamp	null
,constraint dcspp_giftcert_p primary key (giftcertificate_id)
,constraint dcspp_gigiftcrtf_f foreign key (giftcertificate_id) references dcspp_claimable (claimable_id));

create index claimable_user_idx on dcspp_giftcert (purchaser_id);

create table dcs_storecred_clm (
	store_credit_id	varchar2(40)	not null,
	amount	number(19,7)	not null,
	amount_authorized	number(19,7)	not null,
	amount_remaining	number(19,7)	not null,
	owner_id	varchar2(40)	null,
	issue_date	timestamp	null,
	expiration_date	timestamp	null,
	last_used	timestamp	null
,constraint dcs_storecred_cl_p primary key (store_credit_id)
,constraint dcs_storstor_crd_f foreign key (store_credit_id) references dcspp_claimable (claimable_id));

create index storecr_issue_idx on dcs_storecred_clm (issue_date);
create index storecr_owner_idx on dcs_storecred_clm (owner_id);

create table dcspp_cp_folder (
	folder_id	varchar2(40)	not null,
	name	varchar2(254)	not null,
	parent_folder	varchar2(40)	null
,constraint dcspp_cp_folder_p primary key (folder_id)
,constraint dcspp_cp_prntfol_f foreign key (parent_folder) references dcspp_cp_folder (folder_id));

create index dcspp_prntfol_idx on dcspp_cp_folder (parent_folder);

create table dcspp_coupon (
	coupon_id	varchar2(40)	not null,
	promotion_id	varchar2(40)	not null
,constraint dcspp_coupon_p primary key (coupon_id,promotion_id)
,constraint dcspp_coupon_df foreign key (coupon_id) references dcspp_claimable (claimable_id));


create table dcspp_coupon_info (
	coupon_id	varchar2(40)	not null,
	display_name	varchar2(254)	null,
	use_promo_site	number(10)	null,
	parent_folder	varchar2(40)	null,
	max_uses	number(10)	null,
	uses	number(10)	null
,constraint dcspp_copninfo_p primary key (coupon_id)
,constraint dcspp_copninfo_d_f foreign key (coupon_id) references dcspp_claimable (claimable_id)
,constraint dcspp_cpnifol_f foreign key (parent_folder) references dcspp_cp_folder (folder_id));

create index dcspp_folder_idx on dcspp_coupon_info (parent_folder);

create table dcspp_coupon_batch (
	id	varchar2(40)	not null,
	code_prefix	varchar2(40)	not null,
	number_of_coupons	number(10)	null,
	seed_value	blob	null,
	codes_generated	number(1,0)	not null
,constraint dcspp_batch_cp_pk primary key (id)
,constraint code_prefix_idx unique (code_prefix));


create table dcspp_batch_claimable (
	coupon_id	varchar2(40)	not null,
	coupon_batch	varchar2(40)	null
,constraint dcs_batch_claim_pk primary key (coupon_id));




