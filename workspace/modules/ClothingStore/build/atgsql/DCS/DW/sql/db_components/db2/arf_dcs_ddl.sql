


-- ATG Reporting Framework DDL - DCS
-- =================================
-- Fact: CURRENCY CONVERSION
-- Dimensions: DAY
-- SOURCE CURRENCY
-- DESTINATION CURRENCY
-- Measures: SRC TO DEST CONV RATE
-- DEST TO SRC CONV RATE

create table ARF_CURRENCY_CONV (
	DAY_ID	varchar(40)	not null,
	SRC_CURRENCY_ID	smallint	not null,
	DST_CURRENCY_ID	smallint	not null,
	SRC_DST_CONV_RATE	double precision	not null,
	DST_SRC_CONV_RATE	double precision	not null
,constraint ARF_CURNCY_CONV_P primary key (DAY_ID,SRC_CURRENCY_ID,DST_CURRENCY_ID)
,constraint ARF_CRNCY_CONV_F1 foreign key (DAY_ID) references ARF_TIME_DAY (ID)
,constraint ARF_CRNCY_CONV_F2 foreign key (SRC_CURRENCY_ID) references ARF_CURRENCY (ID)
,constraint ARF_CRNCY_CONV_F3 foreign key (DST_CURRENCY_ID) references ARF_CURRENCY (ID));

create index ARF_CRNCY_CONV_X2 on ARF_CURRENCY_CONV (SRC_CURRENCY_ID);
create index ARF_CRNCY_CONV_X3 on ARF_CURRENCY_CONV (DST_CURRENCY_ID);
-- Dimension: CATEGORY
-- Levels: CATEGORY

create table ARF_CATEGORY (
	ID	integer	not null,
	NCATEGORY_ID	varchar(40)	not null,
	NAME	varchar(254)	not null,
	NAME_EN	varchar(254)	default null,
	DESCRIPTION	varchar(254)	default null,
	DESCRIPTION_EN	varchar(254)	default null,
	PARENT_CAT_ID	integer	default null,
	RECORD_LAST_UPDATE	timestamp	default null,
	RECORD_START_DATE	timestamp	default null,
	RECORD_END_DATE	timestamp	default null,
	MOST_RECENT	numeric(1)	default 1 not null,
	DELETED	numeric(1)	default 0 not null
,constraint ARF_CATEGORY_P primary key (ID)
,constraint ARF_CATEGORY_F1 foreign key (PARENT_CAT_ID) references ARF_CATEGORY (ID));

create index ARF_CAT_PCID_X2 on ARF_CATEGORY (PARENT_CAT_ID);
create index ARF_CAT_NCID_X1 on ARF_CATEGORY (NCATEGORY_ID);
-- Dimension: PRODUCT
-- Levels: PRODUCT

create table ARF_PRODUCT (
	ID	integer	not null,
	NPRODUCT_ID	varchar(40)	not null,
	NAME	varchar(254)	not null,
	NAME_EN	varchar(254)	default null,
	DESCRIPTION	varchar(254)	default null,
	DESCRIPTION_EN	varchar(254)	default null,
	PARENT_CAT_ID	integer	default null,
	BRAND	varchar(254)	default null,
	BRAND_EN	varchar(254)	default null,
	RECORD_LAST_UPDATE	timestamp	default null,
	RECORD_START_DATE	timestamp	default null,
	RECORD_END_DATE	timestamp	default null,
	MOST_RECENT	numeric(1)	default 1 not null,
	DELETED	numeric(1)	default 0 not null
,constraint ARF_PRODUCT_P primary key (ID)
,constraint ARF_PRODUCT_F1 foreign key (PARENT_CAT_ID) references ARF_CATEGORY (ID));

create index ARF_PROD_PCID_X2 on ARF_PRODUCT (PARENT_CAT_ID);
create index ARF_PROD_NPID_X1 on ARF_PRODUCT (NPRODUCT_ID);
-- Dimension: SKU
-- Levels: SKU

create table ARF_SKU (
	ID	integer	not null,
	NSKU_ID	varchar(40)	not null,
	NAME	varchar(254)	not null,
	NAME_EN	varchar(254)	default null,
	DESCRIPTION	varchar(254)	default null,
	DESCRIPTION_EN	varchar(254)	default null,
	PARENT_PROD_ID	integer	default null,
	WHOLESALE_PRICE	double precision	default null,
	LIST_PRICE	double precision	default null,
	SALE_PRICE	double precision	default null,
	ON_SALE	numeric(1,0)	default null,
	RECORD_LAST_UPDATE	timestamp	default null,
	RECORD_START_DATE	timestamp	default null,
	RECORD_END_DATE	timestamp	default null,
	MOST_RECENT	numeric(1)	default 1 not null,
	DELETED	numeric(1)	default 0 not null
,constraint ARF_SKU_P primary key (ID)
,constraint ARF_SKU_F1 foreign key (PARENT_PROD_ID) references ARF_PRODUCT (ID));

create index ARF_SKU_PSID_X2 on ARF_SKU (PARENT_PROD_ID);
create index ARF_SKU_NSKUI_X1 on ARF_SKU (NSKU_ID);
-- Dimension: PROMOTION
-- Levels: PROMOTION

create table ARF_PROMOTION (
	ID	smallint	not null,
	NPROMO_ID	varchar(40)	not null,
	PROMO_NAME	varchar(254)	not null,
	PROMO_NAME_EN	varchar(254)	default null,
	PROMO_DESC	varchar(254)	default null,
	PROMO_DESC_EN	varchar(254)	default null,
	PROMO_TYPE	varchar(254)	default null,
	PROMO_ENABLED	numeric(1,0)	default null,
	PROMO_BEGIN_USABLE	timestamp	default null,
	PROMO_END_USABLE	timestamp	default null,
	PROMO_GLOBAL	numeric(1,0)	default null,
	RECORD_LAST_UPDATE	timestamp	default null,
	RECORD_START_DATE	timestamp	default null,
	RECORD_END_DATE	timestamp	default null,
	MOST_RECENT	numeric(1)	default 1 not null,
	DELETED	numeric(1)	default 0 not null
,constraint ARF_PROMOTION_P primary key (ID));

create index ARF_PROMO_NPID_X1 on ARF_PROMOTION (NPROMO_ID);

create table ARF_PROMOGRP (
	ID	smallint	not null,
	NAME	varchar(254)	not null,
	HASH_VALUE	varchar(254)	not null,
	LENGTH	smallint	not null
,constraint ARF_PROMOGRP_P primary key (ID));

create index ARF_PROMOGRP_X1 on ARF_PROMOGRP (HASH_VALUE);

create table ARF_PROMOGRP_MBRS (
	PROMOGRP_ID	smallint	not null,
	PROMOTION_ID	smallint	not null
,constraint ARF_PRMGRP_MBRS_P primary key (PROMOGRP_ID,PROMOTION_ID)
,constraint ARF_PROMOG_MBRS_F1 foreign key (PROMOGRP_ID) references ARF_PROMOGRP (ID)
,constraint ARF_PROMOG_MBRS_F2 foreign key (PROMOTION_ID) references ARF_PROMOTION (ID));

create index ARF_PROMOG_MBRS1_X on ARF_PROMOGRP_MBRS (PROMOTION_ID);
-- Dimension: Sales Channel
-- Levels: Sales Channel

create table ARF_SALES_CHANNEL (
	ID	numeric(3,0)	not null,
	NCODE	integer	not null,
	NAME	varchar(254)	not null,
	NAME_EN	varchar(254)	default null,
	DESCRIPTION	varchar(254)	default null,
	DESCRIPTION_EN	varchar(254)	default null
,constraint ARF_SCHANNEL_P primary key (ID));

-- Dimension: Store
-- Levels: Store

create table ARF_STORE (
	ID	smallint	not null,
	NLOCATION_ID	varchar(40)	not null,
	NAME	varchar(254)	not null,
	NAME_EN	varchar(254)	default null,
	EXT_LOC_ID	varchar(40)	default null,
	LATITUDE	double precision	not null,
	LONGITUDE	double precision	not null,
	ADDRESS_1	varchar(50)	default null,
	ADDRESS_2	varchar(50)	default null,
	ADDRESS_3	varchar(50)	default null,
	CITY	varchar(40)	default null,
	COUNTY	varchar(40)	default null,
	STATE_ADDR	varchar(40)	default null,
	POSTAL_CODE	varchar(40)	default null,
	COUNTRY	varchar(40)	default null,
	PHONE_NUMBER	varchar(40)	default null,
	FAX_NUMBER	varchar(40)	default null,
	EMAIL	varchar(255)	default null,
	HOURS	varchar(64)	default null,
	RECORD_LAST_UPDATE	timestamp	default null,
	RECORD_START_DATE	timestamp	default null,
	RECORD_END_DATE	timestamp	default null,
	MOST_RECENT	numeric(1)	default 1 not null,
	DELETED	numeric(1)	default 0 not null
,constraint ARF_STORE_P primary key (ID));

create index ARF_STORE_NLOCID_X1 on ARF_STORE (NLOCATION_ID);
-- Dimension: COUPON
-- Levels: COUPON

create table ARF_COUPON (
	ID	integer	not null,
	NCOUPON_ID	varchar(40)	not null,
	NAME	varchar(254)	not null,
	NAME_EN	varchar(254)	default null,
	START_DATE	timestamp	default null,
	EXPIRATION_DATE	timestamp	default null,
	IS_BATCH	numeric(1)	default 0 not null,
	NUMBER_OF_COUPONS	integer	default 0 not null,
	RECORD_LAST_UPDATE	timestamp	default null,
	RECORD_START_DATE	timestamp	default null,
	RECORD_END_DATE	timestamp	default null,
	MOST_RECENT	numeric(1)	default 1 not null,
	DELETED	numeric(1)	default 0 not null
,constraint ARF_COUPON_P primary key (ID));

create index ARF_COUPON_NCID_X1 on ARF_COUPON (NCOUPON_ID);
-- Fact: LINE ITEM
-- Dimensions: DAY
-- TIME
-- SKU
-- PRODUCT
-- CATEGORY
-- CUSTOMER
-- AGENT
-- ORIGIN SALES CHANNEL
-- SUBMIT SALES CHANNEL
-- STIMULUS GROUP
-- SEGMENT CLUSTER
-- PROMOTION GROUP
-- BILLING REGION
-- SHIPPING REGION
-- STORE
-- LOCAL CURRENCY
-- ORGANIZATION
-- Measures: QUANTITY
-- LOCAL UNIT PRICE
-- LOCAL LINE ITEM GROSS REVENUE
-- LOCAL LINE ITEM DISCOUNT AMOUNT
-- LOCAL LINE ITEM MARKDOWN DISCOUNT AMOUNT
-- LOCAL ORDER DISCOUNT AMOUNT ALLOCATION
-- LOCAL ORDER TAX REVENUE ALLOCATION
-- LOCAL ORDER SHIPPING REVENUE ALLOCATION
-- LOCAL LINE ITEM NET REVENUE
-- LOCAL ORDER NET REVENUE
-- LOCAL ORDER MANUAL ADJUSTMENTS DEBIT ALLOCATION
-- LOCAL ORDER MANUAL ADJUSTMENTS CREDIT ALLOCATION
-- LOCAL LINE ITEM PRICE OVERRIDE AMOUNT
-- STANDARD UNIT PRICE
-- STANDARD LINE ITEM GROSS REVENUE
-- STANDARD LINE ITEM DISCOUNT AMOUNT
-- STANDARD LINE ITEM MARKDOWN DISCOUNT AMOUNT
-- STANDARD ORDER DISCOUNT AMOUNT ALLOCATION
-- STANDARD ORDER TAX REVENUE ALLOCATION
-- STANDARD ORDER SHIPPING REVENUE ALLOCATION
-- STANDARD LINE ITEM NET REVENUE
-- STANDARD ORDER NET REVENUE
-- STANDARD ORDER MANUAL ADJUSTMENTS DEBIT ALLOCATION
-- STANDARD ORDER MANUAL ADJUSTMENTS CREDIT ALLOCATION
-- STANDARD LINE ITEM PRICE OVERRIDE AMOUNT

create table ARF_LINE_ITEM (
	SUBMIT_TIMESTAMP	timestamp	default null,
	SUBMIT_DAY_ID	varchar(40)	not null,
	SUBMIT_TIME_ID	integer	not null,
	SKU_ID	integer	not null,
	PRODUCT_ID	integer	not null,
	CATEGORY_ID	integer	not null,
	CUSTOMER_ID	integer	not null,
	NCUSTOMER_ID	varchar(40)	default null,
	AGENT_ID	varchar(40)	default null,
	ORIGIN_SALES_CHANNEL_ID	numeric(3,0)	default null,
	SUBMIT_SALES_CHANNEL_ID	numeric(3,0)	default null,
	STIMGRP_ID	integer	not null,
	SEGCLSTR_ID	integer	not null,
	PROMOGRP_ID	smallint	not null,
	BILLING_REGION_ID	smallint	not null,
	SHIPPING_REGION_ID	smallint	not null,
	STORE_ID	smallint	not null,
	LOCAL_CURRENCY_ID	smallint	not null,
	DEMOGRAPHIC_ID	smallint	not null,
	SITE_VISIT_ID	bigint	not null,
	ORDER_ID	integer	not null,
	LINE_ITEM_ID	bigint	not null,
	NORDER_ID	varchar(40)	not null,
	NLINE_ITEM_ID	varchar(40)	not null,
	SESSION_ID	varchar(128)	default null,
	QUANTITY	numeric(19,7)	not null,
	IS_MARKDOWN	numeric(1)	default 0 not null,
	LOCAL_UNIT_PRICE	double precision	not null,
	LOCAL_GROSS_REVENUE	double precision	not null,
	LOCAL_DISCOUNT_AMOUNT	double precision	not null,
	LOCAL_MARKDOWN_DISC_AMOUNT	double precision	not null,
	LOCAL_ORDER_TAX_ALLOC	double precision	not null,
	LOCAL_ORDER_SHIPPING_ALLOC	double precision	not null,
	LOCAL_ORDER_DISCOUNT_ALLOC	double precision	not null,
	LOCAL_NET_REVENUE	double precision	not null,
	LOCAL_ORDER_NET_REVENUE	double precision	not null,
	LOCAL_APPSMT_DBT_ALLOC_AMT	double precision	default null,
	LOCAL_APPSMT_CDT_ALLOC_AMT	double precision	default null,
	LOCAL_PRICE_OVERRIDE_AMT	double precision	default null,
	STANDARD_UNIT_PRICE	double precision	not null,
	STANDARD_GROSS_REVENUE	double precision	not null,
	STANDARD_DISCOUNT_AMOUNT	double precision	not null,
	STANDARD_MARKDOWN_DISC_AMOUNT	double precision	not null,
	STANDARD_ORDER_TAX_ALLOC	double precision	not null,
	STANDARD_ORDER_SHIPPING_ALLOC	double precision	not null,
	STANDARD_ORDER_DISCOUNT_ALLOC	double precision	not null,
	STANDARD_NET_REVENUE	double precision	not null,
	STANDARD_ORDER_NET_REVENUE	double precision	not null,
	STANDARD_APPSMT_DBT_ALLOC_AMT	double precision	default null,
	STANDARD_APPSMT_CDT_ALLOC_AMT	double precision	default null,
	STANDARD_PRICE_OVERRIDE_AMT	double precision	default null,
	SUBMITTED_SITE_ID	smallint	not null,
	ORIGIN_SITE_ID	smallint	not null,
	ITEM_SITE_ID	smallint	not null,
	IS_COUPON_APPLIED	numeric(1)	default 0 not null,
	ORGANIZATION_ID	integer	default null,
	SEARCH_TERM_ID	integer	default null,
	FACET_GROUP_ID	integer	default null,
	MERCH_RULE_GROUP_ID	integer	default null
,constraint ARF_LINE_ITEM_P primary key (LINE_ITEM_ID)
,constraint ARF_LINE_ITEM_F1 foreign key (SUBMIT_DAY_ID) references ARF_TIME_DAY (ID)
,constraint ARF_LINE_ITEM_F2 foreign key (SUBMIT_TIME_ID) references ARF_TIME_TOD (ID)
,constraint ARF_LINE_ITEM_F3 foreign key (SKU_ID) references ARF_SKU (ID)
,constraint ARF_LINE_ITEM_F4 foreign key (PRODUCT_ID) references ARF_PRODUCT (ID)
,constraint ARF_LINE_ITEM_F5 foreign key (CATEGORY_ID) references ARF_CATEGORY (ID)
,constraint ARF_LINE_ITEM_F6 foreign key (CUSTOMER_ID) references ARF_USER (ID)
,constraint ARF_LINE_ITEM_F7 foreign key (STIMGRP_ID) references ARF_STIMGRP (ID)
,constraint ARF_LINE_ITEM_F8 foreign key (SEGCLSTR_ID) references ARF_SEGCLSTR (ID)
,constraint ARF_LINE_ITEM_F9 foreign key (PROMOGRP_ID) references ARF_PROMOGRP (ID)
,constraint ARF_LINE_ITEM_F10 foreign key (BILLING_REGION_ID) references ARF_GEO_REGION (ID)
,constraint ARF_LINE_ITEM_F11 foreign key (SHIPPING_REGION_ID) references ARF_GEO_REGION (ID)
,constraint ARF_LINE_ITEM_F12 foreign key (LOCAL_CURRENCY_ID) references ARF_CURRENCY (ID)
,constraint ARF_LINE_ITEM_F13 foreign key (DEMOGRAPHIC_ID) references ARF_DEMOGRAPHIC (ID)
,constraint ARF_LINE_ITEM_F14 foreign key (ORIGIN_SALES_CHANNEL_ID) references ARF_SALES_CHANNEL (ID)
,constraint ARF_LINE_ITEM_F15 foreign key (SUBMIT_SALES_CHANNEL_ID) references ARF_SALES_CHANNEL (ID)
,constraint ARF_LINE_ITEM_F16 foreign key (AGENT_ID) references ARF_IU_USER (ID)
,constraint ARF_LINE_ITEM_F18 foreign key (SUBMITTED_SITE_ID) references ARF_SITE (ID)
,constraint ARF_LINE_ITEM_F19 foreign key (ORIGIN_SITE_ID) references ARF_SITE (ID)
,constraint ARF_LINE_ITEM_F20 foreign key (ITEM_SITE_ID) references ARF_SITE (ID)
,constraint ARF_LINE_ITEM_F27 foreign key (STORE_ID) references ARF_STORE (ID)
,constraint ARF_LINE_ITEM_F28 foreign key (ORGANIZATION_ID) references ARF_ORGANIZATION (ID)
,constraint ARF_LINE_ITEM_F29 foreign key (SEARCH_TERM_ID) references ARF_SEARCH_TERM (ID)
,constraint ARF_LINE_ITEM_F30 foreign key (FACET_GROUP_ID) references ARF_FACET_SEL_GROUP (ID)
,constraint ARF_LINE_ITEM_F31 foreign key (MERCH_RULE_GROUP_ID) references ARF_MERCH_RULE_GROUP (ID));

create index ARF_LINE_ITEM_X23 on ARF_LINE_ITEM (SUBMITTED_SITE_ID);
create index ARF_LINE_ITEM_X24 on ARF_LINE_ITEM (ORIGIN_SITE_ID);
create index ARF_LINE_ITEM_X25 on ARF_LINE_ITEM (ITEM_SITE_ID);
create index ARF_LINE_ITEM_X27 on ARF_LINE_ITEM (STORE_ID);
create index ARF_LINE_ITEM_X28 on ARF_LINE_ITEM (ORGANIZATION_ID);
create index ARF_LINE_ITEM_X29 on ARF_LINE_ITEM (SEARCH_TERM_ID);
create index ARF_LINE_ITEM_X30 on ARF_LINE_ITEM (FACET_GROUP_ID);
create index ARF_LINE_ITEM_X31 on ARF_LINE_ITEM (MERCH_RULE_GROUP_ID);
create index ARF_LINE_ITEM_X1 on ARF_LINE_ITEM (SUBMIT_DAY_ID);
create index ARF_LINE_ITEM_X2 on ARF_LINE_ITEM (SUBMIT_TIME_ID);
create index ARF_LINE_ITEM_X3 on ARF_LINE_ITEM (SKU_ID);
create index ARF_LINE_ITEM_X4 on ARF_LINE_ITEM (PRODUCT_ID);
create index ARF_LINE_ITEM_X5 on ARF_LINE_ITEM (CATEGORY_ID);
create index ARF_LINE_ITEM_X6 on ARF_LINE_ITEM (CUSTOMER_ID);
create index ARF_LINE_ITEM_X7 on ARF_LINE_ITEM (STIMGRP_ID);
create index ARF_LINE_ITEM_X8 on ARF_LINE_ITEM (SEGCLSTR_ID);
create index ARF_LINE_ITEM_X9 on ARF_LINE_ITEM (PROMOGRP_ID);
create index ARF_LINE_ITEM_X10 on ARF_LINE_ITEM (BILLING_REGION_ID);
create index ARF_LINE_ITEM_X11 on ARF_LINE_ITEM (SHIPPING_REGION_ID);
create index ARF_LINE_ITEM_X12 on ARF_LINE_ITEM (LOCAL_CURRENCY_ID);
create index ARF_LINE_ITEM_X13 on ARF_LINE_ITEM (DEMOGRAPHIC_ID);
create index ARF_LINE_ITEM_X14 on ARF_LINE_ITEM (SITE_VISIT_ID);
create index ARF_LINE_ITEM_X15 on ARF_LINE_ITEM (SESSION_ID);
create index ARF_LINE_ITEM_X16 on ARF_LINE_ITEM (NORDER_ID);
create index ARF_LINE_ITEM_X17 on ARF_LINE_ITEM (ORDER_ID);
create index ARF_LINE_ITEM_X18 on ARF_LINE_ITEM (IS_MARKDOWN);
create index ARF_LINE_ITEM_X19 on ARF_LINE_ITEM (ORIGIN_SALES_CHANNEL_ID);
create index ARF_LINE_ITEM_X20 on ARF_LINE_ITEM (SUBMIT_SALES_CHANNEL_ID);
create index ARF_LINE_ITEM_X21 on ARF_LINE_ITEM (AGENT_ID);
create index ARF_LINE_ITEM_X26 on ARF_LINE_ITEM (NCUSTOMER_ID);
-- Dimension: Return Reason and Disposition

create table ARF_RET_REASON_DISPOSITION (
	ID	integer	not null,
	NREASON_ID	varchar(40)	not null,
	DESCRIPTION	varchar(254)	default null,
	DESCRIPTION_EN	varchar(254)	default null,
	DISPOSITION	numeric(1)	default 0
,constraint ARF_RRD_P primary key (ID));

-- Fact: RETURN LINE ITEM
-- Dimensions: DAY
-- TIME
-- SKU
-- PRODUCT
-- CUSTOMER
-- LOCAL CURRENCY
-- RETURN SALES CHANNEL
-- LOCAL CURRENCY
-- AGENT
-- RETURN
-- RETURN REASON
-- ITEM SITE
-- SUBMITTED SITE
-- Measures: QUANTITY
-- LOCAL TAX REFUND AMOUNT ALLOCATION
-- LOCAL SHIPPING REFUND AMOUNT ALLOCATION
-- LOCAL OTHER REFUND AMOUNT ALLOCATION
-- LOCAL RETURN FEE AMOUNT ALLOCATION
-- LOCAL ITEM REFUND AMOUNT
-- LOCAL TOTAL ADJUSTMENTS AMOUNT
-- LOCAL TOTAL REFUND AMOUNT
-- LOCAL TAX REFUND AMOUNT ALLOCATION
-- LOCAL SHIPPING REFUND AMOUNT ALLOCATION
-- LOCAL OTHER REFUND AMOUNT ALLOCATION
-- LOCAL RETURN FEE AMOUNT ALLOCATION
-- LOCAL ITEM REFUND AMOUNT
-- LOCAL TOTAL ADJUSTMENTS AMOUNT
-- LOCAL TOTAL REFUND AMOUNT

create table ARF_RETURN_ITEM (
	SUBMIT_TIMESTAMP	timestamp	default null,
	SUBMIT_DAY_ID	varchar(40)	not null,
	SUBMIT_TIME_ID	integer	not null,
	SKU_ID	integer	not null,
	PRODUCT_ID	integer	not null,
	CUSTOMER_ID	integer	not null,
	LOCAL_CURRENCY_ID	smallint	not null,
	NRETURN_ID	varchar(40)	not null,
	NORIGINAL_ORDER_ID	varchar(40)	not null,
	NEXCHANGE_ORDER_ID	varchar(40)	default null,
	RETURN_ITEM_ID	bigint	not null,
	NRETURN_ITEM_ID	varchar(40)	not null,
	QUANTITY	numeric(26,7)	not null,
	EXCHANGE	numeric(1)	default 0 not null,
	RETURN_SALES_CHANNEL_ID	numeric(3,0)	not null,
	AGENT_ID	varchar(40)	not null,
	RETURN_REASON_ID	integer	not null,
	ITEM_SITE_ID	smallint	not null,
	SUBMITTED_SITE_ID	smallint	not null,
	LOCAL_ITEM_REFUND	double precision	not null,
	LOCAL_TOTAL_REFUND	double precision	not null,
	LOCAL_TOTAL_ADJ_ALLOC	double precision	not null,
	LOCAL_SHIPPING_REFUND_ALLOC	double precision	not null,
	LOCAL_TAX_REFUND_ALLOC	double precision	not null,
	LOCAL_OTHER_REFUND_ALLOC	double precision	not null,
	LOCAL_RETURN_FEE_ALLOC	double precision	not null,
	STD_ITEM_REFUND	double precision	not null,
	STD_TOTAL_REFUND	double precision	not null,
	STD_TOTAL_ADJ_ALLOC	double precision	not null,
	STD_SHIPPING_REFUND_ALLOC	double precision	not null,
	STD_TAX_REFUND_ALLOC	double precision	not null,
	STD_OTHER_REFUND_ALLOC	double precision	not null,
	STD_RETURN_FEE_ALLOC	double precision	not null
,constraint ARF_RI_P primary key (RETURN_ITEM_ID)
,constraint ARF_RI_F1 foreign key (SUBMIT_DAY_ID) references ARF_TIME_DAY (ID)
,constraint ARF_RI_F2 foreign key (SUBMIT_TIME_ID) references ARF_TIME_TOD (ID)
,constraint ARF_RI_F3 foreign key (SKU_ID) references ARF_SKU (ID)
,constraint ARF_RI_F4 foreign key (PRODUCT_ID) references ARF_PRODUCT (ID)
,constraint ARF_RI_F5 foreign key (CUSTOMER_ID) references ARF_USER (ID)
,constraint ARF_RI_F6 foreign key (LOCAL_CURRENCY_ID) references ARF_CURRENCY (ID)
,constraint ARF_RI_F7 foreign key (RETURN_SALES_CHANNEL_ID) references ARF_SALES_CHANNEL (ID)
,constraint ARF_RI_F8 foreign key (AGENT_ID) references ARF_IU_USER (ID)
,constraint ARF_RI_F10 foreign key (RETURN_REASON_ID) references ARF_RET_REASON_DISPOSITION (ID)
,constraint ARF_RI_F11 foreign key (ITEM_SITE_ID) references ARF_SITE (ID)
,constraint ARF_RI_F12 foreign key (SUBMITTED_SITE_ID) references ARF_SITE (ID));

create index ARF_RI_X1 on ARF_RETURN_ITEM (SUBMIT_DAY_ID);
create index ARF_RI_X2 on ARF_RETURN_ITEM (SUBMIT_TIME_ID);
create index ARF_RI_X3 on ARF_RETURN_ITEM (SKU_ID);
create index ARF_RI_X4 on ARF_RETURN_ITEM (PRODUCT_ID);
create index ARF_RI_X5 on ARF_RETURN_ITEM (CUSTOMER_ID);
create index ARF_RI_X6 on ARF_RETURN_ITEM (AGENT_ID);
create index ARF_RI_X7 on ARF_RETURN_ITEM (LOCAL_CURRENCY_ID);
create index ARF_RI_X8 on ARF_RETURN_ITEM (NORIGINAL_ORDER_ID);
create index ARF_RI_X9 on ARF_RETURN_ITEM (RETURN_REASON_ID);
create index ARF_RI_X10 on ARF_RETURN_ITEM (RETURN_SALES_CHANNEL_ID);
create index ARF_RI_X11 on ARF_RETURN_ITEM (ITEM_SITE_ID);
create index ARF_RI_X12 on ARF_RETURN_ITEM (SUBMITTED_SITE_ID);

create table ARF_PROMOTION_USAGE (
	PROMOTION_USAGE_ID	bigint	not null,
	PROMOTION_ID	smallint	not null,
	USAGE_TIMESTAMP	timestamp	default null,
	DAY_ID	varchar(40)	not null,
	TIME_ID	integer	not null,
	SKU_ID	integer	not null,
	PRODUCT_ID	integer	not null,
	CATEGORY_ID	integer	not null,
	CUSTOMER_ID	integer	not null,
	SEGCLSTR_ID	integer	not null,
	BILLING_REGION_ID	smallint	not null,
	LOCAL_CURRENCY_ID	smallint	not null,
	DEMOGRAPHIC_ID	smallint	not null,
	SITE_VISIT_ID	bigint	not null,
	ORDER_ID	integer	not null,
	NORDER_ID	varchar(40)	not null,
	SESSION_ID	varchar(128)	default null,
	AGENT_ID	varchar(40)	default null,
	ORIGIN_SALES_CHANNEL_ID	numeric(3,0)	default null,
	SUBMIT_SALES_CHANNEL_ID	numeric(3,0)	default null,
	QUANTITY	numeric(19,7)	not null,
	LOCAL_NET_REVENUE	numeric(19,7)	not null,
	LOCAL_ORDER_NET_REVENUE	numeric(19,7)	not null,
	LOCAL_DISCOUNT_AMOUNT	numeric(19,7)	not null,
	STANDARD_NET_REVENUE	numeric(19,7)	not null,
	STANDARD_ORDER_NET_REVENUE	numeric(19,7)	not null,
	STANDARD_DISCOUNT_AMOUNT	numeric(19,7)	not null,
	SITE_ID	smallint	not null,
	COUPON_USAGE_ID	bigint	not null,
	COUPON_ID	integer	not null,
	COUPON_CODE	varchar(254)	default null,
	ORGANIZATION_ID	integer	default null
,constraint ARF_PU_FACT_P primary key (PROMOTION_USAGE_ID)
,constraint ARF_PROMOUSAGE_F1 foreign key (PROMOTION_ID) references ARF_PROMOTION (ID)
,constraint ARF_PROMOUSAGE_F2 foreign key (DAY_ID) references ARF_TIME_DAY (ID)
,constraint ARF_PROMOUSAGE_F3 foreign key (TIME_ID) references ARF_TIME_TOD (ID)
,constraint ARF_PROMOUSAGE_F4 foreign key (SKU_ID) references ARF_SKU (ID)
,constraint ARF_PROMOUSAGE_F5 foreign key (PRODUCT_ID) references ARF_PRODUCT (ID)
,constraint ARF_PROMOUSAGE_F6 foreign key (CATEGORY_ID) references ARF_CATEGORY (ID)
,constraint ARF_PROMOUSAGE_F7 foreign key (CUSTOMER_ID) references ARF_USER (ID)
,constraint ARF_PROMOUSAGE_F8 foreign key (SEGCLSTR_ID) references ARF_SEGCLSTR (ID)
,constraint ARF_PROMOUSAGE_F9 foreign key (BILLING_REGION_ID) references ARF_GEO_REGION (ID)
,constraint ARF_PROMOUSAGE_F10 foreign key (LOCAL_CURRENCY_ID) references ARF_CURRENCY (ID)
,constraint ARF_PROMOUSAGE_F11 foreign key (DEMOGRAPHIC_ID) references ARF_DEMOGRAPHIC (ID)
,constraint ARF_PROMOUSAGE_F12 foreign key (AGENT_ID) references ARF_IU_USER (ID)
,constraint ARF_PROMOUSAGE_F13 foreign key (ORIGIN_SALES_CHANNEL_ID) references ARF_SALES_CHANNEL (ID)
,constraint ARF_PROMOUSAGE_F14 foreign key (SUBMIT_SALES_CHANNEL_ID) references ARF_SALES_CHANNEL (ID)
,constraint ARF_PROMOUSAGE_F15 foreign key (SITE_ID) references ARF_SITE (ID)
,constraint ARF_PROMOUSAGE_F16 foreign key (COUPON_ID) references ARF_COUPON (ID)
,constraint ARF_PROMOUSAGE_F17 foreign key (ORGANIZATION_ID) references ARF_ORGANIZATION (ID));

create index ARF_PROMOUSAGE_X1 on ARF_PROMOTION_USAGE (PROMOTION_ID);
create index ARF_PROMOUSAGE_X2 on ARF_PROMOTION_USAGE (DAY_ID);
create index ARF_PROMOUSAGE_X3 on ARF_PROMOTION_USAGE (TIME_ID);
create index ARF_PROMOUSAGE_X4 on ARF_PROMOTION_USAGE (SKU_ID);
create index ARF_PROMOUSAGE_X5 on ARF_PROMOTION_USAGE (PRODUCT_ID);
create index ARF_PROMOUSAGE_X6 on ARF_PROMOTION_USAGE (CATEGORY_ID);
create index ARF_PROMOUSAGE_X7 on ARF_PROMOTION_USAGE (CUSTOMER_ID);
create index ARF_PROMOUSAGE_X8 on ARF_PROMOTION_USAGE (SEGCLSTR_ID);
create index ARF_PROMOUSAGE_X9 on ARF_PROMOTION_USAGE (BILLING_REGION_ID);
create index ARF_PROMOUSAGE_X10 on ARF_PROMOTION_USAGE (LOCAL_CURRENCY_ID);
create index ARF_PROMOUSAGE_X11 on ARF_PROMOTION_USAGE (DEMOGRAPHIC_ID);
create index ARF_PROMOUSAGE_X12 on ARF_PROMOTION_USAGE (AGENT_ID);
create index ARF_PROMOUSAGE_X13 on ARF_PROMOTION_USAGE (ORIGIN_SALES_CHANNEL_ID);
create index ARF_PROMOUSAGE_X14 on ARF_PROMOTION_USAGE (SUBMIT_SALES_CHANNEL_ID);
create index ARF_PROMOUSAGE_X19 on ARF_PROMOTION_USAGE (SITE_ID);
create index ARF_PROMOUSAGE_X20 on ARF_PROMOTION_USAGE (COUPON_ID);
create index ARF_PROMOUSAGE_X21 on ARF_PROMOTION_USAGE (ORGANIZATION_ID);
create index ARF_PROMOUSAGE_X15 on ARF_PROMOTION_USAGE (SITE_VISIT_ID);
create index ARF_PROMOUSAGE_X16 on ARF_PROMOTION_USAGE (ORDER_ID);
create index ARF_PROMOUSAGE_X17 on ARF_PROMOTION_USAGE (NORDER_ID);
create index ARF_PROMOUSAGE_X18 on ARF_PROMOTION_USAGE (SESSION_ID);
-- Dimension: APPEASEMENT REASON DISPOSITION

create table ARF_APPEASEMENT_RSN_DISP (
	ID	integer	not null,
	NREASON_ID	varchar(40)	not null,
	DESCRIPTION	varchar(254)	default null,
	DISPOSITION	numeric(1)	default 0
,constraint ARF_ARD_P primary key (ID));

-- Fact: APPEASEMENT

create table ARF_APPEASEMENT (
	ID	bigint	not null,
	NAPPEASEMENT_ID	varchar(40)	not null,
	CUSTOMER_ID	integer	not null,
	AGENT_ID	varchar(40)	not null,
	REASON_ID	integer	not null,
	SUBMIT_TIMESTAMP	timestamp	default null,
	SUBMIT_DAY_ID	varchar(40)	not null,
	SUBMIT_TIME_ID	integer	not null,
	LOCAL_CURRENCY_ID	smallint	not null,
	NORDER_ID	varchar(40)	not null,
	TYPE	varchar(40)	not null,
	SALES_CHANNEL_ID	numeric(3,0)	not null,
	SUBMITTED_SITE_ID	smallint	not null,
	LOCAL_APPEASEMENT_AMOUNT	numeric(19,7)	not null,
	STD_APPEASEMENT_AMOUNT	numeric(19,7)	not null
,constraint ARF_APPEASEMENT_P primary key (ID)
,constraint ARF_APP_CID foreign key (CUSTOMER_ID) references ARF_USER (ID)
,constraint ARF_APP_CURR foreign key (LOCAL_CURRENCY_ID) references ARF_CURRENCY (ID)
,constraint ARF_APP_SC foreign key (SALES_CHANNEL_ID) references ARF_SALES_CHANNEL (ID)
,constraint ARF_APP_SITE foreign key (SUBMITTED_SITE_ID) references ARF_SITE (ID)
,constraint ARF_APP_AGT foreign key (AGENT_ID) references ARF_IU_USER (ID)
,constraint ARF_APP_RSN foreign key (REASON_ID) references ARF_APPEASEMENT_RSN_DISP (ID)
,constraint ARF_APP_TD foreign key (SUBMIT_DAY_ID) references ARF_TIME_DAY (ID)
,constraint ARF_APP_TID foreign key (SUBMIT_TIME_ID) references ARF_TIME_TOD (ID));

create index ARF_APP_IDX3 on ARF_APPEASEMENT (CUSTOMER_ID);
create index ARF_APP_IDX5 on ARF_APPEASEMENT (LOCAL_CURRENCY_ID);
create index ARF_APP_IDX8 on ARF_APPEASEMENT (SALES_CHANNEL_ID);
create index ARF_APP_IDX9 on ARF_APPEASEMENT (SUBMITTED_SITE_ID);
create index ARF_APP_IDX4 on ARF_APPEASEMENT (AGENT_ID);
create index ARF_APP_IDX7 on ARF_APPEASEMENT (REASON_ID);
create index ARF_APP_IDX1 on ARF_APPEASEMENT (SUBMIT_DAY_ID);
create index ARF_APP_IDX2 on ARF_APPEASEMENT (SUBMIT_TIME_ID);
create index ARF_APP_IDX6 on ARF_APPEASEMENT (NORDER_ID);
commit;


