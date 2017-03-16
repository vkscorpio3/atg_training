


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/claimable_ddl.xml#1 $$Change: 946917 $

create table dcspp_claimable (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	numeric(1)	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	default null,
	checkin_date	timestamp	default null,
	claimable_id	varchar(40)	not null,
	version	integer	not null,
	type	integer	not null,
	status	integer	default null,
	start_date	timestamp	default null,
	expiration_date	timestamp	default null,
	last_modified	timestamp	default null
,constraint dcspp_claimable_p primary key (claimable_id,asset_version));

create index dcspp_claimabl_wsx on dcspp_claimable (workspace_id);
create index dcspp_claimabl_cix on dcspp_claimable (checkin_date);

create table dcspp_giftcert (
	asset_version	numeric(19)	not null,
	giftcertificate_id	varchar(40)	not null,
	amount	double precision	not null,
	amount_authorized	double precision	not null,
	amount_remaining	double precision	not null,
	purchaser_id	varchar(40)	default null,
	purchase_date	timestamp	default null,
	last_used	timestamp	default null
,constraint dcspp_giftcert_p primary key (giftcertificate_id,asset_version));

create index claimable_user_idx on dcspp_giftcert (purchaser_id);

create table dcs_storecred_clm (
	asset_version	numeric(19)	not null,
	store_credit_id	varchar(40)	not null,
	amount	numeric(19,7)	not null,
	amount_authorized	numeric(19,7)	not null,
	amount_remaining	numeric(19,7)	not null,
	owner_id	varchar(40)	default null,
	issue_date	timestamp	default null,
	expiration_date	timestamp	default null,
	last_used	timestamp	default null
,constraint dcs_storecred_cl_p primary key (store_credit_id,asset_version));

create index storecr_issue_idx on dcs_storecred_clm (issue_date);
create index storecr_owner_idx on dcs_storecred_clm (owner_id);

create table dcspp_cp_folder (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	numeric(1)	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	default null,
	checkin_date	timestamp	default null,
	folder_id	varchar(40)	not null,
	name	varchar(254)	not null,
	parent_folder	varchar(40)	default null
,constraint dcspp_cp_folder_p primary key (folder_id,asset_version));

create index dcspp_cp_folde_wsx on dcspp_cp_folder (workspace_id);
create index dcspp_cp_folde_cix on dcspp_cp_folder (checkin_date);

create table dcspp_coupon (
	asset_version	numeric(19)	not null,
	coupon_id	varchar(40)	not null,
	promotion_id	varchar(40)	not null
,constraint dcspp_coupon_p primary key (coupon_id,promotion_id,asset_version));


create table dcspp_coupon_info (
	asset_version	numeric(19)	not null,
	coupon_id	varchar(40)	not null,
	display_name	varchar(254)	default null,
	use_promo_site	integer	default null,
	parent_folder	varchar(40)	default null,
	max_uses	integer	default null,
	uses	integer	default null
,constraint dcspp_copninfo_p primary key (coupon_id,asset_version));


create table dcspp_coupon_batch (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	code_prefix	varchar(40)	not null,
	number_of_coupons	integer	default null,
	seed_value	blob(128)	default null,
	codes_generated	numeric(1,0)	not null
,constraint dcspp_batch_cp_pk primary key (id,asset_version));


create table dcspp_batch_claimable (
	asset_version	numeric(19)	not null,
	coupon_id	varchar(40)	not null,
	coupon_batch	varchar(40)	default null
,constraint dcs_batch_claim_pk primary key (coupon_id,asset_version));

commit;


