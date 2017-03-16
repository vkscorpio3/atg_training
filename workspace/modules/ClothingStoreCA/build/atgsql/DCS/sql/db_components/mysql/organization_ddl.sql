


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/organization_ddl.xml#1 $$Change: 946917 $

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
	approval_required	tinyint	null
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
	tag	nvarchar(42)	not null,
	payment_id	varchar(40)	not null
,constraint dbc_org_payment_p primary key (org_id,tag)
,constraint dbc_orgppaymnt_d_f foreign key (payment_id) references dps_credit_card (id)
,constraint dbc_orgpymntorg_f foreign key (org_id) references dps_organization (org_id));

create index dbc_org_pymnt_id on dbc_org_payment (payment_id);

create table dbc_org_prefvndr (
	org_id	varchar(40)	not null,
	vendor	nvarchar(100)	not null,
	seq	integer	not null
,constraint dbc_org_prefvndr_p primary key (org_id,seq)
,constraint dbc_orgprfvndorg_f foreign key (org_id) references dps_organization (org_id));


create table dcs_org_address (
	org_id	varchar(40)	not null,
	tag	nvarchar(42)	not null,
	addr_id	varchar(40)	not null
,constraint dcs_org_addr_p primary key (org_id,tag)
,constraint dcs_org_addr_fk1 foreign key (addr_id) references dps_contact_info (id)
,constraint dcs_org_addr_fk2 foreign key (org_id) references dps_organization (org_id));

create index dcs_org_addr_ix1 on dcs_org_address (addr_id);
commit;


