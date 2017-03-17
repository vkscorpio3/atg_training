


--  @version $ $

create table dcs_order_markers (
	marker_id	varchar2(40)	not null,
	order_id	varchar2(40)	not null,
	marker_key	varchar2(100)	not null,
	marker_value	varchar2(100)	null,
	marker_data	varchar2(100)	null,
	creation_date	timestamp	null,
	version	number(10)	not null,
	marker_type	number(10)	null
,constraint dcsordermarkers_p primary key (marker_id,order_id)
,constraint dcsordermarkers_f foreign key (order_id) references dcspp_order (order_id));

create index dcs_ordrmarkers1_x on dcs_order_markers (order_id);

create table dcs_gwp_order_markers (
	marker_id	varchar2(40)	not null,
	order_id	varchar2(40)	not null,
	marker_key	varchar2(100)	not null,
	marker_value	varchar2(100)	null,
	marker_data	varchar2(100)	null,
	creation_date	timestamp	null,
	version	number(10)	not null,
	marker_type	number(10)	null,
	gift_type	varchar2(100)	not null,
	gift_detail	clob	not null,
	auto_remove	number(3)	not null,
	quantity	number(10)	not null,
	quantity_with_fraction	number(19,7)	not null,
	targeted_quantity	number(10)	not null,
	targeted_qty_with_fraction	number(19,7)	not null,
	automatic_quantity	number(10)	not null,
	automatic_qty_with_fraction	number(19,7)	not null,
	selected_quantity	number(10)	not null,
	selected_qty_with_fraction	number(19,7)	not null,
	removed_quantity	number(10)	not null,
	removed_qty_with_fraction	number(19,7)	not null,
	failed_quantity	number(10)	not null,
	failed_qty_with_fraction	number(19,7)	not null
,constraint dcsgwpomarkers_p primary key (marker_id)
,constraint dcsgwpomarkers_f foreign key (order_id) references dcspp_order (order_id));

create index dcs_gwpomarkers1_x on dcs_gwp_order_markers (order_id);

create table dcspp_commerce_item_markers (
	marker_id	varchar2(40)	not null,
	commerce_item_id	varchar2(40)	not null,
	marker_key	varchar2(100)	not null,
	marker_value	varchar2(100)	null,
	marker_data	varchar2(100)	null,
	creation_date	timestamp	null,
	version	number(10)	not null,
	marker_type	number(10)	null
,constraint dcscitemmarkers_p primary key (marker_id,commerce_item_id)
,constraint dcscitemmarkers_f foreign key (commerce_item_id) references dcspp_item (commerce_item_id));

create index dcs_itemmarkers1_x on dcspp_commerce_item_markers (commerce_item_id);

create table dcspp_gwp_item_markers (
	marker_id	varchar2(40)	not null,
	commerce_item_id	varchar2(40)	not null,
	marker_key	varchar2(100)	not null,
	marker_value	varchar2(100)	null,
	marker_data	varchar2(100)	null,
	creation_date	timestamp	null,
	version	number(10)	not null,
	marker_type	number(10)	null,
	targeted_quantity	number(10)	not null,
	targeted_qty_with_fraction	number(19,7)	not null,
	automatic_quantity	number(10)	not null,
	automatic_qty_with_fraction	number(19,7)	not null,
	selected_quantity	number(10)	not null,
	selected_qty_with_fraction	number(19,7)	not null,
	remaining_quantity	number(10)	not null,
	remaining_qty_with_fraction	number(19,7)	not null
,constraint dcsgwpimarkers_p primary key (marker_id)
,constraint dcsgwpimarkers_f foreign key (commerce_item_id) references dcspp_item (commerce_item_id));

create index dcs_gwpimarkers1_x on dcspp_gwp_item_markers (commerce_item_id);



