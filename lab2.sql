drop database expert_system_2_libin_n_george;
create database expert_system_2_libin_n_george;
use expert_system_2_libin_n_george;
create table paper(paper_id int auto_increment primary key, title varchar(150) not null unique, year int not null, conference varchar(50) not null);
describe paper;
delete from paper;
alter table paper auto_increment=0;
insert into paper (title,conference,year) values
('structured embedding models for grouped data','NIPS',2017),
('Topographic factor analysis: A Bayesian model for inferring brain networks from neural data.','PLoS ONE', 2014),
('Nonconvex finite-sum optimization via SCSG methods.','NIPS',2018),
('Nonparametric combinatorial sequence models.','RECOMB', 2011),
('Inferring Cognitive Models from Data using Approximate Bayesian Computation','SIGCHI',2017),
('BLOG: Probabilistic Models with Unknown Objects.', 'Statistical Relational Learning', 2007),
('Blind Date: Using Proper Motions to Determine the Ages of Historical Images.','The Astronomical Journal', 2008),
('Learning structures of Bayesian networks for variable groups.', 'International Journal of Approximate Reasoning', 2017); 

select * from paper;

create table author(author_id int auto_increment primary key, first_name varchar(50), last_name varchar(50) not null);

insert into author (first_name, last_name) values
('M','Rudolph'),
('F','Ruiz'),
('S','Athey'),
('D','Blei'),
('J','Manning'),
('R','Ranganath'),
('K','Norman'),
('L','Lei'),
('C','Ju'),
('J','Chen'),
('M','Jordan'),
('F','Wauthier'),
('N','Jojic'),
('Antti','Kangasraasio'),
('Kumariprabha','Athukorala'),
('Andrew','Howes'),
('Jukka','Corander'),
('Samuel','Kaski'),
('Antti','Oulasvirta'),
('B','Milch'),
('B','Marthi'),
('S','Russell'),
('D','Sontag'),
('D','Ong'),
('A','Kolobov'),
('Jonathan','Barron'),
('David','Hogg'),
('Dustin','Lang'),
('Sam','Roweis'),
('Pekka','Parviainen'),
('S','Bhadra');

alter table paper add column corresponding_author int not null after conference;

update paper set corresponding_author=4 where paper_id=1;
update paper set corresponding_author=4 where paper_id=2;
update paper set corresponding_author=8 where paper_id=3;
update paper set corresponding_author=11 where paper_id=4;
update paper set corresponding_author=18 where paper_id=5;
update paper set corresponding_author=23 where paper_id=6;
update paper set corresponding_author=29 where paper_id=7;
update paper set corresponding_author=18 where paper_id=8;


alter table paper add foreign key (corresponding_author) references author (author_id);

create table author_paper (author_id int not null, paper_id int not null);
alter table author_paper add foreign key (paper_id) references paper(paper_id);
alter table author_paper add foreign key (author_id) references author(author_id);

insert into author_paper (author_id,paper_id) values (1,1),(2,1),(3,1),(4,1),(4,2),(5,2),(6,2),(7,2),(8,3),(9,3),(10,3),(11,3),(12,4),(13,4),(11,4),(14,5),(15,5),(16,5),(17,5),(18,5),(19,5),(20,6),(21,6),(22,6),(23,6),(24,6),(25,6),(26,7),(27,7),(28,7),(29,7),(30,8),(18,8);


insert into author (first_name, last_name) values
('Samy','Bengio'),
('Iulian', 'Serban'),
('Alessandro', 'Sordoni'),
('Ryan', 'Lowe'),
('Laurent', 'Charlin'),
('Joelle', 'Pineau'),
('Aaron', 'Courville'),
('Yoshua', 'Ben_gio'),
('Ian','Goodfellow'),
('Jean','Pouget-Abadie'),
('Mehdi', 'Mirza'),
('Bing', 'Xu'),
('David', 'Warde-Farley'),
('Sherjil', 'Ozair');
select * from author;
insert into paper (title, conference, year, corresponding_author) values
('Statistical machine learning for HCI', 'Multimodal Signal Processing: Theory and
Applications for Human-Computer Interaction', 2010, 32);

insert into paper (title, conference, year, corresponding_author) values
('A Hierarchical Latent Variable Encoder-Decoder Model for Generating
Dialogues.','AAAI', 2017, null);

insert into paper (title, conference, year, corresponding_author) values
('', 'NIPS', 2014, 40);



select paper_id, title from paper;

insert into author_paper (paper_id, author_id) values
(9, 32),
(10, 40),
(10, 41),
(10, 42),
(10, 43),
(10, 44),
(10, 45),
(10, 38),
(10, 39);



SELECT C.first_name, C.last_name, COUNT(C.paper_id) AS paper_count
FROM (SELECT A.author_id, A.first_name, A.last_name, W.paper_id
FROM author_paper AS W
RIGHT JOIN
author AS A
ON A.author_id=W.author_id) AS C
GROUP BY C.author_id;

SELECT P.*, T.num_authors
FROM paper AS P,
( SELECT AP.paper_id, COUNT(AP.author_id) as num_authors
FROM author_paper AS AP
GROUP BY AP.paper_id) AS T
WHERE P.year=2017 AND T.paper_id=P.paper_id
ORDER BY T.num_authors DESC;

SELECT P.*
FROM paper AS P, author AS A
WHERE P.corresponding_author=A.author_id
AND A.first_name='Samuel'
AND A.last_name='Kaski';
SELECT DISTINCT Q.year FROM (SELECT P.* FROM paper AS P, author AS A
WHERE P.corresponding_author=A.author_id AND A.first_name='Samuel' AND
A.last_name='Kaski') AS Q;

SELECT P.*, T.num_authors
FROM paper AS P,
( SELECT AP.paper_id, COUNT(AP.author_id) as num_authors
FROM author_paper AS AP
GROUP BY AP.paper_id) AS T
WHERE T.num_authors>2 AND T.paper_id=P.paper_id ;

SELECT P.*
FROM paper AS P, author AS A, author_paper AS AP
WHERE A.first_name LIKE '%Sam%'AND AP.paper_id=P.paper_id
AND AP.author_id=A.author_id;

SELECT DISTINCT A.*
FROM paper AS P, author AS A, author_paper AS AP
WHERE (P.year= 2011 AND P.year= 2018)
AND AP.paper_id=P.paper_id
AND AP.author_id=A.author_id;

DELETE FROM author WHERE first_name='Samuel' AND last_name='Kaski';

SELECT A.*
FROM author AS A
WHERE A.first_name LIKE '%\_%' OR A.last_name LIKE '%\_%';

update author set first_name=(SELECT REPLACE(first_name, '_', '-')) ;
update author set last_name=(SELECT REPLACE(last_name, '_', '-')) ;

SELECT * FROM author;

DESCRIBE paper;

ALTER TABLE paper CHANGE conference venue VARCHAR(50) NOT NULL;

DESCRIBE paper;

-- ALTER TABLE paper ADD type ENUM('C', 'J', 'W') NOT NULL;

DESCRIBE paper;

show tables;
describe author;
describe paper;
describe author_paper;

select * from paper;
