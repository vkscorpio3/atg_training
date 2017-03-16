


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/promotion_ddl.xml#2 $$Change: 1179550 $
-- Add the DCS_PRM_FOLDER table, promotionFolder

create table dcs_prm_folder (
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
,constraint dcs_prm_folder_p primary key (folder_id,asset_version));

create index dcs_prm_folder_wsx on dcs_prm_folder (workspace_id);
create index dcs_prm_folder_cix on dcs_prm_folder (checkin_date);

create table dcs_stacking_rule (
	asset_version	number(19)	not null,
	workspace_id	varchar2(40)	not null,
	branch_id	varchar2(40)	not null,
	is_head	number(1)	not null,
	version_deleted	number(1)	not null,
	version_editable	number(1)	not null,
	pred_version	number(19)	null,
	checkin_date	timestamp	null,
	stacking_rule_id	varchar2(40)	not null,
	display_name	varchar2(254)	null,
	order_limits	number(10)	null,
	last_modified	timestamp	null
,constraint dcs_sr_p primary key (stacking_rule_id,asset_version));

create index dcs_stacking_r_wsx on dcs_stacking_rule (workspace_id);
create index dcs_stacking_r_cix on dcs_stacking_rule (checkin_date);

create table dcs_excl_stacking_rules (
	asset_version	number(19)	not null,
	stacking_rule_id	varchar2(40)	not null,
	excl_stacking_rule_id	varchar2(40)	not null);


create table dcs_promotion (
	asset_version	number(19)	not null,
	workspace_id	varchar2(40)	not null,
	branch_id	varchar2(40)	not null,
	is_head	number(1)	not null,
	version_deleted	number(1)	not null,
	version_editable	number(1)	not null,
	pred_version	number(19)	null,
	checkin_date	timestamp	null,
	promotion_id	varchar2(40)	not null,
	version	integer	not null,
	creation_date	timestamp	null,
	start_date	timestamp	null,
	end_date	timestamp	null,
	display_name	varchar2(254)	null,
	description	varchar2(254)	null,
	promotion_type	integer	null,
	enabled	number(1,0)	null,
	begin_usable	timestamp	null,
	end_usable	timestamp	null,
	priority	integer	null,
	evaluation_limit	number(10)	null,
	global	number(1,0)	null,
	anon_profile	number(1,0)	null,
	allow_multiple	number(1,0)	null,
	uses	integer	null,
	rel_expiration	number(1,0)	null,
	time_until_expire	integer	null,
	template	varchar2(254)	null,
	ui_access_lvl	integer	null,
	parent_folder	varchar2(40)	null,
	last_modified	timestamp	null,
	pmdl_version	integer	null,
	eval_target_items_first	number(1)	null,
	qualifier	varchar2(254)	null,
	stacking_rule	varchar2(40)	null,
	fil_Qual_Discounted_By_Any	number(1)	null,
	fil_Qual_Discounted_By_Current	number(1)	null,
	fil_Qual_Acted_As_Qual	number(1)	null,
	fil_Qual_On_Sale	number(1)	null,
	fil_Qual_Zero_Prices	number(1)	null,
	fil_Qual_Neg_Prices	number(1)	null,
	fil_Tar_Acted_As_Qual	number(1)	null,
	fil_Tar_Discounted_By_Current	number(1)	null,
	fil_Tar_Discounted_By_Any	number(1)	null,
	fil_Target_On_Sale	number(1)	null,
	fil_Tar_Zero_Prices	number(1)	null,
	fil_Tar_Neg_Prices	number(1)	null,
	fil_Tar_Price_LTOET_Prm_Price	number(1)	null
,constraint dcs_promotion_p primary key (promotion_id,asset_version)
,constraint dcs_promotion1_c check (enabled in (0,1))
,constraint dcs_promotion2_c check (global in (0,1))
,constraint dcs_promotion3_c check (anon_profile in (0,1))
,constraint dcs_promotion4_c check (allow_multiple in (0,1))
,constraint dcs_promotion5_c check (rel_expiration in (0,1))
,constraint dcs_promotion6_c check (eval_target_items_first in (0,1)));

create index prmo_bgin_use_idx on dcs_promotion (begin_usable);
create index prmo_end_dte_idx on dcs_promotion (end_date);
create index prmo_end_use_idx on dcs_promotion (end_usable);
create index prmo_strt_dte_idx on dcs_promotion (start_date);
create index dcs_promotion_wsx on dcs_promotion (workspace_id);
create index dcs_promotion_cix on dcs_promotion (checkin_date);

create table dcs_promo_media (
	asset_version	number(19)	not null,
	promotion_id	varchar2(40)	not null,
	tag	varchar2(42)	not null,
	media_id	varchar2(40)	not null
,constraint dcs_promo_media_p primary key (promotion_id,tag,asset_version));

create index promo_mdia_pid_idx on dcs_promo_media (promotion_id);

create table dcs_promo_payment (
	asset_version	number(19)	not null,
	promotion_id	varchar2(40)	not null,
	payment_type	varchar2(40)	not null);


create table dcs_discount_promo (
	asset_version	number(19)	not null,
	promotion_id	varchar2(40)	not null,
	calculator	varchar2(254)	null,
	adjuster	number(19,7)	null,
	pmdl_rule	clob	not null,
	one_use	number(1,0)	null
,constraint dcs_discount_pro_p primary key (promotion_id,asset_version)
,constraint dcs_discount_pro_c check (one_use in (0, 1)));


create table dcs_promo_upsell (
	asset_version	number(19)	not null,
	promotion_id	varchar2(40)	not null,
	upsell	number(1,0)	null
,constraint dcs_promo_upsell_p primary key (promotion_id,asset_version)
,constraint dcs_promo_upsell_c check (upsell in (0, 1)));


create table dcs_upsell_action (
	asset_version	number(19)	not null,
	workspace_id	varchar2(40)	not null,
	branch_id	varchar2(40)	not null,
	is_head	number(1)	not null,
	version_deleted	number(1)	not null,
	version_editable	number(1)	not null,
	pred_version	number(19)	null,
	checkin_date	timestamp	null,
	action_id	varchar2(40)	not null,
	version	number(10)	not null,
	name	varchar2(40)	not null,
	upsell_prd_grp	clob	null
,constraint dcs_upsell_actn_p primary key (action_id,asset_version));

create index dcs_upsell_act_wsx on dcs_upsell_action (workspace_id);
create index dcs_upsell_act_cix on dcs_upsell_action (checkin_date);

create table dcs_close_qualif (
	asset_version	number(19)	not null,
	workspace_id	varchar2(40)	not null,
	branch_id	varchar2(40)	not null,
	is_head	number(1)	not null,
	version_deleted	number(1)	not null,
	version_editable	number(1)	not null,
	pred_version	number(19)	null,
	checkin_date	timestamp	null,
	close_qualif_id	varchar2(40)	not null,
	version	number(10)	not null,
	name	varchar2(254)	not null,
	priority	number(10)	null,
	qualifier	clob	null,
	upsell_media	varchar2(40)	null,
	upsell_action	varchar2(40)	null
,constraint dcs_close_qualif_p primary key (close_qualif_id,asset_version));

create index dcs_close_qual_wsx on dcs_close_qualif (workspace_id);
create index dcs_close_qual_cix on dcs_close_qualif (checkin_date);

create table dcs_prm_cls_qlf (
	sec_asset_version	number(19)	not null,
	asset_version	number(19)	not null,
	promotion_id	varchar2(40)	not null,
	closeness_qualif	varchar2(40)	not null);


create table dcs_prm_sites (
	asset_version	number(19)	not null,
	promotion_id	varchar2(40)	not null,
	site_id	varchar2(40)	not null);


create table dcs_prm_site_grps (
	asset_version	number(19)	not null,
	promotion_id	varchar2(40)	not null,
	site_group_id	varchar2(40)	not null);


create table dcs_prm_tpl_vals (
	asset_version	number(19)	not null,
	promotion_id	varchar2(40)	not null,
	placeholder	varchar2(40)	not null,
	placeholderValue	clob	null
,constraint dcs_prm_tpl_vals_p primary key (promotion_id,placeholder,asset_version));


create table dcs_prm_cls_vals (
	asset_version	number(19)	not null,
	close_qualif_id	varchar2(40)	not null,
	placeholder	varchar2(40)	not null,
	placeholderValue	clob	null
,constraint dcs_prm_cls_vals_p primary key (close_qualif_id,placeholder,asset_version));


create table dcs_upsell_prods (
	asset_version	number(19)	not null,
	action_id	varchar2(40)	not null,
	product_id	varchar2(40)	not null,
	sequence_num	number(10)	not null
,constraint dcs_upsell_prods_p primary key (action_id,product_id,asset_version));


create table dcs_excl_promotions (
	asset_version	number(19)	not null,
	promotion_id	varchar2(40)	not null,
	excl_promotion_id	varchar2(40)	not null);


create table dcs_incl_promotions (
	asset_version	number(19)	not null,
	promotion_id	varchar2(40)	not null,
	incl_promotion_id	varchar2(40)	not null);




