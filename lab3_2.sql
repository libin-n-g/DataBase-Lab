drop database University;
create database University;
use University;
source create_university.sql

source data_univeristy.sql

show tables;

describe advisor;
describe classroom;
describe course;       
describe department;
describe instructor;
describe prereq;
describe section;
describe student;
describe takes;
describe teaches;
describe time_slot;   

SELECT name FROM instructor WHERE salary > ALL (SELECT salary FROM instructor
       	    	 	    	  	 WHERE dept_name='Biology' OR
					 dept_name='History' OR
					 dept_name='Finance');

select * from instructor;

update instructor set salary = CASE WHEN (salary < 70000)
THEN (salary*1.05)
ELSE salary
END;

select * from instructor;

UPDATE student AS S SET S.tot_cred = Case when EXISTS (SELECT A.tot_cred
       	       	    		     	     FROM(SELECT ID, SUM(credits) as tot_cred
       	       	    		     	       	FROM (takes AS T)
						NATURAL JOIN course
						WHERE T.grade IS NOT NULL
						AND T.grade <> 'F'
						GROUP BY ID) AS A WHERE A.ID=S.ID)  
					THEN (SELECT A.tot_cred
       	       	    		     	     FROM(SELECT ID, SUM(credits) as tot_cred
       	       	    		     	       	FROM (takes AS T)
						NATURAL JOIN course
						WHERE T.grade IS NOT NULL
						AND T.grade <> 'F'
						GROUP BY ID) AS A WHERE A.ID=S.ID)
					ELSE
					0
					END;

INSERT INTO student (ID, name, dept_name) VALUES (98761, 'Raman', 'Music');

SELECT SUM(tot_cred) FROM student;

SELECT SUM(tot_cred) FROM student WHERE tot_cred IS NOT NULL ;

CREATE VIEW tot_C AS SELECT tot_cred from student;

SELECT COUNT(tot_cred) FROM tot_C;

SELECT COUNT(tot_cred) FROM tot_C WHERE tot_cred IS NOT NULL;

select dept_name FROM (SELECT D.dept_name, AVG(D.salary)
AS avg_salary FROM instructor AS D
GROUP BY D.dept_name) AS DD WHERE DD.avg_salary = (SELECT MAX(DE.avg_salary) FROM 
(SELECT D.dept_name, AVG(D.salary)
AS avg_salary FROM instructor AS D
GROUP BY D.dept_name) as DE) ;

Select dept_name from department where budget=(Select MAX(D.budget) from department as D);
