CREATE FUNCTION get_username() RETURNS VARCHAR(20) 
RETURN SUBSTRING_INDEX(USER(), '@', 1) ;

CREATE OR REPLACE VIEW my_details AS SELECT * FROM student WHERE name=get_username();
CREATE OR REPLACE  VIEW students AS SELECT DISTINCT S.name FROM student AS S,
       	    	     	       	   takes as T
				   WHERE T.course_id IN (SELECT T.course_id as c_id
				   FROM takes AS T, student AS S
				   WHERE T.ID=S.ID and S.name = get_username())
				   and T.ID = S.ID;


CREATE ROLE Student;

DELIMITER //

CREATE OR REPLACE TRIGGER new_user
AFTER INSERT ON student
FOR EACH ROW
BEGIN
	CALL create_user(new.`name`, new.`name`);
END //

CREATE OR REPLACE PROCEDURE create_user( IN username VARCHAR(20),
       	  	 	     IN `password` VARCHAR(20))
BEGIN
DECLARE stmt VARCHAR(100);
prepare stmt FROM CONCAT('CREATE OR REPLACE USER ''', username, '''@''%'' IDENTIFIED BY ''',`password`, '''');
execute stmt;
prepare stmt FROM CONCAT('GRANT Student TO ', username);
execute stmt;
END //

CREATE OR REPLACE PROCEDURE INITUSERS()
BEGIN
DECLARE n INT DEFAULT 0;
DECLARE i INT DEFAULT 0;
DECLARE username VARCHAR(20);
SELECT COUNT(*) FROM student INTO n;
SET i=0;
WHILE i<n DO
  SET username = (SELECT name FROM student LIMIT i,1);
  CALL create_user(username, username);
  SET i = i + 1;
END WHILE;
End //

CREATE OR REPLACE PROCEDURE DETAILS()
BEGIN
	SELECT * FROM  my_details;
END //


CREATE OR REPLACE PROCEDURE PEER_STUDENT()
BEGIN
	SELECT DISTINCT  * FROM students;
END //

DELIMITER ;
CREATE OR REPLACE VIEW info AS select D.ID, S.name, D.dept_name, D.tot_cred from my_details AS D RIGHT JOIN students AS S ON D.name=S.name;
GRANT EXECUTE ON PROCEDURE University.DETAILS TO Student ;
GRANT SELECT ON University.my_details  TO Student ;
GRANT SELECT ON University.students  TO Student ;
GRANT SELECT ON University.info  TO Student ;
GRANT EXECUTE ON PROCEDURE University.PEER_STUDENT TO Student ;

call INITUSERS();
