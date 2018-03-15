SET profiling = 1;

select * from student where name='wood';


CREATE TABLE `takes_hash` AS (SELECT * FROM takes) ENGINE=MEMORY;

CREATE INDEX grade_index ON takes_hash(grade) USING HASH;
