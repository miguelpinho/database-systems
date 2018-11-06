/* 1. */
CREATE INDEX person_name_idx ON
person(name);

/* 2. */
CREATE INDEX indicator_idx ON
indicator(units, reference_value);
