


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/custom_catalog_ddl.xml#2 $$Change: 953229 $

create table dcs_catalog (
	catalog_id	varchar(40)	not null,
	version	integer	not null,
	display_name	varchar(254)	null,
	creation_date	datetime	null,
	last_mod_date	datetime	null,
	migration_status	integer	null,
	migration_index	integer	null,
	item_acl	text	null
,constraint dcs_catalog_p primary key (catalog_id))


create table dcs_root_cats (
	catalog_id	varchar(40)	not null,
	root_cat_id	varchar(40)	not null
,constraint dcs_root_cats_p primary key (catalog_id,root_cat_id)
,constraint dcs_rotccatlg_d_f foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_rotcrot_ctd_f foreign key (root_cat_id) references dcs_category (category_id))

create index dcs_rootcatscat_id on dcs_root_cats (root_cat_id)

create table dcs_allroot_cats (
	catalog_id	varchar(40)	not null,
	root_cat_id	varchar(40)	not null
,constraint dcs_allroot_cats_p primary key (catalog_id,root_cat_id)
,constraint dcs_allrcatlg_d_f foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_allrrot_ctd_f foreign key (root_cat_id) references dcs_category (category_id))

create index dcs_allrt_cats_id on dcs_allroot_cats (root_cat_id)

create table dcs_root_subcats (
	catalog_id	varchar(40)	not null,
	sub_catalog_id	varchar(40)	not null
,constraint dcs_root_subcats_p primary key (catalog_id,sub_catalog_id)
,constraint dcs_rotscatlg_d_f foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_rotssub_ctlg_f foreign key (sub_catalog_id) references dcs_catalog (catalog_id))

create index dcs_rtsubcats_id on dcs_root_subcats (sub_catalog_id)

create table dcs_category_info (
	category_info_id	varchar(40)	not null,
	version	integer	not null,
	item_acl	text	null
,constraint dcs_category_inf_p primary key (category_info_id))


create table dcs_product_info (
	product_info_id	varchar(40)	not null,
	version	integer	not null,
	parent_cat_id	varchar(40)	null,
	item_acl	text	null
,constraint dcs_product_info_p primary key (product_info_id))


create table dcs_sku_info (
	sku_info_id	varchar(40)	not null,
	version	integer	not null,
	item_acl	text	null
,constraint dcs_sku_info_p primary key (sku_info_id))


create table dcs_cat_subcats (
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_cat_subcats_p primary key (category_id,sequence_num)
,constraint dcs_catscatlg_d_f foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_catscatgry_d_f foreign key (category_id) references dcs_category (category_id))

create index dcs_catsubcatlogid on dcs_cat_subcats (catalog_id)

create table dcs_cat_subroots (
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	sub_category_id	varchar(40)	not null
,constraint dcs_cat_subroots_p primary key (category_id,sequence_num)
,constraint dcs_subrtscatgry_f foreign key (category_id) references dcs_category (category_id))


create table dcs_cat_catinfo (
	category_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	category_info_id	varchar(40)	not null
,constraint dcs_cat_catinfo_p primary key (category_id,catalog_id)
,constraint dcs_infocatgry_d_f foreign key (category_id) references dcs_category (category_id))


create table dcs_catinfo_anc (
	category_info_id	varchar(40)	not null,
	anc_cat_id	varchar(40)	not null
,constraint dcs_catinfo_anc_p primary key (category_info_id,anc_cat_id))


create table dcs_prd_prdinfo (
	product_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	product_info_id	varchar(40)	not null
,constraint dcs_prd_prdinfo_p primary key (product_id,catalog_id)
,constraint dcs_prdpprodct_d_f foreign key (product_id) references dcs_product (product_id))


create table dcs_prdinfo_rdprd (
	product_info_id	varchar(40)	not null,
	sequence_num	integer	not null,
	related_prd_id	varchar(40)	not null
,constraint dcs_prdinfo_rdpr_p primary key (product_info_id,sequence_num)
,constraint dcs_prdireltd_pr_f foreign key (related_prd_id) references dcs_product (product_id)
,constraint dcs_prdiprodct_n_f foreign key (product_info_id) references dcs_product_info (product_info_id))

create index dcs_prdrelatedinfo on dcs_prdinfo_rdprd (related_prd_id)

create table dcs_prdinfo_anc (
	product_info_id	varchar(40)	not null,
	anc_cat_id	varchar(40)	not null
,constraint dcs_prdinfo_anc_p primary key (product_info_id,anc_cat_id))


create table dcs_sku_skuinfo (
	sku_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	sku_info_id	varchar(40)	not null
,constraint dcs_sku_skuinfo_p primary key (sku_id,catalog_id)
,constraint dcs_skusknfsku_d_f foreign key (sku_id) references dcs_sku (sku_id))


create table dcs_skuinfo_rplc (
	sku_info_id	varchar(40)	not null,
	sequence_num	integer	not null,
	replacement	varchar(40)	not null
,constraint dcs_skuinfo_rplc_p primary key (sku_info_id,sequence_num)
,constraint dcs_skunsku_nfd_f foreign key (sku_info_id) references dcs_sku_info (sku_info_id))


create table dcs_gen_fol_cat (
	folder_id	varchar(40)	not null,
	type	integer	not null,
	name	varchar(40)	not null,
	parent	varchar(40)	null,
	description	varchar(254)	null,
	item_acl	text	null
,constraint dcs_gen_fol_cat_p primary key (folder_id))


create table dcs_child_fol_cat (
	folder_id	varchar(40)	not null,
	sequence_num	integer	not null,
	child_folder_id	varchar(40)	not null
,constraint dcs_child_fol_ca_p primary key (folder_id,sequence_num)
,constraint dcs_catlfoldr_d_f foreign key (folder_id) references dcs_gen_fol_cat (folder_id))


create table dcs_catfol_chld (
	catfol_id	varchar(40)	not null,
	sequence_num	integer	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_catfol_chld_p primary key (catfol_id,sequence_num)
,constraint dcs_catfcatfl_d_f foreign key (catfol_id) references dcs_gen_fol_cat (folder_id))


create table dcs_catfol_sites (
	catfol_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_catfl_sites_pk primary key (catfol_id,site_id))


create table dcs_dir_anc_ctlgs (
	catalog_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_catalog_id	varchar(40)	not null
,constraint dcs_dirancctlgs_pk primary key (catalog_id,sequence_num)
,constraint dcs_dirancctlgs_f1 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_dirancctlgs_f2 foreign key (anc_catalog_id) references dcs_catalog (catalog_id))

create index dcs_dirancctlg_idx on dcs_dir_anc_ctlgs (anc_catalog_id)

create table dcs_ind_anc_ctlgs (
	catalog_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_catalog_id	varchar(40)	not null
,constraint dcs_indancctlgs_pk primary key (catalog_id,sequence_num)
,constraint dcs_indancctlgs_f1 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_indancctlgs_f2 foreign key (anc_catalog_id) references dcs_catalog (catalog_id))

create index dcs_indanctlg_idx on dcs_ind_anc_ctlgs (anc_catalog_id)

create table dcs_ctlg_anc_cats (
	catalog_id	varchar(40)	not null,
	sequence_num	integer	not null,
	category_id	varchar(40)	not null
,constraint dcs_ctlganccats_pk primary key (catalog_id,sequence_num)
,constraint dcs_ctlganccats_f1 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_ctlganccats_f2 foreign key (category_id) references dcs_category (category_id))

create index dcs_ctlgancat_idx on dcs_ctlg_anc_cats (category_id)

create table dcs_cat_anc_cats (
	category_id	varchar(40)	not null,
	sequence_num	integer	not null,
	anc_category_id	varchar(40)	not null
,constraint dcs_cat_anccats_pk primary key (category_id,sequence_num)
,constraint dcs_cat_anccats_f1 foreign key (category_id) references dcs_category (category_id)
,constraint dcs_cat_anccats_f2 foreign key (anc_category_id) references dcs_category (category_id))

create index dcs_catanccat_idx on dcs_cat_anc_cats (anc_category_id)

create table dcs_cat_prnt_cats (
	category_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	parent_ctgy_id	varchar(40)	not null
,constraint dcs_catprntcats_pk primary key (category_id,catalog_id)
,constraint dcscatprntcats_fk1 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcscatprntcats_fk2 foreign key (category_id) references dcs_category (category_id)
,constraint dcscatprntcats_fk3 foreign key (parent_ctgy_id) references dcs_category (category_id))

create index dcscatprntcats_ix1 on dcs_cat_prnt_cats (catalog_id)
create index dcscatprntcats_ix2 on dcs_cat_prnt_cats (category_id)
create index dcscatprntcats_ix3 on dcs_cat_prnt_cats (parent_ctgy_id)

create table dcs_prd_prnt_cats (
	product_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null,
	category_id	varchar(40)	not null
,constraint dcs_prdprntcats_pk primary key (product_id,catalog_id)
,constraint dcs_prdprntcats_f2 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_prdprntcats_f3 foreign key (category_id) references dcs_category (category_id)
,constraint dcs_prdprntcats_f1 foreign key (product_id) references dcs_product (product_id))

create index pr_prnt_cat_pi_idx on dcs_prd_prnt_cats (catalog_id)
create index pr_prnt_cat_ci_idx on dcs_prd_prnt_cats (category_id)

create table dcs_prd_anc_cats (
	product_id	varchar(40)	not null,
	sequence_num	integer	not null,
	category_id	varchar(40)	not null
,constraint dcs_prdanc_cats_pk primary key (product_id,sequence_num)
,constraint dcs_prdanc_cats_f2 foreign key (category_id) references dcs_category (category_id)
,constraint dcs_prdanc_cats_f1 foreign key (product_id) references dcs_product (product_id))

create index dcs_prdanccat_idx on dcs_prd_anc_cats (category_id)

create table dcs_cat_catalogs (
	category_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_cat_catalgs_pk primary key (category_id,catalog_id)
,constraint dcs_cat_catalgs_f2 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_cat_catalgs_f1 foreign key (category_id) references dcs_category (category_id))

create index dcs_catctlgs_idx on dcs_cat_catalogs (catalog_id)

create table dcs_prd_catalogs (
	product_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_prd_catalgs_pk primary key (product_id,catalog_id)
,constraint dcs_prd_catalgs_f2 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_prd_catalgs_f1 foreign key (product_id) references dcs_product (product_id))

create index dcs_prd_ctlgs_idx on dcs_prd_catalogs (catalog_id)

create table dcs_sku_catalogs (
	sku_id	varchar(40)	not null,
	catalog_id	varchar(40)	not null
,constraint dcs_sku_catalgs_pk primary key (sku_id,catalog_id)
,constraint dcs_sku_catalgs_f2 foreign key (catalog_id) references dcs_catalog (catalog_id)
,constraint dcs_sku_catalgs_f1 foreign key (sku_id) references dcs_sku (sku_id))

create index dcs_sku_ctlgs_idx on dcs_sku_catalogs (catalog_id)

create table dcs_catalog_sites (
	catalog_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_catlg_sites_pk primary key (catalog_id,site_id))

create index catlg_site_id_idx on dcs_catalog_sites (site_id)

create table dcs_category_sites (
	category_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_cat_sites_pk primary key (category_id,site_id))

create index cat_site_id_idx on dcs_category_sites (site_id)

create table dcs_product_sites (
	product_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_prod_sites_pk primary key (product_id,site_id)
,constraint dcs_prod_sites_f1 foreign key (product_id) references dcs_product (product_id))

create index prd_site_id_idx on dcs_product_sites (site_id)

create table dcs_sku_sites (
	sku_id	varchar(40)	not null,
	site_id	varchar(40)	not null
,constraint dcs_sku_sites_pk primary key (sku_id,site_id)
,constraint dcs_sku_sites_f1 foreign key (sku_id) references dcs_sku (sku_id))

create index sku_site_id_idx on dcs_sku_sites (site_id)

create table dcs_cat_dynprd (
	category_id	varchar(40)	not null,
	product_id	varchar(40)	not null
,constraint dcs_cat_dynprd_pk primary key (product_id,category_id))


create table dcs_invalidated_prd_ids (
	product_id	varchar(40)	not null
,constraint dcs_invalidated_prd_ids_pk primary key (product_id))


create table dcs_invalidated_sku_ids (
	sku_id	varchar(40)	not null
,constraint dcs_invalidated_sku_ids_pk primary key (sku_id))



go
