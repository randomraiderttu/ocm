CREATE TABLE ocm.subgroup_tech
(  subgroup_tech_id                      SERIAL PRIMARY KEY 
 , subgroup_id                           INTEGER NOT NULL REFERENCES ocm.subgroup(subgroup_id)
 , tech_id                               INTEGER NOT NULL REFERENCES ocm.tech(tech_id)
 , last_on_call_date                     TIMESTAMPTZ DEFAULT to_timestamp('01/01/2000 00:00:00','MM/DD/YYYY HH24:MI:SS') NOT NULL
 , active_status                         CHAR(1) NOT NULL DEFAULT 'Y' CHECK(active_status IN ('Y','N'))
 , create_date                           TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
 , update_date                           TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE UNIQUE INDEX subgroup_tech_nk ON ocm.subgroup_tech(subgroup_id, tech_id);

COMMENT ON TABLE ocm.subgroup_tech IS 'This tables houses the relationship between the tech and the subgroups they belong to. This table also defines the last date/time each tech was on-call for a given sub-group. The natural key of the table is the subgroup and tech.';
COMMENT ON COLUMN ocm.subgroup_tech.subgroup_tech_id IS 'Primary Key; sequence generated.';
COMMENT ON COLUMN ocm.subgroup_tech.subgroup_id IS 'Part of the natural key of this table. Foreign Key to subgroup table. Defines the subgroup the tech belongs to.';
COMMENT ON COLUMN ocm.subgroup_tech.tech_id IS 'Part of the natural key of this table. Foreign Key to the tech table. Defines the tech that belongs to the subgroup.';
COMMENT ON COLUMN ocm.subgroup_tech.last_on_call_date IS 'Defines the last date this tech was on call for this subgroup. This aids in determing the next time this tech should be on-call.';
COMMENT ON COLUMN ocm.subgroup_tech.active_status IS 'Y/N field that defines if this tech is active for this subgroup or soft-deleted.';
COMMENT ON COLUMN ocm.subgroup_tech.create_date IS 'Y/N field that defines if this group is active or soft-deleted.';
COMMENT ON COLUMN ocm.subgroup_tech.update_date IS 'Last updated date for this record in the database.';
