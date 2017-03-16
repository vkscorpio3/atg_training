drop user ATGCORE_CLOTHING cascade;
drop user ATGCATA_CLOTHING  cascade;
drop user ATGCATB_CLOTHING cascade;
drop user ATGPUB_CLOTHING cascade;
drop tablespace CLOTHING including contents and datafiles;

-- create tablespace CLOTHING DATAFILE 'D:\Evironments\Generic\app\jlin\oradata\opnec\week1.dbf' size 400m autoextend on;
create tablespace CLOTHING DATAFILE '/u01/app/oracle/oradata/opnec/week1.dbf' size 400m autoextend on;

CREATE USER ATGCORE_CLOTHING IDENTIFIED BY ATGCORE_CLOTHING default tablespace CLOTHING;
grant connect, resource, DBA to ATGCORE_CLOTHING;

CREATE USER ATGCATA_CLOTHING  IDENTIFIED BY ATGCATA_CLOTHING default tablespace CLOTHING;
grant connect, resource, DBA to ATGCATA_CLOTHING;

CREATE USER ATGCATB_CLOTHING IDENTIFIED BY ATGCATB_CLOTHING default tablespace CLOTHING;
grant connect, resource, DBA to ATGCATB_CLOTHING;

CREATE USER ATGPUB_CLOTHING IDENTIFIED BY ATGPUB_CLOTHING default tablespace CLOTHING;
grant connect, resource, DBA to ATGPUB_CLOTHING;



