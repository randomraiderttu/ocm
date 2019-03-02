CREATE TABLE ocm.subgroup
(   subgroup_id                      SERIAL PRIMARY KEY
  , group_id                         INTEGER REFERENCES ocm.group(group_id)
  , subgroup_name                    VARCHAR(100) NOT NULL CHECK (subgroup_name = UPPER(subgroup_name))
  , subgroup_description             VARCHAR(250) NOT NULL 
  , subgroup_sequence                INTEGER NOT NULL CHECK(subgroup_sequence > -1)
  , schedule_id                      INTEGER NOT NULL REFERENCES ocm.schedule(schedule_id)
  , notes                            VARCHAR(500)
  , active_status                    CHAR(1) NOT NULL DEFAULT 'Y' CHECK(active_status IN ('Y','N'))
  , create_date                      TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
  , update_date                      TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

--Create index to enforce natural key on subgroup_name
CREATE UNIQUE INDEX subgroup_nk ON ocm.subgroup(UPPER(subgroup_name));

COMMENT ON TABLE ocm.subgroup IS 'On-call schedules are defined at the subgroup level. The reason for this is so that you can have a group, for instance, Unix Team, and have an on-call schedule that defines the primary contact and the manager on call as well. The primary and manager on-call would represent two separate subgrups under the same group of Unix Team. Subgroups have their own schedule so that your primary on-call rotation for this group and the manager on-call rotation can be different.';
COMMENT ON COLUMN ocm.subgroup.subgroup_id IS 'Primary key; sequence generated.';
COMMENT ON COLUMN ocm.subgroup.group_id IS 'Foreign Key to the Group table. Part of the natural key of this table. Defines the group that this subgroup belongs to.';
COMMENT ON COLUMN ocm.subgroup.subgroup_name IS 'Part of the natural key of this table. Defines the name of the subgroup. Examples: If Group was On-Call Unix, then subgroups may be Unix Primary On Call, Unix Secondary On Call, Unix Manager On Call, etc.';
COMMENT ON COLUMN ocm.subgroup.subgroup_description IS 'Additional description of subgroup.';
COMMENT ON COLUMN ocm.subgroup.subgroup_sequence IS 'Subgroups are used for escalation or to provide a hiearachy or contact order. Subgroup sequence defines which subgroups show up first when receiving all the on-call persons for a given group. i.e. Primary On-Call will be before Secondary On-Call which would be before Manager On-Call.';
COMMENT ON COLUMN ocm.subgroup.schedule_id IS 'Foreign Key to schedule table to define the schedule for this subgroup. Subgroups within a group can have different rotations.';
COMMENT ON COLUMN ocm.subgroup.notes IS 'Optional notes column.';
COMMENT ON COLUMN ocm.subgroup.active_status IS 'Y/N field to define if this technician is active or soft deleted';
COMMENT ON COLUMN ocm.subgroup.create_date IS 'Creation date for this record in the database';
COMMENT ON COLUMN ocm.subgroup.update_date IS 'Last updated date for this record in the database';