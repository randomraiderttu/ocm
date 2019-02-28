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

