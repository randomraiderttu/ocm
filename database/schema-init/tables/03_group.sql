CREATE TABLE ocm.group
(  group_id                    SERIAL PRIMARY KEY 
 , group_name                  VARCHAR(100) NOT NULL 
 , group_description           VARCHAR(250) NOT NULL
 , group_admin_name            VARCHAR(100) NOT NULL 
 , group_admin_email_address   VARCHAR(150) NOT NULL 
 , group_admin_phone_number    VARCHAR(100) NOT NULL 
 , group_oncall_instructions   VARCHAR(4000)
 , notes                       VARCHAR(500)
 , active_status               CHAR(1) NOT NULL DEFAULT 'Y' CHECK(active_status IN ('Y','N'))
 , create_date                 TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
 , update_date                 TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

--CREATE NATURAL KEY on group name enforcing no dupes
CREATE UNIQUE INDEX group_nk ON ocm.group(UPPER(group_name));

COMMENT ON TABLE ocm.group IS 'Defines the highest level of a given on-call group. An example of a group may be; Unix Team, Operations Team, On-Call DBA, etc. Table is unique based on group name.';

COMMENT ON COLUMN ocm.group.group_id IS 'Primary Key; sequence generated';
COMMENT ON COLUMN ocm.group.group_name IS 'Natural key of table. Describes the on-call group such as On-Call Windows Admins, On-Call Unix Team, etc.';
COMMENT ON COLUMN ocm.group.group_description IS 'Describes the group in better detail.';
COMMENT ON COLUMN ocm.group.group_admin_name IS 'Name of the owner and administrator of this group. Might be a manager or director of a team for example.';
COMMENT ON COLUMN ocm.group.group_admin_email_address IS 'Email address of group administrator for contact regarding the health of the on-call list if necessary.';
COMMENT ON COLUMN ocm.group.group_admin_phone_number IS 'Phone number of the group administrator for contact regarding the health of the on-call list if necessary.';
COMMENT ON COLUMN ocm.group.group_oncall_instructions IS 'Optional field to define on-call instructions for the group if applicable. You may ask your helpdesk to try reaching out to on-call three times before escalating for example. Those types of instruction go here.';
COMMENT ON COLUMN ocm.group.notes IS 'Optional notes for this group.';
COMMENT ON COLUMN ocm.group.active_status IS 'Y/N field that defines if this group is active or soft-deleted.';
COMMENT ON COLUMN ocm.group.create_date IS 'Date this record was created in the database system.';
COMMENT ON COLUMN ocm.group.update_date IS 'Last updated date for this record in the database.';