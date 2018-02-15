source lab4.sql

use University
drop event increment_budget;
SHOW PROCESSLIST;

SET GLOBAL event_scheduler = ON;

CREATE EVENT increment_budget
  ON SCHEDULE EVERY 1 MINUTE DO 
   UPDATE University.department SET budget = 1.05 * budget;

SHOW EVENTS\G;

select * from department;

ALTER EVENT increment_budget
ON SCHEDULE EVERY 1 MINUTE
STARTS  CURRENT_TIMESTAMP
ENDS CURRENT_TIMESTAMP + INTERVAL 5 MINUTE
DO UPDATE University.department SET budget = budget + 100;

show global variables like 'autocommit';

SET AUTOCOMMIT=0;            
UPDATE University.department SET budget = budget + 0.01 WHERE dept_name='Physics';

ROLLBACK; 


UPDATE University.department SET budget = budget + 0.01 WHERE dept_name='Physics';
commit;

CREATE TABLE budget_only (
budget INT
);

ROLLBACK;

show tables;

create table inst_dept AS
( SELECT * FROM instructor
  	 NATURAL JOIN
	 department
);

select * from inst_dept;

DELIMITER //
CREATE TRIGGER budget_update
before update ON inst_dept
FOR EACH ROW
BEGIN 
    IF new.budget <> old.budget
       THEN
       BEGIN
	UPDATE department SET budget = new.budget WHERE dept_name = new.dept_name;
       END;
    END IF;
END;//
DELIMITER ;

DELIMITER //
CREATE TRIGGER building_update
before update ON inst_dept
FOR EACH ROW
BEGIN 
    IF new.building <> old.building
       THEN
       BEGIN
	UPDATE department SET building = new.building WHERE dept_name = new.dept_name;
       END;
    END IF;
END;//
DELIMITER ;
-- TODO CREATE EVENT every 5 min refresh inst_dept from departments table
-- CREATE EVENT update
--   ON SCHEDULE EVERY 5 MINUTE DO
--    UPDATE University.inst_dept SET budget = ( select A.budget from department AS A
--    	  		       	   	    where A.dept_name=dept_name), building = (select A.building from department AS A where A.dept_name=dept_name) ;


update inst_dept set budget=150000 where name='Srinivasan';

SHOW PROFILE;
set profiling=1;
use University ;

select dept_name from department where budget>50000;

DELIMITER //
CREATE FUNCTION raise_by_ten (num FLOAT)
returns FLOAT
BEGIN
declare next_num FLOAT;
SET next_num = num + 10;
return next_num;
END;//
DELIMITER ;

select raise_by_ten(100);


