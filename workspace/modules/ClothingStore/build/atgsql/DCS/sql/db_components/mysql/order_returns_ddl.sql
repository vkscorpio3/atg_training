


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/order_returns_ddl.xml#2 $$Change: 1179550 $

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
	proc_immed	tinyint	not null,
	processed	tinyint	not null,
	origin_of_return	integer	not null,
	agent_id	varchar(40)	null
,constraint csr_exch_p primary key (id)
,constraint csr_exchordr_d_f foreign key (order_id) references dcspp_order (order_id)
,constraint csr_exch1_c check (proc_immed in (0,1))
,constraint csr_exch2_c check (processed in (0,1)));

create index csr_exchorder_id on csr_exch (order_id);

create table csr_exch_cmts (
	comment_id	varchar(40)	not null,
	return_id	varchar(40)	not null,
	agent_id	varchar(40)	null,
	comment_data	varchar(254)	not null,
	creation_date	datetime	null,
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
	upd_inventory	tinyint	not null
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
	quantity_to_return	bigint	not null,
	qty_with_fraction_to_return	numeric(19,7)	null,
	quantity_to_repl	bigint	not null,
	qty_with_fraction_to_repl	numeric(19,7)	null,
	reason	varchar(40)	not null,
	ret_shipment_req	tinyint	not null,
	quantity_received	bigint	not null,
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
	amount	numeric(19,7)	null
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
	payment_group_id	varchar(40)	null,
	sc_id	varchar(40)	null
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
	type	integer	null,
	commerce_item_id	varchar(40)	null,
	shipping_group_id	varchar(40)	null,
	quantity_adj	bigint	not null,
	quantity_with_fraction_adj	numeric(19,7)	null,
	amount_adj	numeric(19,7)	null,
	ods_adj	numeric(19,7)	null,
	mas_adj	numeric(19,7)	null,
	tax_adj	numeric(19,7)	null,
	shipping_adj	numeric(19,7)	null
,constraint csritemadj_p primary key (ica_id));

commit;


