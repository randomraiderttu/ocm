--Holds the Information on the on-call techs
CREATE TABLE ocm.tech
(  tech_id               SERIAL PRIMARY KEY 
 , tech_name             VARCHAR(100) NOT NULL
 , phone_number          VARCHAR(100) NOT NULL
 , sms_number            VARCHAR(30)
 , email_address         VARCHAR(150) UNIQUE NOT NULL CHECK(email_address = LOWER(email_address))
 , notes                 VARCHAR(500)
 , active_status         CHAR(1) NOT NULL DEFAULT 'Y' CHECK(active_status IN ('Y','N'))
 , create_date           TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
 , update_date           TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

--Create natural key index on the name to enforce no dupe names
CREATE UNIQUE INDEX tech_nk ON ocm.tech(UPPER(tech_name));

COMMENT ON TABLE ocm.tech IS 'Defines the names and metadata needed to describe and contact the on-call technicians.';
COMMENT ON COLUMN ocm.tech.tech_id IS 'Primary Key and generated via serial sequence.';
COMMENT ON COLUMN ocm.tech.tech_name IS 'Natural Key of table and provides name of technician.';
COMMENT ON COLUMN ocm.tech.phone_number IS 'Holds the contact phone numbers for the technician. Text field so multiple numbers can be provided with designations. Ex: Home - 800-999-9999, Cell - 800-999-9001';
COMMENT ON COLUMN ocm.tech.sms_number IS 'Optional text field but should hold sms capable phone number only.  Used to send SMS messages to technician.';
COMMENT ON COLUMN ocm.tech.email_address IS 'Email address for technician for contact purposes.';
COMMENT ON COLUMN ocm.tech.notes IS 'Free text field for any additional notes needed for this technician.';
COMMENT ON COLUMN ocm.tech.active_status IS 'Y/N field to define if this technician is active or soft deleted';
COMMENT ON COLUMN ocm.tech.create_date IS 'Creation date for this record in the database';
COMMENT ON COLUMN ocm.tech.update_date IS 'Last updated date for this record in the database';