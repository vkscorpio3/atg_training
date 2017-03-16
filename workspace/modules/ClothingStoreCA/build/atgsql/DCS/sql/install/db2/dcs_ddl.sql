
-- the source for this section is 
-- invoice_ddl.sql





create table dbc_inv_delivery (
	id	varchar(40)	not null,
	version	integer	not null,
	type	integer	not null,
	prefix	varchar(40)	default null,
	first_name	varchar(40)	default null,
	middle_name	varchar(40)	default null,
	last_name	varchar(40)	default null,
	suffix	varchar(40)	default null,
	job_title	varchar(80)	default null,
	company_name	varchar(40)	default null,
	address1	varchar(80)	default null,
	address2	varchar(80)	default null,
	address3	varchar(80)	default null,
	city	varchar(40)	default null,
	county	varchar(40)	default null,
	state	varchar(40)	default null,
	postal_code	varchar(10)	default null,
	country	varchar(40)	default null,
	phone_number	varchar(40)	default null,
	fax_number	varchar(40)	default null,
	email_addr	varchar(255)	default null,
	format	integer	default null,
	delivery_mode	integer	default null
,constraint dbc_inv_delivery_p primary key (id));


create table dbc_inv_pmt_terms (
	id	varchar(40)	not null,
	version	integer	not null,
	type	integer	not null,
	disc_percent	numeric(19,7)	default null,
	disc_days	integer	default null,
	net_days	integer	default null
,constraint dbc_inv_pmt_term_p primary key (id));


create table dbc_invoice (
	id	varchar(40)	not null,
	version	integer	not null,
	type	integer	not null,
	creation_date	timestamp	default null,
	last_mod_date	timestamp	default null,
	invoice_number	varchar(40)	default null,
	po_number	varchar(40)	default null,
	req_number	varchar(40)	default null,
	delivery_info	varchar(40)	default null,
	balance_due	numeric(19,7)	default null,
	pmt_due_date	timestamp	default null,
	pmt_terms	varchar(40)	default null,
	order_id	varchar(40)	default null,
	pmt_group_id	varchar(40)	default null
,constraint dbc_invoice_p primary key (id)
,constraint dbc_invcdelvry_n_f foreign key (delivery_info) references dbc_inv_delivery (id)
,constraint dbc_invcpmt_term_f foreign key (pmt_terms) references dbc_inv_pmt_terms (id));

create index dbc_inv_dlivr_info on dbc_invoice (delivery_info);
create index dbc_inv_pmt_terms on dbc_invoice (pmt_terms);
create index inv_inv_idx on dbc_invoice (invoice_number);
create index inv_order_idx on dbc_invoice (order_id);
create index inv_pmt_idx on dbc_invoice (pmt_group_id);
create index inv_po_idx on dbc_invoice (po_number);
commit;



-- the source for this section is 
-- contracts_ddl.sql




-- Normally, catalog_id and price_list_id would reference the appropriate table it is possible not to use those tables though, which is why the reference is not included

create table dbc_contract (
	contract_id	varchar(40)	not null,
	display_name	varchar(254)	default null,
	creation_date	timestamp	default null,
	start_date	timestamp	default null,
	end_date	timestamp	default null,
	creator_id	varchar(40)	default null,
	negotiator_info	varchar(40)	default null,
	price_list_id	varchar(40)	default null,
	catalog_id	varchar(40)	default null,
	term_id	varchar(40)	default null,
	comments	varchar(254)	default null
,constraint dbc_contract_p primary key (contract_id));


create table dbc_contract_term (
	terms_id	varchar(40)	not null,
	terms	varchar(20480)	default null,
	disc_percent	numeric(19,7)	default null,
	disc_days	integer	default null,
	net_days	integer	default null
,constraint dbc_contract_ter_p primary key (terms_id));

commit;



-- the source for this section is 
-- commerce_user.sql





create table dps_credit_card (
	id	varchar(40)	not null,
	credit_card_number	varchar(80)	default null,
	credit_card_type	varchar(40)	default null,
	expiration_month	varchar(20)	default null,
	exp_day_of_month	varchar(20)	default null,
	expiration_year	varchar(20)	default null,
	billing_addr	varchar(40)	default null
,constraint dps_credit_card_p primary key (id));

create index dps_crcdba_idx on dps_credit_card (billing_addr);

create table dbc_cost_center (
	id	varchar(40)	not null,
	identifier	varchar(40)	not null,
	description	varchar(254)	default null,
	user_id	varchar(40)	default null
,constraint dbc_cost_center_p primary key (id));


create table dcs_user (
	user_id	varchar(40)	not null,
	allow_partial_ship	numeric(1,0)	default null,
	default_creditcard	varchar(40)	default null,
	daytime_phone_num	varchar(30)	default null,
	express_checkout	numeric(1,0)	default null,
	default_carrier	varchar(256)	default null,
	price_list	varchar(40)	default null,
	user_catalog	varchar(40)	default null,
	sale_price_list	varchar(40)	default null,
	dflt_cost_center	varchar(40)	default null,
	order_price_limit	numeric(19,7)	default null,
	approval_required	numeric(4,0)	default null
,constraint dcs_user_p primary key (user_id)
,constraint dcs_usrdeflt_cr_f foreign key (default_creditcard) references dps_credit_card (id)
,constraint dcs_usrdflt_cos_f foreign key (dflt_cost_center) references dbc_cost_center (id)
,constraint dcs_user1_c check (allow_partial_ship in (0,1))
,constraint dcs_user2_c check (express_checkout in (0,1)));

create index dcs_usrdcc_idx on dcs_user (default_creditcard);
create index usr_defcstctr_idx on dcs_user (dflt_cost_center);

create table dps_usr_creditcard (
	user_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	credit_card_id	varchar(40)	not null
,constraint dps_usr_creditca_p primary key (user_id,tag)
,constraint dps_usrccredt_cr_f foreign key (credit_card_id) references dps_credit_card (id)
,constraint dps_usrcusr_d_f foreign key (user_id) references dps_user (id));

create index dps_ucccid_idx on dps_usr_creditcard (credit_card_id);
create index dps_uccuid_idx on dps_usr_creditcard (user_id);

create table dbc_buyer_costctr (
	user_id	varchar(40)	not null,
	seq	integer	not null,
	cost_center_id	varchar(40)	not null
,constraint dbc_buyer_costct_p primary key (user_id,seq)
,constraint dbc_buyrcost_cnt_f foreign key (cost_center_id) references dbc_cost_center (id));

create index dbc_byr_costctr_id on dbc_buyer_costctr (cost_center_id);
--  Multi-table associating a Buyer with one or more order approvers.  Approvers are required to be registered users of the site so they can perform online approvals. 

create table dbc_buyer_approver (
	user_id	varchar(40)	not null,
	approver_id	varchar(40)	not null,
	seq	integer	not null
,constraint dbc_buyer_approv_p primary key (user_id,seq)
,constraint dbc_buyrapprvr_d_f foreign key (approver_id) references dps_user (id)
,constraint dbc_buyrusr_d_f foreign key (user_id) references dps_user (id));

create index buyer_approver_idx on dbc_buyer_approver (approver_id);

create table dbc_buyer_prefvndr (
	user_id	varchar(40)	not null,
	vendor	varchar(100)	not null,
	seq	integer	not null
,constraint dbc_buyer_prefvn_p primary key (user_id,seq)
,constraint dbc_byrprfndusrd_f foreign key (user_id) references dps_user (id));


create table dbc_buyer_plist (
	user_id	varchar(40)	not null,
	list_id	varchar(40)	not null,
	tag	integer	not null
,constraint dbc_buyer_plist_p primary key (user_id,tag));


create table dcs_user_favstores (
	user_id	varchar(40)	not null,
	seq	integer	not null,
	location_id	varchar(40)	default null
,constraint dcs_user_fvstore_p primary key (user_id,seq)
,constraint dcs_favstoreusrd_f foreign key (user_id) references dps_user (id));

commit;



-- the source for this section is 
-- organization_ddl.sql





create table dbc_organization (
	id	varchar(40)	not null,
	type	integer	default null,
	cust_type	integer	default null,
	duns_number	varchar(20)	default null,
	dflt_shipping_addr	varchar(40)	default null,
	dflt_billing_addr	varchar(40)	default null,
	dflt_payment_type	varchar(40)	default null,
	dflt_cost_center	varchar(40)	default null,
	order_price_limit	numeric(19,7)	default null,
	contract_id	varchar(40)	default null,
	approval_required	numeric(4,0)	default null
,constraint dbc_organization_p primary key (id)
,constraint dbc_orgncontrct__f foreign key (contract_id) references dbc_contract (contract_id)
,constraint dbc_orgndflt_bil_f foreign key (dflt_billing_addr) references dps_contact_info (id)
,constraint dbc_orgndflt_shi_f foreign key (dflt_shipping_addr) references dps_contact_info (id)
,constraint dbc_orgndflt_pay_f foreign key (dflt_payment_type) references dps_credit_card (id)
,constraint dbc_orgnztnid_f foreign key (id) references dps_organization (org_id));

create index dbc_org_cntrct_id on dbc_organization (contract_id);
create index dbc_orgdfltblig_ad on dbc_organization (dflt_billing_addr);
create index dbc_orgdflt_shpadr on dbc_organization (dflt_shipping_addr);
create index dbc_orgdflt_pmttyp on dbc_organization (dflt_payment_type);
create index dbc_orgdfltcst_ctr on dbc_organization (dflt_cost_center);

create table dbc_org_contact (
	org_id	varchar(40)	not null,
	contact_id	varchar(40)	not null,
	seq	integer	not null
,constraint dbc_org_contact_p primary key (org_id,seq)
,constraint dbc_orgccontct_d_f foreign key (contact_id) references dps_contact_info (id)
,constraint dbc_orgcorg_d_f foreign key (org_id) references dps_organization (org_id));

create index dbc_org_cntct_id on dbc_org_contact (contact_id);
-- Multi-table associating an Organization with one or more order approvers.  Like administrators, approvers are required to be registered users of the site so they can perform online approvals.

create table dbc_org_approver (
	org_id	varchar(40)	not null,
	approver_id	varchar(40)	not null,
	seq	integer	not null
,constraint dbc_org_approver_p primary key (org_id,seq)
,constraint dbc_orgporg_d_f foreign key (org_id) references dps_organization (org_id)
,constraint dbc_orgpapprvr_d_f foreign key (approver_id) references dps_user (id));

create index org_approver_idx on dbc_org_approver (approver_id);
-- Multi-table associating an Organization with one or more costcenters that are pre-approved for use by members of the organization.  

create table dbc_org_costctr (
	org_id	varchar(40)	not null,
	cost_center	varchar(40)	not null,
	seq	integer	not null
,constraint dbc_org_costctr_p primary key (org_id,seq)
,constraint dbc_ocstctrorgd_f foreign key (org_id) references dps_organization (org_id));

create index dbc_org_cstctr on dbc_org_costctr (cost_center);
-- Multi-table associating an Organization with one or more payment types that are pre-apprived for use by members of the organization.Right now we're just using credit cards here, but this will needto change to support more general payment types, including invoicing and purchase orders

create table dbc_org_payment (
	org_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	payment_id	varchar(40)	not null
,constraint dbc_org_payment_p primary key (org_id,tag)
,constraint dbc_orgppaymnt_d_f foreign key (payment_id) references dps_credit_card (id)
,constraint dbc_orgpymntorg_f foreign key (org_id) references dps_organization (org_id));

create index dbc_org_pymnt_id on dbc_org_payment (payment_id);

create table dbc_org_prefvndr (
	org_id	varchar(40)	not null,
	vendor	varchar(100)	not null,
	seq	integer	not null
,constraint dbc_org_prefvndr_p primary key (org_id,seq)
,constraint dbc_orgprfvndorg_f foreign key (org_id) references dps_organization (org_id));


create table dcs_org_address (
	org_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	addr_id	varchar(40)	not null
,constraint dcs_org_addr_p primary key (org_id,tag)
,constraint dcs_org_addr_fk1 foreign key (addr_id) references dps_contact_info (id)
,constraint dcs_org_addr_fk2 foreign key (org_id) references dps_organization (org_id));

create index dcs_org_addr_ix1 on dcs_org_address (addr_id);
commit;



-- the source for this section is 
-- product_catalog_ddl.sql





create table dcs_folder (
	folder_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	timestamp	default null,
	start_date	timestamp	default null,
	end_date	timestamp	default null,
	description	varchar(254)	default null,
	name	varchar(254)	not null,
	path	varchar(254)	not null,
	parent_folder_id	varchar(40)	default null
,constraint dcs_folder_p primary key (folder_id)
,constraint dcs_foldparnt_fl_f foreign key (parent_folder_id) references dcs_folder (folder_id));

create index fldr_pfldrid_idx on dcs_folder (parent_folder_id);
create index fldr_end_dte_idx on dcs_folder (end_date);
create index fldr_path_idx on dcs_folder (path);
create index fldr_strt_dte_idx on dcs_folder (start_date);

create table dcs_media (
	media_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	timestamp	default null,
	start_date	timestamp	default null,
	end_date	timestamp	default null,
	description	varchar(254)	default null,
	name	varchar(254)	not null,
	path	varchar(254)	not null,
	parent_folder_id	varchar(40)	not null,
	media_type	integer	default null
,constraint dcs_media_p primary key (media_id)
,constraint dcs_medparnt_fl_f foreign key (parent_folder_id) references dcs_folder (folder_id));

create index med_pfldrid_idx on dcs_media (parent_folder_id);
create index med_end_dte_idx on dcs_media (end_date);
create index med_path_idx on dcs_media (path);
create index med_strt_dte_idx on dcs_media (start_date);
create index med_type_idx on dcs_media (media_type);

create table dcs_media_ext (
	media_id	varchar(40)	not null,
	url	varchar(254)	not null
,constraint dcs_media_ext_p primary key (media_id)
,constraint dcs_medxtmed_d_f foreign key (media_id) references dcs_media (media_id));


create table dcs_media_bin (
	media_id	varchar(40)	not null,
	length	integer	not null,
	last_modified	timestamp	not null,
	data	blob(1048576)	not null
,constraint dcs_media_bin_p primary key (media_id)
,constraint dcs_medbnmed_d_f foreign key (media_id) references dcs_media (media_id));


create table dcs_media_txt (
	media_id	varchar(40)	not null,
	length	integer	not null,
	last_modified	timestamp	not null,
	data	varchar(20480)	not null
,constraint dcs_media_txt_p primary key (media_id)
,constraint dcs_medtxtmed_d_f foreign key (media_id) references dcs_media (media_id));


create table dcs_category (
	category_id	varchar(40)	not null,
	version	integer	not null,
	catalog_id	varchar(40)	default null,
	creation_date	timestamp	default null,
	start_date	timestamp	default null,
	end_date	timestamp	default null,
	display_name	varchar(254)	default null,
	description	varchar(254)	default null,
	long_description	varchar(20480)	default null,
	parent_cat_id	varchar(40)	default null,
	category_type	integer	default null,
	root_category	numeric(1,0)	default null
,constraint dcs_category_p primary key (category_id)
,constraint dcs_category_c check (root_category in (0,1)));

create index cat_end_dte_idx on dcs_category (end_date);
create index cat_pcatid_idx on dcs_category (parent_cat_id);
create index cat_strt_dte_idx on dcs_category (start_date);
create index cat_type_idx on dcs_category (category_type);

create table dcs_category_acl (
	category_id	varchar(40)	not null,
	item_acl	varchar(1024)	default null
,constraint dcs_category_acl_p primary key (category_id));


create table dcs_product (
	product_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	timestamp	default null,
	start_date	timestamp	default null,
	end_date	timestamp	default null,
	display_name	varchar(254)	default null,
	description	varchar(254)	default null,
	long_description	varchar(20480)	default null,
	parent_cat_id	varchar(40)	default null,
	product_type	integer	default null,
	admin_display	varchar(254)	default null,
	nonreturnable	numeric(1,0)	default null,
	discountable	numeric(1)	default null,
	fractional_quantities_allowed	numeric(1)	default null,
	unit_of_measure	integer	default null,
	brand	varchar(254)	default null,
	disallow_recommend	numeric(1,0)	default null,
	manufacturer	varchar(40)	default null,
	online_only	numeric(1,0)	default null
,constraint dcs_product_p primary key (product_id)
,constraint dcs_product_c check (nonreturnable in (0,1))
,constraint dcs_product1_c check (disallow_recommend in (0,1))
,constraint dcs_product2_c check (online_only in (0,1)));

create index prd_end_dte_idx on dcs_product (end_date);
create index prd_pcatid_idx on dcs_product (parent_cat_id);
create index prd_strt_dte_idx on dcs_product (start_date);
create index prd_type_idx on dcs_product (product_type);

create table dcs_product_acl (
	product_id	varchar(40)	not null,
	item_acl	varchar(1024)	default null
,constraint dcs_product_acl_p primary key (product_id));


create table dcs_sku (
	sku_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	timestamp	default null,
	start_date	timestamp	default null,
	end_date	timestamp	default null,
	display_name	varchar(254)	default null,
	description	varchar(254)	default null,
	sku_type	integer	default null,
	wholesale_price	double precision	default null,
	list_price	double precision	default null,
	sale_price	double precision	default null,
	on_sale	numeric(1,0)	default null,
	tax_status	integer	default null,
	fulfiller	integer	default null,
	item_acl	varchar(1024)	default null,
	nonreturnable	numeric(1,0)	default null,
	discountable	numeric(1)	default null,
	fractional_quantities_allowed	numeric(1)	default null,
	manuf_part_num	varchar(254)	default null,
	online_only	numeric(1,0)	default null
,constraint dcs_sku_p primary key (sku_id)
,constraint dcs_sku_c check (on_sale in (0,1))
,constraint dcs_sku1_c check (nonreturnable in (0,1))
,constraint dcs_sku2_c check (online_only in (0,1)));

create index sku_end_dte_idx on dcs_sku (end_date);
create index sku_lstprice_idx on dcs_sku (list_price);
create index sku_sleprice_idx on dcs_sku (sale_price);
create index sku_strt_dte_idx on dcs_sku (start_date);
create index sku_type_idx on dcs_sku (sku_type);

create table dcs_cat_groups (
	category_id	varchar(40)	not null,
	child_prd_group	varchar(254)	default null,
	child_cat_group	varchar(254)	default null,
	related_cat_group	varchar(254)	default null
,constraint dcs_cat_groups_p primary key (category_id)
,constraint dcs_catgcatgry_d_f foreign key (category_id) references dcs_category (category_id));


create table dcs_cat_chldprd (
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_prd_id	varchar(40)	not null
,constraint dcs_cat_chldprd_p primary key (category_id,sequence_num)
,constraint dcs_catccatgry_d_f foreign key (category_id) references dcs_category (category_id)
,constraint dcs_catcchild_pr_f foreign key (child_prd_id) references dcs_product (product_id));

create index ct_chldprd_cpi_idx on dcs_cat_chldprd (child_prd_id);
create index ct_chldprd_cid_idx on dcs_cat_chldprd (category_id);

create table dcs_cat_chldcat (
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_cat_id	varchar(40)	not null
,constraint dcs_cat_chldcat_p primary key (category_id,sequence_num)
,constraint dcs_catcchild_ct_f foreign key (child_cat_id) references dcs_category (category_id)
,constraint dcs_chlccatgry_d_f foreign key (category_id) references dcs_category (category_id));

create index ct_chldcat_cci_idx on dcs_cat_chldcat (child_cat_id);
create index ct_chldcat_cid_idx on dcs_cat_chldcat (category_id);

create table dcs_cat_ancestors (
	category_id	varchar(40)	not null,
	anc_cat_id	varchar(40)	not null
,constraint dcs_cat_ancestor_p primary key (category_id,anc_cat_id));

create index dcs_ct_anc_cat_id on dcs_cat_ancestors (anc_cat_id);
create index dcs_ct_cat_id on dcs_cat_ancestors (category_id);

create table dcs_cat_rltdcat (
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_cat_id	varchar(40)	not null
,constraint dcs_cat_rltdcat_p primary key (category_id,sequence_num)
,constraint dcs_catrcatgry_d_f foreign key (category_id) references dcs_category (category_id)
,constraint dcs_catrreltd_ct_f foreign key (related_cat_id) references dcs_category (category_id));

create index ct_rltdcat_rci_idx on dcs_cat_rltdcat (related_cat_id);
create index ct_rltdcat_cid_idx on dcs_cat_rltdcat (category_id);

create table dcs_cat_keywrds (
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	keyword	varchar(254)	not null
,constraint dcs_cat_keywrds_p primary key (category_id,sequence_num)
,constraint dcs_catkcatgry_d_f foreign key (category_id) references dcs_category (category_id));

create index cat_keywrds_idx on dcs_cat_keywrds (keyword);
create index ct_keywrds_cid_idx on dcs_cat_keywrds (category_id);

create table dcs_cat_media (
	category_id	varchar(40)	not null,
	template_id	varchar(40)	default null,
	thumbnail_image_id	varchar(40)	default null,
	small_image_id	varchar(40)	default null,
	large_image_id	varchar(40)	default null
,constraint dcs_cat_media_p primary key (category_id)
,constraint dcs_catmcatgry_d_f foreign key (category_id) references dcs_category (category_id)
,constraint dcs_catmlarg_mgd_f foreign key (large_image_id) references dcs_media (media_id)
,constraint dcs_catmsmall_mg_f foreign key (small_image_id) references dcs_media (media_id)
,constraint dcs_catmtemplt_d_f foreign key (template_id) references dcs_media (media_id)
,constraint dcs_catmthumbnl__f foreign key (thumbnail_image_id) references dcs_media (media_id));

create index ct_mdia_lrimid_idx on dcs_cat_media (large_image_id);
create index ct_mdia_smimid_idx on dcs_cat_media (small_image_id);
create index ct_mdia_tmplid_idx on dcs_cat_media (template_id);
create index ct_mdia_thimid_idx on dcs_cat_media (thumbnail_image_id);

create table dcs_cat_aux_media (
	category_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	media_id	varchar(40)	not null
,constraint dcs_cat_aux_medi_p primary key (category_id,tag)
,constraint dcs_catxcatgry_d_f foreign key (category_id) references dcs_category (category_id)
,constraint dcs_catxmdmed_d_f foreign key (media_id) references dcs_media (media_id));

create index ct_aux_mdia_mi_idx on dcs_cat_aux_media (media_id);
create index ct_aux_mdia_ci_idx on dcs_cat_aux_media (category_id);

create table dcs_prd_keywrds (
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	keyword	varchar(254)	not null
,constraint dcs_prd_keywrds_p primary key (product_id,sequence_num)
,constraint dcs_prdkprodct_d_f foreign key (product_id) references dcs_product (product_id));

create index prd_keywrds_idx on dcs_prd_keywrds (keyword);
create index pr_keywrds_pid_idx on dcs_prd_keywrds (product_id);

create table dcs_prd_media (
	product_id	varchar(40)	not null,
	template_id	varchar(40)	default null,
	thumbnail_image_id	varchar(40)	default null,
	small_image_id	varchar(40)	default null,
	large_image_id	varchar(40)	default null
,constraint dcs_prd_media_p primary key (product_id)
,constraint dcs_prdmlarg_mgd_f foreign key (large_image_id) references dcs_media (media_id)
,constraint dcs_prdmsmall_mg_f foreign key (small_image_id) references dcs_media (media_id)
,constraint dcs_prdmtemplt_d_f foreign key (template_id) references dcs_media (media_id)
,constraint dcs_prdmthumbnl__f foreign key (thumbnail_image_id) references dcs_media (media_id)
,constraint dcs_prdmprodct_d_f foreign key (product_id) references dcs_product (product_id));

create index pr_mdia_lrimid_idx on dcs_prd_media (large_image_id);
create index pr_mdia_smimid_idx on dcs_prd_media (small_image_id);
create index pr_mdia_tmplid_idx on dcs_prd_media (template_id);
create index pr_mdia_thimid_idx on dcs_prd_media (thumbnail_image_id);

create table dcs_prd_aux_media (
	product_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	media_id	varchar(40)	not null
,constraint dcs_prd_aux_medi_p primary key (product_id,tag)
,constraint dcs_prdaxmdmed_d_f foreign key (media_id) references dcs_media (media_id)
,constraint dcs_prdaprodct_d_f foreign key (product_id) references dcs_product (product_id));

create index pr_aux_mdia_mi_idx on dcs_prd_aux_media (media_id);
create index pr_aux_mdia_pi_idx on dcs_prd_aux_media (product_id);

create table dcs_prd_chldsku (
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	sku_id	varchar(40)	not null
,constraint dcs_prd_chldsku_p primary key (product_id,sequence_num)
,constraint dcs_prdcprodct_d_f foreign key (product_id) references dcs_product (product_id)
,constraint dcs_prdcsku_d_f foreign key (sku_id) references dcs_sku (sku_id));

create index pr_chldsku_sid_idx on dcs_prd_chldsku (sku_id);
create index pr_chldsku_pid_idx on dcs_prd_chldsku (product_id);

create table dcs_prd_skuattr (
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	attribute_name	varchar(40)	not null
,constraint dcs_prd_skuattr_p primary key (product_id,sequence_num)
,constraint dcs_prdsprodct_d_f foreign key (product_id) references dcs_product (product_id));

create index pr_skuattr_pid_idx on dcs_prd_skuattr (product_id);

create table dcs_prd_groups (
	product_id	varchar(40)	not null,
	related_prd_group	varchar(254)	default null,
	upsl_prd_group	varchar(254)	default null
,constraint dcs_prd_groups_p primary key (product_id)
,constraint dcs_prdgprodct_d_f foreign key (product_id) references dcs_product (product_id));


create table dcs_prd_rltdprd (
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_prd_id	varchar(40)	not null
,constraint dcs_prd_rltdprd_p primary key (product_id,sequence_num)
,constraint dcs_prdrprodct_d_f foreign key (product_id) references dcs_product (product_id)
,constraint dcs_prdrreltd_pr_f foreign key (related_prd_id) references dcs_product (product_id));

create index pr_rltdprd_rpi_idx on dcs_prd_rltdprd (related_prd_id);
create index pr_rltdprd_pid_idx on dcs_prd_rltdprd (product_id);

create table dcs_prd_upslprd (
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	upsell_prd_id	varchar(40)	not null
,constraint dcs_prd_upslprd_p primary key (product_id,sequence_num)
,constraint dcs_prduprodct_d_f foreign key (product_id) references dcs_product (product_id)
,constraint dcs_prdureltd_pr_f foreign key (upsell_prd_id) references dcs_product (product_id));

create index pr_upslprd_upi_idx on dcs_prd_upslprd (upsell_prd_id);

create table dcs_prd_ancestors (
	product_id	varchar(40)	not null,
	anc_cat_id	varchar(40)	not null
,constraint dcs_prd_ancestor_p primary key (product_id,anc_cat_id));

create index dcs_prd_anc_cat_id on dcs_prd_ancestors (anc_cat_id);
create index dcs_prd_prd_id on dcs_prd_ancestors (product_id);

create table dcs_sku_attr (
	sku_id	varchar(40)	not null,
	attribute_name	varchar(42)	not null,
	attribute_value	varchar(254)	not null
,constraint dcs_sku_attr_p primary key (sku_id,attribute_name)
,constraint dcs_skuttrsku_d_f foreign key (sku_id) references dcs_sku (sku_id));

create index sku_attr_skuid_idx on dcs_sku_attr (sku_id);

create table dcs_sku_link (
	sku_link_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	timestamp	default null,
	start_date	timestamp	default null,
	end_date	timestamp	default null,
	display_name	varchar(254)	default null,
	description	varchar(254)	default null,
	quantity	integer	default null,
	quantity_with_fraction	numeric(19,7)	default null,
	bundle_item	varchar(40)	not null,
	item_acl	varchar(1024)	default null
,constraint dcs_sku_link_p primary key (sku_link_id)
,constraint dcs_skulbundl_tm_f foreign key (bundle_item) references dcs_sku (sku_id));

create index sk_link_bndlid_idx on dcs_sku_link (bundle_item);
create index skl_end_dte_idx on dcs_sku_link (end_date);
create index skl_strt_dte_idx on dcs_sku_link (start_date);

create table dcs_sku_bndllnk (
	sku_id	varchar(40)	not null,
	sequence_num	integer	not null,
	sku_link_id	varchar(40)	not null
,constraint dcs_sku_bndllnk_p primary key (sku_id,sequence_num)
,constraint dcs_skubsku_d_f foreign key (sku_id) references dcs_sku (sku_id)
,constraint dcs_skubsku_lnkd_f foreign key (sku_link_id) references dcs_sku_link (sku_link_id));

create index sk_bndllnk_sli_idx on dcs_sku_bndllnk (sku_link_id);
create index sk_bndllnk_sid_idx on dcs_sku_bndllnk (sku_id);

create table dcs_sku_media (
	sku_id	varchar(40)	not null,
	template_id	varchar(40)	default null,
	thumbnail_image_id	varchar(40)	default null,
	small_image_id	varchar(40)	default null,
	large_image_id	varchar(40)	default null
,constraint dcs_sku_media_p primary key (sku_id)
,constraint dcs_skumlarg_mgd_f foreign key (large_image_id) references dcs_media (media_id)
,constraint dcs_skumsmall_mg_f foreign key (small_image_id) references dcs_media (media_id)
,constraint dcs_skumtemplt_d_f foreign key (template_id) references dcs_media (media_id)
,constraint dcs_skumthumbnl__f foreign key (thumbnail_image_id) references dcs_media (media_id)
,constraint dcs_skumdsku_d_f foreign key (sku_id) references dcs_sku (sku_id));

create index sk_mdia_lrimid_idx on dcs_sku_media (large_image_id);
create index sk_mdia_smimid_idx on dcs_sku_media (small_image_id);
create index sk_mdia_tmplid_idx on dcs_sku_media (template_id);
create index sk_mdia_thimid_idx on dcs_sku_media (thumbnail_image_id);

create table dcs_sku_aux_media (
	sku_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	media_id	varchar(40)	not null
,constraint dcs_sku_aux_medi_p primary key (sku_id,tag)
,constraint dcs_skuxmdmed_d_f foreign key (media_id) references dcs_media (media_id)
,constraint dcs_skuxmdsku_d_f foreign key (sku_id) references dcs_sku (sku_id));

create index sk_aux_mdia_mi_idx on dcs_sku_aux_media (media_id);
create index sk_aux_mdia_si_idx on dcs_sku_aux_media (sku_id);

create table dcs_sku_replace (
	sku_id	varchar(40)	not null,
	sequence_num	integer	not null,
	replacement	varchar(40)	not null
,constraint dcs_sku_replace_p primary key (sku_id,sequence_num)
,constraint dcs_skurplcsku_d_f foreign key (sku_id) references dcs_sku (sku_id));

create index sk_replace_sid_idx on dcs_sku_replace (sku_id);

create table dcs_sku_conf (
	sku_id	varchar(40)	not null,
	config_props	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcs_sku_conf_p primary key (sku_id,sequence_num)
,constraint dcs_skucnfsku_d_f foreign key (sku_id) references dcs_sku (sku_id));


create table dcs_config_sku (
	sku_id	varchar(40)	not null,
	configurator_id	varchar(254)	default null
,constraint dcs_config_sku_p primary key (sku_id)
,constraint dcs_cnfskusku_d_f foreign key (sku_id) references dcs_sku (sku_id));


create table dcs_config_prop (
	config_prop_id	varchar(40)	not null,
	version	integer	not null,
	display_name	varchar(40)	default null,
	description	varchar(255)	default null,
	configurator_id	varchar(254)	default null,
	item_acl	varchar(1024)	default null
,constraint dcs_config_prop_p primary key (config_prop_id));


create table dcs_conf_options (
	config_prop_id	varchar(40)	not null,
	config_options	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcs_conf_options_p primary key (config_prop_id,sequence_num)
,constraint dcs_confconfg_pr_f foreign key (config_prop_id) references dcs_config_prop (config_prop_id));


create table dcs_config_opt (
	config_opt_id	varchar(40)	not null,
	version	integer	not null,
	display_name	varchar(40)	default null,
	description	varchar(255)	default null,
	sku	varchar(40)	default null,
	product	varchar(40)	default null,
	price	double precision	default null,
	item_acl	varchar(1024)	default null
,constraint dcs_config_opt_p primary key (config_opt_id));

create index ct_conf_prod_idx on dcs_config_opt (product);
create index ct_conf_sku_idx on dcs_config_opt (sku);

create table dcs_foreign_cat (
	catalog_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	name	varchar(100)	default null,
	description	varchar(255)	default null,
	host	varchar(100)	default null,
	port	integer	default null,
	base_url	varchar(255)	default null,
	return_url	varchar(255)	default null,
	item_acl	varchar(1024)	default null
,constraint dcs_foreign_cat_p primary key (catalog_id));


create table dbc_manufacturer (
	manufacturer_id	varchar(40)	not null,
	manufacturer_name	varchar(254)	default null,
	description	varchar(254)	default null,
	long_description	varchar(20480)	default null,
	email	varchar(255)	default null
,constraint dbc_manufacturer_p primary key (manufacturer_id));

create index dbc_man_name_idx on dbc_manufacturer (manufacturer_name);

create table dbc_measurement (
	sku_id	varchar(40)	not null,
	unit_of_measure	integer	default null,
	quantity	double precision	default null
,constraint dbc_measurement_p primary key (sku_id));


create table dcs_product_rltd_media (
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_media_id	varchar(40)	not null
,constraint dcs_product_rltd_media_p primary key (product_id,sequence_num)
,constraint dcs_product_rltd_media1_f foreign key (product_id) references dcs_product (product_id)
,constraint dcs_product_rltd_media2_f foreign key (related_media_id) references wcm_media_content (id));

create index dcs_product_rltd_media_idx on dcs_product_rltd_media (related_media_id);

create table dcs_product_rltd_article (
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_article_id	varchar(40)	not null
,constraint dcs_product_rltd_article_p primary key (product_id,sequence_num)
,constraint dcs_product_rltd_article1_f foreign key (product_id) references dcs_product (product_id)
,constraint dcs_product_rltd_article2_f foreign key (related_article_id) references wcm_article (id));

create index dcs_product_rltd_article_idx on dcs_product_rltd_article (related_article_id);
commit;



-- the source for this section is 
-- custom_catalog_ddl.sql





create table dcs_catalog (
	catalog_id	varchar(40)	not null,
	version	integer	not null,
	display_name	varchar(254)	default null,
	creation_date	timestamp	default null,
	last_mod_date	timestamp	default null,
	migration_status	numeric(3,0)	default null,
	migration_index	numeric(10,0)	default null,
	item_acl	varchar(1024)	default null
,constraint dcs_catalog_p primary key (catalog_id));


create table dcs_root_cats (
	catalog_id	varchar(40)	not null,
	root_cat_id	varchar(40)	not null
,constraint dcs_root_cats_p primary key (catalog_id,root_cat_id)
,constraint dcs_rotccatlg_d_f foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_rotcrot_ctd_f foreign key (root_cat_id) references dcs_category (category_id));

create index dcs_rootcatscat_id on dcs_root_cats (root_cat_id);

create table dcs_allroot_cats (
	catalog_id	varchar(40)	not null,
	root_cat_id	varchar(40)	not null
,constraint dcs_allroot_cats_p primary key (catalog_id,root_cat_id)
,constraint dcs_allrcatlg_d_f foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_allrrot_ctd_f foreign key (root_cat_id) references dcs_category (category_id));

create index dcs_allrt_cats_id on dcs_allroot_cats (root_cat_id);

create table dcs_root_subcats (
	catalog_id	varchar(40)	not null,
	sub_catalog_id	varchar(40)	not null
,constraint dcs_root_subcats_p primary key (catalog_id,sub_catalog_id)
,constraint dcs_rotscatlg_d_f foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_rotssub_ctlg_f foreign key (sub_catalog_id) references dcs_catalog (catalog_id));

create index dcs_rtsubcats_id on dcs_root_subcats (sub_catalog_id);

create table dcs_category_info (
	category_info_id	varchar(40)	not null,
	version	integer	not null,
	item_acl	varchar(1024)	default null
,constraint dcs_category_inf_p primary key (category_info_id));


create table dcs_product_info (
	product_info_id	varchar(40)	not null,
	version	integer	not null,
	parent_cat_id	varchar(40)	default null,
	item_acl	varchar(1024)	default null
,constraint dcs_product_info_p primary key (product_info_id));


create table dcs_sku_info (
	sku_info_id	varchar(40)	not null,
	version	integer	not null,
	item_acl	varchar(1024)	default null
,constraint dcs_sku_info_p primary key (sku_info_id));


create table dcs_cat_subcats (
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_cat_subcats_p primary key (category_id,sequence_num)
,constraint dcs_catscatlg_d_f foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_catscatgry_d_f foreign key (category_id) references dcs_category (category_id));

create index dcs_catsubcatlogid on dcs_cat_subcats (catalog_id);

create table dcs_cat_subroots (
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	sub_category_id	varchar(40)	not null
,constraint dcs_cat_subroots_p primary key (category_id,sequence_num)
,constraint dcs_subrtscatgry_f foreign key (category_id) references dcs_category (category_id));


create table dcs_cat_catinfo (
	category_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	category_info_id	varchar(40)	not null
,constraint dcs_cat_catinfo_p primary key (category_id,catalog_id)
,constraint dcs_infocatgry_d_f foreign key (category_id) references dcs_category (category_id));


create table dcs_catinfo_anc (
	category_info_id	varchar(40)	not null,
	anc_cat_id	varchar(40)	not null
,constraint dcs_catinfo_anc_p primary key (category_info_id,anc_cat_id));


create table dcs_prd_prdinfo (
	product_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	product_info_id	varchar(40)	not null
,constraint dcs_prd_prdinfo_p primary key (product_id,catalog_id)
,constraint dcs_prdpprodct_d_f foreign key (product_id) references dcs_product (product_id));


create table dcs_prdinfo_rdprd (
	product_info_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_prd_id	varchar(40)	not null
,constraint dcs_prdinfo_rdpr_p primary key (product_info_id,sequence_num)
,constraint dcs_prdireltd_pr_f foreign key (related_prd_id) references dcs_product (product_id)
,constraint dcs_prdiprodct_n_f foreign key (product_info_id) references dcs_product_info (product_info_id));

create index dcs_prdrelatedinfo on dcs_prdinfo_rdprd (related_prd_id);

create table dcs_prdinfo_anc (
	product_info_id	varchar(40)	not null,
	anc_cat_id	varchar(40)	not null
,constraint dcs_prdinfo_anc_p primary key (product_info_id,anc_cat_id));


create table dcs_sku_skuinfo (
	sku_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	sku_info_id	varchar(40)	not null
,constraint dcs_sku_skuinfo_p primary key (sku_id,catalog_id)
,constraint dcs_skusknfsku_d_f foreign key (sku_id) references dcs_sku (sku_id));


create table dcs_skuinfo_rplc (
	sku_info_id	varchar(40)	not null,
	sequence_num	integer	not null,
	replacement	varchar(40)	not null
,constraint dcs_skuinfo_rplc_p primary key (sku_info_id,sequence_num)
,constraint dcs_skunsku_nfd_f foreign key (sku_info_id) references dcs_sku_info (sku_info_id));


create table dcs_gen_fol_cat (
	folder_id	varchar(40)	not null,
	type	integer	not null,
	name	varchar(40)	not null,
	parent	varchar(40)	default null,
	description	varchar(254)	default null,
	item_acl	varchar(1024)	default null
,constraint dcs_gen_fol_cat_p primary key (folder_id));


create table dcs_child_fol_cat (
	folder_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_folder_id	varchar(40)	not null
,constraint dcs_child_fol_ca_p primary key (folder_id,sequence_num)
,constraint dcs_catlfoldr_d_f foreign key (folder_id) references dcs_gen_fol_cat (folder_id));


create table dcs_catfol_chld (
	catfol_id	varchar(40)	not null,
	sequence_num	integer	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_catfol_chld_p primary key (catfol_id,sequence_num)
,constraint dcs_catfcatfl_d_f foreign key (catfol_id) references dcs_gen_fol_cat (folder_id));


create table dcs_catfol_sites (
	catfol_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_catfl_sites_pk primary key (catfol_id,site_id));


create table dcs_dir_anc_ctlgs (
	catalog_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_catalog_id	varchar(40)	not null
,constraint dcs_dirancctlgs_pk primary key (catalog_id,sequence_num)
,constraint dcs_dirancctlgs_f1 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_dirancctlgs_f2 foreign key (anc_catalog_id) references dcs_catalog (catalog_id));

create index dcs_dirancctlg_idx on dcs_dir_anc_ctlgs (anc_catalog_id);

create table dcs_ind_anc_ctlgs (
	catalog_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_catalog_id	varchar(40)	not null
,constraint dcs_indancctlgs_pk primary key (catalog_id,sequence_num)
,constraint dcs_indancctlgs_f1 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_indancctlgs_f2 foreign key (anc_catalog_id) references dcs_catalog (catalog_id));

create index dcs_indanctlg_idx on dcs_ind_anc_ctlgs (anc_catalog_id);

create table dcs_ctlg_anc_cats (
	catalog_id	varchar(40)	not null,
	sequence_num	integer	not null,
	category_id	varchar(40)	not null
,constraint dcs_ctlganccats_pk primary key (catalog_id,sequence_num)
,constraint dcs_ctlganccats_f1 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_ctlganccats_f2 foreign key (category_id) references dcs_category (category_id));

create index dcs_ctlgancat_idx on dcs_ctlg_anc_cats (category_id);

create table dcs_cat_anc_cats (
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_category_id	varchar(40)	not null
,constraint dcs_cat_anccats_pk primary key (category_id,sequence_num)
,constraint dcs_cat_anccats_f1 foreign key (category_id) references dcs_category (category_id)
,constraint dcs_cat_anccats_f2 foreign key (anc_category_id) references dcs_category (category_id));

create index dcs_catanccat_idx on dcs_cat_anc_cats (anc_category_id);

create table dcs_cat_prnt_cats (
	category_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	parent_ctgy_id	varchar(40)	not null
,constraint dcs_catprntcats_pk primary key (category_id,catalog_id)
,constraint dcscatprntcats_fk1 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcscatprntcats_fk2 foreign key (category_id) references dcs_category (category_id)
,constraint dcscatprntcats_fk3 foreign key (parent_ctgy_id) references dcs_category (category_id));

create index dcscatprntcats_ix1 on dcs_cat_prnt_cats (catalog_id);
create index dcscatprntcats_ix2 on dcs_cat_prnt_cats (category_id);
create index dcscatprntcats_ix3 on dcs_cat_prnt_cats (parent_ctgy_id);

create table dcs_prd_prnt_cats (
	product_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	category_id	varchar(40)	not null
,constraint dcs_prdprntcats_pk primary key (product_id,catalog_id)
,constraint dcs_prdprntcats_f2 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_prdprntcats_f3 foreign key (category_id) references dcs_category (category_id)
,constraint dcs_prdprntcats_f1 foreign key (product_id) references dcs_product (product_id));

create index pr_prnt_cat_pi_idx on dcs_prd_prnt_cats (catalog_id);
create index pr_prnt_cat_ci_idx on dcs_prd_prnt_cats (category_id);

create table dcs_prd_anc_cats (
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	category_id	varchar(40)	not null
,constraint dcs_prdanc_cats_pk primary key (product_id,sequence_num)
,constraint dcs_prdanc_cats_f2 foreign key (category_id) references dcs_category (category_id)
,constraint dcs_prdanc_cats_f1 foreign key (product_id) references dcs_product (product_id));

create index dcs_prdanccat_idx on dcs_prd_anc_cats (category_id);

create table dcs_cat_catalogs (
	category_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_cat_catalgs_pk primary key (category_id,catalog_id)
,constraint dcs_cat_catalgs_f2 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_cat_catalgs_f1 foreign key (category_id) references dcs_category (category_id));

create index dcs_catctlgs_idx on dcs_cat_catalogs (catalog_id);

create table dcs_prd_catalogs (
	product_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_prd_catalgs_pk primary key (product_id,catalog_id)
,constraint dcs_prd_catalgs_f2 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_prd_catalgs_f1 foreign key (product_id) references dcs_product (product_id));

create index dcs_prd_ctlgs_idx on dcs_prd_catalogs (catalog_id);

create table dcs_sku_catalogs (
	sku_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_sku_catalgs_pk primary key (sku_id,catalog_id)
,constraint dcs_sku_catalgs_f2 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_sku_catalgs_f1 foreign key (sku_id) references dcs_sku (sku_id));

create index dcs_sku_ctlgs_idx on dcs_sku_catalogs (catalog_id);

create table dcs_catalog_sites (
	catalog_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_catlg_sites_pk primary key (catalog_id,site_id));

create index catlg_site_id_idx on dcs_catalog_sites (site_id);

create table dcs_category_sites (
	category_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_cat_sites_pk primary key (category_id,site_id));

create index cat_site_id_idx on dcs_category_sites (site_id);

create table dcs_product_sites (
	product_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_prod_sites_pk primary key (product_id,site_id)
,constraint dcs_prod_sites_f1 foreign key (product_id) references dcs_product (product_id));

create index prd_site_id_idx on dcs_product_sites (site_id);

create table dcs_sku_sites (
	sku_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_sku_sites_pk primary key (sku_id,site_id)
,constraint dcs_sku_sites_f1 foreign key (sku_id) references dcs_sku (sku_id));

create index sku_site_id_idx on dcs_sku_sites (site_id);

create table dcs_cat_dynprd (
	category_id	varchar(40)	not null,
	product_id	varchar(40)	not null
,constraint dcs_cat_dynprd_pk primary key (product_id,category_id));


create table dcs_invalidated_prd_ids (
	product_id	varchar(40)	not null
,constraint dcs_invalidated_prd_ids_pk primary key (product_id));


create table dcs_invalidated_sku_ids (
	sku_id	varchar(40)	not null
,constraint dcs_invalidated_sku_ids_pk primary key (sku_id));

commit;



-- the source for this section is 
-- location_ddl.sql





create table dcs_location (
	location_id	varchar(40)	not null,
	ext_loc_id	varchar(40)	default null,
	type	integer	not null,
	version	integer	not null,
	name	varchar(254)	default null,
	start_date	timestamp	default null,
	end_date	timestamp	default null,
	latitude	numeric(19,7)	not null,
	longitude	numeric(19,7)	not null
,constraint dcs_location_p primary key (location_id));


create table dcs_location_sites (
	location_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_location_sites_pk primary key (location_id,site_id));

create index location_site_id_idx on dcs_location_sites (site_id);

create table dcs_loc_site_grps (
	location_id	varchar(40)	not null,
	site_group_id	varchar(40)	not null
,constraint dcs_loc_sgrps_pk primary key (location_id,site_group_id)
,constraint dcs_loc_sgrps1_d_f foreign key (location_id) references dcs_location (location_id)
,constraint dcs_loc_sgrps2_d_f foreign key (site_group_id) references site_group (id));

create index dcs_loc_sgrps2_x on dcs_loc_site_grps (site_group_id);

create table dcs_location_store (
	location_id	varchar(40)	not null,
	hours	varchar(64)	default null
,constraint dcs_loc_store_p primary key (location_id));


create table dcs_location_addr (
	location_id	varchar(40)	not null,
	address_1	varchar(50)	default null,
	address_2	varchar(50)	default null,
	address_3	varchar(50)	default null,
	city	varchar(40)	default null,
	county	varchar(40)	default null,
	state_addr	varchar(40)	default null,
	postal_code	varchar(10)	default null,
	country	varchar(40)	default null,
	phone_number	varchar(40)	default null,
	fax_number	varchar(40)	default null,
	email	varchar(255)	default null
,constraint dcspp_loc_addr_p primary key (location_id)
,constraint dcspp_loc_addr_f foreign key (location_id) references dcs_location (location_id));


create table dcs_location_rltd_media (
	location_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_media_id	varchar(40)	not null
,constraint dcs_location_rltd_media_p primary key (location_id,sequence_num)
,constraint dcs_location_rltd_media1_f foreign key (location_id) references dcs_location (location_id)
,constraint dcs_location_rltd_media2_f foreign key (related_media_id) references wcm_media_content (id));

create index dcs_location_rltd_media_idx on dcs_location_rltd_media (related_media_id);

create table dcs_location_rltd_article (
	location_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_article_id	varchar(40)	not null
,constraint dcs_location_rltd_article_p primary key (location_id,sequence_num)
,constraint dcs_location_rltd_article1_f foreign key (location_id) references dcs_location (location_id)
,constraint dcs_location_rltd_article2_f foreign key (related_article_id) references wcm_article (id));

create index dcs_location_rltd_article_idx on dcs_location_rltd_article (related_article_id);
commit;



-- the source for this section is 
-- inventory_ddl.sql





create table dcs_inventory (
	inventory_id	varchar(40)	not null,
	location_id	varchar(40)	default null,
	version	integer	not null,
	inventory_lock	varchar(20)	default null,
	creation_date	timestamp	default null,
	start_date	timestamp	default null,
	end_date	timestamp	default null,
	display_name	varchar(254)	default null,
	description	varchar(254)	default null,
	catalog_ref_id	varchar(40)	not null,
	avail_status	integer	not null,
	availability_date	timestamp	default null,
	stock_level	integer	default null,
	stock_level_with_fraction	numeric(19,7)	default null,
	backorder_level	integer	default null,
	backorder_level_with_fraction	numeric(19,7)	default null,
	preorder_level	integer	default null,
	preorder_level_with_fraction	numeric(19,7)	default null,
	stock_thresh	integer	default null,
	backorder_thresh	integer	default null,
	preorder_thresh	integer	default null
,constraint dcs_inventory_p primary key (inventory_id));

create unique index inv_catloc_idx on dcs_inventory (catalog_ref_id,location_id);
create index inv_end_dte_idx on dcs_inventory (end_date);
create index inv_strt_dte_idx on dcs_inventory (start_date);

create table dcs_inv_atp (
	id	varchar(40)	not null,
	version	integer	not null,
	inventory_id	varchar(40)	default null,
	available_date	timestamp	not null,
	quantity	integer	not null,
	quantity_with_fraction	numeric(19,7)	default null
,constraint dcs_inv_atp_p primary key (id));

commit;



-- the source for this section is 
-- promotion_ddl.sql




-- Add the DCS_PRM_FOLDER table, promotionFolder

create table dcs_prm_folder (
	folder_id	varchar(40)	not null,
	name	varchar(254)	not null,
	parent_folder	varchar(40)	default null
,constraint dcs_prm_folder_p primary key (folder_id)
,constraint dcs_prm_prntfol_f foreign key (parent_folder) references dcs_prm_folder (folder_id));

create index prm_prntfol_idx on dcs_prm_folder (parent_folder);

create table dcs_stacking_rule (
	stacking_rule_id	varchar(40)	not null,
	display_name	varchar(254)	default null,
	order_limits	integer	default null,
	last_modified	timestamp	default null
,constraint dcs_sr_p primary key (stacking_rule_id));


create table dcs_excl_stacking_rules (
	stacking_rule_id	varchar(40)	not null,
	excl_stacking_rule_id	varchar(40)	not null
,constraint dcs_excl_sr1_d_f foreign key (stacking_rule_id) references dcs_stacking_rule (stacking_rule_id)
,constraint dcs_excl_sr2_d_f foreign key (excl_stacking_rule_id) references dcs_stacking_rule (stacking_rule_id));

create index dcs_excl_sr1_x on dcs_excl_stacking_rules (stacking_rule_id);
create index dcs_excl_sr2_x on dcs_excl_stacking_rules (excl_stacking_rule_id);

create table dcs_promotion (
	promotion_id	varchar(40)	not null,
	version	integer	not null,
	creation_date	timestamp	default null,
	start_date	timestamp	default null,
	end_date	timestamp	default null,
	display_name	varchar(254)	default null,
	description	varchar(254)	default null,
	promotion_type	integer	default null,
	enabled	numeric(1,0)	default null,
	begin_usable	timestamp	default null,
	end_usable	timestamp	default null,
	priority	integer	default null,
	evaluation_limit	integer	default null,
	global	numeric(1,0)	default null,
	anon_profile	numeric(1,0)	default null,
	allow_multiple	numeric(1,0)	default null,
	uses	integer	default null,
	rel_expiration	numeric(1,0)	default null,
	time_until_expire	integer	default null,
	template	varchar(254)	default null,
	ui_access_lvl	integer	default null,
	parent_folder	varchar(40)	default null,
	last_modified	timestamp	default null,
	pmdl_version	integer	default null,
	eval_target_items_first	numeric(1)	default null,
	qualifier	varchar(254)	default null,
	stacking_rule	varchar(40)	default null,
	fil_Qual_Discounted_By_Any	numeric(1)	default null,
	fil_Qual_Discounted_By_Current	numeric(1)	default null,
	fil_Qual_Acted_As_Qual	numeric(1)	default null,
	fil_Qual_On_Sale	numeric(1)	default null,
	fil_Qual_Zero_Prices	numeric(1)	default null,
	fil_Qual_Neg_Prices	numeric(1)	default null,
	fil_Tar_Acted_As_Qual	numeric(1)	default null,
	fil_Tar_Discounted_By_Current	numeric(1)	default null,
	fil_Tar_Discounted_By_Any	numeric(1)	default null,
	fil_Target_On_Sale	numeric(1)	default null,
	fil_Tar_Zero_Prices	numeric(1)	default null,
	fil_Tar_Neg_Prices	numeric(1)	default null,
	fil_Tar_Price_LTOET_Prm_Price	numeric(1)	default null
,constraint dcs_promotion_p primary key (promotion_id)
,constraint dcs_prm_fol_f foreign key (parent_folder) references dcs_prm_folder (folder_id)
,constraint dcs_sta_rule_f foreign key (stacking_rule) references dcs_stacking_rule (stacking_rule_id)
,constraint dcs_promotion1_c check (enabled in (0,1))
,constraint dcs_promotion2_c check (global in (0,1))
,constraint dcs_promotion3_c check (anon_profile in (0,1))
,constraint dcs_promotion4_c check (allow_multiple in (0,1))
,constraint dcs_promotion5_c check (rel_expiration in (0,1))
,constraint dcs_promotion6_c check (eval_target_items_first in (0,1)));

create index promo_folder_idx on dcs_promotion (parent_folder);
create index stacking_rule_idx on dcs_promotion (stacking_rule);
create index prmo_bgin_use_idx on dcs_promotion (begin_usable);
create index prmo_end_dte_idx on dcs_promotion (end_date);
create index prmo_end_use_idx on dcs_promotion (end_usable);
create index prmo_strt_dte_idx on dcs_promotion (start_date);

create table dcs_promo_media (
	promotion_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	media_id	varchar(40)	not null
,constraint dcs_promo_media_p primary key (promotion_id,tag)
,constraint dcs_prommdmed_d_f foreign key (media_id) references dcs_media (media_id)
,constraint dcs_prompromtn_d_f foreign key (promotion_id) references dcs_promotion (promotion_id));

create index promo_mdia_mid_idx on dcs_promo_media (media_id);
create index promo_mdia_pid_idx on dcs_promo_media (promotion_id);

create table dcs_promo_payment (
	promotion_id	varchar(40)	not null,
	payment_type	varchar(40)	not null);


create table dcs_discount_promo (
	promotion_id	varchar(40)	not null,
	calculator	varchar(254)	default null,
	adjuster	numeric(19,7)	default null,
	pmdl_rule	long varchar	not null,
	one_use	numeric(1,0)	default null
,constraint dcs_discount_pro_p primary key (promotion_id)
,constraint dcs_discpromtn_d_f foreign key (promotion_id) references dcs_promotion (promotion_id)
,constraint dcs_discount_pro_c check (one_use in (0, 1)));


create table dcs_promo_upsell (
	promotion_id	varchar(40)	not null,
	upsell	numeric(1,0)	default null
,constraint dcs_promo_upsell_p primary key (promotion_id)
,constraint dcs_proupsell_d_f foreign key (promotion_id) references dcs_promotion (promotion_id)
,constraint dcs_promo_upsell_c check (upsell in (0, 1)));


create table dcs_upsell_action (
	action_id	varchar(40)	not null,
	version	integer	not null,
	name	varchar(40)	not null,
	upsell_prd_grp	long varchar	default null
,constraint dcs_upsell_actn_p primary key (action_id));


create table dcs_close_qualif (
	close_qualif_id	varchar(40)	not null,
	version	integer	not null,
	name	varchar(254)	not null,
	priority	integer	default null,
	qualifier	long varchar	default null,
	upsell_media	varchar(40)	default null,
	upsell_action	varchar(40)	default null
,constraint dcs_close_qualif_p primary key (close_qualif_id)
,constraint dcs_cq_media_d_f foreign key (upsell_media) references dcs_media (media_id)
,constraint dcs_cq_action_d_f foreign key (upsell_action) references dcs_upsell_action (action_id));

create index dcs_closequalif2_x on dcs_close_qualif (upsell_media);
create index dcs_closequalif1_x on dcs_close_qualif (upsell_action);

create table dcs_prm_cls_qlf (
	promotion_id	varchar(40)	not null,
	closeness_qualif	varchar(40)	not null
,constraint dcs_promo_cq_d_f foreign key (promotion_id) references dcs_promotion (promotion_id)
,constraint dcs_prmclsqlf_d_f foreign key (closeness_qualif) references dcs_close_qualif (close_qualif_id));

create index dcs_prm_cls_qlf2_x on dcs_prm_cls_qlf (promotion_id);
create index dcs_prm_cls_qlf1_x on dcs_prm_cls_qlf (closeness_qualif);

create table dcs_prm_sites (
	promotion_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_prm_sites1_d_f foreign key (promotion_id) references dcs_promotion (promotion_id)
,constraint dcs_prm_sites2_d_f foreign key (site_id) references site_configuration (id));

create index dcs_prm_sites1_x on dcs_prm_sites (promotion_id);
create index dcs_prm_sites2_x on dcs_prm_sites (site_id);

create table dcs_prm_site_grps (
	promotion_id	varchar(40)	not null,
	site_group_id	varchar(40)	not null
,constraint dcs_prm_sgrps1_d_f foreign key (promotion_id) references dcs_promotion (promotion_id)
,constraint dcs_prm_sgrps2_d_f foreign key (site_group_id) references site_group (id));

create index dcs_prm_sgrps1_x on dcs_prm_site_grps (promotion_id);
create index dcs_prm_sgrps2_x on dcs_prm_site_grps (site_group_id);

create table dcs_prm_tpl_vals (
	promotion_id	varchar(40)	not null,
	placeholder	varchar(40)	not null,
	placeholderValue	long varchar	default null
,constraint dcs_prm_tpl_vals_p primary key (promotion_id,placeholder)
,constraint dcs_prmtplvals_d_f foreign key (promotion_id) references dcs_promotion (promotion_id));


create table dcs_prm_cls_vals (
	close_qualif_id	varchar(40)	not null,
	placeholder	varchar(40)	not null,
	placeholderValue	long varchar	default null
,constraint dcs_prm_cls_vals_p primary key (close_qualif_id,placeholder)
,constraint dcs_prmclsvals_d_f foreign key (close_qualif_id) references dcs_close_qualif (close_qualif_id));


create table dcs_upsell_prods (
	action_id	varchar(40)	not null,
	product_id	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcs_upsell_prods_p primary key (action_id,product_id)
,constraint dcs_ups_prod_d_f foreign key (product_id) references dcs_product (product_id));

create index dcs_upsellprods1_x on dcs_upsell_prods (product_id);

create table dcs_excl_promotions (
	promotion_id	varchar(40)	not null,
	excl_promotion_id	varchar(40)	not null
,constraint dcs_excl_pr1_d_f foreign key (promotion_id) references dcs_promotion (promotion_id)
,constraint dcs_excl_pr2_d_f foreign key (excl_promotion_id) references dcs_promotion (promotion_id));

create index dcs_excl_pr1_x on dcs_excl_promotions (promotion_id);
create index dcs_excl_pr2_x on dcs_excl_promotions (excl_promotion_id);

create table dcs_incl_promotions (
	promotion_id	varchar(40)	not null,
	incl_promotion_id	varchar(40)	not null
,constraint dcs_incl_pr1_d_f foreign key (promotion_id) references dcs_promotion (promotion_id)
,constraint dcs_incl_pr2_d_f foreign key (incl_promotion_id) references dcs_promotion (promotion_id));

create index dcs_incl_pr1_x on dcs_incl_promotions (promotion_id);
create index dcs_incl_pr2_x on dcs_incl_promotions (incl_promotion_id);
commit;



-- the source for this section is 
-- user_promotion_ddl.sql




-- The promotion line was commented out to allow the profile and promotion tables to be delinked. The promotion tables are intended to be used as a "read-only" table on the production servers. The promotion (and product catalog) tables are promoted and made active on the production system through copy-switch. In doing so, the profile tables and the promotion tables cannot be in the same database, and therefore we must remove this referece. However if you are not going to use copy-switch for the promotions, then you can add this reference back in.     promotion			VARCHAR(40)		NOT NULL	REFERENCES dcs_promotion(promotion_id),

create table dcs_usr_promostat (
	status_id	varchar(40)	not null,
	profile_id	varchar(40)	not null,
	promotion	varchar(40)	not null,
	num_uses	integer	default null,
	expirationDate	timestamp	default null,
	granted_date	timestamp	default null
,constraint dcs_usr_promosta_p primary key (status_id));

create index promostat_prof_idx on dcs_usr_promostat (profile_id);
create index usr_prmstat_pr_idx on dcs_usr_promostat (promotion);

create table dcs_usr_actvpromo (
	id	varchar(40)	not null,
	sequence_num	integer	not null,
	promo_status_id	varchar(40)	not null
,constraint dcs_usr_actvprom_p primary key (id,sequence_num)
,constraint usr_actvprm_id_f foreign key (id) references dps_user (id)
,constraint usr_actvprm_stat_f foreign key (promo_status_id) references dcs_usr_promostat (status_id));

create index usr_actvprm_ps_idx on dcs_usr_actvpromo (promo_status_id);
create index usr_actvprm_id_idx on dcs_usr_actvpromo (id);

create table dcs_promo_st_cpn (
	status_id	varchar(40)	not null,
	sequence_num	integer	not null,
	coupon_id	varchar(40)	not null
,constraint dcs_promo_st_cpn_p primary key (status_id,sequence_num));

-- The promotion_id column was commented out to allow the profile and promotion tables to be delinked. The promotion tables are intended to be used as a "read-only" table on the production servers. The promotion (and product catalog) tables are promoted and made active on the production system through copy-switch. In doing so, the profile tables and the promotion tables cannot be in the same database, and therefore we must remove this referece. However if you are not going to use copy-switch for the promotions, then you can add this reference back in.        promotion_id                    VARCHAR(40)             NOT NULL        REFERENCES dcs_promotion(promotion_id),

create table dcs_usr_usedpromo (
	id	varchar(40)	not null,
	promotion_id	varchar(40)	not null
,constraint dcs_usr_usedprom_p primary key (id,promotion_id));

create index usr_usedprm_id_idx on dcs_usr_usedpromo (id);
create index usr_usedprm_pi_idx on dcs_usr_usedpromo (promotion_id);
commit;



-- the source for this section is 
-- user_giftlist_ddl.sql





create table dcs_giftlist (
	id	varchar(40)	not null,
	owner_id	varchar(40)	default null,
	site_id	varchar(40)	default null,
	is_public	numeric(1,0)	not null,
	is_published	numeric(1,0)	not null,
	event_name	varchar(64)	default null,
	event_type	integer	default null,
	event_date	timestamp	default null,
	comments	varchar(254)	default null,
	description	varchar(254)	default null,
	instructions	varchar(254)	default null,
	creation_date	timestamp	default null,
	last_modified_date	timestamp	default null,
	shipping_addr_id	varchar(40)	default null
,constraint dcs_giftlist_p primary key (id)
,constraint dcs_giftlist1_c check (is_public in (0,1))
,constraint dcs_giftlist2_c check (is_published in (0,1)));

create index gftlst_shpadid_idx on dcs_giftlist (shipping_addr_id);
create index gft_evnt_name_idx on dcs_giftlist (event_name);
create index gft_evnt_type_idx on dcs_giftlist (event_type);
create index gft_owner_id_idx on dcs_giftlist (owner_id);
create index gft_site_id_idx on dcs_giftlist (site_id);

create table dcs_giftinst (
	giftlist_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	special_inst	varchar(254)	default null
,constraint dcs_giftinst_p primary key (giftlist_id,tag)
,constraint dcs_giftgiftlst__f foreign key (giftlist_id) references dcs_giftlist (id));

create index giftinst_gflid_idx on dcs_giftinst (giftlist_id);

create table dcs_giftitem (
	id	varchar(40)	not null,
	catalog_ref_id	varchar(40)	default null,
	product_id	varchar(40)	default null,
	site_id	varchar(40)	default null,
	display_name	varchar(254)	default null,
	description	varchar(254)	default null,
	quantity_desired	integer	default null,
	quantity_purchased	integer	default null,
	qty_with_fraction_desired	numeric(19,7)	default null,
	qty_with_fraction_purchased	numeric(19,7)	default null
,constraint dcs_giftitem_p primary key (id));

create index giftitem_cat_idx on dcs_giftitem (catalog_ref_id);
create index giftitem_prod_idx on dcs_giftitem (product_id);
create index giftitem_site_idx on dcs_giftitem (site_id);

create table dcs_giftlist_item (
	giftlist_id	varchar(40)	not null,
	sequence_num	integer	not null,
	giftitem_id	varchar(40)	default null
,constraint dcs_giftlist_ite_p primary key (giftlist_id,sequence_num)
,constraint dcs_giftgifttm_d_f foreign key (giftitem_id) references dcs_giftitem (id)
,constraint dcs_gftlstgftlst_f foreign key (giftlist_id) references dcs_giftlist (id));

create index gftlst_itm_gii_idx on dcs_giftlist_item (giftitem_id);
create index gftlst_itm_gli_idx on dcs_giftlist_item (giftlist_id);

create table dcs_user_wishlist (
	user_id	varchar(40)	not null,
	giftlist_id	varchar(40)	default null
,constraint dcs_user_wishlis_p primary key (user_id)
,constraint dcs_usrwgiftlst__f foreign key (giftlist_id) references dcs_giftlist (id));

create index usr_wshlst_gli_idx on dcs_user_wishlist (giftlist_id);

create table dcs_user_giftlist (
	user_id	varchar(40)	not null,
	sequence_num	integer	not null,
	giftlist_id	varchar(40)	default null
,constraint dcs_user_giftlis_p primary key (user_id,sequence_num)
,constraint dcs_usrgiftlst__f foreign key (giftlist_id) references dcs_giftlist (id));

create index usr_gftlst_gli_idx on dcs_user_giftlist (giftlist_id);
create index usr_gftlst_uid_idx on dcs_user_giftlist (user_id);

create table dcs_user_otherlist (
	user_id	varchar(40)	not null,
	sequence_num	integer	not null,
	giftlist_id	varchar(40)	default null
,constraint dcs_user_otherli_p primary key (user_id,sequence_num)
,constraint dcs_usrtgiftlst__f foreign key (giftlist_id) references dcs_giftlist (id));

create index usr_otrlst_gli_idx on dcs_user_otherlist (giftlist_id);
commit;



-- the source for this section is 
-- order_ddl.sql





create table dcspp_order (
	order_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	order_class_type	varchar(40)	default null,
	profile_id	varchar(40)	default null,
	organization_id	varchar(40)	default null,
	description	varchar(64)	default null,
	state	varchar(40)	default null,
	state_detail	varchar(254)	default null,
	created_by_order	varchar(40)	default null,
	origin_of_order	integer	default null,
	creation_date	timestamp	default null,
	submitted_date	timestamp	default null,
	last_modified_date	timestamp	default null,
	completed_date	timestamp	default null,
	price_info	varchar(40)	default null,
	tax_price_info	varchar(40)	default null,
	explicitly_saved	numeric(1,0)	default null,
	agent_id	varchar(40)	default null,
	sales_channel	integer	default null,
	creation_site_id	varchar(40)	default null,
	site_id	varchar(40)	default null,
	gwp	numeric(1,0)	default null,
	quote_info	varchar(40)	default null,
	active_quote_order_id	varchar(40)	default null,
	configurator_id	varchar(254)	default null
,constraint dcspp_order_p primary key (order_id)
,constraint dcspp_order_c check (explicitly_saved IN (0,1)));

create index order_lastmod_idx on dcspp_order (last_modified_date);
create index order_profile_idx on dcspp_order (profile_id);
create index order_submit_idx on dcspp_order (submitted_date);
create index ord_creat_site_idx on dcspp_order (creation_site_id);
create index ord_site_idx on dcspp_order (site_id);
create index ord_activequote_idx on dcspp_order (active_quote_order_id);
create index ord_organization_idx on dcspp_order (organization_id);

create table dcspp_ship_group (
	shipping_group_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	shipgrp_class_type	varchar(40)	default null,
	shipping_method	varchar(40)	default null,
	description	varchar(64)	default null,
	ship_on_date	timestamp	default null,
	actual_ship_date	timestamp	default null,
	state	varchar(40)	default null,
	state_detail	varchar(254)	default null,
	submitted_date	timestamp	default null,
	price_info	varchar(40)	default null,
	order_ref	varchar(40)	default null
,constraint dcspp_ship_group_p primary key (shipping_group_id));


create table dcspp_pay_group (
	payment_group_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	paygrp_class_type	varchar(40)	default null,
	payment_method	varchar(40)	default null,
	amount	numeric(19,7)	default null,
	amount_authorized	numeric(19,7)	default null,
	amount_debited	numeric(19,7)	default null,
	amount_credited	numeric(19,7)	default null,
	currency_code	varchar(10)	default null,
	state	varchar(40)	default null,
	state_detail	varchar(254)	default null,
	submitted_date	timestamp	default null,
	order_ref	varchar(40)	default null
,constraint dcspp_pay_group_p primary key (payment_group_id));


create table dcspp_item (
	commerce_item_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	item_class_type	varchar(40)	default null,
	catalog_id	varchar(40)	default null,
	catalog_ref_id	varchar(40)	default null,
	external_id	varchar(40)	default null,
	catalog_key	varchar(40)	default null,
	product_id	varchar(40)	default null,
	site_id	varchar(40)	default null,
	quantity	numeric(19,0)	default null,
	quantity_with_fraction	numeric(19,7)	default null,
	state	varchar(40)	default null,
	state_detail	varchar(254)	default null,
	price_info	varchar(40)	default null,
	order_ref	varchar(40)	default null,
	gwp	numeric(1,0)	default null
,constraint dcspp_item_p primary key (commerce_item_id));

create index item_catref_idx on dcspp_item (catalog_ref_id);
create index item_prodref_idx on dcspp_item (product_id);
create index item_site_idx on dcspp_item (site_id);

create table dcspp_relationship (
	relationship_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	rel_class_type	varchar(40)	default null,
	relationship_type	varchar(40)	default null,
	order_ref	varchar(40)	default null
,constraint dcspp_relationsh_p primary key (relationship_id));


create table dcspp_rel_orders (
	order_id	varchar(40)	not null,
	related_orders	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_rel_orders_p primary key (order_id,sequence_num)
,constraint dcspp_reordr_d_f foreign key (order_id) references dcspp_order (order_id));


create table dcspp_order_inst (
	order_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	special_inst	varchar(254)	default null
,constraint dcspp_order_inst_p primary key (order_id,tag)
,constraint dcspp_orordr_d_f foreign key (order_id) references dcspp_order (order_id));

create index order_inst_oid_idx on dcspp_order_inst (order_id);

create table dcspp_order_sg (
	order_id	varchar(40)	not null,
	shipping_groups	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_order_sg_p primary key (order_id,sequence_num)
,constraint dcspp_sgordr_d_f foreign key (order_id) references dcspp_order (order_id));

create index order_sg_ordid_idx on dcspp_order_sg (order_id);

create table dcspp_order_pg (
	order_id	varchar(40)	not null,
	payment_groups	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_order_pg_p primary key (order_id,sequence_num)
,constraint dcspp_orpgordr_f foreign key (order_id) references dcspp_order (order_id));

create index order_pg_ordid_idx on dcspp_order_pg (order_id);

create table dcspp_order_item (
	order_id	varchar(40)	not null,
	commerce_items	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_order_item_p primary key (order_id,sequence_num)
,constraint dcspp_oritordr_d_f foreign key (order_id) references dcspp_order (order_id));

create index order_item_oid_idx on dcspp_order_item (order_id);
create index order_item_cit_idx on dcspp_order_item (commerce_items);

create table dcspp_order_rel (
	order_id	varchar(40)	not null,
	relationships	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_order_rel_p primary key (order_id,sequence_num)
,constraint dcspp_orlordr_d_f foreign key (order_id) references dcspp_order (order_id));

create index order_rel_orid_idx on dcspp_order_rel (order_id);

create table dcspp_ship_inst (
	shipping_group_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	special_inst	varchar(254)	default null
,constraint dcspp_ship_inst_p primary key (shipping_group_id,tag)
,constraint dcspp_shshippng__f foreign key (shipping_group_id) references dcspp_ship_group (shipping_group_id));

create index ship_inst_sgid_idx on dcspp_ship_inst (shipping_group_id);

create table dcspp_hrd_ship_grp (
	shipping_group_id	varchar(40)	not null,
	tracking_number	varchar(40)	default null
,constraint dcspp_hrd_ship_g_p primary key (shipping_group_id)
,constraint dcspp_hrshippng__f foreign key (shipping_group_id) references dcspp_ship_group (shipping_group_id));


create table dcspp_ele_ship_grp (
	shipping_group_id	varchar(40)	not null,
	email_address	varchar(255)	default null
,constraint dcspp_ele_ship_g_p primary key (shipping_group_id)
,constraint dcspp_elshippng__f foreign key (shipping_group_id) references dcspp_ship_group (shipping_group_id));


create table dcspp_isp_ship_grp (
	shipping_group_id	varchar(40)	not null,
	location_id	varchar(40)	not null,
	first_name	varchar(40)	default null,
	middle_name	varchar(40)	default null,
	last_name	varchar(40)	default null
,constraint dcspp_isp_ship_g_p primary key (shipping_group_id)
,constraint dcspp_ispshippng__f foreign key (shipping_group_id) references dcspp_ship_group (shipping_group_id));


create table dcspp_ship_addr (
	shipping_group_id	varchar(40)	not null,
	prefix	varchar(40)	default null,
	first_name	varchar(40)	default null,
	middle_name	varchar(40)	default null,
	last_name	varchar(40)	default null,
	suffix	varchar(40)	default null,
	job_title	varchar(40)	default null,
	company_name	varchar(40)	default null,
	address_1	varchar(50)	default null,
	address_2	varchar(50)	default null,
	address_3	varchar(50)	default null,
	city	varchar(40)	default null,
	county	varchar(40)	default null,
	state	varchar(40)	default null,
	postal_code	varchar(10)	default null,
	country	varchar(40)	default null,
	phone_number	varchar(40)	default null,
	fax_number	varchar(40)	default null,
	email	varchar(255)	default null
,constraint dcspp_ship_addr_p primary key (shipping_group_id)
,constraint dcspp_shdshippng_f foreign key (shipping_group_id) references dcspp_ship_group (shipping_group_id));


create table dcspp_hand_inst (
	handling_inst_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	hndinst_class_type	varchar(40)	default null,
	handling_method	varchar(40)	default null,
	shipping_group_id	varchar(40)	default null,
	commerce_item_id	varchar(40)	default null,
	quantity	integer	default null,
	quantity_with_fraction	numeric(19,7)	default null
,constraint dcspp_hand_inst_p primary key (handling_inst_id));

create index hi_item_idx on dcspp_hand_inst (commerce_item_id);
create index hi_ship_group_idx on dcspp_hand_inst (shipping_group_id);

create table dcspp_gift_inst (
	handling_inst_id	varchar(40)	not null,
	giftlist_id	varchar(40)	default null,
	giftlist_item_id	varchar(40)	default null
,constraint dcspp_gift_inst_p primary key (handling_inst_id)
,constraint dcspp_gihandlng__f foreign key (handling_inst_id) references dcspp_hand_inst (handling_inst_id));


create table dcspp_sg_hand_inst (
	shipping_group_id	varchar(40)	not null,
	handling_instrs	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_sg_hand_in_p primary key (shipping_group_id,sequence_num)
,constraint dcspp_sgshippng__f foreign key (shipping_group_id) references dcspp_ship_group (shipping_group_id));

create index sg_hnd_ins_sgi_idx on dcspp_sg_hand_inst (shipping_group_id);

create table dcspp_pay_inst (
	payment_group_id	varchar(40)	not null,
	tag	varchar(42)	not null,
	special_inst	varchar(254)	default null
,constraint dcspp_pay_inst_p primary key (payment_group_id,tag)
,constraint dcspp_papaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id));

create index pay_inst_pgrid_idx on dcspp_pay_inst (payment_group_id);

create table dcspp_config_item (
	config_item_id	varchar(40)	not null,
	reconfig_data	varchar(255)	default null,
	notes	varchar(255)	default null,
	configured	numeric(1)	default null,
	configurator_id	varchar(254)	default null
,constraint dcspp_config_ite_p primary key (config_item_id)
,constraint dcspp_coconfg_tm_f foreign key (config_item_id) references dcspp_item (commerce_item_id));


create table dcspp_subsku_item (
	subsku_item_id	varchar(40)	not null,
	ind_quantity	integer	default null,
	config_prop_id	varchar(40)	default null,
	config_opt_id	varchar(40)	default null
,constraint dcspp_subsku_ite_p primary key (subsku_item_id)
,constraint dcspp_susubsk_tm_f foreign key (subsku_item_id) references dcspp_item (commerce_item_id));


create table dcspp_config_subsku_item (
	subsku_item_id	varchar(40)	not null,
	config_prop_id	varchar(40)	default null,
	config_opt_id	varchar(40)	default null
,constraint dcspp_cfg_subsku_ite_p primary key (subsku_item_id)
,constraint dcspp_cfg_subsku_tm_f foreign key (subsku_item_id) references dcspp_item (commerce_item_id));


create table dcspp_item_ci (
	commerce_item_id	varchar(40)	not null,
	commerce_items	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_item_ci_p primary key (commerce_item_id,sequence_num)
,constraint dcspp_itcommrc_t_f foreign key (commerce_item_id) references dcspp_item (commerce_item_id));


create table dcspp_gift_cert (
	payment_group_id	varchar(40)	not null,
	profile_id	varchar(40)	default null,
	gift_cert_number	varchar(50)	default null
,constraint dcspp_gift_cert_p primary key (payment_group_id)
,constraint dcspp_gipaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id));

create index gc_number_idx on dcspp_gift_cert (gift_cert_number);
create index gc_profile_idx on dcspp_gift_cert (profile_id);

create table dcspp_store_cred (
	payment_group_id	varchar(40)	not null,
	profile_id	varchar(40)	default null,
	store_cred_number	varchar(50)	default null
,constraint dcspp_store_cred_p primary key (payment_group_id)
,constraint dcspp_stpaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id));

create index sc_number_idx on dcspp_store_cred (store_cred_number);
create index sc_profile_idx on dcspp_store_cred (profile_id);

create table dcspp_credit_card (
	payment_group_id	varchar(40)	not null,
	credit_card_number	varchar(40)	default null,
	credit_card_type	varchar(40)	default null,
	expiration_month	varchar(20)	default null,
	exp_day_of_month	varchar(20)	default null,
	expiration_year	varchar(20)	default null
,constraint dcspp_credit_car_p primary key (payment_group_id)
,constraint dcspp_crpaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id));


create table dcspp_token_crdt_crd (
	payment_group_id	varchar(40)	not null,
	token	varchar(40)	not null
,constraint dcspp_token_crdt_crd_p primary key (payment_group_id)
,constraint dcspp_tokencrdtcrd__f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id));


create table dcspp_bill_addr (
	payment_group_id	varchar(40)	not null,
	prefix	varchar(40)	default null,
	first_name	varchar(40)	default null,
	middle_name	varchar(40)	default null,
	last_name	varchar(40)	default null,
	suffix	varchar(40)	default null,
	job_title	varchar(40)	default null,
	company_name	varchar(40)	default null,
	address_1	varchar(50)	default null,
	address_2	varchar(50)	default null,
	address_3	varchar(50)	default null,
	city	varchar(40)	default null,
	county	varchar(40)	default null,
	state	varchar(40)	default null,
	postal_code	varchar(10)	default null,
	country	varchar(40)	default null,
	phone_number	varchar(40)	default null,
	fax_number	varchar(40)	default null,
	email	varchar(255)	default null
,constraint dcspp_bill_addr_p primary key (payment_group_id)
,constraint dcspp_bipaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id));


create table dcspp_pay_status (
	status_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	trans_id	varchar(50)	default null,
	amount	numeric(19,7)	default null,
	trans_success	numeric(1,0)	default null,
	error_message	varchar(254)	default null,
	trans_timestamp	timestamp	default null
,constraint dcspp_pay_status_p primary key (status_id)
,constraint dcspp_pay_status_c check (trans_success IN (0,1)));


create table dcspp_cc_status (
	status_id	varchar(40)	not null,
	auth_expiration	timestamp	default null,
	avs_code	varchar(40)	default null,
	avs_desc_result	varchar(254)	default null,
	integration_data	varchar(256)	default null
,constraint dcspp_cc_status_p primary key (status_id)
,constraint dcspp_ccstats_d_f foreign key (status_id) references dcspp_pay_status (status_id));


create table dcspp_gc_status (
	status_id	varchar(40)	not null,
	auth_expiration	timestamp	default null
,constraint dcspp_gc_status_p primary key (status_id)
,constraint dcspp_gcstats_d_f foreign key (status_id) references dcspp_pay_status (status_id));


create table dcspp_sc_status (
	status_id	varchar(40)	not null,
	auth_expiration	timestamp	default null
,constraint dcspp_sc_status_p primary key (status_id)
,constraint dcspp_scstats_d_f foreign key (status_id) references dcspp_pay_status (status_id));


create table dcspp_auth_status (
	payment_group_id	varchar(40)	not null,
	auth_status	varchar(254)	not null,
	sequence_num	integer	not null
,constraint dcspp_auth_statu_p primary key (payment_group_id,sequence_num)
,constraint dcspp_atpaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id));

create index auth_stat_pgid_idx on dcspp_auth_status (payment_group_id);

create table dcspp_debit_status (
	payment_group_id	varchar(40)	not null,
	debit_status	varchar(254)	not null,
	sequence_num	integer	not null
,constraint dcspp_debit_stat_p primary key (payment_group_id,sequence_num)
,constraint dcspp_depaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id));

create index debit_stat_pgi_idx on dcspp_debit_status (payment_group_id);

create table dcspp_cred_status (
	payment_group_id	varchar(40)	not null,
	credit_status	varchar(254)	not null,
	sequence_num	integer	not null
,constraint dcspp_cred_statu_p primary key (payment_group_id,sequence_num)
,constraint dcspp_crpaymntgr_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id));

create index cred_stat_pgid_idx on dcspp_cred_status (payment_group_id);

create table dcspp_shipitem_rel (
	relationship_id	varchar(40)	not null,
	shipping_group_id	varchar(40)	default null,
	commerce_item_id	varchar(40)	default null,
	quantity	numeric(19,0)	default null,
	quantity_with_fraction	numeric(19,7)	default null,
	returned_qty	numeric(19,0)	default null,
	returned_qty_with_fraction	numeric(19,7)	default null,
	amount	numeric(19,7)	default null,
	state	varchar(40)	default null,
	state_detail	varchar(254)	default null
,constraint dcspp_shipitem_r_p primary key (relationship_id)
,constraint dcspp_shreltnshp_f foreign key (relationship_id) references dcspp_relationship (relationship_id));

create index sirel_item_idx on dcspp_shipitem_rel (commerce_item_id);
create index sirel_shipgrp_idx on dcspp_shipitem_rel (shipping_group_id);

create table dcspp_rel_range (
	relationship_id	varchar(40)	not null,
	low_bound	integer	default null,
	low_bound_with_fraction	numeric(19,7)	default null,
	high_bound	integer	default null,
	high_bound_with_fraction	numeric(19,7)	default null
,constraint dcspp_rel_range_p primary key (relationship_id));


create table dcspp_payitem_rel (
	relationship_id	varchar(40)	not null,
	payment_group_id	varchar(40)	default null,
	commerce_item_id	varchar(40)	default null,
	quantity	numeric(19,0)	default null,
	quantity_with_fraction	numeric(19,7)	default null,
	amount	numeric(19,7)	default null
,constraint dcspp_payitem_re_p primary key (relationship_id)
,constraint dcspp_pareltnshp_f foreign key (relationship_id) references dcspp_relationship (relationship_id));

create index pirel_item_idx on dcspp_payitem_rel (commerce_item_id);
create index pirel_paygrp_idx on dcspp_payitem_rel (payment_group_id);

create table dcspp_payship_rel (
	relationship_id	varchar(40)	not null,
	payment_group_id	varchar(40)	default null,
	shipping_group_id	varchar(40)	default null,
	amount	numeric(19,7)	default null
,constraint dcspp_payship_re_p primary key (relationship_id)
,constraint dcspp_pshrltnshp_f foreign key (relationship_id) references dcspp_relationship (relationship_id));

create index psrel_paygrp_idx on dcspp_payship_rel (payment_group_id);
create index psrel_shipgrp_idx on dcspp_payship_rel (shipping_group_id);

create table dcspp_payorder_rel (
	relationship_id	varchar(40)	not null,
	payment_group_id	varchar(40)	default null,
	order_id	varchar(40)	default null,
	amount	numeric(19,7)	default null
,constraint dcspp_payorder_r_p primary key (relationship_id)
,constraint dcspp_odreltnshp_f foreign key (relationship_id) references dcspp_relationship (relationship_id));

create index porel_order_idx on dcspp_payorder_rel (order_id);
create index porel_paygrp_idx on dcspp_payorder_rel (payment_group_id);

create table dcspp_amount_info (
	amount_info_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	currency_code	varchar(10)	default null,
	amount	numeric(19,7)	default null,
	discounted	numeric(1,0)	default null,
	amount_is_final	numeric(1,0)	default null,
	final_rc	integer	default null
,constraint dcspp_amount_inf_p primary key (amount_info_id)
,constraint dcspp_amount_in1_c check (discounted IN (0,1))
,constraint dcspp_amount_in2_c check (amount_is_final IN (0,1)));


create table dcspp_order_price (
	amount_info_id	varchar(40)	not null,
	raw_subtotal	numeric(19,7)	default null,
	tax	numeric(19,7)	default null,
	shipping	numeric(19,7)	default null,
	manual_adj_total	numeric(19,7)	default null
,constraint dcspp_order_pric_p primary key (amount_info_id)
,constraint dcspp_oramnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id));


create table dcspp_item_price (
	amount_info_id	varchar(40)	not null,
	list_price	numeric(19,7)	default null,
	raw_total_price	numeric(19,7)	default null,
	sale_price	numeric(19,7)	default null,
	on_sale	numeric(1,0)	default null,
	order_discount	numeric(19,7)	default null,
	qty_discounted	numeric(19,0)	default null,
	qty_with_fraction_discounted	numeric(19,7)	default null,
	qty_as_qualifier	numeric(19,0)	default null,
	qty_with_fraction_as_qualifier	numeric(19,7)	default null,
	price_list	varchar(40)	default null,
	discountable	numeric(1)	default null
,constraint dcspp_item_price_p primary key (amount_info_id)
,constraint dcspp_itamnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id)
,constraint dcspp_item_price_c check (on_sale IN (0,1)));


create table dcspp_tax_price (
	amount_info_id	varchar(40)	not null,
	city_tax	numeric(19,7)	default null,
	county_tax	numeric(19,7)	default null,
	state_tax	numeric(19,7)	default null,
	country_tax	numeric(19,7)	default null
,constraint dcspp_tax_price_p primary key (amount_info_id)
,constraint dcspp_taamnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id));


create table dcspp_ship_price (
	amount_info_id	varchar(40)	not null,
	raw_shipping	numeric(19,7)	default null
,constraint dcspp_ship_price_p primary key (amount_info_id)
,constraint dcspp_shamnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id));


create table dcspp_amtinfo_adj (
	amount_info_id	varchar(40)	not null,
	adjustments	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_amtinfo_ad_p primary key (amount_info_id,sequence_num)
,constraint dcspp_amamnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id));

create index amtinf_adj_aid_idx on dcspp_amtinfo_adj (amount_info_id);
create index amtinf_adj_adj_idx on dcspp_amtinfo_adj (adjustments);

create table dcspp_price_adjust (
	adjustment_id	varchar(40)	not null,
	version	integer	not null,
	adj_description	varchar(254)	default null,
	pricing_model	varchar(40)	default null,
	pricing_model_index	integer	default null,
	pricing_model_group_index	integer	default null,
	manual_adjustment	varchar(40)	default null,
	coupon_id	varchar(40)	default null,
	adjustment	numeric(19,7)	default null,
	qty_adjusted	integer	default null,
	qty_with_fraction_adjusted	numeric(19,7)	default null
,constraint dcspp_price_adju_p primary key (adjustment_id));


create table dcspp_shipitem_sub (
	amount_info_id	varchar(40)	not null,
	shipping_group_id	varchar(42)	not null,
	ship_item_subtotal	varchar(40)	not null
,constraint dcspp_shipitem_s_p primary key (amount_info_id,shipping_group_id)
,constraint dcspp_sbamnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id));

create index ship_item_sub_idx on dcspp_shipitem_sub (amount_info_id);

create table dcspp_taxshipitem (
	amount_info_id	varchar(40)	not null,
	shipping_group_id	varchar(42)	not null,
	tax_ship_item_sub	varchar(40)	not null
,constraint dcspp_taxshipite_p primary key (amount_info_id,shipping_group_id)
,constraint dcspp_shamntxnfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id));

create index tax_ship_item_idx on dcspp_taxshipitem (amount_info_id);

create table dcspp_ntaxshipitem (
	amount_info_id	varchar(40)	not null,
	shipping_group_id	varchar(42)	not null,
	non_tax_item_sub	varchar(40)	not null
,constraint dcspp_ntaxshipit_p primary key (amount_info_id,shipping_group_id)
,constraint dcspp_ntamnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id));

create index ntax_ship_item_idx on dcspp_ntaxshipitem (amount_info_id);

create table dcspp_shipitem_tax (
	amount_info_id	varchar(40)	not null,
	shipping_group_id	varchar(42)	not null,
	ship_item_tax	varchar(40)	not null
,constraint dcspp_shipitem_t_p primary key (amount_info_id,shipping_group_id)
,constraint dcspp_txamnt_nfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id));

create index ship_item_tax_idx on dcspp_shipitem_tax (amount_info_id);

create table dcspp_itmprice_det (
	amount_info_id	varchar(40)	not null,
	cur_price_details	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_itmprice_d_p primary key (amount_info_id,sequence_num)
,constraint dcspp_sbamntnfd_f foreign key (amount_info_id) references dcspp_amount_info (amount_info_id));

create index itmprc_det_aii_idx on dcspp_itmprice_det (amount_info_id);

create table dcspp_det_price (
	amount_info_id	varchar(40)	not null,
	tax	numeric(19,7)	default null,
	order_discount	numeric(19,7)	default null,
	order_manual_adj	numeric(19,7)	default null,
	quantity	numeric(19,0)	default null,
	quantity_with_fraction	numeric(19,7)	default null,
	qty_as_qualifier	numeric(19,0)	default null,
	qty_with_fraction_as_qualifier	numeric(19,7)	default null
,constraint dcspp_det_price_p primary key (amount_info_id));


create table dcspp_det_range (
	amount_info_id	varchar(40)	not null,
	low_bound	integer	default null,
	low_bound_with_fraction	numeric(19,7)	default null,
	high_bound	integer	default null,
	high_bound_with_fraction	numeric(19,7)	default null
,constraint dcspp_det_range_p primary key (amount_info_id));


create table dcspp_order_adj (
	order_id	varchar(40)	not null,
	adjustment_id	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcspp_order_adj_p primary key (order_id,sequence_num)
,constraint dcspp_oradj_d_f foreign key (order_id) references dcspp_order (order_id));

create index order_adj_orid_idx on dcspp_order_adj (order_id);

create table dcspp_quote_info (
	quote_info_id	varchar(40)	not null,
	request_date	timestamp	default null,
	expiration_date	timestamp	default null,
	rejection_date	timestamp	default null,
	requester_note	varchar(255)	default null,
	provider_note	varchar(255)	default null,
	rejection_note	varchar(255)	default null,
	external_id	varchar(40)	default null,
	agent_id	varchar(40)	default null,
	version	integer	not null
,constraint dcspp_quote_info_p primary key (quote_info_id));


create table dcspp_manual_adj (
	manual_adjust_id	varchar(40)	not null,
	type	integer	not null,
	adjustment_type	integer	not null,
	reason	integer	not null,
	amount	numeric(19,7)	default null,
	notes	varchar(255)	default null,
	version	integer	not null
,constraint dcspp_manual_adj_p primary key (manual_adjust_id));


create table dbcpp_sched_order (
	scheduled_order_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	name	varchar(32)	default null,
	profile_id	varchar(40)	default null,
	create_date	timestamp	default null,
	start_date	timestamp	default null,
	end_date	timestamp	default null,
	template_order	varchar(32)	default null,
	state	integer	default null,
	next_scheduled	timestamp	default null,
	schedule	varchar(255)	default null,
	site_id	varchar(40)	default null
,constraint dbcpp_sched_orde_p primary key (scheduled_order_id));

create index sched_tmplt_idx on dbcpp_sched_order (template_order);
create index sched_profile_idx on dbcpp_sched_order (profile_id);
create index sched_site_idx on dbcpp_sched_order (site_id);

create table dbcpp_sched_clone (
	scheduled_order_id	varchar(40)	not null,
	cloned_order	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dbcpp_sched_clon_p primary key (scheduled_order_id,sequence_num)
,constraint dbcpp_scschedld__f foreign key (scheduled_order_id) references dbcpp_sched_order (scheduled_order_id));


create table dcspp_scherr_aux (
	scheduled_order_id	varchar(40)	not null,
	sched_error_id	varchar(40)	not null
,constraint dcspp_scherr_aux_p primary key (scheduled_order_id));

create index sched_error_idx on dcspp_scherr_aux (sched_error_id);

create table dcspp_sched_error (
	sched_error_id	varchar(40)	not null,
	error_date	timestamp	not null
,constraint dcspp_sched_err_p primary key (sched_error_id));


create table dcspp_schd_errmsg (
	sched_error_id	varchar(40)	not null,
	error_txt	varchar(254)	not null,
	sequence_num	integer	not null
,constraint dcspp_schd_errs_p primary key (sched_error_id,sequence_num)
,constraint dcspp_sch_errs_f foreign key (sched_error_id) references dcspp_sched_error (sched_error_id));


create table dbcpp_approverids (
	order_id	varchar(40)	not null,
	approver_ids	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dbcpp_approverid_p primary key (order_id,sequence_num)
,constraint dbcpp_apordr_d_f foreign key (order_id) references dcspp_order (order_id));


create table dbcpp_authapprids (
	order_id	varchar(40)	not null,
	auth_appr_ids	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dbcpp_authapprid_p primary key (order_id,sequence_num)
,constraint dbcpp_atordr_d_f foreign key (order_id) references dcspp_order (order_id));


create table dbcpp_apprsysmsgs (
	order_id	varchar(40)	not null,
	appr_sys_msgs	varchar(254)	not null,
	sequence_num	integer	not null
,constraint dbcpp_apprsysmsg_p primary key (order_id,sequence_num)
,constraint dbcpp_sysmordr_d_f foreign key (order_id) references dcspp_order (order_id));


create table dbcpp_appr_msgs (
	order_id	varchar(40)	not null,
	approver_msgs	varchar(254)	not null,
	sequence_num	integer	not null
,constraint dbcpp_appr_msgs_p primary key (order_id,sequence_num)
,constraint dbcpp_msgordr_d_f foreign key (order_id) references dcspp_order (order_id));


create table dbcpp_invoice_req (
	payment_group_id	varchar(40)	not null,
	po_number	varchar(40)	default null,
	pref_format	varchar(40)	default null,
	pref_delivery	varchar(40)	default null,
	disc_percent	numeric(19,7)	default null,
	disc_days	integer	default null,
	net_days	integer	default null,
	pmt_due_date	timestamp	default null
,constraint dbcpp_invoice_re_p primary key (payment_group_id)
,constraint dbcpp_inpaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id));


create table dbcpp_cost_center (
	cost_center_id	varchar(40)	not null,
	type	integer	not null,
	version	integer	not null,
	costctr_class_type	varchar(40)	default null,
	identifier	varchar(40)	default null,
	amount	numeric(19,7)	default null,
	order_ref	varchar(40)	default null
,constraint dbcpp_cost_cente_p primary key (cost_center_id));


create table dbcpp_order_cc (
	order_id	varchar(40)	not null,
	cost_centers	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dbcpp_order_cc_p primary key (order_id,sequence_num)
,constraint dbcpp_orordr_d_f foreign key (order_id) references dcspp_order (order_id));

create index order_cc_ordid_idx on dbcpp_order_cc (order_id);

create table dbcpp_ccitem_rel (
	relationship_id	varchar(40)	not null,
	cost_center_id	varchar(40)	default null,
	commerce_item_id	varchar(40)	default null,
	quantity	numeric(19,0)	default null,
	quantity_with_fraction	numeric(19,7)	default null,
	amount	numeric(19,7)	default null
,constraint dbcpp_ccitem_rel_p primary key (relationship_id)
,constraint dbcpp_ccreltnshp_f foreign key (relationship_id) references dcspp_relationship (relationship_id));

create index cirel_cstctr_idx on dbcpp_ccitem_rel (cost_center_id);
create index cirel_item_idx on dbcpp_ccitem_rel (commerce_item_id);

create table dbcpp_ccship_rel (
	relationship_id	varchar(40)	not null,
	cost_center_id	varchar(40)	default null,
	shipping_group_id	varchar(40)	default null,
	amount	numeric(19,7)	default null
,constraint dbcpp_ccship_rel_p primary key (relationship_id)
,constraint dbcpp_shreltnshp_f foreign key (relationship_id) references dcspp_relationship (relationship_id));

create index csrel_cstctr_idx on dbcpp_ccship_rel (cost_center_id);
create index csrel_shipgrp_idx on dbcpp_ccship_rel (shipping_group_id);

create table dbcpp_ccorder_rel (
	relationship_id	varchar(40)	not null,
	cost_center_id	varchar(40)	default null,
	order_id	varchar(40)	default null,
	amount	numeric(19,7)	default null
,constraint dbcpp_ccorder_re_p primary key (relationship_id)
,constraint dbcpp_odreltnshp_f foreign key (relationship_id) references dcspp_relationship (relationship_id));

create index corel_cstctr_idx on dbcpp_ccorder_rel (cost_center_id);
create index corel_order_idx on dbcpp_ccorder_rel (order_id);

create table dbcpp_pmt_req (
	payment_group_id	varchar(40)	not null,
	req_number	varchar(40)	default null
,constraint dbcpp_pmt_req_p primary key (payment_group_id)
,constraint dbcpp_pmpaymnt_g_f foreign key (payment_group_id) references dcspp_pay_group (payment_group_id));

create index pmtreq_req_idx on dbcpp_pmt_req (req_number);

create table dcspp_appeasement (
	appeasement_id	varchar(40)	not null,
	order_id	varchar(40)	not null,
	type	varchar(40)	not null,
	status	varchar(40)	default null,
	creation_date	timestamp	not null,
	agent_id	varchar(40)	default null,
	profile_id	varchar(40)	not null,
	origin_of_appeasement	integer	not null,
	reason_code	varchar(40)	not null,
	comments	varchar(254)	default null,
	processed	numeric(3)	default null,
	appeasement_amount	numeric(19,7)	not null
,constraint dcs_appeasement_p primary key (appeasement_id));


create table dcspp_appeasement_reasons (
	id	varchar(40)	not null,
	description	varchar(254)	not null
,constraint appeasement_reasons_p primary key (id));


create table dcspp_appeasement_refund (
	id	varchar(40)	not null,
	type	integer	not null,
	amount	numeric(19,7)	default null
,constraint appsmt_refund_p primary key (id));


create table dcspp_appeasement_refunds (
	appeasement_id	varchar(40)	not null,
	appeasement_refund_id	varchar(40)	not null
,constraint appsmt_refunds_p primary key (appeasement_id,appeasement_refund_id)
,constraint appeasement_refund_d_f foreign key (appeasement_id) references dcspp_appeasement (appeasement_id)
,constraint appeasement_refund_m_f foreign key (appeasement_refund_id) references dcspp_appeasement_refund (id));

create index appsmt_refund_id on dcspp_appeasement_refunds (appeasement_refund_id);

create table dcspp_appeasement_refund_cc (
	appeasement_refund_id	varchar(40)	not null,
	payment_group_id	varchar(40)	not null
,constraint appsmt_refund_cc_p primary key (appeasement_refund_id)
,constraint appeasement_cc_m_f foreign key (appeasement_refund_id) references dcspp_appeasement_refund (id));


create table dcspp_appeasement_refund_sc (
	appeasement_refund_id	varchar(40)	not null,
	payment_group_id	varchar(40)	default null,
	sc_id	varchar(40)	default null
,constraint appsmt_refund_sc_p primary key (appeasement_refund_id)
,constraint appeasement_sc_m_f foreign key (appeasement_refund_id) references dcspp_appeasement_refund (id));

commit;



-- the source for this section is 
-- dcs_mappers.sql





create table dcs_cart_event (
	id	varchar(40)	not null,
	timestamp	timestamp	default null,
	orderid	varchar(40)	default null,
	itemid	varchar(40)	default null,
	sessionid	varchar(100)	default null,
	parentsessionid	varchar(100)	default null,
	quantity	integer	default null,
	amount	numeric(19,7)	default null,
	profileid	varchar(40)	default null);


create table dcs_submt_ord_evt (
	id	varchar(40)	not null,
	clocktime	timestamp	default null,
	orderid	varchar(40)	default null,
	profileid	varchar(40)	default null,
	sessionid	varchar(100)	default null,
	parentsessionid	varchar(100)	default null);


create table dcs_prom_used_evt (
	id	varchar(40)	not null,
	clocktime	timestamp	default null,
	orderid	varchar(40)	default null,
	profileid	varchar(40)	default null,
	sessionid	varchar(100)	default null,
	parentsessionid	varchar(100)	default null,
	promotionid	varchar(40)	default null,
	order_amount	numeric(26,7)	default null,
	discount	numeric(26,7)	default null);


create table dcs_ord_merge_evt (
	id	varchar(40)	not null,
	clocktime	timestamp	default null,
	sourceorderid	varchar(40)	default null,
	destorderid	varchar(40)	default null,
	profileid	varchar(40)	default null,
	sessionid	varchar(100)	default null,
	parentsessionid	varchar(100)	default null,
	sourceremoved	numeric(1,0)	default null
,constraint dcs_ordmergeevt_ck check (sourceremoved in (0,1)));


create table dcs_promo_rvkd (
	id	varchar(40)	not null,
	time_stamp	timestamp	default null,
	promotionid	varchar(254)	not null,
	profileid	varchar(254)	not null,
	sessionid	varchar(100)	default null,
	parentsessionid	varchar(100)	default null);


create table dcs_promo_grntd (
	id	varchar(40)	not null,
	time_stamp	timestamp	default null,
	promotionid	varchar(254)	not null,
	profileid	varchar(254)	not null,
	sessionid	varchar(100)	default null,
	parentsessionid	varchar(100)	default null);

commit;



-- the source for this section is 
-- claimable_ddl.sql





create table dcspp_claimable (
	claimable_id	varchar(40)	not null,
	version	integer	not null,
	type	integer	not null,
	status	integer	default null,
	start_date	timestamp	default null,
	expiration_date	timestamp	default null,
	last_modified	timestamp	default null
,constraint dcspp_claimable_p primary key (claimable_id));


create table dcspp_giftcert (
	giftcertificate_id	varchar(40)	not null,
	amount	double precision	not null,
	amount_authorized	double precision	not null,
	amount_remaining	double precision	not null,
	purchaser_id	varchar(40)	default null,
	purchase_date	timestamp	default null,
	last_used	timestamp	default null
,constraint dcspp_giftcert_p primary key (giftcertificate_id)
,constraint dcspp_gigiftcrtf_f foreign key (giftcertificate_id) references dcspp_claimable (claimable_id));

create index claimable_user_idx on dcspp_giftcert (purchaser_id);

create table dcs_storecred_clm (
	store_credit_id	varchar(40)	not null,
	amount	numeric(19,7)	not null,
	amount_authorized	numeric(19,7)	not null,
	amount_remaining	numeric(19,7)	not null,
	owner_id	varchar(40)	default null,
	issue_date	timestamp	default null,
	expiration_date	timestamp	default null,
	last_used	timestamp	default null
,constraint dcs_storecred_cl_p primary key (store_credit_id)
,constraint dcs_storstor_crd_f foreign key (store_credit_id) references dcspp_claimable (claimable_id));

create index storecr_issue_idx on dcs_storecred_clm (issue_date);
create index storecr_owner_idx on dcs_storecred_clm (owner_id);

create table dcspp_cp_folder (
	folder_id	varchar(40)	not null,
	name	varchar(254)	not null,
	parent_folder	varchar(40)	default null
,constraint dcspp_cp_folder_p primary key (folder_id)
,constraint dcspp_cp_prntfol_f foreign key (parent_folder) references dcspp_cp_folder (folder_id));

create index dcspp_prntfol_idx on dcspp_cp_folder (parent_folder);

create table dcspp_coupon (
	coupon_id	varchar(40)	not null,
	promotion_id	varchar(40)	not null
,constraint dcspp_coupon_p primary key (coupon_id,promotion_id)
,constraint dcspp_coupon_df foreign key (coupon_id) references dcspp_claimable (claimable_id));


create table dcspp_coupon_info (
	coupon_id	varchar(40)	not null,
	display_name	varchar(254)	default null,
	use_promo_site	integer	default null,
	parent_folder	varchar(40)	default null,
	max_uses	integer	default null,
	uses	integer	default null
,constraint dcspp_copninfo_p primary key (coupon_id)
,constraint dcspp_copninfo_d_f foreign key (coupon_id) references dcspp_claimable (claimable_id)
,constraint dcspp_cpnifol_f foreign key (parent_folder) references dcspp_cp_folder (folder_id));

create index dcspp_folder_idx on dcspp_coupon_info (parent_folder);

create table dcspp_coupon_batch (
	id	varchar(40)	not null,
	code_prefix	varchar(40)	not null,
	number_of_coupons	integer	default null,
	seed_value	blob(128)	default null,
	codes_generated	numeric(1,0)	not null
,constraint dcspp_batch_cp_pk primary key (id)
,constraint code_prefix_idx unique (code_prefix));


create table dcspp_batch_claimable (
	coupon_id	varchar(40)	not null,
	coupon_batch	varchar(40)	default null
,constraint dcs_batch_claim_pk primary key (coupon_id));

commit;



-- the source for this section is 
-- priceLists_ddl.sql





create table dcs_price_list (
	price_list_id	varchar(40)	not null,
	version	integer	not null,
	display_name	varchar(254)	default null,
	description	varchar(254)	default null,
	creation_date	timestamp	default null,
	last_mod_date	timestamp	default null,
	start_date	timestamp	default null,
	end_date	timestamp	default null,
	locale	integer	default null,
	base_price_list	varchar(40)	default null,
	item_acl	varchar(1024)	default null
,constraint dcs_price_list_p primary key (price_list_id)
,constraint dcs_pricbas_prcl_f foreign key (base_price_list) references dcs_price_list (price_list_id));

create index dcs_pricelstbase_i on dcs_price_list (base_price_list);

create table dcs_complex_price (
	complex_price_id	varchar(40)	not null,
	version	integer	not null
,constraint dcs_complex_pric_p primary key (complex_price_id));


create table dcs_price (
	price_id	varchar(40)	not null,
	version	integer	not null,
	price_list	varchar(40)	not null,
	product_id	varchar(40)	default null,
	sku_id	varchar(40)	default null,
	parent_sku_id	varchar(40)	default null,
	pricing_scheme	integer	not null,
	list_price	double precision	default null,
	complex_price	varchar(40)	default null,
	start_date	timestamp	default null,
	end_date	timestamp	default null
,constraint dcs_price_p primary key (price_id)
,constraint dcs_priccomplx_p_f foreign key (complex_price) references dcs_complex_price (complex_price_id)
,constraint dcs_pricpric_lst_f foreign key (price_list) references dcs_price_list (price_list_id));

create index dcs_cmplx_prc_idx on dcs_price (complex_price);
create index dcs_price_idx1 on dcs_price (product_id);
create index dcs_price_idx2 on dcs_price (price_list,sku_id);

create table dcs_price_levels (
	complex_price_id	varchar(40)	not null,
	price_levels	varchar(40)	not null,
	sequence_num	integer	not null
,constraint dcs_price_levels_p primary key (complex_price_id,sequence_num)
,constraint dcs_lvlscomplx_p_f foreign key (complex_price_id) references dcs_complex_price (complex_price_id));


create table dcs_price_level (
	price_level_id	varchar(40)	not null,
	version	integer	not null,
	quantity	integer	not null,
	price	double precision	not null
,constraint dcs_price_level_p primary key (price_level_id));


create table dcs_gen_fol_pl (
	folder_id	varchar(40)	not null,
	type	integer	not null,
	name	varchar(40)	not null,
	parent	varchar(40)	default null,
	description	varchar(254)	default null,
	item_acl	varchar(1024)	default null
,constraint dcs_gen_fol_pl_p primary key (folder_id));


create table dcs_child_fol_pl (
	folder_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_folder_id	varchar(40)	not null
,constraint dcs_child_fol_pl_p primary key (folder_id,sequence_num)
,constraint dcs_chilfoldr_d_f foreign key (folder_id) references dcs_gen_fol_pl (folder_id));


create table dcs_plfol_chld (
	plfol_id	varchar(40)	not null,
	sequence_num	integer	not null,
	price_list_id	varchar(40)	not null
,constraint dcs_plfol_chld_p primary key (plfol_id,sequence_num)
,constraint dcs_plfoplfol_d_f foreign key (plfol_id) references dcs_gen_fol_pl (folder_id));

commit;



-- the source for this section is 
-- order_markers_ddl.sql





create table dcs_order_markers (
	marker_id	varchar(40)	not null,
	order_id	varchar(40)	not null,
	marker_key	varchar(100)	not null,
	marker_value	varchar(100)	default null,
	marker_data	varchar(100)	default null,
	creation_date	timestamp	default null,
	version	integer	not null,
	marker_type	integer	default null
,constraint dcsordermarkers_p primary key (marker_id,order_id)
,constraint dcsordermarkers_f foreign key (order_id) references dcspp_order (order_id));

create index dcs_ordrmarkers1_x on dcs_order_markers (order_id);

create table dcs_gwp_order_markers (
	marker_id	varchar(40)	not null,
	order_id	varchar(40)	not null,
	marker_key	varchar(100)	not null,
	marker_value	varchar(100)	default null,
	marker_data	varchar(100)	default null,
	creation_date	timestamp	default null,
	version	integer	not null,
	marker_type	integer	default null,
	gift_type	varchar(100)	not null,
	gift_detail	long varchar	not null,
	auto_remove	numeric(3)	not null,
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
,constraint dcsgwpomarkers_f foreign key (order_id) references dcspp_order (order_id));

create index dcs_gwpomarkers1_x on dcs_gwp_order_markers (order_id);

create table dcspp_commerce_item_markers (
	marker_id	varchar(40)	not null,
	commerce_item_id	varchar(40)	not null,
	marker_key	varchar(100)	not null,
	marker_value	varchar(100)	default null,
	marker_data	varchar(100)	default null,
	creation_date	timestamp	default null,
	version	integer	not null,
	marker_type	integer	default null
,constraint dcscitemmarkers_p primary key (marker_id,commerce_item_id)
,constraint dcscitemmarkers_f foreign key (commerce_item_id) references dcspp_item (commerce_item_id));

create index dcs_itemmarkers1_x on dcspp_commerce_item_markers (commerce_item_id);

create table dcspp_gwp_item_markers (
	marker_id	varchar(40)	not null,
	commerce_item_id	varchar(40)	not null,
	marker_key	varchar(100)	not null,
	marker_value	varchar(100)	default null,
	marker_data	varchar(100)	default null,
	creation_date	timestamp	default null,
	version	integer	not null,
	marker_type	integer	default null,
	targeted_quantity	integer	not null,
	targeted_qty_with_fraction	numeric(19,7)	not null,
	automatic_quantity	integer	not null,
	automatic_qty_with_fraction	numeric(19,7)	not null,
	selected_quantity	integer	not null,
	selected_qty_with_fraction	numeric(19,7)	not null,
	remaining_quantity	integer	not null,
	remaining_qty_with_fraction	numeric(19,7)	not null
,constraint dcsgwpimarkers_p primary key (marker_id)
,constraint dcsgwpimarkers_f foreign key (commerce_item_id) references dcspp_item (commerce_item_id));

create index dcs_gwpimarkers1_x on dcspp_gwp_item_markers (commerce_item_id);
commit;



-- the source for this section is 
-- commerce_site_ddl.sql




-- This file contains create table statements, which will configureyour database for use MultiSite

create table dcs_site (
	id	varchar(40)	not null,
	catalog_id	varchar(40)	default null,
	list_pricelist_id	varchar(40)	default null,
	sale_pricelist_id	varchar(40)	default null,
	max_num_coupons	integer	default null,
	max_num_coupons_per_order	integer	default null
,constraint dcs_site_p primary key (id));

commit;



-- the source for this section is 
-- custom_catalog_reporting.sql




--        new drpt_products compiles information about each product in the catalog new   
create view drpt_products
as
select p.product_id as product_id, 
	'N/A' as category_name,
	avg(s.wholesale_price) as avg_cost, 
	avg(s.list_price) as avg_list_price, 
	avg(s.sale_price) as avg_sale_price, 
	((avg(s.list_price) - avg(s.wholesale_price)) / avg(s.wholesale_price)) as avg_initial_markup, 
	sum(inv.stock_level) as units_on_hand, 
	count(s.sku_id) as number_of_skus
from dcs_product p, 
	dcs_sku s, 
	dcs_prd_chldsku pc, 
	dcs_inventory inv
where p.product_id = pc.product_id 
	and pc.sku_id = s.sku_id
	and pc.sku_id = inv.catalog_ref_id
group by p.product_id
         ;


--        new drpt_category calculates statistics about prices and costs on a per-category basis  new   
create view drpt_category
as
select ctlg.display_name as catalog_name, 
	c.display_name as category_name, 
	c.category_id as category_id,
	avg(s.wholesale_price)as avg_cost,
	avg(s.list_price) as avg_list_price,
	avg(s.sale_price) as avg_sale_price,
	((avg(s.list_price) - avg(s.wholesale_price)) / avg(s.wholesale_price)) as avg_initial_markup,
	sum(inv.stock_level) as units_on_hand, 
	count(s.sku_id) as number_of_skus
from dcs_catalog ctlg, 
	dcs_category c, 
	dcs_sku s, 
	dcs_prd_chldsku pc, 
	dcs_product_info pi,
	dcs_prd_prdinfo ppi, 
	dcs_inventory inv
where c.category_id = pi.parent_cat_id 
	and pc.product_id = ppi.product_id 
	and pc.sku_id = s.sku_id
	and ctlg.catalog_id = c.catalog_id 
	and pc.sku_id = s.sku_id 
	and ppi.catalog_id = ctlg.catalog_id 
	and ppi.product_info_id = pi.product_info_id 
	and pc.sku_id = inv.catalog_ref_id
group by c.display_name,
	ctlg.display_name, 
	c.category_id
         ;


commit;

-- the source for this section is 
-- order_returns_ddl.sql





create table csr_exch (
	id	varchar(40)	not null,
	order_id	varchar(40)	not null,
	created_date	timestamp	not null,
	status	varchar(40)	not null,
	rma	varchar(40)	default null,
	repl_order_id	varchar(40)	default null,
	bal_pmt_id	varchar(40)	default null,
	sugg_tax_refund	numeric(19,7)	not null,
	actl_tax_refund	numeric(19,7)	not null,
	sugg_ship_refund	numeric(19,7)	not null,
	actl_ship_refund	numeric(19,7)	not null,
	other_refund	numeric(19,7)	not null,
	sc_recipient	varchar(40)	default null,
	proc_immed	numeric(4,0)	not null,
	processed	numeric(4,0)	not null,
	origin_of_return	integer	not null,
	agent_id	varchar(40)	default null
,constraint csr_exch_p primary key (id)
,constraint csr_exchordr_d_f foreign key (order_id) references dcspp_order (order_id)
,constraint csr_exch1_c check (proc_immed in (0,1))
,constraint csr_exch2_c check (processed in (0,1)));

create index csr_exchorder_id on csr_exch (order_id);

create table csr_exch_cmts (
	comment_id	varchar(40)	not null,
	return_id	varchar(40)	not null,
	agent_id	varchar(40)	default null,
	comment_data	varchar(254)	not null,
	creation_date	timestamp	default null,
	version	integer	not null
,constraint csrexchcmmt_p primary key (comment_id,return_id)
,constraint csrexchcmmt_f foreign key (return_id) references csr_exch (id));

create index csrexchcmmt1_x on csr_exch_cmts (return_id);

create table csr_exch_reasons (
	id	varchar(40)	not null,
	description	varchar(254)	not null
,constraint csr_exch_reasons_p primary key (id));


create table csr_exch_item_disp (
	id	varchar(40)	not null,
	description	varchar(254)	not null,
	upd_inventory	numeric(4,0)	not null
,constraint csr_exchitem_dis_p primary key (id)
,constraint csr_exchitem_dis_c check (upd_inventory in (0,1)));


create table csr_return_fee (
	exchange_id	varchar(40)	not null,
	return_fee	numeric(19,7)	not null
,constraint csr_return_fee_p primary key (exchange_id)
,constraint csr_rfexchng_d_f foreign key (exchange_id) references csr_exch (id));


create table csr_exch_item (
	id	varchar(40)	not null,
	commerce_item_id	varchar(40)	not null,
	shipping_group_id	varchar(40)	not null,
	quantity_to_return	numeric(19,0)	not null,
	qty_with_fraction_to_return	numeric(19,7)	default null,
	quantity_to_repl	numeric(19,0)	not null,
	qty_with_fraction_to_repl	numeric(19,7)	default null,
	reason	varchar(40)	not null,
	ret_shipment_req	numeric(4,0)	not null,
	quantity_received	numeric(19,0)	not null,
	qty_with_fraction_received	numeric(19,7)	default null,
	disposition	varchar(40)	default null,
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
,constraint csr_exch_item1_c check (ret_shipment_req in (0,1)));

create index csr_exch_itemdisp on csr_exch_item (disposition);
create index csr_exch_itmreason on csr_exch_item (reason);
create index csr_exch_itmshpgrp on csr_exch_item (shipping_group_id);

create table csr_exch_items (
	exchange_id	varchar(40)	not null,
	exchange_item_id	varchar(40)	not null
,constraint csr_exch_items_p primary key (exchange_id,exchange_item_id)
,constraint csr_exchtxchng_d_f foreign key (exchange_id) references csr_exch (id)
,constraint csr_exchtxchng_t_f foreign key (exchange_item_id) references csr_exch_item (id));

create index csr_exch_exch_itm on csr_exch_items (exchange_item_id);

create table csr_exch_method (
	id	varchar(40)	not null,
	type	integer	not null,
	amount	numeric(19,7)	default null
,constraint csr_exch_method_p primary key (id));


create table csr_exch_methods (
	exchange_id	varchar(40)	not null,
	exchange_method_id	varchar(40)	not null
,constraint csr_exch_methods_p primary key (exchange_id,exchange_method_id)
,constraint csr_exchmxchng_d_f foreign key (exchange_id) references csr_exch (id)
,constraint csr_exchmxchng_m_f foreign key (exchange_method_id) references csr_exch_method (id));

create index csr_exch_method_id on csr_exch_methods (exchange_method_id);

create table csr_cc_exch_method (
	exchange_method_id	varchar(40)	not null,
	payment_group_id	varchar(40)	not null
,constraint csr_cc_exch_mthd_p primary key (exchange_method_id)
,constraint csr_ccexcxchng_m_f foreign key (exchange_method_id) references csr_exch_method (id));


create table csr_sc_exch_method (
	exchange_method_id	varchar(40)	not null,
	payment_group_id	varchar(40)	default null,
	sc_id	varchar(40)	default null
,constraint csr_sc_exch_mthd_p primary key (exchange_method_id)
,constraint csr_scexcxchng_m_f foreign key (exchange_method_id) references csr_exch_method (id));


create table csr_exch_ipromos (
	exchange_id	varchar(40)	not null,
	promotion_id	varchar(40)	not null
,constraint csrexchipromos_p primary key (exchange_id,promotion_id)
,constraint csr_ex_ipromos_f foreign key (exchange_id) references csr_exch (id));


create table csr_exch_opromos (
	exchange_id	varchar(40)	not null,
	promotion_id	varchar(40)	not null
,constraint csrexchopromos_p primary key (exchange_id,promotion_id)
,constraint csr_ex_opromos_f foreign key (exchange_id) references csr_exch (id));


create table csr_promo_adjust (
	exchange_id	varchar(40)	not null,
	promotion_id	varchar(40)	not null,
	value_adjust	numeric(19,7)	not null
,constraint csrpromoadjust_p primary key (exchange_id,promotion_id)
,constraint csr_promo_adj_f foreign key (exchange_id) references csr_exch (id));


create table csr_nonreturn_adj (
	exchange_id	varchar(40)	not null,
	ica_id	varchar(40)	not null
,constraint csr_nr_adj_p primary key (exchange_id,ica_id)
,constraint csr_nr_adj_f foreign key (exchange_id) references csr_exch (id));


create table csr_item_adj (
	ica_id	varchar(40)	not null,
	type	integer	default null,
	commerce_item_id	varchar(40)	default null,
	shipping_group_id	varchar(40)	default null,
	quantity_adj	numeric(19,0)	not null,
	quantity_with_fraction_adj	numeric(19,7)	default null,
	amount_adj	numeric(19,7)	default null,
	ods_adj	numeric(19,7)	default null,
	mas_adj	numeric(19,7)	default null,
	tax_adj	numeric(19,7)	default null,
	shipping_adj	numeric(19,7)	default null
,constraint csritemadj_p primary key (ica_id));

commit;



-- the source for this section is 
-- dcs_content_mgmt_ddl.sql




-- This file contains create table statements, which will configure your database for use with the Content Management schema.

create table dcs_wcm_media_rltd_prod (
	media_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_product_id	varchar(40)	not null
,constraint wcm_media_rltd_product_p primary key (media_id,sequence_num)
,constraint wcm_media_rltd_product1_f foreign key (media_id) references wcm_media_content (id)
,constraint wcm_media_rltd_product2_f foreign key (related_product_id) references dcs_product (product_id));

create index wcm_media_rltd_product_idx on dcs_wcm_media_rltd_prod (related_product_id);

create table dcs_wcm_media_rltd_ctgy (
	media_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_category_id	varchar(40)	not null
,constraint wcm_media_rltd_category_p primary key (media_id,sequence_num)
,constraint wcm_media_rltd_category1_f foreign key (media_id) references wcm_media_content (id)
,constraint wcm_media_rltd_category_f foreign key (related_category_id) references dcs_category (category_id));

create index wcm_media_rltd_category_idx on dcs_wcm_media_rltd_ctgy (related_category_id);

create table dcs_wcm_article_rltd_prod (
	article_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_product_id	varchar(40)	not null
,constraint wcm_article_rltd_product_p primary key (article_id,sequence_num)
,constraint wcm_article_rltd_product1_f foreign key (article_id) references wcm_article (id)
,constraint wcm_article_rltd_product2_f foreign key (related_product_id) references dcs_product (product_id));

create index wcm_article_rltd_product_idx on dcs_wcm_article_rltd_prod (related_product_id);

create table dcs_wcm_article_rltd_ctgy (
	article_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_category_id	varchar(40)	not null
,constraint wcm_article_rltd_category_p primary key (article_id,sequence_num)
,constraint wcm_article_rltd_category1_f foreign key (article_id) references wcm_article (id)
,constraint wcm_article_rltd_category2_f foreign key (related_category_id) references dcs_category (category_id));

create index wcm_article_rltd_category_idx on dcs_wcm_article_rltd_ctgy (related_category_id);
commit;



-- the source for this section is 
-- dcs_backing_maps_ddl.sql




-- Tables for backing maps for item descriptors enables for dynamic properties in product catalog repository

create table dcs_dyn_prop_map_str (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	varchar(400)	default null
,constraint dcs_dyn_prop_map_str_p primary key (id,prop_name));


create table dcs_dyn_prop_map_big_str (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	clob	default null
,constraint dcs_dyn_prop_map_big_str_p primary key (id,prop_name));


create table dcs_dyn_prop_map_double (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19,7)	default null
,constraint dcs_dyn_prop_map_double_p primary key (id,prop_name));


create table dcs_dyn_prop_map_long (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19)	default null
,constraint dcs_dyn_prop_map_long_p primary key (id,prop_name));

-- Tables for backing maps for sku item descriptor

create table dcs_sku_dyn_prop_map_str (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	varchar(400)	default null
,constraint dcs_sku_dyn_prop_map_str_p primary key (id,prop_name));


create table dcs_sku_dyn_prop_map_big_str (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	clob	default null
,constraint dcs_sku_dynmc_prp_mp_bg_str_p primary key (id,prop_name));


create table dcs_sku_dyn_prop_map_double (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19,7)	default null
,constraint dcs_sku_dyn_prp_mp_dbl_p primary key (id,prop_name));


create table dcs_sku_dyn_prop_map_long (
	id	varchar(40)	not null,
	prop_name	varchar(254)	not null,
	prop_value	numeric(19)	default null
,constraint dcs_sku_dyn_prp_mp_lng_p primary key (id,prop_name));

commit;



-- the source for this section is 
-- abandoned_order_ddl.sql




-- $Id: //product/DCS/version/11.2/templates/DCS/AbandonedOrderServices/sql/abandoned_order_ddl.xml#1 $

create table dcspp_ord_abandon (
	abandonment_id	varchar(40)	not null,
	version	integer	not null,
	order_id	varchar(40)	not null,
	ord_last_updated	timestamp	default null,
	abandon_state	varchar(40)	default null,
	abandonment_count	integer	default null,
	abandonment_date	timestamp	default null,
	reanimation_date	timestamp	default null,
	convert_date	timestamp	default null,
	lost_date	timestamp	default null
,constraint dcspp_ord_abndn_p primary key (abandonment_id));

create index dcspp_ordabandn1_x on dcspp_ord_abandon (order_id);

create table dcs_user_abandoned (
	id	varchar(40)	not null,
	order_id	varchar(40)	not null,
	profile_id	varchar(40)	not null
,constraint dcs_usr_abndnd_p primary key (id));


create table drpt_conv_order (
	order_id	varchar(40)	not null,
	converted_date	timestamp	not null,
	amount	numeric(19,7)	not null,
	promo_count	integer	not null,
	promo_value	numeric(19,7)	not null
,constraint drpt_conv_order_p primary key (order_id));


create table drpt_session_ord (
	dataset_id	varchar(40)	not null,
	order_id	varchar(40)	not null,
	date_time	timestamp	not null,
	amount	numeric(19,7)	not null,
	submitted	integer	not null,
	order_persistent	numeric(1)	default null,
	session_id	varchar(40)	default null,
	parent_session_id	varchar(40)	default null
,constraint drpt_session_ord_p primary key (order_id));

commit;



-- the source for this section is 
-- abandoned_order_views.sql




create view drpt_abandon_ord
as
      select oa.abandonment_date as abandonment_date, ai.amount as amount, case when oa.abandon_state = 'CONVERTED' then 100 else 0 end as converted from dcspp_order o, dcspp_ord_abandon oa, dcspp_amount_info ai where oa.order_id=o.order_id and o.price_info=ai.amount_info_id
         ;


create view drpt_tns_abndn_ord
as
      select date_time as abandonment_date, amount as amount from drpt_session_ord where submitted=0
         ;


commit;
