


--  @version $ $

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
