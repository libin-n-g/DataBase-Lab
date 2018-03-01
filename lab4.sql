source lab3_2.sql

CREATE USER coordinator identified by 'abc';

CREATE ROLE reader;

GRANT SELECT ON University.* TO reader ;

GRANT reader TO coordinator;

CREATE ROLE writer;

GRANT INSERT ON University.* TO writer ;

CREATE USER datamaster;

GRANT writer TO datamaster;

CREATE USER moderator;

GRANT writer TO moderator;
GRANT reader TO moderator;

SET @avg_cred = 0;

SELECT * FROM student;

SET @avg_cred = (select AVG(tot_cred) FROM student);   

DELIMITER //

CREATE FUNCTION fun_sel_avg (threshold FLOAT)

returns FLOAT
BEGIN
declare avg_buget FLOAT;

SET avg_buget = (SELECT AVG(budget) FROM department WHERE budget > threshold);

return avg_buget;
END;//
DELIMITER ;

SELECT fun_sel_avg (10000.0);

DELIMITER //

CREATE PROCEDURE sp_top_avg (IN N INT,
       		 	    OUT avg_buget FLOAT)
BEGIN

SELECT AVG(D.budget) INTO avg_buget FROM (SELECT * FROM department ORDER BY budget DESC LIMIT N) AS D;


END;//
DELIMITER ;


set @avg = 0;
call sp_top_avg(3, @avg);
select @avg;


insert into department values ('Dance', 'Watson', 10000);
DELIMITER //

CREATE PROCEDURE update_budget ()
BEGIN

declare avg_buget FLOAT;
SELECT AVG(D.budget) INTO avg_buget FROM department AS D;

UPDATE department SET budget=(avg_buget/2) where budget< avg_buget/2;

END;//
DELIMITER ;

call update_budget();

select * from department;

