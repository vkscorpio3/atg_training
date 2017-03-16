


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/user_giftlist_ddl.xml#2 $$Change: 1179550 $

create table dcs_giftlist (
	id	varchar(40)	not null,
	owner_id	varchar(40)	null,
	site_id	varchar(40)	null,
	is_public	tinyint	not null,
	is_published	tinyint	not null,
	event_name	nvarchar(64)	null,
	event_type	integer	null,
	event_date	datetime	null,
	comments	nvarchar(254)	null,
	description	nvarchar(254)	null,
	instructions	nvarchar(254)	null,
	creation_date	datetime	null,
	last_modified_date	datetime	null,
	shipping_addr_id	varchar(40)	null
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
	special_inst	varchar(254)	null
,constraint dcs_giftinst_p primary key (giftlist_id,tag)
,constraint dcs_giftgiftlst__f foreign key (giftlist_id) references dcs_giftlist (id));

create index giftinst_gflid_idx on dcs_giftinst (giftlist_id);

create table dcs_giftitem (
	id	varchar(40)	not null,
	catalog_ref_id	varchar(40)	null,
	product_id	varchar(40)	null,
	site_id	varchar(40)	null,
	display_name	nvarchar(254)	null,
	description	nvarchar(254)	null,
	quantity_desired	integer	null,
	quantity_purchased	integer	null,
	qty_with_fraction_desired	numeric(19,7)	null,
	qty_with_fraction_purchased	numeric(19,7)	null
,constraint dcs_giftitem_p primary key (id));

create index giftitem_cat_idx on dcs_giftitem (catalog_ref_id);
create index giftitem_prod_idx on dcs_giftitem (product_id);
create index giftitem_site_idx on dcs_giftitem (site_id);

create table dcs_giftlist_item (
	giftlist_id	varchar(40)	not null,
	sequence_num	integer	not null,
	giftitem_id	varchar(40)	null
,constraint dcs_giftlist_ite_p primary key (giftlist_id,sequence_num)
,constraint dcs_giftgifttm_d_f foreign key (giftitem_id) references dcs_giftitem (id)
,constraint dcs_gftlstgftlst_f foreign key (giftlist_id) references dcs_giftlist (id));

create index gftlst_itm_gii_idx on dcs_giftlist_item (giftitem_id);
create index gftlst_itm_gli_idx on dcs_giftlist_item (giftlist_id);

create table dcs_user_wishlist (
	user_id	varchar(40)	not null,
	giftlist_id	varchar(40)	null
,constraint dcs_user_wishlis_p primary key (user_id)
,constraint dcs_usrwgiftlst__f foreign key (giftlist_id) references dcs_giftlist (id));

create index usr_wshlst_gli_idx on dcs_user_wishlist (giftlist_id);

create table dcs_user_giftlist (
	user_id	varchar(40)	not null,
	sequence_num	integer	not null,
	giftlist_id	varchar(40)	null
,constraint dcs_user_giftlis_p primary key (user_id,sequence_num)
,constraint dcs_usrgiftlst__f foreign key (giftlist_id) references dcs_giftlist (id));

create index usr_gftlst_gli_idx on dcs_user_giftlist (giftlist_id);
create index usr_gftlst_uid_idx on dcs_user_giftlist (user_id);

create table dcs_user_otherlist (
	user_id	varchar(40)	not null,
	sequence_num	integer	not null,
	giftlist_id	varchar(40)	null
,constraint dcs_user_otherli_p primary key (user_id,sequence_num)
,constraint dcs_usrtgiftlst__f foreign key (giftlist_id) references dcs_giftlist (id));

create index usr_otrlst_gli_idx on dcs_user_otherlist (giftlist_id);
commit;


