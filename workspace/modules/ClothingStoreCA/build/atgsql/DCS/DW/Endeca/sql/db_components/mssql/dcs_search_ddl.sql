


-- ATG Reporting Framework DDL - DCS.DW.Endeca
-- =================================
-- Fact: LINE ITEM SEARCH
-- Dimensions: LINE ITEM
-- SEARCH

create table ARF_LINE_ITEM_SEARCH (
	ID	bigint	not null,
	LINE_ITEM_ID	bigint	not null,
	SEARCH_ID	bigint	not null,
	NLINE_ITEM_ID	varchar(40)	not null,
	NSEARCH_ID	varchar(40)	not null
,constraint ARF_LINE_ITEM_SEARCH_PK primary key (ID)
,constraint ARF_LINE_ITEM_SEARCH_FK1 foreign key (LINE_ITEM_ID) references ARF_LINE_ITEM (LINE_ITEM_ID)
,constraint ARF_LINE_ITEM_SEARCH_FK2 foreign key (SEARCH_ID) references ARF_SEARCH (ID))

create index ARF_LINE_ITEM_SEARCH_IX1 on ARF_LINE_ITEM_SEARCH (LINE_ITEM_ID)
create index ARF_LINE_ITEM_SEARCH_IX2 on ARF_LINE_ITEM_SEARCH (SEARCH_ID)
create index ARF_LINE_ITEM_SEARCH_IX3 on ARF_LINE_ITEM_SEARCH (NLINE_ITEM_ID)
create index ARF_LINE_ITEM_SEARCH_IX4 on ARF_LINE_ITEM_SEARCH (NSEARCH_ID)


go
