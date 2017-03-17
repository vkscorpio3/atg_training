


--  @version $Id: //product/DCS/version/11.2/DW/sql/xml/arf_dcs_i18n_init.xml#3 $$Change: 1179550 $

START TRANSACTION;
INSERT INTO ARF_SALES_CHANNEL_I18N (LANG_ID,ID,NAME) VALUES ('EN',2,'Contact Center');
INSERT INTO ARF_SALES_CHANNEL_I18N (LANG_ID,ID,NAME) VALUES ('EN',1,'Web');
INSERT INTO ARF_SALES_CHANNEL_I18N (LANG_ID,ID,NAME) VALUES ('EN',0,'Unspecified');

INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('EN',1,'Order Arrived Late');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('EN',2,'Order Arrived Damaged');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('EN',3,'Item Arrived Late');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('EN',4,'Item Arrived Damaged');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('EN',5,'Customer Did Not Like Item');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('EN',6,'Incorrect Item Received');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('EN',7,'Goodwill Gesture');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('EN',8,'Product Complaint');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('EN',0,'Unspecified');

COMMIT;

commit;


