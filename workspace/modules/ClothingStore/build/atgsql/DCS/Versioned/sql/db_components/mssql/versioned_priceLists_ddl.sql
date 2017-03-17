


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/priceLists_ddl.xml#2 $$Change: 1179550 $

create table dcs_price_list (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	price_list_id	varchar(40)	not null,
	version	integer	not null,
	display_name	varchar(254)	null,
	description	varchar(254)	null,
	creation_date	datetime	null,
	last_mod_date	datetime	null,
	start_date	datetime	null,
	end_date	datetime	null,
	locale	integer	null,
	base_price_list	varchar(40)	null,
	item_acl	text	null
,constraint dcs_price_list_p primary key (price_list_id,asset_version))

create index dcs_price_list_wsx on dcs_price_list (workspace_id)
create index dcs_price_list_cix on dcs_price_list (checkin_date)

create table dcs_complex_price (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	complex_price_id	varchar(40)	not null,
	version	integer	not null
,constraint dcs_complex_pric_p primary key (complex_price_id,asset_version))

create index dcs_complex_pr_wsx on dcs_complex_price (workspace_id)
create index dcs_complex_pr_cix on dcs_complex_price (checkin_date)

create table dcs_price (
	sec_asset_version	numeric(19)	null,
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	price_id	varchar(40)	not null,
	version	integer	not null,
	price_list	varchar(40)	not null,
	product_id	varchar(40)	null,
	sku_id	varchar(40)	null,
	parent_sku_id	varchar(40)	null,
	pricing_scheme	integer	not null,
	list_price	numeric(19,7)	null,
	complex_price	varchar(40)	null,
	start_date	datetime	null,
	end_date	datetime	null
,constraint dcs_price_p primary key (price_id,asset_version))

create index dcs_price_idx1 on dcs_price (product_id)
create index dcs_price_idx2 on dcs_price (price_list,sku_id)
create index dcs_price_wsx on dcs_price (workspace_id)
create index dcs_price_cix on dcs_price (checkin_date)

create table dcs_price_levels (
	asset_version	numeric(19)	not null,
	complex_price_id	varchar(40)	not null,
	price_levels	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcs_price_levels_p primary key (complex_price_id,sequence_num,asset_version))


create table dcs_price_level (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	price_level_id	varchar(40)	not null,
	version	integer	not null,
	quantity	integer	not null,
	price	numeric(19,7)	not null
,constraint dcs_price_level_p primary key (price_level_id,asset_version))

create index dcs_price_leve_wsx on dcs_price_level (workspace_id)
create index dcs_price_leve_cix on dcs_price_level (checkin_date)

create table dcs_gen_fol_pl (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	folder_id	varchar(40)	not null,
	type	integer	not null,
	name	varchar(40)	not null,
	parent	varchar(40)	null,
	description	varchar(254)	null,
	item_acl	text	null
,constraint dcs_gen_fol_pl_p primary key (folder_id,asset_version))

create index dcs_gen_fol_pl_wsx on dcs_gen_fol_pl (workspace_id)
create index dcs_gen_fol_pl_cix on dcs_gen_fol_pl (checkin_date)

create table dcs_child_fol_pl (
	sec_asset_version	numeric(19)	not null,
	asset_version	numeric(19)	not null,
	folder_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_folder_id	varchar(40)	not null
,constraint dcs_child_fol_pl_p primary key (folder_id,sequence_num,asset_version,sec_asset_version))


create table dcs_plfol_chld (
	asset_version	numeric(19)	not null,
	plfol_id	varchar(40)	not null,
	sequence_num	integer	not null,
	price_list_id	varchar(40)	not null
,constraint dcs_plfol_chld_p primary key (plfol_id,sequence_num,asset_version))



go
