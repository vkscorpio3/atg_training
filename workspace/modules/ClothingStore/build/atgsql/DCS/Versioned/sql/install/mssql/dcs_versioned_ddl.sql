
-- the source for this section is 
-- mssql_functions_ddl.sql





IF OBJECT_ID('dbo.TRUNC') IS NOT NULL
    DROP FUNCTION dbo.TRUNC
go



CREATE  FUNCTION TRUNC(@mydate datetime, @type varchar(4))
RETURNS datetime
AS
BEGIN
  declare @ret datetime

  IF(@type='YEAR')
  BEGIN
    -- return the first day of the year
    select @ret = convert(datetime, CONVERT(char(10), DATEADD(day, 1-DATEPART(dayofyear, @mydate), @mydate), 101))
  END
  ELSE IF(@type='Q')
  BEGIN
    -- return the first day for the quarter
    select @ret = convert(datetime, convert(varchar(2),(DATEPART(quarter, @mydate)-1)*3+1) + '/01/' + convert(varchar(4),datepart(year, @mydate)), 101)
  END
  ELSE IF(@type='MON')
  BEGIN
    -- return the first day of the month
    select @ret = convert(datetime, CONVERT(char(10), DATEADD(day, 1-DATEPART(day, @mydate), @mydate), 101))
  END
  ELSE IF(@type='DAY')
  BEGIN
    -- return the fist day (SUNDAY) of the week
    select @ret = convert(datetime, CONVERT(char(10), DATEADD(day, 1-DATEPART(weekday, @mydate), @mydate), 101))
  END
  ELSE IF(@type='DATE')
  BEGIN
    -- return date part and truncate time part
    select @ret = convert(datetime, CONVERT(char(10), @mydate, 101))
  END
  ELSE
  BEGIN
    SELECT @ret = @mydate
  END
  RETURN @ret
END
go



IF OBJECT_ID('dbo.MONTHS_BETWEEN') IS NOT NULL
    DROP FUNCTION dbo.MONTHS_BETWEEN
go




CREATE  FUNCTION MONTHS_BETWEEN(@mydate1 datetime, @mydate2 datetime)
RETURNS INTEGER
AS
BEGIN
  RETURN DATEDIFF(MONTH, @mydate2, @mydate1)
END




go

-- the source for this section is 
-- invoice_ddl.sql





create table dbc_inv_delivery (
	id	varchar(40)	not null,
	version	integer	not null,
	type	integer	not null,
	prefix	nvarchar(40)	null,
	first_name	nvarchar(40)	null,
	middle_name	nvarchar(40)	null,
	last_name	nvarchar(40)	null,
	suffix	nvarchar(40)	null,
	job_title	nvarchar(80)	null,
	company_name	nvarchar(40)	null,
	address1	nvarchar(80)	null,
	address2	nvarchar(80)	null,
	address3	nvarchar(80)	null,
	city	nvarchar(40)	null,
	county	nvarchar(40)	null,
	state	nvarchar(40)	null,
	postal_code	nvarchar(10)	null,
	country	nvarchar(40)	null,
	phone_number	nvarchar(40)	null,
	fax_number	nvarchar(40)	null,
	email_addr	nvarchar(255)	null,
	format	integer	null,
	delivery_mode	integer	null
,constraint dbc_inv_delivery_p primary key (id))


create table dbc_inv_pmt_terms (
	id	varchar(40)	not null,
	version	integer	not null,
	type	integer	not null,
	disc_percent	numeric(19,7)	null,
	disc_days	integer	null,
	net_days	integer	null
,constraint dbc_inv_pmt_term_p primary key (id))


create table dbc_invoice (
	id	varchar(40)	not null,
	version	integer	not null,
	type	integer	not null,
	creation_date	datetime	null,
	last_mod_date	datetime	null,
	invoice_number	varchar(40)	null,
	po_number	varchar(40)	null,
	req_number	varchar(40)	null,
	delivery_info	varchar(40)	null,
	balance_due	numeric(19,7)	null,
	pmt_due_date	datetime	null,
	pmt_terms	varchar(40)	null,
	order_id	varchar(40)	null,
	pmt_group_id	varchar(40)	null
,constraint dbc_invoice_p primary key (id)
,constraint dbc_invcdelvry_n_f foreign key (delivery_info) references dbc_inv_delivery (id)
,constraint dbc_invcpmt_term_f foreign key (pmt_terms) references dbc_inv_pmt_terms (id))

create index dbc_inv_dlivr_info on dbc_invoice (delivery_info)
create index dbc_inv_pmt_terms on dbc_invoice (pmt_terms)
create index inv_inv_idx on dbc_invoice (invoice_number)
create index inv_order_idx on dbc_invoice (order_id)
create index inv_pmt_idx on dbc_invoice (pmt_group_id)
create index inv_po_idx on dbc_invoice (po_number)


go

-- the source for this section is 
-- contracts_ddl.sql




-- Normally, catalog_id and price_list_id would reference the appropriate table it is possible not to use those tables though, which is why the reference is not included

create table dbc_contract (
	contract_id	varchar(40)	not null,
	display_name	varchar(254)	null,
	creation_date	datetime	null,
	start_date	datetime	null,
	end_date	datetime	null,
	creator_id	varchar(40)	null,
	negotiator_info	varchar(40)	null,
	price_list_id	varchar(40)	null,
	catalog_id	varchar(40)	null,
	term_id	varchar(40)	null,
	comments	varchar(254)	null
,constraint dbc_contract_p primary key (contract_id))


create table dbc_contract_term (
	terms_id	varchar(40)	not null,
	terms	text	null,
	disc_percent	numeric(19,7)	null,
	disc_days	integer	null,
	net_days	integer	null
,constraint dbc_contract_ter_p primary key (terms_id))



go

-- the source for this section is 
-- commerce_user.sql





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

-- the source for this section is 
-- organization_ddl.sql





create table dbc_organization (
	id	varchar(40)	not null,
	type	integer	null,
	cust_type	integer	null,
	duns_number	varchar(20)	null,
	dflt_shipping_addr	varchar(40)	null,
	dflt_billing_addr	varchar(40)	null,
	dflt_payment_type	varchar(40)	null,
	dflt_cost_center	varchar(40)	null,
	order_price_limit	numeric(19,7)	null,
	contract_id	varchar(40)	null,
	approval_required	numeric(1,0)	null
,constraint dbc_organization_p primary key (id)
,constraint dbc_orgncontrct__f foreign key (contract_id) references dbc_contract (contract_id)
,constraint dbc_orgndflt_bil_f foreign key (dflt_billing_addr) references dps_contact_info (id)
,constraint dbc_orgndflt_shi_f foreign key (dflt_shipping_addr) references dps_contact_info (id)
,constraint dbc_orgndflt_pay_f foreign key (dflt_payment_type) references dps_credit_card (id)
,constraint dbc_orgnztnid_f foreign key (id) references dps_organization (org_id))

create index dbc_org_cntrct_id on dbc_organization (contract_id)
create index dbc_orgdfltblig_ad on dbc_organization (dflt_billing_addr)
create index dbc_orgdflt_shpadr on dbc_organization (dflt_shipping_addr)
create index dbc_orgdflt_pmttyp on dbc_organization (dflt_payment_type)
create index dbc_orgdfltcst_ctr on dbc_organization (dflt_cost_center)

create table dbc_org_contact (
	org_id	varchar(40)	not null,
	contact_id	varchar(40)	not null,
	seq	integer	not null
,constraint dbc_org_contact_p primary key (org_id,seq)
,constraint dbc_orgccontct_d_f foreign key (contact_id) references dps_contact_info (id)
,constraint dbc_orgcorg_d_f foreign key (org_id) references dps_organization (org_id))

create index dbc_org_cntct_id on dbc_org_contact (contact_id)
-- Multi-table associating an Organization with one or more order approvers.  Like administrators, approvers are required to be registered users of the site so they can perform online approvals.

create table dbc_org_approver (
	org_id	varchar(40)	not null,
	approver_id	varchar(40)	not null,
	seq	integer	not null
,constraint dbc_org_approver_p primary key (org_id,seq)
,constraint dbc_orgporg_d_f foreign key (org_id) references dps_organization (org_id)
,constraint dbc_orgpapprvr_d_f foreign key (approver_id) references dps_user (id))

create index org_approver_idx on dbc_org_approver (approver_id)
-- Multi-table associating an Organization with one or more costcenters that are pre-approved for use by members of the organization.  

create table dbc_org_costctr (
	org_id	varchar(40)	not null,
	cost_center	varchar(80)	not null,
	seq	integer	not null
,constraint dbc_org_costctr_p primary key (org_id,seq)
,constraint dbc_ocstctrorgd_f foreign key (org_id) references dps_organization (org_id))

create index dbc_org_cstctr on dbc_org_costctr (cost_center)
-- Multi-table associating an Organization with one or more payment types that are pre-apprived for use by members of the organization.Right now we're just using credit cards here, but this will needto change to support more general payment types, including invoicing and purchase orders

create table dbc_org_payment (
	org_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	payment_id	varchar(40)	not null
,constraint dbc_org_payment_p primary key (org_id,tag)
,constraint dbc_orgppaymnt_d_f foreign key (payment_id) references dps_credit_card (id)
,constraint dbc_orgpymntorg_f foreign key (org_id) references dps_organization (org_id))

create index dbc_org_pymnt_id on dbc_org_payment (payment_id)

create table dbc_org_prefvndr (
	org_id	varchar(40)	not null,
	vendor	varchar(100)	not null,
	seq	integer	not null
,constraint dbc_org_prefvndr_p primary key (org_id,seq)
,constraint dbc_orgprfvndorg_f foreign key (org_id) references dps_organization (org_id))


create table dcs_org_address (
	org_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	addr_id	varchar(40)	not null
,constraint dcs_org_addr_p primary key (org_id,tag)
,constraint dcs_org_addr_fk1 foreign key (addr_id) references dps_contact_info (id)
,constraint dcs_org_addr_fk2 foreign key (org_id) references dps_organization (org_id))

create index dcs_org_addr_ix1 on dcs_org_address (addr_id)


go

-- the source for this section is 
-- versioned_product_catalog_ddl.sql





create table dcs_folder (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	folder_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	datetime	null,
	start_date	datetime	null,
	end_date	datetime	null,
	description	varchar(254)	null,
	name	varchar(254)	not null,
	path	varchar(254)	not null,
	parent_folder_id	varchar(40)	null
,constraint dcs_folder_p primary key (folder_id,asset_version))

create index fldr_end_dte_idx on dcs_folder (end_date)
create index fldr_path_idx on dcs_folder (path)
create index fldr_strt_dte_idx on dcs_folder (start_date)
create index dcs_folder_wsx on dcs_folder (workspace_id)
create index dcs_folder_cix on dcs_folder (checkin_date)

create table dcs_media (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	media_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	datetime	null,
	start_date	datetime	null,
	end_date	datetime	null,
	description	varchar(254)	null,
	name	varchar(254)	not null,
	path	varchar(254)	not null,
	parent_folder_id	varchar(40)	not null,
	media_type	integer	null
,constraint dcs_media_p primary key (media_id,asset_version))

create index med_end_dte_idx on dcs_media (end_date)
create index med_path_idx on dcs_media (path)
create index med_strt_dte_idx on dcs_media (start_date)
create index med_type_idx on dcs_media (media_type)
create index dcs_media_wsx on dcs_media (workspace_id)
create index dcs_media_cix on dcs_media (checkin_date)

create table dcs_media_ext (
	asset_version	numeric(19)	not null,
	media_id	varchar(40)	not null,
	url	varchar(254)	not null
,constraint dcs_media_ext_p primary key (media_id,asset_version))


create table dcs_media_bin (
	asset_version	numeric(19)	not null,
	media_id	varchar(40)	not null,
	length	integer	not null,
	last_modified	datetime	not null,
	data	image	not null
,constraint dcs_media_bin_p primary key (media_id,asset_version))


create table dcs_media_txt (
	asset_version	numeric(19)	not null,
	media_id	varchar(40)	not null,
	length	integer	not null,
	last_modified	datetime	not null,
	data	text	not null
,constraint dcs_media_txt_p primary key (media_id,asset_version))


create table dcs_category (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	category_id	varchar(40)	not null,
	version	integer	not null,
	catalog_id	varchar(40)	null,
	creation_date	datetime	null,
	start_date	datetime	null,
	end_date	datetime	null,
	display_name	varchar(254)	null,
	description	varchar(254)	null,
	long_description	text	null,
	parent_cat_id	varchar(40)	null,
	category_type	integer	null,
	root_category	numeric(1,0)	null
,constraint dcs_category_p primary key (category_id,asset_version)
,constraint dcs_category_c check (root_category in (0,1)))

create index cat_end_dte_idx on dcs_category (end_date)
create index cat_pcatid_idx on dcs_category (parent_cat_id)
create index cat_strt_dte_idx on dcs_category (start_date)
create index cat_type_idx on dcs_category (category_type)
create index dcs_category_wsx on dcs_category (workspace_id)
create index dcs_category_cix on dcs_category (checkin_date)

create table dcs_category_acl (
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	item_acl	text	null
,constraint dcs_category_acl_p primary key (category_id,asset_version))


create table dcs_product (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	product_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	datetime	null,
	start_date	datetime	null,
	end_date	datetime	null,
	display_name	varchar(254)	null,
	description	varchar(254)	null,
	long_description	text	null,
	parent_cat_id	varchar(40)	null,
	product_type	integer	null,
	admin_display	varchar(254)	null,
	nonreturnable	numeric(1,0)	null,
	discountable	tinyint	null,
	fractional_quantities_allowed	tinyint	null,
	unit_of_measure	integer	null,
	brand	varchar(254)	null,
	disallow_recommend	numeric(1,0)	null,
	manufacturer	varchar(40)	null,
	online_only	numeric(1,0)	null
,constraint dcs_product_p primary key (product_id,asset_version)
,constraint dcs_product_c check (nonreturnable in (0,1))
,constraint dcs_product1_c check (disallow_recommend in (0,1))
,constraint dcs_product2_c check (online_only in (0,1)))

create index prd_end_dte_idx on dcs_product (end_date)
create index prd_pcatid_idx on dcs_product (parent_cat_id)
create index prd_strt_dte_idx on dcs_product (start_date)
create index prd_type_idx on dcs_product (product_type)
create index dcs_product_wsx on dcs_product (workspace_id)
create index dcs_product_cix on dcs_product (checkin_date)

create table dcs_product_acl (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	item_acl	text	null
,constraint dcs_product_acl_p primary key (product_id,asset_version))


create table dcs_sku (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	sku_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	datetime	null,
	start_date	datetime	null,
	end_date	datetime	null,
	display_name	varchar(254)	null,
	description	varchar(254)	null,
	sku_type	integer	null,
	wholesale_price	numeric(19,7)	null,
	list_price	numeric(19,7)	null,
	sale_price	numeric(19,7)	null,
	on_sale	numeric(1,0)	null,
	tax_status	integer	null,
	fulfiller	integer	null,
	item_acl	text	null,
	nonreturnable	numeric(1,0)	null,
	discountable	tinyint	null,
	fractional_quantities_allowed	tinyint	null,
	manuf_part_num	varchar(254)	null,
	online_only	numeric(1,0)	null
,constraint dcs_sku_p primary key (sku_id,asset_version)
,constraint dcs_sku_c check (on_sale in (0,1))
,constraint dcs_sku1_c check (nonreturnable in (0,1))
,constraint dcs_sku2_c check (online_only in (0,1)))

create index sku_end_dte_idx on dcs_sku (end_date)
create index sku_lstprice_idx on dcs_sku (list_price)
create index sku_sleprice_idx on dcs_sku (sale_price)
create index sku_strt_dte_idx on dcs_sku (start_date)
create index sku_type_idx on dcs_sku (sku_type)
create index dcs_sku_wsx on dcs_sku (workspace_id)
create index dcs_sku_cix on dcs_sku (checkin_date)

create table dcs_cat_groups (
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	child_prd_group	varchar(254)	null,
	child_cat_group	varchar(254)	null,
	related_cat_group	varchar(254)	null
,constraint dcs_cat_groups_p primary key (category_id,asset_version))


create table dcs_cat_chldprd (
	sec_asset_version	numeric(19)	not null,
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_prd_id	varchar(40)	not null
,constraint dcs_cat_chldprd_p primary key (category_id,sequence_num,asset_version,sec_asset_version))

create index ct_chldprd_cpi_idx on dcs_cat_chldprd (child_prd_id)
create index ct_chldprd_cid_idx on dcs_cat_chldprd (category_id)

create table dcs_cat_chldcat (
	sec_asset_version	numeric(19)	not null,
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_cat_id	varchar(40)	not null
,constraint dcs_cat_chldcat_p primary key (category_id,sequence_num,asset_version,sec_asset_version))

create index ct_chldcat_cci_idx on dcs_cat_chldcat (child_cat_id)
create index ct_chldcat_cid_idx on dcs_cat_chldcat (category_id)

create table dcs_cat_ancestors (
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	anc_cat_id	varchar(40)	not null
,constraint dcs_cat_ancestor_p primary key (category_id,anc_cat_id,asset_version))

create index dcs_ct_anc_cat_id on dcs_cat_ancestors (anc_cat_id)
create index dcs_ct_cat_id on dcs_cat_ancestors (category_id)

create table dcs_cat_rltdcat (
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_cat_id	varchar(40)	not null
,constraint dcs_cat_rltdcat_p primary key (category_id,sequence_num,asset_version))

create index ct_rltdcat_cid_idx on dcs_cat_rltdcat (category_id)

create table dcs_cat_keywrds (
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	keyword	varchar(254)	not null
,constraint dcs_cat_keywrds_p primary key (category_id,sequence_num,asset_version))

create index cat_keywrds_idx on dcs_cat_keywrds (keyword)
create index ct_keywrds_cid_idx on dcs_cat_keywrds (category_id)

create table dcs_cat_media (
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	template_id	varchar(40)	null,
	thumbnail_image_id	varchar(40)	null,
	small_image_id	varchar(40)	null,
	large_image_id	varchar(40)	null
,constraint dcs_cat_media_p primary key (category_id,asset_version))


create table dcs_cat_aux_media (
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	media_id	varchar(40)	not null
,constraint dcs_cat_aux_medi_p primary key (category_id,tag,asset_version))

create index ct_aux_mdia_ci_idx on dcs_cat_aux_media (category_id)

create table dcs_prd_keywrds (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	keyword	varchar(254)	not null
,constraint dcs_prd_keywrds_p primary key (product_id,sequence_num,asset_version))

create index prd_keywrds_idx on dcs_prd_keywrds (keyword)
create index pr_keywrds_pid_idx on dcs_prd_keywrds (product_id)

create table dcs_prd_media (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	template_id	varchar(40)	null,
	thumbnail_image_id	varchar(40)	null,
	small_image_id	varchar(40)	null,
	large_image_id	varchar(40)	null
,constraint dcs_prd_media_p primary key (product_id,asset_version))


create table dcs_prd_aux_media (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	media_id	varchar(40)	not null
,constraint dcs_prd_aux_medi_p primary key (product_id,tag,asset_version))

create index pr_aux_mdia_pi_idx on dcs_prd_aux_media (product_id)

create table dcs_prd_chldsku (
	sec_asset_version	numeric(19)	not null,
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	sku_id	varchar(40)	not null
,constraint dcs_prd_chldsku_p primary key (product_id,sequence_num,asset_version,sec_asset_version))

create index pr_chldsku_sid_idx on dcs_prd_chldsku (sku_id)
create index pr_chldsku_pid_idx on dcs_prd_chldsku (product_id)

create table dcs_prd_skuattr (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	attribute_name	varchar(40)	not null
,constraint dcs_prd_skuattr_p primary key (product_id,sequence_num,asset_version))

create index pr_skuattr_pid_idx on dcs_prd_skuattr (product_id)

create table dcs_prd_groups (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	related_prd_group	varchar(254)	null,
	upsl_prd_group	varchar(254)	null
,constraint dcs_prd_groups_p primary key (product_id,asset_version))


create table dcs_prd_rltdprd (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_prd_id	varchar(40)	not null
,constraint dcs_prd_rltdprd_p primary key (product_id,sequence_num,asset_version))

create index pr_rltdprd_pid_idx on dcs_prd_rltdprd (product_id)

create table dcs_prd_upslprd (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	upsell_prd_id	varchar(40)	not null
,constraint dcs_prd_upslprd_p primary key (product_id,sequence_num,asset_version))


create table dcs_prd_ancestors (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	anc_cat_id	varchar(40)	not null
,constraint dcs_prd_ancestor_p primary key (product_id,anc_cat_id,asset_version))

create index dcs_prd_anc_cat_id on dcs_prd_ancestors (anc_cat_id)
create index dcs_prd_prd_id on dcs_prd_ancestors (product_id)

create table dcs_sku_attr (
	asset_version	numeric(19)	not null,
	sku_id	varchar(40)	not null,
	attribute_name	varchar(42)	not null,
	attribute_value	varchar(254)	not null
,constraint dcs_sku_attr_p primary key (sku_id,attribute_name,asset_version))

create index sku_attr_skuid_idx on dcs_sku_attr (sku_id)

create table dcs_sku_link (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	sku_link_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	datetime	null,
	start_date	datetime	null,
	end_date	datetime	null,
	display_name	varchar(254)	null,
	description	varchar(254)	null,
	quantity	integer	null,
	quantity_with_fraction	numeric(19,7)	null,
	bundle_item	varchar(40)	not null,
	item_acl	text	null
,constraint dcs_sku_link_p primary key (sku_link_id,asset_version))

create index skl_end_dte_idx on dcs_sku_link (end_date)
create index skl_strt_dte_idx on dcs_sku_link (start_date)
create index dcs_sku_link_wsx on dcs_sku_link (workspace_id)
create index dcs_sku_link_cix on dcs_sku_link (checkin_date)

create table dcs_sku_bndllnk (
	asset_version	numeric(19)	not null,
	sku_id	varchar(40)	not null,
	sequence_num	integer	not null,
	sku_link_id	varchar(40)	not null
,constraint dcs_sku_bndllnk_p primary key (sku_id,sequence_num,asset_version))

create index sk_bndllnk_sid_idx on dcs_sku_bndllnk (sku_id)

create table dcs_sku_media (
	asset_version	numeric(19)	not null,
	sku_id	varchar(40)	not null,
	template_id	varchar(40)	null,
	thumbnail_image_id	varchar(40)	null,
	small_image_id	varchar(40)	null,
	large_image_id	varchar(40)	null
,constraint dcs_sku_media_p primary key (sku_id,asset_version))


create table dcs_sku_aux_media (
	asset_version	numeric(19)	not null,
	sku_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	media_id	varchar(40)	not null
,constraint dcs_sku_aux_medi_p primary key (sku_id,tag,asset_version))

create index sk_aux_mdia_si_idx on dcs_sku_aux_media (sku_id)

create table dcs_sku_replace (
	asset_version	numeric(19)	not null,
	sku_id	varchar(40)	not null,
	sequence_num	integer	not null,
	replacement	varchar(40)	not null
,constraint dcs_sku_replace_p primary key (sku_id,sequence_num,asset_version))

create index sk_replace_sid_idx on dcs_sku_replace (sku_id)

create table dcs_sku_conf (
	asset_version	numeric(19)	not null,
	sku_id	varchar(40)	not null,
	config_props	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcs_sku_conf_p primary key (sku_id,sequence_num,asset_version))


create table dcs_config_sku (
	asset_version	numeric(19)	not null,
	sku_id	varchar(40)	not null,
	configurator_id	varchar(254)	null
,constraint dcs_config_sku_p primary key (sku_id,asset_version))


create table dcs_config_prop (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	config_prop_id	varchar(40)	not null,
	version	integer	not null,
	display_name	varchar(40)	null,
	description	varchar(255)	null,
	configurator_id	varchar(254)	null,
	item_acl	text	null
,constraint dcs_config_prop_p primary key (config_prop_id,asset_version))

create index dcs_config_pro_wsx on dcs_config_prop (workspace_id)
create index dcs_config_pro_cix on dcs_config_prop (checkin_date)

create table dcs_conf_options (
	asset_version	numeric(19)	not null,
	config_prop_id	varchar(40)	not null,
	config_options	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcs_conf_options_p primary key (config_prop_id,sequence_num,asset_version))


create table dcs_config_opt (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	config_opt_id	varchar(40)	not null,
	version	integer	not null,
	display_name	varchar(40)	null,
	description	varchar(255)	null,
	sku	varchar(40)	null,
	product	varchar(40)	null,
	price	numeric(19,7)	null,
	item_acl	text	null
,constraint dcs_config_opt_p primary key (config_opt_id,asset_version))

create index ct_conf_prod_idx on dcs_config_opt (product)
create index ct_conf_sku_idx on dcs_config_opt (sku)
create index dcs_config_opt_wsx on dcs_config_opt (workspace_id)
create index dcs_config_opt_cix on dcs_config_opt (checkin_date)

create table dcs_foreign_cat (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	catalog_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	name	varchar(100)	null,
	description	varchar(255)	null,
	host	varchar(100)	null,
	port	integer	null,
	base_url	varchar(255)	null,
	return_url	varchar(255)	null,
	item_acl	text	null
,constraint dcs_foreign_cat_p primary key (catalog_id,asset_version))

create index dcs_foreign_ca_wsx on dcs_foreign_cat (workspace_id)
create index dcs_foreign_ca_cix on dcs_foreign_cat (checkin_date)

create table dbc_manufacturer (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	manufacturer_id	varchar(40)	not null,
	manufacturer_name	varchar(254)	null,
	description	varchar(254)	null,
	long_description	text	null,
	email	varchar(255)	null
,constraint dbc_manufacturer_p primary key (manufacturer_id,asset_version))

create index dbc_man_name_idx on dbc_manufacturer (manufacturer_name)
create index dbc_manufactur_wsx on dbc_manufacturer (workspace_id)
create index dbc_manufactur_cix on dbc_manufacturer (checkin_date)

create table dbc_measurement (
	asset_version	numeric(19)	not null,
	sku_id	varchar(40)	not null,
	unit_of_measure	integer	null,
	quantity	numeric(19,7)	null
,constraint dbc_measurement_p primary key (sku_id,asset_version))


create table dcs_product_rltd_media (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_media_id	varchar(40)	not null
,constraint dcs_product_rltd_media_p primary key (product_id,sequence_num,asset_version))


create table dcs_product_rltd_article (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_article_id	varchar(40)	not null
,constraint dcs_product_rltd_article_p primary key (product_id,sequence_num,asset_version))



go

-- the source for this section is 
-- versioned_location_ddl.sql





create table dcs_location (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	location_id	varchar(40)	not null,
	ext_loc_id	varchar(40)	null,
	type	integer	not null,
	version	integer	not null,
	name	varchar(254)	null,
	start_date	datetime	null,
	end_date	datetime	null,
	latitude	numeric(19,7)	not null,
	longitude	numeric(19,7)	not null
,constraint dcs_location_p primary key (location_id,asset_version))

create index dcs_location_wsx on dcs_location (workspace_id)
create index dcs_location_cix on dcs_location (checkin_date)

create table dcs_location_sites (
	asset_version	numeric(19)	not null,
	location_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_location_sites_pk primary key (location_id,site_id,asset_version))

create index location_site_id_idx on dcs_location_sites (site_id)

create table dcs_loc_site_grps (
	asset_version	numeric(19)	not null,
	location_id	varchar(40)	not null,
	site_group_id	varchar(40)	not null
,constraint dcs_loc_sgrps_pk primary key (location_id,site_group_id,asset_version))


create table dcs_location_store (
	asset_version	numeric(19)	not null,
	location_id	varchar(40)	not null,
	hours	varchar(64)	null
,constraint dcs_loc_store_p primary key (location_id,asset_version))


create table dcs_location_addr (
	asset_version	numeric(19)	not null,
	location_id	varchar(40)	not null,
	address_1	varchar(50)	null,
	address_2	varchar(50)	null,
	address_3	varchar(50)	null,
	city	varchar(40)	null,
	county	varchar(40)	null,
	state_addr	varchar(40)	null,
	postal_code	varchar(10)	null,
	country	varchar(40)	null,
	phone_number	varchar(40)	null,
	fax_number	varchar(40)	null,
	email	varchar(255)	null
,constraint dcspp_loc_addr_p primary key (location_id,asset_version))


create table dcs_location_rltd_media (
	asset_version	numeric(19)	not null,
	location_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_media_id	varchar(40)	not null
,constraint dcs_location_rltd_media_p primary key (location_id,sequence_num,asset_version))


create table dcs_location_rltd_article (
	asset_version	numeric(19)	not null,
	location_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_article_id	varchar(40)	not null
,constraint dcs_location_rltd_article_p primary key (location_id,sequence_num,asset_version))



go

-- the source for this section is 
-- inventory_ddl.sql





create table dcs_inventory (
	inventory_id	varchar(40)	not null,
	location_id	varchar(40)	null,
	version	integer	not null,
	inventory_lock	varchar(20)	null,
	creation_date	datetime	null,
	start_date	datetime	null,
	end_date	datetime	null,
	display_name	varchar(254)	null,
	description	varchar(254)	null,
	catalog_ref_id	varchar(40)	not null,
	avail_status	integer	not null,
	availability_date	datetime	null,
	stock_level	integer	null,
	stock_level_with_fraction	numeric(19,7)	null,
	backorder_level	integer	null,
	backorder_level_with_fraction	numeric(19,7)	null,
	preorder_level	integer	null,
	preorder_level_with_fraction	numeric(19,7)	null,
	stock_thresh	integer	null,
	backorder_thresh	integer	null,
	preorder_thresh	integer	null
,constraint dcs_inventory_p primary key (inventory_id))

create unique index inv_catloc_idx on dcs_inventory (catalog_ref_id,location_id)
create index inv_end_dte_idx on dcs_inventory (end_date)
create index inv_strt_dte_idx on dcs_inventory (start_date)

create table dcs_inv_atp (
	id	varchar(40)	not null,
	version	integer	not null,
	inventory_id	varchar(40)	null,
	available_date	datetime	not null,
	quantity	integer	not null,
	quantity_with_fraction	numeric(19,7)	null
,constraint dcs_inv_atp_p primary key (id))



go

-- the source for this section is 
-- versioned_promotion_ddl.sql




-- Add the DCS_PRM_FOLDER table, promotionFolder

create table dcs_prm_folder (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	folder_id	varchar(40)	not null,
	name	varchar(254)	not null,
	parent_folder	varchar(40)	null
,constraint dcs_prm_folder_p primary key (folder_id,asset_version))

create index dcs_prm_folder_wsx on dcs_prm_folder (workspace_id)
create index dcs_prm_folder_cix on dcs_prm_folder (checkin_date)

create table dcs_stacking_rule (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	stacking_rule_id	varchar(40)	not null,
	display_name	varchar(254)	null,
	order_limits	integer	null,
	last_modified	datetime	null
,constraint dcs_sr_p primary key (stacking_rule_id,asset_version))

create index dcs_stacking_r_wsx on dcs_stacking_rule (workspace_id)
create index dcs_stacking_r_cix on dcs_stacking_rule (checkin_date)

create table dcs_excl_stacking_rules (
	asset_version	numeric(19)	not null,
	stacking_rule_id	varchar(40)	not null,
	excl_stacking_rule_id	varchar(40)	not null)


create table dcs_promotion (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	promotion_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	datetime	null,
	start_date	datetime	null,
	end_date	datetime	null,
	display_name	varchar(254)	null,
	description	varchar(254)	null,
	promotion_type	integer	null,
	enabled	numeric(1,0)	null,
	begin_usable	datetime	null,
	end_usable	datetime	null,
	priority	integer	null,
	evaluation_limit	integer	null,
	global	numeric(1,0)	null,
	anon_profile	numeric(1,0)	null,
	allow_multiple	numeric(1,0)	null,
	uses	integer	null,
	rel_expiration	numeric(1,0)	null,
	time_until_expire	integer	null,
	template	varchar(254)	null,
	ui_access_lvl	integer	null,
	parent_folder	varchar(40)	null,
	last_modified	datetime	null,
	pmdl_version	integer	null,
	eval_target_items_first	tinyint	null,
	qualifier	varchar(254)	null,
	stacking_rule	varchar(40)	null,
	fil_Qual_Discounted_By_Any	tinyint	null,
	fil_Qual_Discounted_By_Current	tinyint	null,
	fil_Qual_Acted_As_Qual	tinyint	null,
	fil_Qual_On_Sale	tinyint	null,
	fil_Qual_Zero_Prices	tinyint	null,
	fil_Qual_Neg_Prices	tinyint	null,
	fil_Tar_Acted_As_Qual	tinyint	null,
	fil_Tar_Discounted_By_Current	tinyint	null,
	fil_Tar_Discounted_By_Any	tinyint	null,
	fil_Target_On_Sale	tinyint	null,
	fil_Tar_Zero_Prices	tinyint	null,
	fil_Tar_Neg_Prices	tinyint	null,
	fil_Tar_Price_LTOET_Prm_Price	tinyint	null
,constraint dcs_promotion_p primary key (promotion_id,asset_version)
,constraint dcs_promotion1_c check (enabled in (0,1))
,constraint dcs_promotion2_c check (global in (0,1))
,constraint dcs_promotion3_c check (anon_profile in (0,1))
,constraint dcs_promotion4_c check (allow_multiple in (0,1))
,constraint dcs_promotion5_c check (rel_expiration in (0,1))
,constraint dcs_promotion6_c check (eval_target_items_first in (0,1)))

create index prmo_bgin_use_idx on dcs_promotion (begin_usable)
create index prmo_end_dte_idx on dcs_promotion (end_date)
create index prmo_end_use_idx on dcs_promotion (end_usable)
create index prmo_strt_dte_idx on dcs_promotion (start_date)
create index dcs_promotion_wsx on dcs_promotion (workspace_id)
create index dcs_promotion_cix on dcs_promotion (checkin_date)

create table dcs_promo_media (
	asset_version	numeric(19)	not null,
	promotion_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	media_id	varchar(40)	not null
,constraint dcs_promo_media_p primary key (promotion_id,tag,asset_version))

create index promo_mdia_pid_idx on dcs_promo_media (promotion_id)

create table dcs_promo_payment (
	asset_version	numeric(19)	not null,
	promotion_id	varchar(40)	not null,
	payment_type	varchar(40)	not null)


create table dcs_discount_promo (
	asset_version	numeric(19)	not null,
	promotion_id	varchar(40)	not null,
	calculator	varchar(254)	null,
	adjuster	numeric(19,7)	null,
	pmdl_rule	text	not null,
	one_use	numeric(1,0)	null
,constraint dcs_discount_pro_p primary key (promotion_id,asset_version)
,constraint dcs_discount_pro_c check (one_use in (0, 1)))


create table dcs_promo_upsell (
	asset_version	numeric(19)	not null,
	promotion_id	varchar(40)	not null,
	upsell	tinyint	null
,constraint dcs_promo_upsell_p primary key (promotion_id,asset_version)
,constraint dcs_promo_upsell_c check (upsell in (0, 1)))


create table dcs_upsell_action (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	action_id	varchar(40)	not null,
	version	integer	not null,
	name	varchar(40)	not null,
	upsell_prd_grp	text	null
,constraint dcs_upsell_actn_p primary key (action_id,asset_version))

create index dcs_upsell_act_wsx on dcs_upsell_action (workspace_id)
create index dcs_upsell_act_cix on dcs_upsell_action (checkin_date)

create table dcs_close_qualif (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	close_qualif_id	varchar(40)	not null,
	version	integer	not null,
	name	varchar(254)	not null,
	priority	integer	null,
	qualifier	text	null,
	upsell_media	varchar(40)	null,
	upsell_action	varchar(40)	null
,constraint dcs_close_qualif_p primary key (close_qualif_id,asset_version))

create index dcs_close_qual_wsx on dcs_close_qualif (workspace_id)
create index dcs_close_qual_cix on dcs_close_qualif (checkin_date)

create table dcs_prm_cls_qlf (
	sec_asset_version	numeric(19)	not null,
	asset_version	numeric(19)	not null,
	promotion_id	varchar(40)	not null,
	closeness_qualif	varchar(40)	not null)


create table dcs_prm_sites (
	asset_version	numeric(19)	not null,
	promotion_id	varchar(40)	not null,
	site_id	varchar(40)	not null)


create table dcs_prm_site_grps (
	asset_version	numeric(19)	not null,
	promotion_id	varchar(40)	not null,
	site_group_id	varchar(40)	not null)


create table dcs_prm_tpl_vals (
	asset_version	numeric(19)	not null,
	promotion_id	varchar(40)	not null,
	placeholder	varchar(40)	not null,
	placeholderValue	text	null
,constraint dcs_prm_tpl_vals_p primary key (promotion_id,placeholder,asset_version))


create table dcs_prm_cls_vals (
	asset_version	numeric(19)	not null,
	close_qualif_id	varchar(40)	not null,
	placeholder	varchar(40)	not null,
	placeholderValue	text	null
,constraint dcs_prm_cls_vals_p primary key (close_qualif_id,placeholder,asset_version))


create table dcs_upsell_prods (
	asset_version	numeric(19)	not null,
	action_id	varchar(40)	not null,
	product_id	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcs_upsell_prods_p primary key (action_id,product_id,asset_version))


create table dcs_excl_promotions (
	asset_version	numeric(19)	not null,
	promotion_id	varchar(40)	not null,
	excl_promotion_id	varchar(40)	not null)


create table dcs_incl_promotions (
	asset_version	numeric(19)	not null,
	promotion_id	varchar(40)	not null,
	incl_promotion_id	varchar(40)	not null)



go

-- the source for this section is 
-- user_promotion_ddl.sql




-- The promotion line was commented out to allow the profile and promotion tables to be delinked. The promotion tables are intended to be used as a "read-only" table on the production servers. The promotion (and product catalog) tables are promoted and made active on the production system through copy-switch. In doing so, the profile tables and the promotion tables cannot be in the same database, and therefore we must remove this referece. However if you are not going to use copy-switch for the promotions, then you can add this reference back in.     promotion			VARCHAR(40)		NOT NULL	REFERENCES dcs_promotion(promotion_id),

create table dcs_usr_promostat (
	status_id	varchar(40)	not null,
	profile_id	varchar(40)	not null,
	promotion	varchar(40)	not null,
	num_uses	integer	null,
	expirationDate	datetime	null,
	granted_date	datetime	null
,constraint dcs_usr_promosta_p primary key (status_id))

create index promostat_prof_idx on dcs_usr_promostat (profile_id)
create index usr_prmstat_pr_idx on dcs_usr_promostat (promotion)

create table dcs_usr_actvpromo (
	id	varchar(40)	not null,
	sequence_num	integer	not null,
	promo_status_id	varchar(40)	not null
,constraint dcs_usr_actvprom_p primary key (id,sequence_num)
,constraint usr_actvprm_id_f foreign key (id) references dps_user (id)
,constraint usr_actvprm_stat_f foreign key (promo_status_id) references dcs_usr_promostat (status_id))

create index usr_actvprm_ps_idx on dcs_usr_actvpromo (promo_status_id)
create index usr_actvprm_id_idx on dcs_usr_actvpromo (id)

create table dcs_promo_st_cpn (
	status_id	varchar(40)	not null,
	sequence_num	integer	not null,
	coupon_id	varchar(40)	not null
,constraint dcs_promo_st_cpn_p primary key (status_id,sequence_num))

-- The promotion_id column was commented out to allow the profile and promotion tables to be delinked. The promotion tables are intended to be used as a "read-only" table on the production servers. The promotion (and product catalog) tables are promoted and made active on the production system through copy-switch. In doing so, the profile tables and the promotion tables cannot be in the same database, and therefore we must remove this referece. However if you are not going to use copy-switch for the promotions, then you can add this reference back in.        promotion_id                    VARCHAR(40)             NOT NULL        REFERENCES dcs_promotion(promotion_id),

create table dcs_usr_usedpromo (
	id	varchar(40)	not null,
	promotion_id	varchar(40)	not null
,constraint dcs_usr_usedprom_p primary key (id,promotion_id))

create index usr_usedprm_id_idx on dcs_usr_usedpromo (id)
create index usr_usedprm_pi_idx on dcs_usr_usedpromo (promotion_id)


go

-- the source for this section is 
-- user_giftlist_ddl.sql





create table dcs_giftlist (
	id	varchar(40)	not null,
	owner_id	varchar(40)	null,
	site_id	varchar(40)	null,
	is_public	numeric(1,0)	not null,
	is_published	numeric(1,0)	not null,
	event_name	varchar(64)	null,
	event_type	integer	null,
	event_date	datetime	null,
	comments	varchar(254)	null,
	description	varchar(254)	null,
	instructions	varchar(254)	null,
	creation_date	datetime	null,
	last_modified_date	datetime	null,
	shipping_addr_id	varchar(40)	null
,constraint dcs_giftlist_p primary key (id)
,constraint dcs_giftlist1_c check (is_public in (0,1))
,constraint dcs_giftlist2_c check (is_published in (0,1)))

create index gftlst_shpadid_idx on dcs_giftlist (shipping_addr_id)
create index gft_evnt_name_idx on dcs_giftlist (event_name)
create index gft_evnt_type_idx on dcs_giftlist (event_type)
create index gft_owner_id_idx on dcs_giftlist (owner_id)
create index gft_site_id_idx on dcs_giftlist (site_id)

create table dcs_giftinst (
	giftlist_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	special_inst	varchar(254)	null
,constraint dcs_giftinst_p primary key (giftlist_id,tag)
,constraint dcs_giftgiftlst__f foreign key (giftlist_id) references dcs_giftlist (id))

create index giftinst_gflid_idx on dcs_giftinst (giftlist_id)

create table dcs_giftitem (
	id	varchar(40)	not null,
	catalog_ref_id	varchar(40)	null,
	product_id	varchar(40)	null,
	site_id	varchar(40)	null,
	display_name	varchar(254)	null,
	description	varchar(254)	null,
	quantity_desired	integer	null,
	quantity_purchased	integer	null,
	qty_with_fraction_desired	numeric(19,7)	null,
	qty_with_fraction_purchased	numeric(19,7)	null
,constraint dcs_giftitem_p primary key (id))

create index giftitem_cat_idx on dcs_giftitem (catalog_ref_id)
create index giftitem_prod_idx on dcs_giftitem (product_id)
create index giftitem_site_idx on dcs_giftitem (site_id)

create table dcs_giftlist_item (
	giftlist_id	varchar(40)	not null,
	sequence_num	integer	not null,
	giftitem_id	varchar(40)	null
,constraint dcs_giftlist_ite_p primary key (giftlist_id,sequence_num)
,constraint dcs_giftgifttm_d_f foreign key (giftitem_id) references dcs_giftitem (id)
,constraint dcs_gftlstgftlst_f foreign key (giftlist_id) references dcs_giftlist (id))

create index gftlst_itm_gii_idx on dcs_giftlist_item (giftitem_id)
create index gftlst_itm_gli_idx on dcs_giftlist_item (giftlist_id)

create table dcs_user_wishlist (
	user_id	varchar(40)	not null,
	giftlist_id	varchar(40)	null
,constraint dcs_user_wishlis_p primary key (user_id)
,constraint dcs_usrwgiftlst__f foreign key (giftlist_id) references dcs_giftlist (id))

create index usr_wshlst_gli_idx on dcs_user_wishlist (giftlist_id)

create table dcs_user_giftlist (
	user_id	varchar(40)	not null,
	sequence_num	integer	not null,
	giftlist_id	varchar(40)	null
,constraint dcs_user_giftlis_p primary key (user_id,sequence_num)
,constraint dcs_usrgiftlst__f foreign key (giftlist_id) references dcs_giftlist (id))

create index usr_gftlst_gli_idx on dcs_user_giftlist (giftlist_id)
create index usr_gftlst_uid_idx on dcs_user_giftlist (user_id)

create table dcs_user_otherlist (
	user_id	varchar(40)	not null,
	sequence_num	integer	not null,
	giftlist_id	varchar(40)	null
,constraint dcs_user_otherli_p primary key (user_id,sequence_num)
,constraint dcs_usrtgiftlst__f foreign key (giftlist_id) references dcs_giftlist (id))

create index usr_otrlst_gli_idx on dcs_user_otherlist (giftlist_id)


go

-- the source for this section is 
-- order_ddl.sql





create table dcspp_order (
	order_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	order_class_type	varchar(40)	null,
	profile_id	varchar(40)	null,
	organization_id	varchar(40)	null,
	description	varchar(64)	null,
	state	varchar(40)	null,
	state_detail	varchar(254)	null,
	created_by_order	varchar(40)	null,
	origin_of_order	integer	null,
	creation_date	datetime	null,
	submitted_date	datetime	null,
	last_modified_date	datetime	null,
	completed_date	datetime	null,
	price_info	varchar(40)	null,
	tax_price_info	varchar(40)	null,
	explicitly_saved	numeric(1,0)	null,
	agent_id	varchar(40)	null,
	sales_channel	integer	null,
	creation_site_id	varchar(40)	null,
	site_id	varchar(40)	null,
	gwp	numeric(1,0)	null,
	quote_info	varchar(40)	null,
	active_quote_order_id	varchar(40)	null,
	configurator_id	varchar(254)	null
,constraint dcspp_order_p primary key (order_id)
,constraint dcspp_order_c check (explicitly_saved IN (0,1)))

create index order_lastmod_idx on dcspp_order (last_modified_date)
create index order_profile_idx on dcspp_order (profile_id)
create index order_submit_idx on dcspp_order (submitted_date)
create index ord_creat_site_idx on dcspp_order (creation_site_id)
create index ord_site_idx on dcspp_order (site_id)
create index ord_activequote_idx on dcspp_order (active_quote_order_id)
create index ord_organization_idx on dcspp_order (organization_id)

create table dcspp_ship_group (
	shipping_group_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	shipgrp_class_type	varchar(40)	null,
	shipping_method	varchar(40)	null,
	description	varchar(64)	null,
	ship_on_date	datetime	null,
	actual_ship_date	datetime	null,
	state	varchar(40)	null,
	state_detail	varchar(254)	null,
	submitted_date	datetime	null,
	price_info	varchar(40)	null,
	order_ref	varchar(40)	null
,constraint dcspp_ship_group_p primary key (shipping_group_id))


create table dcspp_pay_group (
	payment_group_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	paygrp_class_type	varchar(40)	null,
	payment_method	varchar(40)	null,
	amount	numeric(19,7)	null,
	amount_authorized	numeric(19,7)	null,
	amount_debited	numeric(19,7)	null,
	amount_credited	numeric(19,7)	null,
	currency_code	varchar(10)	null,
	state	varchar(40)	null,
	state_detail	varchar(254)	null,
	submitted_date	datetime	null,
	order_ref	varchar(40)	null
,constraint dcspp_pay_group_p primary key (payment_group_id))


create table dcspp_item (
	commerce_item_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	item_class_type	varchar(40)	null,
	catalog_id	varchar(40)	null,
	catalog_ref_id	varchar(40)	null,
	external_id	varchar(40)	null,
	catalog_key	varchar(40)	null,
	product_id	varchar(40)	null,
	site_id	varchar(40)	null,
	quantity	numeric(19,0)	null,
	quantity_with_fraction	numeric(19,7)	null,
	state	varchar(40)	null,
	state_detail	varchar(254)	null,
	price_info	varchar(40)	null,
	order_ref	varchar(40)	null,
	gwp	numeric(1,0)	null
,constraint dcspp_item_p primary key (commerce_item_id))

create index item_catref_idx on dcspp_item (catalog_ref_id)
create index item_prodref_idx on dcspp_item (product_id)
create index item_site_idx on dcspp_item (site_id)

create table dcspp_relationship (
	relationship_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	rel_class_type	varchar(40)	null,
	relationship_type	varchar(40)	null,
	order_ref	varchar(40)	null
,constraint dcspp_relationsh_p primary key (relationship_id))


create table dcspp_rel_orders (
	order_id	varchar(40)	not null,
	related_orders	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_rel_orders_p primary key (order_id,sequence_num)
,constraint dcspp_reordr_d_f foreign key (order_id) references dcspp_order (order_id))


create table dcspp_order_inst (
	order_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	special_inst	varchar(254)	null
,constraint dcspp_order_inst_p primary key (order_id,tag)
,constraint dcspp_orordr_d_f foreign key (order_id) references dcspp_order (order_id))

create index order_inst_oid_idx on dcspp_order_inst (order_id)

create table dcspp_order_sg (
	order_id	varchar(40)	not null,
	shipping_groups	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_order_sg_p primary key (order_id,sequence_num)
,constraint dcspp_sgordr_d_f foreign key (order_id) references dcspp_order (order_id))

create index order_sg_ordid_idx on dcspp_order_sg (order_id)

create table dcspp_order_pg (
	order_id	varchar(40)	not null,
	payment_groups	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_order_pg_p primary key (order_id,sequence_num)
,constraint dcspp_orpgordr_f foreign key (order_id) references dcspp_order (order_id))

create index order_pg_ordid_idx on dcspp_order_pg (order_id)

create table dcspp_order_item (
	order_id	varchar(40)	not null,
	commerce_items	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_order_item_p primary key (order_id,sequence_num)
,constraint dcspp_oritordr_d_f foreign key (order_id) references dcspp_order (order_id))

create index order_item_oid_idx on dcspp_order_item (order_id)
create index order_item_cit_idx on dcspp_order_item (commerce_items)

create table dcspp_order_rel (
	order_id	varchar(40)	not null,
	relationships	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_order_rel_p primary key (order_id,sequence_num)
,constraint dcspp_orlordr_d_f foreign key (order_id) references dcspp_order (order_id))

create index order_rel_orid_idx on dcspp_order_rel (order_id)

create table dcspp_ship_inst (
	shipping_group_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	special_inst	varchar(254)	null
,constraint dcspp_ship_inst_p primary key (shipping_group_id,tag)
,constraint dcspp_shshippng__f foreign key (shipping_group_id) references dcspp_ship_group (shipping_group_id))

create index ship_inst_sgid_idx on dcspp_ship_inst (shipping_group_id)

create table dcspp_hrd_ship_grp (
	shipping_group_id	varchar(40)	not null,
	tracking_number	varchar(40)	null
,constraint dcspp_hrd_ship_g_p primary key (shipping_group_id)
,constraint dcspp_hrshippng__f foreign key (shipping_group_id) references dcspp_ship_group (shipping_group_id))


create table dcspp_ele_ship_grp (
	shipping_group_id	varchar(40)	not null,
	email_address	varchar(255)	null
,constraint dcspp_ele_ship_g_p primary key (shipping_group_id)
,constraint dcspp_elshippng__f foreign key (shipping_group_id) references dcspp_ship_group (shipping_group_id))


create table dcspp_isp_ship_grp (
	shipping_group_id	varchar(40)	not null,
	location_id	varchar(40)	not null,
	first_name	varchar(40)	null,
	middle_name	varchar(40)	null,
	last_name	varchar(40)	null
,constraint dcspp_isp_ship_g_p primary key (shipping_group_id)
,constraint dcspp_ispshippng__f foreign key (shipping_group_id) references dcspp_ship_group (shipping_group_id))


create table dcspp_ship_addr (
	shipping_group_id	varchar(40)	not null,
	prefix	nvarchar(40)	null,
	first_name	nvarchar(40)	null,
	middle_name	nvarchar(40)	null,
	last_name	nvarchar(40)	null,
	suffix	nvarchar(40)	null,
	job_title	nvarchar(40)	null,
	company_name	nvarchar(40)	null,
	address_1	nvarchar(50)	null,
	address_2	nvarchar(50)	null,
	address_3	nvarchar(50)	null,
	city	nvarchar(40)	null,
	county	nvarchar(40)	null,
	state	nvarchar(40)	null,
	postal_code	nvarchar(10)	null,
	country	nvarchar(40)	null,
	phone_number	nvarchar(40)	null,
	fax_number	nvarchar(40)	null,
	email	nvarchar(255)	null
,constraint dcspp_ship_addr_p primary key (shipping_group_id)
,constraint dcspp_shdshippng_f foreign key (shipping_group_id) references dcspp_ship_group (shipping_group_id))


create table dcspp_hand_inst (
	handling_inst_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	hndinst_class_type	varchar(40)	null,
	handling_method	varchar(40)	null,
	shipping_group_id	varchar(40)	null,
	commerce_item_id	varchar(40)	null,
	quantity	integer	null,
	quantity_with_fraction	numeric(19,7)	null
,constraint dcspp_hand_inst_p primary key (handling_inst_id))

create index hi_item_idx on dcspp_hand_inst (commerce_item_id)
create index hi_ship_group_idx on dcspp_hand_inst (shipping_group_id)

create table dcspp_gift_inst (
	handling_inst_id	varchar(40)	not null,
	giftlist_id	varchar(40)	null,
	giftlist_item_id	varchar(40)	null
,constraint dcspp_gift_inst_p primary key (handling_inst_id)
,constraint dcspp_gihandlng__f foreign key (handling_inst_id) references dcspp_hand_inst (handling_inst_id))


create table dcspp_sg_hand_inst (
	shipping_group_id	varchar(40)	not null,
	handling_instrs	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_sg_hand_in_p primary key (shipping_group_id,sequence_num)
,constraint dcspp_sgshippng__f foreign key (shipping_group_id) references dcspp_ship_group (shipping_group_id))

create index sg_hnd_ins_sgi_idx on dcspp_sg_hand_inst (shipping_group_id)

create table dcspp_pay_inst (
	payment_group_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	special_inst	varchar(254)	null
,constraint dcspp_pay_inst_p primary key (payment_group_id,tag)
,constraint dcspp_papaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id))

create index pay_inst_pgrid_idx on dcspp_pay_inst (payment_group_id)

create table dcspp_config_item (
	config_item_id	varchar(40)	not null,
	reconfig_data	varchar(255)	null,
	notes	varchar(255)	null,
	configured	tinyint	null,
	configurator_id	varchar(254)	null
,constraint dcspp_config_ite_p primary key (config_item_id)
,constraint dcspp_coconfg_tm_f foreign key (config_item_id) references dcspp_item (commerce_item_id))


create table dcspp_subsku_item (
	subsku_item_id	varchar(40)	not null,
	ind_quantity	integer	null,
	config_prop_id	varchar(40)	null,
	config_opt_id	varchar(40)	null
,constraint dcspp_subsku_ite_p primary key (subsku_item_id)
,constraint dcspp_susubsk_tm_f foreign key (subsku_item_id) references dcspp_item (commerce_item_id))


create table dcspp_config_subsku_item (
	subsku_item_id	varchar(40)	not null,
	config_prop_id	varchar(40)	null,
	config_opt_id	varchar(40)	null
,constraint dcspp_cfg_subsku_ite_p primary key (subsku_item_id)
,constraint dcspp_cfg_subsku_tm_f foreign key (subsku_item_id) references dcspp_item (commerce_item_id))


create table dcspp_item_ci (
	commerce_item_id	varchar(40)	not null,
	commerce_items	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_item_ci_p primary key (commerce_item_id,sequence_num)
,constraint dcspp_itcommrc_t_f foreign key (commerce_item_id) references dcspp_item (commerce_item_id))


create table dcspp_gift_cert (
	payment_group_id	varchar(40)	not null,
	profile_id	varchar(40)	null,
	gift_cert_number	varchar(50)	null
,constraint dcspp_gift_cert_p primary key (payment_group_id)
,constraint dcspp_gipaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id))

create index gc_number_idx on dcspp_gift_cert (gift_cert_number)
create index gc_profile_idx on dcspp_gift_cert (profile_id)

create table dcspp_store_cred (
	payment_group_id	varchar(40)	not null,
	profile_id	varchar(40)	null,
	store_cred_number	varchar(50)	null
,constraint dcspp_store_cred_p primary key (payment_group_id)
,constraint dcspp_stpaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id))

create index sc_number_idx on dcspp_store_cred (store_cred_number)
create index sc_profile_idx on dcspp_store_cred (profile_id)

create table dcspp_credit_card (
	payment_group_id	varchar(40)	not null,
	credit_card_number	varchar(40)	null,
	credit_card_type	varchar(40)	null,
	expiration_month	varchar(20)	null,
	exp_day_of_month	varchar(20)	null,
	expiration_year	varchar(20)	null
,constraint dcspp_credit_car_p primary key (payment_group_id)
,constraint dcspp_crpaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id))


create table dcspp_token_crdt_crd (
	payment_group_id	varchar(40)	not null,
	token	varchar(40)	not null
,constraint dcspp_token_crdt_crd_p primary key (payment_group_id)
,constraint dcspp_tokencrdtcrd__f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id))


create table dcspp_bill_addr (
	payment_group_id	varchar(40)	not null,
	prefix	nvarchar(40)	null,
	first_name	nvarchar(40)	null,
	middle_name	nvarchar(40)	null,
	last_name	nvarchar(40)	null,
	suffix	nvarchar(40)	null,
	job_title	nvarchar(40)	null,
	company_name	nvarchar(40)	null,
	address_1	nvarchar(50)	null,
	address_2	nvarchar(50)	null,
	address_3	nvarchar(50)	null,
	city	nvarchar(40)	null,
	county	nvarchar(40)	null,
	state	nvarchar(40)	null,
	postal_code	nvarchar(10)	null,
	country	nvarchar(40)	null,
	phone_number	nvarchar(40)	null,
	fax_number	nvarchar(40)	null,
	email	nvarchar(255)	null
,constraint dcspp_bill_addr_p primary key (payment_group_id)
,constraint dcspp_bipaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id))


create table dcspp_pay_status (
	status_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	trans_id	varchar(50)	null,
	amount	numeric(19,7)	null,
	trans_success	numeric(1,0)	null,
	error_message	varchar(254)	null,
	trans_timestamp	datetime	null
,constraint dcspp_pay_status_p primary key (status_id)
,constraint dcspp_pay_status_c check (trans_success IN (0,1)))


create table dcspp_cc_status (
	status_id	varchar(40)	not null,
	auth_expiration	datetime	null,
	avs_code	varchar(40)	null,
	avs_desc_result	varchar(254)	null,
	integration_data	varchar(256)	null
,constraint dcspp_cc_status_p primary key (status_id)
,constraint dcspp_ccstats_d_f foreign key (status_id) references dcspp_pay_status (status_id))


create table dcspp_gc_status (
	status_id	varchar(40)	not null,
	auth_expiration	datetime	null
,constraint dcspp_gc_status_p primary key (status_id)
,constraint dcspp_gcstats_d_f foreign key (status_id) references dcspp_pay_status (status_id))


create table dcspp_sc_status (
	status_id	varchar(40)	not null,
	auth_expiration	datetime	null
,constraint dcspp_sc_status_p primary key (status_id)
,constraint dcspp_scstats_d_f foreign key (status_id) references dcspp_pay_status (status_id))


create table dcspp_auth_status (
	payment_group_id	varchar(40)	not null,
	auth_status	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_auth_statu_p primary key (payment_group_id,sequence_num)
,constraint dcspp_atpaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id))

create index auth_stat_pgid_idx on dcspp_auth_status (payment_group_id)

create table dcspp_debit_status (
	payment_group_id	varchar(40)	not null,
	debit_status	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_debit_stat_p primary key (payment_group_id,sequence_num)
,constraint dcspp_depaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id))

create index debit_stat_pgi_idx on dcspp_debit_status (payment_group_id)

create table dcspp_cred_status (
	payment_group_id	varchar(40)	not null,
	credit_status	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_cred_statu_p primary key (payment_group_id,sequence_num)
,constraint dcspp_crpaymntgr_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id))

create index cred_stat_pgid_idx on dcspp_cred_status (payment_group_id)

create table dcspp_shipitem_rel (
	relationship_id	varchar(40)	not null,
	shipping_group_id	varchar(40)	null,
	commerce_item_id	varchar(40)	null,
	quantity	numeric(19,0)	null,
	quantity_with_fraction	numeric(19,7)	null,
	returned_qty	numeric(19,0)	null,
	returned_qty_with_fraction	numeric(19,7)	null,
	amount	numeric(19,7)	null,
	state	varchar(40)	null,
	state_detail	varchar(254)	null
,constraint dcspp_shipitem_r_p primary key (relationship_id)
,constraint dcspp_shreltnshp_f foreign key (relationship_id) references dcspp_relationship (relationship_id))

create index sirel_item_idx on dcspp_shipitem_rel (commerce_item_id)
create index sirel_shipgrp_idx on dcspp_shipitem_rel (shipping_group_id)

create table dcspp_rel_range (
	relationship_id	varchar(40)	not null,
	low_bound	integer	null,
	low_bound_with_fraction	numeric(19,7)	null,
	high_bound	integer	null,
	high_bound_with_fraction	numeric(19,7)	null
,constraint dcspp_rel_range_p primary key (relationship_id))


create table dcspp_payitem_rel (
	relationship_id	varchar(40)	not null,
	payment_group_id	varchar(40)	null,
	commerce_item_id	varchar(40)	null,
	quantity	numeric(19,0)	null,
	quantity_with_fraction	numeric(19,7)	null,
	amount	numeric(19,7)	null
,constraint dcspp_payitem_re_p primary key (relationship_id)
,constraint dcspp_pareltnshp_f foreign key (relationship_id) references dcspp_relationship (relationship_id))

create index pirel_item_idx on dcspp_payitem_rel (commerce_item_id)
create index pirel_paygrp_idx on dcspp_payitem_rel (payment_group_id)

create table dcspp_payship_rel (
	relationship_id	varchar(40)	not null,
	payment_group_id	varchar(40)	null,
	shipping_group_id	varchar(40)	null,
	amount	numeric(19,7)	null
,constraint dcspp_payship_re_p primary key (relationship_id)
,constraint dcspp_pshrltnshp_f foreign key (relationship_id) references dcspp_relationship (relationship_id))

create index psrel_paygrp_idx on dcspp_payship_rel (payment_group_id)
create index psrel_shipgrp_idx on dcspp_payship_rel (shipping_group_id)

create table dcspp_payorder_rel (
	relationship_id	varchar(40)	not null,
	payment_group_id	varchar(40)	null,
	order_id	varchar(40)	null,
	amount	numeric(19,7)	null
,constraint dcspp_payorder_r_p primary key (relationship_id)
,constraint dcspp_odreltnshp_f foreign key (relationship_id) references dcspp_relationship (relationship_id))

create index porel_order_idx on dcspp_payorder_rel (order_id)
create index porel_paygrp_idx on dcspp_payorder_rel (payment_group_id)

create table dcspp_amount_info (
	amount_info_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	currency_code	varchar(10)	null,
	amount	numeric(19,7)	null,
	discounted	numeric(1,0)	null,
	amount_is_final	numeric(1,0)	null,
	final_rc	integer	null
,constraint dcspp_amount_inf_p primary key (amount_info_id)
,constraint dcspp_amount_in1_c check (discounted IN (0,1))
,constraint dcspp_amount_in2_c check (amount_is_final IN (0,1)))


create table dcspp_order_price (
	amount_info_id	varchar(40)	not null,
	raw_subtotal	numeric(19,7)	null,
	tax	numeric(19,7)	null,
	shipping	numeric(19,7)	null,
	manual_adj_total	numeric(19,7)	null
,constraint dcspp_order_pric_p primary key (amount_info_id)
,constraint dcspp_oramnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id))


create table dcspp_item_price (
	amount_info_id	varchar(40)	not null,
	list_price	numeric(19,7)	null,
	raw_total_price	numeric(19,7)	null,
	sale_price	numeric(19,7)	null,
	on_sale	numeric(1,0)	null,
	order_discount	numeric(19,7)	null,
	qty_discounted	numeric(19,0)	null,
	qty_with_fraction_discounted	numeric(19,7)	null,
	qty_as_qualifier	numeric(19,0)	null,
	qty_with_fraction_as_qualifier	numeric(19,7)	null,
	price_list	varchar(40)	null,
	discountable	tinyint	null
,constraint dcspp_item_price_p primary key (amount_info_id)
,constraint dcspp_itamnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id)
,constraint dcspp_item_price_c check (on_sale IN (0,1)))


create table dcspp_tax_price (
	amount_info_id	varchar(40)	not null,
	city_tax	numeric(19,7)	null,
	county_tax	numeric(19,7)	null,
	state_tax	numeric(19,7)	null,
	country_tax	numeric(19,7)	null
,constraint dcspp_tax_price_p primary key (amount_info_id)
,constraint dcspp_taamnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id))


create table dcspp_ship_price (
	amount_info_id	varchar(40)	not null,
	raw_shipping	numeric(19,7)	null
,constraint dcspp_ship_price_p primary key (amount_info_id)
,constraint dcspp_shamnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id))


create table dcspp_amtinfo_adj (
	amount_info_id	varchar(40)	not null,
	adjustments	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_amtinfo_ad_p primary key (amount_info_id,sequence_num)
,constraint dcspp_amamnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id))

create index amtinf_adj_aid_idx on dcspp_amtinfo_adj (amount_info_id)
create index amtinf_adj_adj_idx on dcspp_amtinfo_adj (adjustments)

create table dcspp_price_adjust (
	adjustment_id	varchar(40)	not null,
	version	integer	not null,
	adj_description	varchar(254)	null,
	pricing_model	varchar(40)	null,
	pricing_model_index	integer	null,
	pricing_model_group_index	integer	null,
	manual_adjustment	varchar(40)	null,
	coupon_id	varchar(40)	null,
	adjustment	numeric(19,7)	null,
	qty_adjusted	integer	null,
	qty_with_fraction_adjusted	numeric(19,7)	null
,constraint dcspp_price_adju_p primary key (adjustment_id))


create table dcspp_shipitem_sub (
	amount_info_id	varchar(40)	not null,
	shipping_group_id	varchar(42)	not null,
	ship_item_subtotal	varchar(40)	not null
,constraint dcspp_shipitem_s_p primary key (amount_info_id,shipping_group_id)
,constraint dcspp_sbamnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id))

create index ship_item_sub_idx on dcspp_shipitem_sub (amount_info_id)

create table dcspp_taxshipitem (
	amount_info_id	varchar(40)	not null,
	shipping_group_id	varchar(42)	not null,
	tax_ship_item_sub	varchar(40)	not null
,constraint dcspp_taxshipite_p primary key (amount_info_id,shipping_group_id)
,constraint dcspp_shamntxnfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id))

create index tax_ship_item_idx on dcspp_taxshipitem (amount_info_id)

create table dcspp_ntaxshipitem (
	amount_info_id	varchar(40)	not null,
	shipping_group_id	varchar(42)	not null,
	non_tax_item_sub	varchar(40)	not null
,constraint dcspp_ntaxshipit_p primary key (amount_info_id,shipping_group_id)
,constraint dcspp_ntamnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id))

create index ntax_ship_item_idx on dcspp_ntaxshipitem (amount_info_id)

create table dcspp_shipitem_tax (
	amount_info_id	varchar(40)	not null,
	shipping_group_id	varchar(42)	not null,
	ship_item_tax	varchar(40)	not null
,constraint dcspp_shipitem_t_p primary key (amount_info_id,shipping_group_id)
,constraint dcspp_txamnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id))

create index ship_item_tax_idx on dcspp_shipitem_tax (amount_info_id)

create table dcspp_itmprice_det (
	amount_info_id	varchar(40)	not null,
	cur_price_details	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_itmprice_d_p primary key (amount_info_id,sequence_num)
,constraint dcspp_sbamntnfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id))

create index itmprc_det_aii_idx on dcspp_itmprice_det (amount_info_id)

create table dcspp_det_price (
	amount_info_id	varchar(40)	not null,
	tax	numeric(19,7)	null,
	order_discount	numeric(19,7)	null,
	order_manual_adj	numeric(19,7)	null,
	quantity	numeric(19,0)	null,
	quantity_with_fraction	numeric(19,7)	null,
	qty_as_qualifier	numeric(19,0)	null,
	qty_with_fraction_as_qualifier	numeric(19,7)	null
,constraint dcspp_det_price_p primary key (amount_info_id))


create table dcspp_det_range (
	amount_info_id	varchar(40)	not null,
	low_bound	integer	null,
	low_bound_with_fraction	numeric(19,7)	null,
	high_bound	integer	null,
	high_bound_with_fraction	numeric(19,7)	null
,constraint dcspp_det_range_p primary key (amount_info_id))


create table dcspp_order_adj (
	order_id	varchar(40)	not null,
	adjustment_id	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_order_adj_p primary key (order_id,sequence_num)
,constraint dcspp_oradj_d_f foreign key (order_id) references dcspp_order (order_id))

create index order_adj_orid_idx on dcspp_order_adj (order_id)

create table dcspp_quote_info (
	quote_info_id	varchar(40)	not null,
	request_date	datetime	null,
	expiration_date	datetime	null,
	rejection_date	datetime	null,
	requester_note	varchar(255)	null,
	provider_note	varchar(255)	null,
	rejection_note	varchar(255)	null,
	external_id	varchar(40)	null,
	agent_id	varchar(40)	null,
	version	integer	not null
,constraint dcspp_quote_info_p primary key (quote_info_id))


create table dcspp_manual_adj (
	manual_adjust_id	varchar(40)	not null,
	type	integer	not null,
	adjustment_type	integer	not null,
	reason	integer	not null,
	amount	numeric(19,7)	null,
	notes	varchar(255)	null,
	version	integer	not null
,constraint dcspp_manual_adj_p primary key (manual_adjust_id))


create table dbcpp_sched_order (
	scheduled_order_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	name	varchar(32)	null,
	profile_id	varchar(40)	null,
	create_date	datetime	null,
	start_date	datetime	null,
	end_date	datetime	null,
	template_order	varchar(32)	null,
	state	integer	null,
	next_scheduled	datetime	null,
	schedule	varchar(255)	null,
	site_id	varchar(40)	null
,constraint dbcpp_sched_orde_p primary key (scheduled_order_id))

create index sched_tmplt_idx on dbcpp_sched_order (template_order)
create index sched_profile_idx on dbcpp_sched_order (profile_id)
create index sched_site_idx on dbcpp_sched_order (site_id)

create table dbcpp_sched_clone (
	scheduled_order_id	varchar(40)	not null,
	cloned_order	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dbcpp_sched_clon_p primary key (scheduled_order_id,sequence_num)
,constraint dbcpp_scschedld__f foreign key (scheduled_order_id) references dbcpp_sched_order (scheduled_order_id))


create table dcspp_scherr_aux (
	scheduled_order_id	varchar(40)	not null,
	sched_error_id	varchar(40)	not null
,constraint dcspp_scherr_aux_p primary key (scheduled_order_id))

create index sched_error_idx on dcspp_scherr_aux (sched_error_id)

create table dcspp_sched_error (
	sched_error_id	varchar(40)	not null,
	error_date	datetime	not null
,constraint dcspp_sched_err_p primary key (sched_error_id))


create table dcspp_schd_errmsg (
	sched_error_id	varchar(40)	not null,
	error_txt	varchar(254)	not null,
	sequence_num	integer	not null
,constraint dcspp_schd_errs_p primary key (sched_error_id,sequence_num)
,constraint dcspp_sch_errs_f foreign key (sched_error_id) references dcspp_sched_error (sched_error_id))


create table dbcpp_approverids (
	order_id	varchar(40)	not null,
	approver_ids	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dbcpp_approverid_p primary key (order_id,sequence_num)
,constraint dbcpp_apordr_d_f foreign key (order_id) references dcspp_order (order_id))


create table dbcpp_authapprids (
	order_id	varchar(40)	not null,
	auth_appr_ids	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dbcpp_authapprid_p primary key (order_id,sequence_num)
,constraint dbcpp_atordr_d_f foreign key (order_id) references dcspp_order (order_id))


create table dbcpp_apprsysmsgs (
	order_id	varchar(40)	not null,
	appr_sys_msgs	varchar(254)	not null,
	sequence_num	integer	not null
,constraint dbcpp_apprsysmsg_p primary key (order_id,sequence_num)
,constraint dbcpp_sysmordr_d_f foreign key (order_id) references dcspp_order (order_id))


create table dbcpp_appr_msgs (
	order_id	varchar(40)	not null,
	approver_msgs	varchar(254)	not null,
	sequence_num	integer	not null
,constraint dbcpp_appr_msgs_p primary key (order_id,sequence_num)
,constraint dbcpp_msgordr_d_f foreign key (order_id) references dcspp_order (order_id))


create table dbcpp_invoice_req (
	payment_group_id	varchar(40)	not null,
	po_number	varchar(40)	null,
	pref_format	varchar(40)	null,
	pref_delivery	varchar(40)	null,
	disc_percent	numeric(19,7)	null,
	disc_days	integer	null,
	net_days	integer	null,
	pmt_due_date	datetime	null
,constraint dbcpp_invoice_re_p primary key (payment_group_id)
,constraint dbcpp_inpaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id))


create table dbcpp_cost_center (
	cost_center_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	costctr_class_type	varchar(40)	null,
	identifier	varchar(40)	null,
	amount	numeric(19,7)	null,
	order_ref	varchar(40)	null
,constraint dbcpp_cost_cente_p primary key (cost_center_id))


create table dbcpp_order_cc (
	order_id	varchar(40)	not null,
	cost_centers	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dbcpp_order_cc_p primary key (order_id,sequence_num)
,constraint dbcpp_orordr_d_f foreign key (order_id) references dcspp_order (order_id))

create index order_cc_ordid_idx on dbcpp_order_cc (order_id)

create table dbcpp_ccitem_rel (
	relationship_id	varchar(40)	not null,
	cost_center_id	varchar(40)	null,
	commerce_item_id	varchar(40)	null,
	quantity	numeric(19,0)	null,
	quantity_with_fraction	numeric(19,7)	null,
	amount	numeric(19,7)	null
,constraint dbcpp_ccitem_rel_p primary key (relationship_id)
,constraint dbcpp_ccreltnshp_f foreign key (relationship_id) references dcspp_relationship (relationship_id))

create index cirel_cstctr_idx on dbcpp_ccitem_rel (cost_center_id)
create index cirel_item_idx on dbcpp_ccitem_rel (commerce_item_id)

create table dbcpp_ccship_rel (
	relationship_id	varchar(40)	not null,
	cost_center_id	varchar(40)	null,
	shipping_group_id	varchar(40)	null,
	amount	numeric(19,7)	null
,constraint dbcpp_ccship_rel_p primary key (relationship_id)
,constraint dbcpp_shreltnshp_f foreign key (relationship_id) references dcspp_relationship (relationship_id))

create index csrel_cstctr_idx on dbcpp_ccship_rel (cost_center_id)
create index csrel_shipgrp_idx on dbcpp_ccship_rel (shipping_group_id)

create table dbcpp_ccorder_rel (
	relationship_id	varchar(40)	not null,
	cost_center_id	varchar(40)	null,
	order_id	varchar(40)	null,
	amount	numeric(19,7)	null
,constraint dbcpp_ccorder_re_p primary key (relationship_id)
,constraint dbcpp_odreltnshp_f foreign key (relationship_id) references dcspp_relationship (relationship_id))

create index corel_cstctr_idx on dbcpp_ccorder_rel (cost_center_id)
create index corel_order_idx on dbcpp_ccorder_rel (order_id)

create table dbcpp_pmt_req (
	payment_group_id	varchar(40)	not null,
	req_number	varchar(40)	null
,constraint dbcpp_pmt_req_p primary key (payment_group_id)
,constraint dbcpp_pmpaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id))

create index pmtreq_req_idx on dbcpp_pmt_req (req_number)

create table dcspp_appeasement (
	appeasement_id	varchar(40)	not null,
	order_id	varchar(40)	not null,
	type	varchar(40)	not null,
	status	varchar(40)	null,
	creation_date	datetime	not null,
	agent_id	varchar(40)	null,
	profile_id	varchar(40)	not null,
	origin_of_appeasement	integer	not null,
	reason_code	varchar(40)	not null,
	comments	varchar(254)	null,
	processed	tinyint	null,
	appeasement_amount	numeric(19,7)	not null
,constraint dcs_appeasement_p primary key (appeasement_id))


create table dcspp_appeasement_reasons (
	id	varchar(40)	not null,
	description	varchar(254)	not null
,constraint appeasement_reasons_p primary key (id))


create table dcspp_appeasement_refund (
	id	varchar(40)	not null,
	type	integer	not null,
	amount	numeric(19,7)	null
,constraint appsmt_refund_p primary key (id))


create table dcspp_appeasement_refunds (
	appeasement_id	varchar(40)	not null,
	appeasement_refund_id	varchar(40)	not null
,constraint appsmt_refunds_p primary key (appeasement_id,appeasement_refund_id)
,constraint appeasement_refund_d_f foreign key (appeasement_id) references dcspp_appeasement (appeasement_id)
,constraint appeasement_refund_m_f foreign key (appeasement_refund_id) references dcspp_appeasement_refund (id))

create index appsmt_refund_id on dcspp_appeasement_refunds (appeasement_refund_id)

create table dcspp_appeasement_refund_cc (
	appeasement_refund_id	varchar(40)	not null,
	payment_group_id	varchar(40)	not null
,constraint appsmt_refund_cc_p primary key (appeasement_refund_id)
,constraint appeasement_cc_m_f foreign key (appeasement_refund_id) references dcspp_appeasement_refund (id))


create table dcspp_appeasement_refund_sc (
	appeasement_refund_id	varchar(40)	not null,
	payment_group_id	varchar(40)	null,
	sc_id	varchar(40)	null
,constraint appsmt_refund_sc_p primary key (appeasement_refund_id)
,constraint appeasement_sc_m_f foreign key (appeasement_refund_id) references dcspp_appeasement_refund (id))



go

-- the source for this section is 
-- dcs_mappers.sql





create table dcs_cart_event (
	id	varchar(40)	not null,
	timestamp	datetime	null,
	orderid	varchar(40)	null,
	itemid	varchar(40)	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	quantity	integer	null,
	amount	money	null,
	profileid	varchar(40)	null)


create table dcs_submt_ord_evt (
	id	varchar(40)	not null,
	clocktime	datetime	null,
	orderid	varchar(40)	null,
	profileid	varchar(40)	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null)


create table dcs_prom_used_evt (
	id	varchar(40)	not null,
	clocktime	datetime	null,
	orderid	varchar(40)	null,
	profileid	varchar(40)	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	promotionid	varchar(40)	null,
	order_amount	numeric(26,7)	null,
	discount	numeric(26,7)	null)


create table dcs_ord_merge_evt (
	id	varchar(40)	not null,
	clocktime	datetime	null,
	sourceorderid	varchar(40)	null,
	destorderid	varchar(40)	null,
	profileid	varchar(40)	null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null,
	sourceremoved	tinyint	null
,constraint dcs_ordmergeevt_ck check (sourceremoved in (0,1)))


create table dcs_promo_rvkd (
	id	varchar(40)	not null,
	time_stamp	datetime	null,
	promotionid	varchar(254)	not null,
	profileid	varchar(254)	not null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null)


create table dcs_promo_grntd (
	id	varchar(40)	not null,
	time_stamp	datetime	null,
	promotionid	varchar(254)	not null,
	profileid	varchar(254)	not null,
	sessionid	varchar(100)	null,
	parentsessionid	varchar(100)	null)



go

-- the source for this section is 
-- order_returns_ddl.sql





create table csr_exch (
	id	varchar(40)	not null,
	order_id	varchar(40)	not null,
	created_date	datetime	not null,
	status	varchar(40)	not null,
	rma	varchar(40)	null,
	repl_order_id	varchar(40)	null,
	bal_pmt_id	varchar(40)	null,
	sugg_tax_refund	numeric(19,7)	not null,
	actl_tax_refund	numeric(19,7)	not null,
	sugg_ship_refund	numeric(19,7)	not null,
	actl_ship_refund	numeric(19,7)	not null,
	other_refund	numeric(19,7)	not null,
	sc_recipient	varchar(40)	null,
	proc_immed	numeric(1,0)	not null,
	processed	numeric(1,0)	not null,
	origin_of_return	integer	not null,
	agent_id	varchar(40)	null
,constraint csr_exch_p primary key (id)
,constraint csr_exchordr_d_f foreign key (order_id) references dcspp_order (order_id)
,constraint csr_exch1_c check (proc_immed in (0,1))
,constraint csr_exch2_c check (processed in (0,1)))

create index csr_exchorder_id on csr_exch (order_id)

create table csr_exch_cmts (
	comment_id	varchar(40)	not null,
	return_id	varchar(40)	not null,
	agent_id	varchar(40)	null,
	comment_data	varchar(254)	not null,
	creation_date	datetime	null,
	version	integer	not null
,constraint csrexchcmmt_p primary key (comment_id,return_id)
,constraint csrexchcmmt_f foreign key (return_id) references csr_exch (id))

create index csrexchcmmt1_x on csr_exch_cmts (return_id)

create table csr_exch_reasons (
	id	varchar(40)	not null,
	description	varchar(254)	not null
,constraint csr_exch_reasons_p primary key (id))


create table csr_exch_item_disp (
	id	varchar(40)	not null,
	description	varchar(254)	not null,
	upd_inventory	numeric(1,0)	not null
,constraint csr_exchitem_dis_p primary key (id)
,constraint csr_exchitem_dis_c check (upd_inventory in (0,1)))


create table csr_return_fee (
	exchange_id	varchar(40)	not null,
	return_fee	numeric(19,7)	not null
,constraint csr_return_fee_p primary key (exchange_id)
,constraint csr_rfexchng_d_f foreign key (exchange_id) references csr_exch (id))


create table csr_exch_item (
	id	varchar(40)	not null,
	commerce_item_id	varchar(40)	not null,
	shipping_group_id	varchar(40)	not null,
	quantity_to_return	numeric(19,0)	not null,
	qty_with_fraction_to_return	numeric(19,7)	null,
	quantity_to_repl	numeric(19,0)	not null,
	qty_with_fraction_to_repl	numeric(19,7)	null,
	reason	varchar(40)	not null,
	ret_shipment_req	numeric(1,0)	not null,
	quantity_received	numeric(19,0)	not null,
	qty_with_fraction_received	numeric(19,7)	null,
	disposition	varchar(40)	null,
	refund_amount	numeric(19,7)	not null,
	status	varchar(40)	not null,
	exch_ref	varchar(40)	not null,
	sugg_ship_refund	numeric(19,7)	not null,
	actl_ship_refund	numeric(19,7)	not null,
	sugg_tax_refund	numeric(19,7)	not null,
	actl_tax_refund	numeric(19,7)	not null
,constraint csr_exch_item_p primary key (id)
,constraint csr_exchtmdspstn_f foreign key (disposition) references csr_exch_item_disp (id)
,constraint csr_exchtmresn_f foreign key (reason) references csr_exch_reasons (id)
,constraint csr_exchtshippng_f foreign key (shipping_group_id) references dcspp_ship_group (shipping_group_id)
,constraint csr_exch_item1_c check (ret_shipment_req in (0,1)))

create index csr_exch_itemdisp on csr_exch_item (disposition)
create index csr_exch_itmreason on csr_exch_item (reason)
create index csr_exch_itmshpgrp on csr_exch_item (shipping_group_id)

create table csr_exch_items (
	exchange_id	varchar(40)	not null,
	exchange_item_id	varchar(40)	not null
,constraint csr_exch_items_p primary key (exchange_id,exchange_item_id)
,constraint csr_exchtxchng_d_f foreign key (exchange_id) references csr_exch (id)
,constraint csr_exchtxchng_t_f foreign key (exchange_item_id) references csr_exch_item (id))

create index csr_exch_exch_itm on csr_exch_items (exchange_item_id)

create table csr_exch_method (
	id	varchar(40)	not null,
	type	integer	not null,
	amount	numeric(19,7)	null
,constraint csr_exch_method_p primary key (id))


create table csr_exch_methods (
	exchange_id	varchar(40)	not null,
	exchange_method_id	varchar(40)	not null
,constraint csr_exch_methods_p primary key (exchange_id,exchange_method_id)
,constraint csr_exchmxchng_d_f foreign key (exchange_id) references csr_exch (id)
,constraint csr_exchmxchng_m_f foreign key (exchange_method_id) references csr_exch_method (id))

create index csr_exch_method_id on csr_exch_methods (exchange_method_id)

create table csr_cc_exch_method (
	exchange_method_id	varchar(40)	not null,
	payment_group_id	varchar(40)	not null
,constraint csr_cc_exch_mthd_p primary key (exchange_method_id)
,constraint csr_ccexcxchng_m_f foreign key (exchange_method_id) references csr_exch_method (id))


create table csr_sc_exch_method (
	exchange_method_id	varchar(40)	not null,
	payment_group_id	varchar(40)	null,
	sc_id	varchar(40)	null
,constraint csr_sc_exch_mthd_p primary key (exchange_method_id)
,constraint csr_scexcxchng_m_f foreign key (exchange_method_id) references csr_exch_method (id))


create table csr_exch_ipromos (
	exchange_id	varchar(40)	not null,
	promotion_id	varchar(40)	not null
,constraint csrexchipromos_p primary key (exchange_id,promotion_id)
,constraint csr_ex_ipromos_f foreign key (exchange_id) references csr_exch (id))


create table csr_exch_opromos (
	exchange_id	varchar(40)	not null,
	promotion_id	varchar(40)	not null
,constraint csrexchopromos_p primary key (exchange_id,promotion_id)
,constraint csr_ex_opromos_f foreign key (exchange_id) references csr_exch (id))


create table csr_promo_adjust (
	exchange_id	varchar(40)	not null,
	promotion_id	varchar(40)	not null,
	value_adjust	numeric(19,7)	not null
,constraint csrpromoadjust_p primary key (exchange_id,promotion_id)
,constraint csr_promo_adj_f foreign key (exchange_id) references csr_exch (id))


create table csr_nonreturn_adj (
	exchange_id	varchar(40)	not null,
	ica_id	varchar(40)	not null
,constraint csr_nr_adj_p primary key (exchange_id,ica_id)
,constraint csr_nr_adj_f foreign key (exchange_id) references csr_exch (id))


create table csr_item_adj (
	ica_id	varchar(40)	not null,
	type	integer	null,
	commerce_item_id	varchar(40)	null,
	shipping_group_id	varchar(40)	null,
	quantity_adj	numeric(19,0)	not null,
	quantity_with_fraction_adj	numeric(19,7)	null,
	amount_adj	numeric(19,7)	null,
	ods_adj	numeric(19,7)	null,
	mas_adj	numeric(19,7)	null,
	tax_adj	numeric(19,7)	null,
	shipping_adj	numeric(19,7)	null
,constraint csritemadj_p primary key (ica_id))



go

-- the source for this section is 
-- versioned_claimable_ddl.sql





create table dcspp_claimable (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	claimable_id	varchar(40)	not null,
	version	integer	not null,
	type	integer	not null,
	status	integer	null,
	start_date	datetime	null,
	expiration_date	datetime	null,
	last_modified	datetime	null
,constraint dcspp_claimable_p primary key (claimable_id,asset_version))

create index dcspp_claimabl_wsx on dcspp_claimable (workspace_id)
create index dcspp_claimabl_cix on dcspp_claimable (checkin_date)

create table dcspp_giftcert (
	asset_version	numeric(19)	not null,
	giftcertificate_id	varchar(40)	not null,
	amount	numeric(19,7)	not null,
	amount_authorized	numeric(19,7)	not null,
	amount_remaining	numeric(19,7)	not null,
	purchaser_id	varchar(40)	null,
	purchase_date	datetime	null,
	last_used	datetime	null
,constraint dcspp_giftcert_p primary key (giftcertificate_id,asset_version))

create index claimable_user_idx on dcspp_giftcert (purchaser_id)

create table dcs_storecred_clm (
	asset_version	numeric(19)	not null,
	store_credit_id	varchar(40)	not null,
	amount	numeric(19,7)	not null,
	amount_authorized	numeric(19,7)	not null,
	amount_remaining	numeric(19,7)	not null,
	owner_id	varchar(40)	null,
	issue_date	datetime	null,
	expiration_date	datetime	null,
	last_used	datetime	null
,constraint dcs_storecred_cl_p primary key (store_credit_id,asset_version))

create index storecr_issue_idx on dcs_storecred_clm (issue_date)
create index storecr_owner_idx on dcs_storecred_clm (owner_id)

create table dcspp_cp_folder (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	folder_id	varchar(40)	not null,
	name	varchar(254)	not null,
	parent_folder	varchar(40)	null
,constraint dcspp_cp_folder_p primary key (folder_id,asset_version))

create index dcspp_cp_folde_wsx on dcspp_cp_folder (workspace_id)
create index dcspp_cp_folde_cix on dcspp_cp_folder (checkin_date)

create table dcspp_coupon (
	asset_version	numeric(19)	not null,
	coupon_id	varchar(40)	not null,
	promotion_id	varchar(40)	not null
,constraint dcspp_coupon_p primary key (coupon_id,promotion_id,asset_version))


create table dcspp_coupon_info (
	asset_version	numeric(19)	not null,
	coupon_id	varchar(40)	not null,
	display_name	varchar(254)	null,
	use_promo_site	integer	null,
	parent_folder	varchar(40)	null,
	max_uses	integer	null,
	uses	integer	null
,constraint dcspp_copninfo_p primary key (coupon_id,asset_version))


create table dcspp_coupon_batch (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	code_prefix	varchar(40)	not null,
	number_of_coupons	integer	null,
	seed_value	image	null,
	codes_generated	numeric(1,0)	not null
,constraint dcspp_batch_cp_pk primary key (id,asset_version))


create table dcspp_batch_claimable (
	asset_version	numeric(19)	not null,
	coupon_id	varchar(40)	not null,
	coupon_batch	varchar(40)	null
,constraint dcs_batch_claim_pk primary key (coupon_id,asset_version))



go

-- the source for this section is 
-- versioned_priceLists_ddl.sql





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

-- the source for this section is 
-- versioned_commerce_site_ddl.sql




-- This file contains create table statements, which will configureyour database for use MultiSite

create table dcs_site (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	catalog_id	varchar(40)	null,
	list_pricelist_id	varchar(40)	null,
	sale_pricelist_id	varchar(40)	null,
	max_num_coupons	integer	null,
	max_num_coupons_per_order	integer	null
,constraint dcs_site_p primary key (id,asset_version))



go

-- the source for this section is 
-- order_markers_ddl.sql





create table dcs_order_markers (
	marker_id	varchar(40)	not null,
	order_id	varchar(40)	not null,
	marker_key	varchar(100)	not null,
	marker_value	varchar(100)	null,
	marker_data	varchar(100)	null,
	creation_date	datetime	null,
	version	integer	not null,
	marker_type	integer	null
,constraint dcsordermarkers_p primary key (marker_id,order_id)
,constraint dcsordermarkers_f foreign key (order_id) references dcspp_order (order_id))

create index dcs_ordrmarkers1_x on dcs_order_markers (order_id)

create table dcs_gwp_order_markers (
	marker_id	varchar(40)	not null,
	order_id	varchar(40)	not null,
	marker_key	varchar(100)	not null,
	marker_value	varchar(100)	null,
	marker_data	varchar(100)	null,
	creation_date	datetime	null,
	version	integer	not null,
	marker_type	integer	null,
	gift_type	varchar(100)	not null,
	gift_detail	text	not null,
	auto_remove	tinyint	not null,
	quantity	integer	not null,
	quantity_with_fraction	numeric(19,7)	not null,
	targeted_quantity	integer	not null,
	targeted_qty_with_fraction	numeric(19,7)	not null,
	automatic_quantity	integer	not null,
	automatic_qty_with_fraction	numeric(19,7)	not null,
	selected_quantity	integer	not null,
	selected_qty_with_fraction	numeric(19,7)	not null,
	removed_quantity	integer	not null,
	removed_qty_with_fraction	numeric(19,7)	not null,
	failed_quantity	integer	not null,
	failed_qty_with_fraction	numeric(19,7)	not null
,constraint dcsgwpomarkers_p primary key (marker_id)
,constraint dcsgwpomarkers_f foreign key (order_id) references dcspp_order (order_id))

create index dcs_gwpomarkers1_x on dcs_gwp_order_markers (order_id)

create table dcspp_commerce_item_markers (
	marker_id	varchar(40)	not null,
	commerce_item_id	varchar(40)	not null,
	marker_key	varchar(100)	not null,
	marker_value	varchar(100)	null,
	marker_data	varchar(100)	null,
	creation_date	datetime	null,
	version	integer	not null,
	marker_type	integer	null
,constraint dcscitemmarkers_p primary key (marker_id,commerce_item_id)
,constraint dcscitemmarkers_f foreign key (commerce_item_id) references dcspp_item (commerce_item_id))

create index dcs_itemmarkers1_x on dcspp_commerce_item_markers (commerce_item_id)

create table dcspp_gwp_item_markers (
	marker_id	varchar(40)	not null,
	commerce_item_id	varchar(40)	not null,
	marker_key	varchar(100)	not null,
	marker_value	varchar(100)	null,
	marker_data	varchar(100)	null,
	creation_date	datetime	null,
	version	integer	not null,
	marker_type	integer	null,
	targeted_quantity	integer	not null,
	targeted_qty_with_fraction	numeric(19,7)	not null,
	automatic_quantity	integer	not null,
	automatic_qty_with_fraction	numeric(19,7)	not null,
	selected_quantity	integer	not null,
	selected_qty_with_fraction	numeric(19,7)	not null,
	remaining_quantity	integer	not null,
	remaining_qty_with_fraction	numeric(19,7)	not null
,constraint dcsgwpimarkers_p primary key (marker_id)
,constraint dcsgwpimarkers_f foreign key (commerce_item_id) references dcspp_item (commerce_item_id))

create index dcs_gwpimarkers1_x on dcspp_gwp_item_markers (commerce_item_id)


go

-- the source for this section is 
-- versioned_dcs_content_mgmt_ddl.sql




-- This file contains create table statements, which will configure your database for use with the Content Management schema.

create table dcs_wcm_media_rltd_prod (
	asset_version	numeric(19)	not null,
	media_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_product_id	varchar(40)	not null
,constraint wcm_media_rltd_product_p primary key (media_id,sequence_num,asset_version))


create table dcs_wcm_media_rltd_ctgy (
	asset_version	numeric(19)	not null,
	media_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_category_id	varchar(40)	not null
,constraint wcm_media_rltd_category_p primary key (media_id,sequence_num,asset_version))


create table dcs_wcm_article_rltd_prod (
	asset_version	numeric(19)	not null,
	article_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_product_id	varchar(40)	not null
,constraint wcm_article_rltd_product_p primary key (article_id,sequence_num,asset_version))


create table dcs_wcm_article_rltd_ctgy (
	asset_version	numeric(19)	not null,
	article_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_category_id	varchar(40)	not null
,constraint wcm_article_rltd_category_p primary key (article_id,sequence_num,asset_version))



go

-- the source for this section is 
-- versioned_dcs_backing_maps_ddl.sql




-- Tables for backing maps for item descriptors enables for dynamic properties in product catalog repository

create table dcs_dyn_prop_map_str (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	varchar(400)	null
,constraint dcs_dyn_prop_map_str_p primary key (id,prop_name,asset_version))


create table dcs_dyn_prop_map_big_str (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	text	null
,constraint dcs_dyn_prop_map_big_str_p primary key (id,prop_name,asset_version))


create table dcs_dyn_prop_map_double (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19,7)	null
,constraint dcs_dyn_prop_map_double_p primary key (id,prop_name,asset_version))


create table dcs_dyn_prop_map_long (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19)	null
,constraint dcs_dyn_prop_map_long_p primary key (id,prop_name,asset_version))

-- Tables for backing maps for sku item descriptor

create table dcs_sku_dyn_prop_map_str (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	varchar(400)	null
,constraint dcs_sku_dyn_prop_map_str_p primary key (id,prop_name,asset_version))


create table dcs_sku_dyn_prop_map_big_str (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	text	null
,constraint dcs_sku_dynmc_prp_mp_bg_str_p primary key (id,prop_name,asset_version))


create table dcs_sku_dyn_prop_map_double (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19,7)	null
,constraint dcs_sku_dyn_prp_mp_dbl_p primary key (id,prop_name,asset_version))


create table dcs_sku_dyn_prop_map_long (
	asset_version	numeric(19)	not null,
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19)	null
,constraint dcs_sku_dyn_prp_mp_lng_p primary key (id,prop_name,asset_version))



go

-- the source for this section is 
-- abandoned_order_ddl.sql




-- $Id: //product/DCS/version/11.2/templates/DCS/AbandonedOrderServices/sql/abandoned_order_ddl.xml#1 $

create table dcspp_ord_abandon (
	abandonment_id	varchar(40)	not null,
	version	integer	not null,
	order_id	varchar(40)	not null,
	ord_last_updated	datetime	null,
	abandon_state	varchar(40)	null,
	abandonment_count	integer	null,
	abandonment_date	datetime	null,
	reanimation_date	datetime	null,
	convert_date	datetime	null,
	lost_date	datetime	null
,constraint dcspp_ord_abndn_p primary key (abandonment_id))

create index dcspp_ordabandn1_x on dcspp_ord_abandon (order_id)

create table dcs_user_abandoned (
	id	varchar(40)	not null,
	order_id	varchar(40)	not null,
	profile_id	varchar(40)	not null
,constraint dcs_usr_abndnd_p primary key (id))


create table drpt_conv_order (
	order_id	varchar(40)	not null,
	converted_date	datetime	not null,
	amount	numeric(19,7)	not null,
	promo_count	integer	not null,
	promo_value	numeric(19,7)	not null
,constraint drpt_conv_order_p primary key (order_id))


create table drpt_session_ord (
	dataset_id	varchar(40)	not null,
	order_id	varchar(40)	not null,
	date_time	datetime	not null,
	amount	numeric(19,7)	not null,
	submitted	integer	not null,
	order_persistent	tinyint	null,
	session_id	varchar(40)	null,
	parent_session_id	varchar(40)	null
,constraint drpt_session_ord_p primary key (order_id))



go

-- the source for this section is 
-- abandoned_order_views.sql




create view drpt_abandon_ord
(abandonment_date,amount,converted)
as
      select oa.abandonment_date as abandonment_date, ai.amount as amount, case when oa.abandon_state = 'CONVERTED' then 100 else 0 end as converted from dcspp_order o, dcspp_ord_abandon oa, dcspp_amount_info ai where oa.order_id=o.order_id and o.price_info=ai.amount_info_id
         
go

create view drpt_tns_abndn_ord
(abandonment_date,amount)
as
      select date_time as abandonment_date, amount as amount from drpt_session_ord where submitted=0
         
go



-- the source for this section is 
-- versioned_custom_catalog_ddl.sql





create table dcs_catalog (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	catalog_id	varchar(40)	not null,
	version	integer	not null,
	display_name	varchar(254)	null,
	creation_date	datetime	null,
	last_mod_date	datetime	null,
	migration_status	integer	null,
	migration_index	integer	null,
	item_acl	text	null
,constraint dcs_catalog_p primary key (catalog_id,asset_version))

create index dcs_catalog_wsx on dcs_catalog (workspace_id)
create index dcs_catalog_cix on dcs_catalog (checkin_date)

create table dcs_root_cats (
	sec_asset_version	numeric(19)	not null,
	asset_version	numeric(19)	not null,
	catalog_id	varchar(40)	not null,
	root_cat_id	varchar(40)	not null
,constraint dcs_root_cats_p primary key (catalog_id,root_cat_id,asset_version,sec_asset_version))

create index dcs_rootcatscat_id on dcs_root_cats (root_cat_id)

create table dcs_allroot_cats (
	asset_version	numeric(19)	not null,
	catalog_id	varchar(40)	not null,
	root_cat_id	varchar(40)	not null
,constraint dcs_allroot_cats_p primary key (catalog_id,root_cat_id,asset_version))


create table dcs_root_subcats (
	sec_asset_version	numeric(19)	not null,
	asset_version	numeric(19)	not null,
	catalog_id	varchar(40)	not null,
	sub_catalog_id	varchar(40)	not null
,constraint dcs_root_subcats_p primary key (catalog_id,sub_catalog_id,asset_version,sec_asset_version))


create table dcs_category_info (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	category_info_id	varchar(40)	not null,
	version	integer	not null,
	item_acl	text	null
,constraint dcs_category_inf_p primary key (category_info_id,asset_version))

create index dcs_category_i_wsx on dcs_category_info (workspace_id)
create index dcs_category_i_cix on dcs_category_info (checkin_date)

create table dcs_product_info (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	product_info_id	varchar(40)	not null,
	version	integer	not null,
	parent_cat_id	varchar(40)	null,
	item_acl	text	null
,constraint dcs_product_info_p primary key (product_info_id,asset_version))

create index dcs_product_in_wsx on dcs_product_info (workspace_id)
create index dcs_product_in_cix on dcs_product_info (checkin_date)

create table dcs_sku_info (
	asset_version	numeric(19)	not null,
	workspace_id	varchar(40)	not null,
	branch_id	varchar(40)	not null,
	is_head	tinyint	not null,
	version_deleted	numeric(1)	not null,
	version_editable	numeric(1)	not null,
	pred_version	numeric(19)	null,
	checkin_date	datetime	null,
	sku_info_id	varchar(40)	not null,
	version	integer	not null,
	item_acl	text	null
,constraint dcs_sku_info_p primary key (sku_info_id,asset_version))

create index dcs_sku_info_wsx on dcs_sku_info (workspace_id)
create index dcs_sku_info_cix on dcs_sku_info (checkin_date)

create table dcs_cat_subcats (
	sec_asset_version	numeric(19)	not null,
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_cat_subcats_p primary key (category_id,sequence_num,asset_version,sec_asset_version))

create index dcs_catsubcatlogid on dcs_cat_subcats (catalog_id)

create table dcs_cat_subroots (
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	sub_category_id	varchar(40)	not null
,constraint dcs_cat_subroots_p primary key (category_id,sequence_num,asset_version))


create table dcs_cat_catinfo (
	sec_asset_version	numeric(19)	not null,
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	category_info_id	varchar(40)	not null
,constraint dcs_cat_catinfo_p primary key (category_id,catalog_id,asset_version,sec_asset_version))


create table dcs_catinfo_anc (
	asset_version	numeric(19)	not null,
	category_info_id	varchar(40)	not null,
	anc_cat_id	varchar(40)	not null
,constraint dcs_catinfo_anc_p primary key (category_info_id,anc_cat_id,asset_version))


create table dcs_prd_prdinfo (
	sec_asset_version	numeric(19)	not null,
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	product_info_id	varchar(40)	not null
,constraint dcs_prd_prdinfo_p primary key (product_id,catalog_id,asset_version,sec_asset_version))


create table dcs_prdinfo_rdprd (
	asset_version	numeric(19)	not null,
	product_info_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_prd_id	varchar(40)	not null
,constraint dcs_prdinfo_rdpr_p primary key (product_info_id,sequence_num,asset_version))


create table dcs_prdinfo_anc (
	asset_version	numeric(19)	not null,
	product_info_id	varchar(40)	not null,
	anc_cat_id	varchar(40)	not null
,constraint dcs_prdinfo_anc_p primary key (product_info_id,anc_cat_id,asset_version))


create table dcs_sku_skuinfo (
	sec_asset_version	numeric(19)	not null,
	asset_version	numeric(19)	not null,
	sku_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	sku_info_id	varchar(40)	not null
,constraint dcs_sku_skuinfo_p primary key (sku_id,catalog_id,asset_version,sec_asset_version))


create table dcs_skuinfo_rplc (
	asset_version	numeric(19)	not null,
	sku_info_id	varchar(40)	not null,
	sequence_num	integer	not null,
	replacement	varchar(40)	not null
,constraint dcs_skuinfo_rplc_p primary key (sku_info_id,sequence_num,asset_version))


create table dcs_gen_fol_cat (
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
,constraint dcs_gen_fol_cat_p primary key (folder_id,asset_version))

create index dcs_gen_fol_ca_wsx on dcs_gen_fol_cat (workspace_id)
create index dcs_gen_fol_ca_cix on dcs_gen_fol_cat (checkin_date)

create table dcs_child_fol_cat (
	sec_asset_version	numeric(19)	not null,
	asset_version	numeric(19)	not null,
	folder_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_folder_id	varchar(40)	not null
,constraint dcs_child_fol_ca_p primary key (folder_id,sequence_num,asset_version,sec_asset_version))


create table dcs_catfol_chld (
	sec_asset_version	numeric(19)	not null,
	asset_version	numeric(19)	not null,
	catfol_id	varchar(40)	not null,
	sequence_num	integer	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_catfol_chld_p primary key (catfol_id,sequence_num,asset_version,sec_asset_version))


create table dcs_catfol_sites (
	asset_version	numeric(19)	not null,
	catfol_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_catfl_sites_pk primary key (catfol_id,site_id,asset_version))


create table dcs_dir_anc_ctlgs (
	asset_version	numeric(19)	not null,
	catalog_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_catalog_id	varchar(40)	not null
,constraint dcs_dirancctlgs_pk primary key (catalog_id,sequence_num,asset_version))


create table dcs_ind_anc_ctlgs (
	asset_version	numeric(19)	not null,
	catalog_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_catalog_id	varchar(40)	not null
,constraint dcs_indancctlgs_pk primary key (catalog_id,sequence_num,asset_version))


create table dcs_ctlg_anc_cats (
	asset_version	numeric(19)	not null,
	catalog_id	varchar(40)	not null,
	sequence_num	integer	not null,
	category_id	varchar(40)	not null
,constraint dcs_ctlganccats_pk primary key (catalog_id,sequence_num,asset_version))


create table dcs_cat_anc_cats (
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_category_id	varchar(40)	not null
,constraint dcs_cat_anccats_pk primary key (category_id,sequence_num,asset_version))


create table dcs_cat_prnt_cats (
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	parent_ctgy_id	varchar(40)	not null
,constraint dcs_catprntcats_pk primary key (category_id,catalog_id,asset_version))


create table dcs_prd_prnt_cats (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	category_id	varchar(40)	not null
,constraint dcs_prdprntcats_pk primary key (product_id,catalog_id,asset_version))


create table dcs_prd_anc_cats (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	category_id	varchar(40)	not null
,constraint dcs_prdanc_cats_pk primary key (product_id,sequence_num,asset_version))


create table dcs_cat_catalogs (
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_cat_catalgs_pk primary key (category_id,catalog_id,asset_version))


create table dcs_prd_catalogs (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_prd_catalgs_pk primary key (product_id,catalog_id,asset_version))


create table dcs_sku_catalogs (
	asset_version	numeric(19)	not null,
	sku_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_sku_catalgs_pk primary key (sku_id,catalog_id,asset_version))


create table dcs_catalog_sites (
	asset_version	numeric(19)	not null,
	catalog_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_catlg_sites_pk primary key (catalog_id,site_id,asset_version))

create index catlg_site_id_idx on dcs_catalog_sites (site_id)

create table dcs_category_sites (
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_cat_sites_pk primary key (category_id,site_id,asset_version))

create index cat_site_id_idx on dcs_category_sites (site_id)

create table dcs_product_sites (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_prod_sites_pk primary key (product_id,site_id,asset_version))

create index prd_site_id_idx on dcs_product_sites (site_id)

create table dcs_sku_sites (
	asset_version	numeric(19)	not null,
	sku_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_sku_sites_pk primary key (sku_id,site_id,asset_version))

create index sku_site_id_idx on dcs_sku_sites (site_id)

create table dcs_cat_dynprd (
	asset_version	numeric(19)	not null,
	category_id	varchar(40)	not null,
	product_id	varchar(40)	not null
,constraint dcs_cat_dynprd_pk primary key (product_id,category_id,asset_version))


create table dcs_invalidated_prd_ids (
	asset_version	numeric(19)	not null,
	product_id	varchar(40)	not null
,constraint dcs_invalidated_prd_ids_pk primary key (product_id,asset_version))


create table dcs_invalidated_sku_ids (
	asset_version	numeric(19)	not null,
	sku_id	varchar(40)	not null
,constraint dcs_invalidated_sku_ids_pk primary key (sku_id,asset_version))



go
