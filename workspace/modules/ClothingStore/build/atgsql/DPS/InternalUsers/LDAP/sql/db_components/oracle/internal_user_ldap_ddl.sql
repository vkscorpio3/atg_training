


--  @version $Id: //product/DPS/version/11.2/templates/DPS/InternalUsers/LDAP/sql/internal_user_ldap_ddl.xml#1 $$Change: 953229 $
-- This file contains create table statements, which will configure your database for use with the new DPS schema.
-- Add the ldap organization definition.  

create table dpi_organization_ldap (
	org_id	varchar2(40)	not null,
	ldap	number(1,0)	null
,constraint dpi_organization_ldap_p primary key (org_id)
,constraint dpi_organizationldap_f foreign key (org_id) references dpi_organization (org_id));




