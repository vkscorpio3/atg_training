


-- @version $ Id: $$Change: 1179550 $

START TRANSACTION;
INSERT INTO ARF_SALES_CHANNEL_I18N (LANG_ID,ID,NAME) VALUES ('ES',2,'Centro de contacto');
INSERT INTO ARF_SALES_CHANNEL_I18N (LANG_ID,ID,NAME) VALUES ('ES',1,'Web');
INSERT INTO ARF_SALES_CHANNEL_I18N (LANG_ID,ID,NAME) VALUES ('ES',0,'Sin especificar');

INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('ES',1,'La orden llegó tarde');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('ES',2,'La orden llegó dañada');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('ES',3,'El artículo llegó tarde');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('ES',4,'El artículo llegó dañado');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('ES',5,'Al cliente no le gustó el artículo');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('ES',6,'Se recibió un artículo incorrecto');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('ES',7,'Gesto de buena voluntad');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('ES',8,'Reclamación sobre producto');
INSERT INTO ARF_APPEASEMENT_RSN_DISP_I18N (LANG_ID, ID, DESCRIPTION) VALUES ('ES',0,'Sin especificar');

COMMIT;

commit;


