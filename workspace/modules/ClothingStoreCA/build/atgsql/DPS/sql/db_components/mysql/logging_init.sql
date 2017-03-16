


--  @version $Id: //product/DPS/version/11.2/templates/DPS/sql/logging_init.xml#1 $$Change: 946917 $
-- This file contains SQL statements which will initialize theDPS logging/reporting tables.
-- Set names of the default user event types, and initialize the log entry id counters

	START TRANSACTION;
	INSERT INTO dps_event_type (id, name) VALUES (0, 'newsession');
	INSERT INTO dps_event_type (id, name) VALUES (1, 'sessionexpiration');
	INSERT INTO dps_event_type (id, name) VALUES (2, 'login');
	INSERT INTO dps_event_type (id, name) VALUES (3, 'registration');
	INSERT INTO dps_event_type (id, name) VALUES (4, 'logout');
	INSERT INTO dps_log_id (tablename, nextid) VALUES ('dps_user_event', 0);
	INSERT INTO dps_log_id (tablename, nextid) VALUES ('dps_request', 0);
	INSERT INTO dps_log_id (tablename, nextid) VALUES ('dps_con_req', 0);
	COMMIT;
        
commit;


