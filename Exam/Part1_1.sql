--PART 1
-- Q2
drop database university_midsem;
create database university_midsem;
use university_midsem ;
source university_midsem.sql;

-- Q2
--a
DELIMITER //
CREATE OR REPLACE FUNCTION get_first_year(stu_id VARCHAR(5)) RETURNS DECIMAL(4,0)
BEGIN
declare _year DECIMAL(4,0);
SET _year = (SELECT MIN(A.year) FROM (SELECT year from takes where ID = stu_id) AS A); 
return _year ;
END;//
DELIMITER ;
--b

SELECT DISTINCT C.title FROM course as C,
       takes AS T ,
       student AS S
       WHERE T.year=get_first_year(S.ID)
       and T.ID = S.ID
       and S.name = 'Shankar'
       and C.course_id = T.course_id;
--Q3

--a

SELECT DISTINCT S.name FROM student as S,
       (SELECT * FROM section NATURAL JOIN takes) AS A
       WHERE S.ID = A.ID
       and A.building='Watson';
--b

SELECT COUNT(DISTINCT A1.ID) AS student_count
       FROM (SELECT T.ID
       FROM takes as T
       WHERE T.sec_id = '1') AS A1,
       (SELECT T.ID 
       FROM takes as T
       WHERE T.sec_id = '2') AS A2
       WHERE A1.ID = A2.ID;

--c

CREATE OR REPLACE VIEW sl2stud (ID, name, tot_cred) AS
(SELECT ID, name , tot_cred FROM student WHERE dept_name='Comp. Sci.' ORDER BY tot_cred ASC ) LIMIT 2; 

SELECT * from sl2stud;

--d

SELECT DISTINCT I.name from instructor AS I,
       (SELECT MAx(A.c) as cou, A.ID FROM (select COUNT(ID) as c,ID
       	       		      from teaches
			      group by ID, semester, year)
			      AS A GROUP BY A.ID) as AA
       WHERE I.ID = AA.ID and AA.cou <= 1;

--e


SELECT A.dept_name from 
       (SELECT MIN(salary) as min_salary, dept_name FROM instructor group by dept_name) AS A
       WHERE (SELECT AVG(salary) FROM instructor) < A.min_salary;

--f


--Q4

DELIMITER //
CREATE TRIGGER grade_checker
before insert ON takes
FOR EACH ROW
BEGIN
DECLARE msg VARCHAR (150);
set msg = CONCAT('Insertion Failed due to invalid entry for grade: ', new.grade);
  IF NEW.grade NOT IN (select grade FROM takes where NOT ISNULL(grade)) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
        END IF;
END; //
	
DELIMITER ;
insert into takes values ('12345', 'MU-199', '1', 'Spring', 2010, 'DF');

