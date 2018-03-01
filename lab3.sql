source lab2.sql;
use expert_system_2_libin_n_george;

set sql_mode=STRICT_ALL_TABLES;

set sql_mode=EMPTY_STRING_IS_NULL;

ALTER TABLE paper ADD type ENUM('C', 'J', 'W') NOT NULL; 

ALTER TABLE author ADD hindex INT DEFAULT 0 NOT NULL;

CREATE VIEW paper_names AS
SELECT paper_id AS id, title AS name
FROM paper;  

select id, name from paper_names where name LIKE "%Bayesian%";

CREATE VIEW author_sub AS
SELECT ​ author_id ​AS id ,last_name AS last
FROM author;

ALTER VIEW author_sub AS
SELECT ​ author_id ​AS id ,last_name AS last, hindex
FROM author;


CREATE VIEW author_li AS
SELECT ​ id ,last
FROM author_sub;

SELECT * FROM author_li;
INSERT INTO author_li (last) VALUES ('Bhadra');
SELECT * FROM author_li;
SELECT * FROM author_sub;
SELECT * FROM author;
DELETE FROM author WHERE last_name='Bhadra';
SELECT * FROM author_li;
SELECT * FROM author_sub;
SELECT * FROM author;

INSERT INTO author_sub (last,id) VALUES ('DB', 50);
SELECT * FROM author_li;
SELECT * FROM author_sub;
SELECT * FROM author;

Drop VIEW author_sub;

SELECT * FROM author_li;
SELECT * FROM author;

​CREATE VIEW author_ih AS SELECT author_id, hindex FROM author;

Insert INTO author_ih (author_id, hindex) values (40,'Doc') ;

show full tables;

​CREATE VIEW paper_names AS SELECT title AS name FROM paper;
ALTER VIEW paper_names AS SELECT title AS name, venue AS conference FROM paper;

CREATE VIEW paper_cauthor AS SELECT P.title AS name, A.last_name
FROM paper AS P , author AS A, author_paper AS AP WHERE AP.paper_id = P.paper_id AND AP.author_id = A.author_id;
-- Insert (ID and name) in ​ paper_name ​ view.
CREATE VIEW paper_names AS SELECT paper_id AS id, title AS name, conference FROM paper;
