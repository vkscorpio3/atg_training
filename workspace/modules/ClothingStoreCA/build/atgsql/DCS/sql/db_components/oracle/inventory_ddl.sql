


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/inventory_ddl.xml#2 $$Change: 1179550 $

create table dcs_inventory (
	inventory_id	varchar2(40)	not null,
	location_id	varchar2(40)	null,
	version	integer	not null,
	inventory_lock	varchar2(20)	null,
	creation_date	timestamp	null,
	start_date	timestamp	null,
	end_date	timestamp	null,
	display_name	varchar2(254)	null,
	description	varchar2(254)	null,
	catalog_ref_id	varchar2(40)	not null,
	avail_status	integer	not null,
	availability_date	timestamp	null,
	stock_level	integer	null,
	stock_level_with_fraction	number(19,7)	null,
	backorder_level	integer	null,
	backorder_level_with_fraction	number(19,7)	null,
	preorder_level	integer	null,
	preorder_level_with_fraction	number(19,7)	null,
	stock_thresh	integer	null,
	backorder_thresh	integer	null,
	preorder_thresh	integer	null
,constraint dcs_inventory_p primary key (inventory_id));

create unique index inv_catloc_idx on dcs_inventory (catalog_ref_id,location_id);
create index inv_end_dte_idx on dcs_inventory (end_date);
create index inv_strt_dte_idx on dcs_inventory (start_date);

create table dcs_inv_atp (
	id	varchar2(40)	not null,
	version	number(10)	not null,
	inventory_id	varchar2(40)	null,
	available_date	date	not null,
	quantity	number(10)	not null,
	quantity_with_fraction	number(19,7)	null
,constraint dcs_inv_atp_p primary key (id));




