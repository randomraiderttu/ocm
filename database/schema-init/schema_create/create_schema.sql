--Create admin user and schema for OCM
CREATE USER ocmadmin WITH PASSWORD 'ocmadmin';
CREATE SCHEMA ocm AUTHORIZATION ocmadmin;
--We don't want users connecting as admin, so we'll create a user account
--with limited privs.
CREATE USER ocmuser WITH PASSWORD 'ocmuser';
CREATE ROLE ocm_user_r;
GRANT SELECT ON ALL TABLES IN SCHEMA ocm TO ocm_user_r;
