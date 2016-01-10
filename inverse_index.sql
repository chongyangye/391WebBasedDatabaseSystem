DROP INDEX inverse_diagnosis;
DROP INDEX inverse_description;
DROP INDEX inverse_test_type;
DROP INDEX inverse_first_name;
DROP INDEX inverse_last_name;

CREATE INDEX inverse_diagnosis ON radiology_record(diagnosis) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX inverse_description ON radiology_record(description) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX inverse_test_type ON radiology_record(test_type) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX inverse_first_name ON persons(first_name) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX inverse_last_name ON persons(last_name) INDEXTYPE IS CTXSYS.CONTEXT;