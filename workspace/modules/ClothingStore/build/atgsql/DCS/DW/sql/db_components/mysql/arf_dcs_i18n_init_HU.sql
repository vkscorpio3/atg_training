


-- @version $ Id: $$Change: 1179550 $

START TRANSACTION;
INSERT INTO ARF_SALES_CHANNEL_I18N (LANG_ID,ID,NAME) VALUES ('HU',2,'Ügyfélszolgálati központ');
INSERT INTO ARF_SALES_CHANNEL_I18N (LANG_ID,ID,NAME) VALUES ('HU',1,'Web');
INSERT INTO ARF_SALES_CHANNEL_I18N (LANG_ID,ID,NAME) VALUES ('HU',0,'Nincs megadva');

INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('HU',1,'A rendelés későn érkezett.');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('HU',2,'A rendelés sérülten érkezett.');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('HU',3,'Az elem későn érkezett.');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('HU',4,'Az elem sérülten érkezett.');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('HU',5,'Az ügyfélnek nem tetszett az elem.');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('HU',6,'Helytelen elem érkezett.');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('HU',7,'Jóindulatú gesztus');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('HU',8,'Termékkel kapcsolatos panasz');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('HU',0,'Nincs megadva');

COMMIT;

commit;


