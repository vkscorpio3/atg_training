


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/claimable_ddl.xml#1 $$Change: 946917 $

create table dcspp_claimable (
	asset_version	number(19)	not null,
	workspace_id	varchar2(40)	not null,
	branch_id	varchar2(40)	not null,
	is_head	number(1)	not null,
	version_deleted	number(1)	not null,
	version_editable	number(1)	not null,
	pred_version	number(19)	null,
	checkin_date	timestamp	null,
	claimable_id	varchar2(40)	not null,
	version	integer	not null,
	type	integer	not null,
	status	integer	null,
	start_date	timestamp	null,
	expiration_date	timestamp	null,
	last_modified	timestamp	null
,constraint dcspp_claimable_p primary key (claimable_id,asset_version));

create index dcspp_claimabl_wsx on dcspp_claimable (workspace_id);
create index dcspp_claimabl_cix on dcspp_claimable (checkin_date);

create table dcspp_giftcert (
	asset_version	number(19)	not null,
	giftcertificate_id	varchar2(40)	not null,
	amount	double precision	not null,
	amount_authorized	double precision	not null,
	amount_remaining	double precision	not null,
	purchaser_id	varchar2(40)	null,
	purchase_date	timestamp	null,
	last_used	timestamp	null
,constraint dcspp_giftcert_p primary key (giftcertificate_id,asset_version));

create index claimable_user_idx on dcspp_giftcert (purchaser_id);

create table dcs_storecred_clm (
	asset_version	number(19)	not null,
	store_credit_id	varchar2(40)	not null,
	amount	number(19,7)	not null,
	amount_authorized	number(19,7)	not null,
	amount_remaining	number(19,7)	not null,
	owner_id	varchar2(40)	null,
	issue_date	timestamp	null,
	expiration_date	timestamp	null,
	last_used	timestamp	null
,constraint dcs_storecred_cl_p primary key (store_credit_id,asset_version));

create index storecr_issue_idx on dcs_storecred_clm (issue_date);
create index storecr_owner_idx on dcs_storecred_clm (owner_id);

create table dcspp_cp_folder (
	asset_version	number(19)	not null,
	workspace_id	varchar2(40)	not null,
	branch_id	varchar2(40)	not null,
	is_head	number(1)	not null,
	version_deleted	number(1)	not null,
	version_editable	number(1)	not null,
	pred_version	number(19)	null,
	checkin_date	timestamp	null,
	folder_id	varchar2(40)	not null,
	name	varchar2(254)	not null,
	parent_folder	varchar2(40)	null
,constraint dcspp_cp_folder_p primary key (folder_id,asset_version));

create index dcspp_cp_folde_wsx on dcspp_cp_folder (workspace_id);
create index dcspp_cp_folde_cix on dcspp_cp_folder (checkin_date);

create table dcspp_coupon (
	asset_version	number(19)	not null,
	coupon_id	varchar2(40)	not null,
	promotion_id	varchar2(40)	not null
,constraint dcspp_coupon_p primary key (coupon_id,promotion_id,asset_version));


create table dcspp_coupon_info (
	asset_version	number(19)	not null,
	coupon_id	varchar2(40)	not null,
	display_name	varchar2(254)	null,
	use_promo_site	number(10)	null,
	parent_folder	varchar2(40)	null,
	max_uses	number(10)	null,
	uses	number(10)	null
,constraint dcspp_copninfo_p primary key (coupon_id,asset_version));


create table dcspp_coupon_batch (
	asset_version	number(19)	not null,
	id	varchar2(40)	not null,
	code_prefix	varchar2(40)	not null,
	number_of_coupons	number(10)	null,
	seed_value	blob	null,
	codes_generated	number(1,0)	not null
,constraint dcspp_batch_cp_pk primary key (id,asset_version));


create table dcspp_batch_claimable (
	asset_version	number(19)	not null,
	coupon_id	varchar2(40)	not null,
	coupon_batch	varchar2(40)	null
,constraint dcs_batch_claim_pk primary key (coupon_id,asset_version));




