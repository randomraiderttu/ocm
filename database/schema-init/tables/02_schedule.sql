--Defines the schedule to determine how often the technician for a subgroup changes.
CREATE TABLE ocm.schedule
(   schedule_id                  SERIAL PRIMARY KEY 
  , schedule_name                VARCHAR(100) NOT NULL CHECK(schedule_name = UPPER(schedule_name))
  , interval_type                VARCHAR(10) NOT NULL CHECK(interval_type IN ('DAY','WEEK','MONTH'))
  , interval_value               SMALLINT NOT NULL CHECK(interval_value < 365)
  , generation_interval          SMALLINT NOT NULL CHECK(generation_interval < 100)
  , notes                        VARCHAR(500)
  , active_status                CHAR(1) NOT NULL DEFAULT 'Y' CHECK(active_status IN ('Y','N'))
  , create_date                  TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
  , update_date                  TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

--Create natural key for schedule table - ensure no dupes on schedule name
CREATE UNIQUE INDEX schedule_nk ON ocm.schedule(UPPER(schedule_name));

COMMENT ON TABLE ocm.schedule IS 'Holds the different schedules created that are assigned to subgroups. Defines the period of time a given technician is on-call and the frequency/length of the rotation.';
COMMENT ON COLUMN ocm.schedule.schedule_id IS 'Primary Key; Sequence generated.';
COMMENT ON COLUMN ocm.schedule.schedule_name IS 'Natural Key of the table. Defines the name given to this schedule. Examples: Bi-Weekly Schedule, Monthly Rotation, Weekly Manager On-Call Schedule, etc.';
COMMENT ON COLUMN ocm.schedule.interval_type IS 'Defines the base interval for this schedule rotation. Restricted to DAY, WEEK, MONTH only. The interval type and value make up the rotation schedule.';
COMMENT ON COLUMN ocm.schedule.interval_value IS 'Defines the interval value to apply to the interval type. Example: Interval type of Week and Interval value of 2 would result in a bi-weekly schedule.';
COMMENT ON COLUMN ocm.schedule.generation_interval IS 'Defines how many intervals of the schedule should be created in advance in the calendar. Example: If type is WEEK, interval value is 2 and generation_interval is 10, then the system would always house 20 weeks of on-call schedule into the future.';
COMMENT ON COLUMN ocm.schedule.notes IS 'Free text notes field for any additional description needed.';
COMMENT ON COLUMN ocm.schedule.active_status IS 'Y/N field that defines if this schedule is active or soft-deleted.';
COMMENT ON COLUMN ocm.schedule.create_date IS 'Date this record was created in the database system.';
COMMENT ON COLUMN ocm.schedule.update_date IS 'Last updated date for this record in the database.';
