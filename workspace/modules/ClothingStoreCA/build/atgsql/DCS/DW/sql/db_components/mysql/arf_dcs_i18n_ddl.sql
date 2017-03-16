


-- Dimension: Sales Channel

create table ARF_SALES_CHANNEL_I18N (
	LANG_ID	varchar(6)	not null,
	ID	tinyint	not null,
	NAME	nvarchar(254)	not null
,constraint ARF_SCHANNEL_I18N_P primary key (LANG_ID,ID));

-- Dimension: Appeasement Reason Dispositions

create table ARF_APPEASEMENT_RSN_DISP_I18N (
	LANG_ID	varchar(6)	not null,
	ID	tinyint	not null,
	DESCRIPTION	nvarchar(254)	not null
,constraint ARF_APPSMT_RSN_DISP_I18N_P primary key (LANG_ID,ID));

commit;


