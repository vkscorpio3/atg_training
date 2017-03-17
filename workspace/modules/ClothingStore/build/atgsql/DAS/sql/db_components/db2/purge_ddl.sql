


-- 
-- Purge Progress Tables
-- $Id: //product/DAS/version/11.2/templates/DAS/sql/purge_ddl.xml#1 $
-- 

create table das_purge_progress (
	purge_progress_id	varchar(40)	not null,
	item_type	varchar(254)	not null,
	start_timestamp	timestamp	default null,
	update_timestamp	timestamp	default null,
	end_timestamp	timestamp	default null,
	status	integer	not null,
	success_items	integer	default 0 not null,
	skipped_items	integer	default 0 not null,
	skipped_on_error_items	integer	default 0 not null,
	error_items	integer	default 0 not null,
	processed_items	integer	default 0 not null,
	estimated_items	integer	default 0 not null,
	total_items	integer	default 0 not null,
	owner	varchar(254)	default null,
	criteria	varchar(4000)	default null,
	related_criteria	varchar(4000)	default null,
	error_message	varchar(8000)	default null
,constraint das_purge_pr_p primary key (purge_progress_id));

commit;


