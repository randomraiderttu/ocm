--Create admin user and schema for OCM
CREATE USER ocmadmin WITH PASSWORD 'ocmadmin';
CREATE SCHEMA ocm AUTHORIZATION ocmadmin;
GRANT ALL ON ALL TABLES IN SCHEMA OCM TO OCMADMIN;
--We don't want users connecting as admin, so we'll create a user account
--with limited privs.
CREATE USER ocmuser WITH PASSWORD 'ocmuser';
CREATE ROLE ocm_user_r;
GRANT SELECT ON ALL TABLES IN SCHEMA ocm TO ocm_user_r;
--Remove all roles from ability to access public
REVOKE ALL ON SCHEMA PUBLIC FROM PUBLIC;
--Set default schemas (via search_path to OCM for all users we set up)
ALTER ROLE ocm SET search_path = ocm;
ALTER ROLE ocmadmin SET search_path = ocm;
ALTER ROLE ocmuser SET search_path = ocm;
