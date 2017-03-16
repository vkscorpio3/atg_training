SET NEWPAGE 0
SET SPACE 0
SET LINESIZE 80
SET PAGESIZE 0
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING OFF
SET MARKUP HTML OFF

purge recyclebin;

SPOOL DELETE_ME.SQL

select 'drop procedure ', object_name, ';' from user_procedures;

select 'drop view ', view_name, 'cascade constraints;' from user_views;

select 'drop table ', table_name, 'cascade constraints;' from user_tables;

SPOOL OFF

@DELETE_ME.SQL

commit;

