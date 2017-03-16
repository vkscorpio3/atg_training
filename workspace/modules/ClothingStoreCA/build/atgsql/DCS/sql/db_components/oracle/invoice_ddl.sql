


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/invoice_ddl.xml#1 $$Change: 946917 $

create table dbc_inv_delivery (
	id	varchar2(40)	not null,
	version	integer	not null,
	type	integer	not null,
	prefix	varchar2(40)	null,
	first_name	varchar2(40)	null,
	middle_name	varchar2(40)	null,
	last_name	varchar2(40)	null,
	suffix	varchar2(40)	null,
	job_title	varchar2(80)	null,
	company_name	varchar2(40)	null,
	address1	varchar2(80)	null,
	address2	varchar2(80)	null,
	address3	varchar2(80)	null,
	city	varchar2(40)	null,
	county	varchar2(40)	null,
	state	varchar2(40)	null,
	postal_code	varchar2(10)	null,
	country	varchar2(40)	null,
	phone_number	varchar2(40)	null,
	fax_number	varchar2(40)	null,
	email_addr	varchar2(255)	null,
	format	integer	null,
	delivery_mode	integer	null
,constraint dbc_inv_delivery_p primary key (id));


create table dbc_inv_pmt_terms (
	id	varchar2(40)	not null,
	version	integer	not null,
	type	integer	not null,
	disc_percent	number(19,7)	null,
	disc_days	integer	null,
	net_days	integer	null
,constraint dbc_inv_pmt_term_p primary key (id));


create table dbc_invoice (
	id	varchar2(40)	not null,
	version	integer	not null,
	type	integer	not null,
	creation_date	timestamp	null,
	last_mod_date	timestamp	null,
	invoice_number	varchar2(40)	null,
	po_number	varchar2(40)	null,
	req_number	varchar2(40)	null,
	delivery_info	varchar2(40)	null,
	balance_due	number(19,7)	null,
	pmt_due_date	date	null,
	pmt_terms	varchar2(40)	null,
	order_id	varchar2(40)	null,
	pmt_group_id	varchar2(40)	null
,constraint dbc_invoice_p primary key (id)
,constraint dbc_invcdelvry_n_f foreign key (delivery_info) references dbc_inv_delivery (id)
,constraint dbc_invcpmt_term_f foreign key (pmt_terms) references dbc_inv_pmt_terms (id));

create index dbc_inv_dlivr_info on dbc_invoice (delivery_info);
create index dbc_inv_pmt_terms on dbc_invoice (pmt_terms);
create index inv_inv_idx on dbc_invoice (invoice_number);
create index inv_order_idx on dbc_invoice (order_id);
create index inv_pmt_idx on dbc_invoice (pmt_group_id);
create index inv_po_idx on dbc_invoice (po_number);



