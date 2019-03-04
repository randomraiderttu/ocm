CREATE TABLE ocm.oncall_calendar
(   oncall_date_id                    SERIAL PRIMARY KEY 
  , oncall_actual_date                DATE NOT NULL
  , subgroup_tech_id                  INTEGER NOT NULL REFERENCES ocm.subgroup_tech(subgroup_tech_id)
  , oncall_effective_start_datetime   TIMESTAMPTZ NOT NULL 
  , oncall_effective_end_datetime     TIMESTAMPTZ NOT NULL 
  , create_date                       TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
  , update_date                       TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE UNIQUE INDEX oncall_calendar_nk ON ocm.oncall_calendar(oncall_actual_date, subgroup_tech_id);

COMMENT ON TABLE ocm.oncall_calendar IS 'The oncall calendar table which defines which person for a particular subgroup is on-call for the listed date. The subgroup_tech_id and actual date are the natural key of the table meaning there cannot be more than one person assigned to a date for a subgroup.';
COMMENT ON COLUMN ocm.oncall_calendar.oncall_date_id IS 'Primary Key; sequence generated.';
COMMENT ON COLUMN ocm.oncall_calendar.oncall_actual_date IS 'Date field. Subgroup and Tech are assigned to a day regardless of what the effective start and end time of the on-call period may be. Example: If you define your effective start times for on-call work to begin at 8am, then you would still define someone for a given day but that is the day their period would start. i.e. If we start on-call at 10am, then if I am oncall on January 10th, my actual date would be 1/10 but my effective start date would be 1/10 at 10am and and time of 1/11 at 9:59:59am.';
COMMENT ON COLUMN ocm.oncall_calendar.subgroup_tech_id IS 'Defines the tech and subgroup assigned to this on-call date.  There can and likely will be other techs belonging to other subgroups with an entry for the same date.';
COMMENT ON COLUMN ocm.oncall_calendar.oncall_effective_start_datetime IS 'Using the configuration setting for when the on-call period starts, this is the effective start time of the on-call period. See comment on oncall_actual_date for more detail.';
COMMENT ON COLUMN ocm.oncall_calendar.oncall_effective_end_datetime IS 'Using the configuration setting for when the on-call period starts, this is the effective end time of the on-call period. See comment on oncall_actual_date for more detail.';
COMMENT ON COLUMN ocm.oncall_calendar.create_date IS 'Date this record was created in the database system.';
COMMENT ON COLUMN ocm.oncall_calendar.update_date IS 'Last updated date for this record in the database.';