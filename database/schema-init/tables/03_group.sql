CREATE TABLE ocm.group
(  group_id                    SERIAL PRIMARY KEY 
 , group_name                  VARCHAR(100) NOT NULL 
 , group_description           VARCHAR(250) NOT NULL
 , group_administrator_name    VARCHAR(100) NOT NULL 
 , group_email_address         VARCHAR(150) NOT NULL 
 , group_phone_number          VARCHAR(100) NOT NULL 
 , notes                       VARCHAR(500)
 , active_status               CHAR(1) NOT NULL DEFAULT 'Y' CHECK(active_status IN ('Y','N'))
 , create_date                 TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
 , update_date                 TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

--CREATE NATURAL KEY on group name enforcing no dupes
CREATE UNIQUE INDEX group_nk ON ocm.group(UPPER(group_name));