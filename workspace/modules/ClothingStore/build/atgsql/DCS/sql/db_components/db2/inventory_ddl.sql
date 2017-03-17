


--  @version $Id: //product/DCS/version/11.2/templates/DCS/sql/inventory_ddl.xml#2 $$Change: 1179550 $

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


