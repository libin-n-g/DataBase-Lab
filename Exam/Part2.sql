drop database uni_test ;


--Q5
create database uni_test;
use uni_test;

--Q6


CREATE OR REPLACE table second (
id INT,
PRIMARY KEY (id),
department VARCHAR(50));

CREATE OR REPLACE table first (
id INT,
name VARCHAR(50),
PRIMARY KEY(id));


ALTER table second
Add constraint foreign key second(id) references first(id);

Alter table first
add constraint foreign key first(id) references second(id);

SET global variable AUTOCOMMIT=0;  

insert into first values (1,'a'), (100, 'a');


insert into second values (1,'z'), (10, 'y'), (11, 'a');
show global variables like 'autocommit';


