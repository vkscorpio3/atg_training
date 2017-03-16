


-- 
-- Purge Progress Tables
-- $Id: //product/DAS/version/11.2/templates/DAS/sql/purge_ddl.xml#1 $
-- 

create table das_purge_progress (
	purge_progress_id	varchar2(40)	not null,
	item_type	varchar2(254)	not null,
	start_timestamp	timestamp	null,
	update_timestamp	timestamp	null,
	end_timestamp	timestamp	null,
	status	number(10)	not null,
	success_items	number(10)	default 0 not null,
	skipped_items	number(10)	default 0 not null,
	skipped_on_error_items	number(10)	default 0 not null,
	error_items	number(10)	default 0 not null,
	processed_items	number(10)	default 0 not null,
	estimated_items	number(10)	default 0 not null,
	total_items	number(10)	default 0 not null,
	owner	varchar2(254)	null,
	criteria	varchar2(4000)	null,
	related_criteria	varchar2(4000)	null,
	error_message	clob	null
,constraint das_purge_pr_p primary key (purge_progress_id));




