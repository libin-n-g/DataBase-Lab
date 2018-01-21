SET PASSWORD FOR 'root'@'localhost' = PASSWORD('password');
CREATE DATABASE expert_system_libin_n_george;
use expert_system_libin_n_george;
CREATE TABLE authors(
aid INT NOT NULL AUTO_INCREMENT,
name VARCHAR(30) NOT NULL,
UNIQUE(name),
PRIMARY KEY(aid)
);

CREATE TABLE papers (
pid INT NOT NULL AUTO_INCREMENT,
title VARCHAR(200) NOT NULL,
corresponding_author INT NOT NULL,
FOREIGN KEY(corresponding_author) references authors(aid) ON DELETE NO ACTION,
PRIMARY KEY(PID));

CREATE TABLE year (
pid INT NOT NULL ,
FOREIGN KEY(pid) REFERENCES papers(pid) ON DELETE CASCADE,
published_year INT NOT NULL,
PRIMARY KEY(pid)
);

CREATE TABLE written_by (
pid INT NOT NULL,
FOREIGN KEY(pid) references papers(pid) ON DELETE CASCADE,
PRIMARY KEY(pid, aid),
aid INT NOT NULL,
FOREIGN KEY(aid) references authors(aid) ON DELETE NO ACTION
);

INSERT INTO authors (name)
VALUES
('M. Rudolph'),
('F. Ruiz'),
('S. Athey'),
('D. Blei'),
('J. Manning'),
('R. Ranganath'),
('K. Norman'),
('L. Lei'),
('C. Ju'),
('J. Chen'),
('M. I. Jordan'),
('F. Wauthier'),
('N. Jojic'),
('Sahely Bhadra'),
('Samuel Kashi'),
('Juho Rousu');

INSERT INTO papers (title, corresponding_author) VALUES
('Structured embedding models for grouped data​', 4),
('​Topographic factor analysis: A Bayesian model for inferring brain networks from neural data​', 4),
('Nonconvex finite-sum optimization via SCSG methods​', 11),
('Nonparametric combinatorial sequence models​​', 11),
('Multi-view kernel completion​', 14);

INSERT INTO year (pid, published_year) VALUES
(1, 2017),
(2, 2014),
(3, 2018),
(4, 2011),
(5, 2017);

INSERT INTO written_by  (pid, aid) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 4),
(3, 8),
(3, 9),
(3, 10),
(3, 11),
(4, 12),
(4, 11),
(4, 13),
(5, 14),
(5, 15),
(5, 16);

DELETE FROM papers WHERE title = 'Multi-view kernel completion​';

INSERT INTO authors (name) VALUES
('Antti Kangasrääsiö'),
('Kumaripaba Athukorala'),
('Andrew Howes'),
('Jukka Corander'),
('Antti Oulasvirta'),
('B. Milch'),
('B. Marthi'),
('S. Russell'),
('D. Sontag'),
('D. L. Ong'),
('A. Kolobov'),
('Jonathan T. Barron'),
('David W. Hogg'),
('Dustin Lang1'),
('Sam Roweis')
;

INSERT INTO papers (title, corresponding_author) VALUES
('Inferring Cognitive Models from Data using Approximate Bayesian Computation', 15),
('BLOG: Probabilistic Models with Unknown Objects​', 25),
('Blind Date: Using Proper Motions to Determine the Ages of Historical Images', 31)
;

INSERT INTO year (pid, published_year) VALUES
(5, 2017),
(6, 2007),
(7, 2008)
;
INSERT INTO written_by  (pid, aid) VALUES
(5, 17),
(5, 18),
(5, 19),
(5, 20),
(5, 21),
(5, 15),
(6, 22),
(6, 23),
(6, 24),
(6, 25),
(6, 26),
(6, 27),
(7, 28),
(7, 29),
(7, 30),
(7, 31);

DELETE FROM authors WHERE name = 'Antti Oulasvirta';

INSERT INTO authors ( name) VALUES
('Pekka Parviainen');
INSERT INTO papers (title, corresponding_author) VALUES
('Learning structures of Bayesian networks for variable groups',15);
INSERT INTO year (pid, published_year) VALUES
(8, 2017);
INSERT INTO written_by  (pid, aid) VALUES
(8, 32),
(8, 15);

SELECT P.title FROM papers AS P , year AS Y WHERE Y.published_year=2017 AND P.pid = Y.pid;

SELECT P.title FROM papers AS P , written_by AS W WHERE W.aid=( SELECT A.aid FROM authors AS A WHERE A.name='Samuel Kashi') AND P.pid = W.pid;





SELECT P.title FROM (SELECT W.pid, COUNT(W.aid)  FROM written_by AS W GROUP BY W.pid HAVING ( COUNT(W.aid) > 2 )) AS S, papers AS P WHERE P.pid=S.pid;

SELECT P.title, A.name FROM papers AS P , written_by AS W, authors AS A WHERE P.pid = W.pid and W.aid = A.aid AND A.name Like "Sam% %";

DELETE FROM authors WHERE name = 'Samuel Kaski';

DROP TABLE year;

CREATE TABLE fields (
fid INT NOT NULL AUTO_INCREMENT,
PRIMARY KEY(fid),
field_name VARCHAR(100) NOT NULL
);

CREATE TABLE expert_in (
aid INT NOT NULL,
fid INT NOT NULL,
PRIMARY KEY(aid, fid)
);

INSERT INTO fields (field_name) VALUES
('Bayesian models'),
('Approximate reasoning'),
('Human computer interaction'),
('Embedding models'),
('Optimization'),
('Nonparametric models');

CREATE TABLE conferences (
cid INT NOT NULL AUTO_INCREMENT,
name VARCHAR(175) NOT NULL,
year INT NOT NULL,
PRIMARY KEY(cid),
UNIQUE (name, year)
);

INSERT INTO conferences (name, year) VALUES
('Neural Information Processing Systems',2017),
('PLoS ONE, 9(5)', 2014),
('S. Bengio, R. Fergus, S. Vishwanathan, and H. Wallach (Eds), ​ Advances in Neural Information Processing Systems (NIPS) 29​', 2018),
('15th Annual International Conference on Research in Computational Molecular Biology (RECOMB) ​ , Vancouver, BC', 2011),
('ACM SIGCHI annual conference on human factors in computing systems, Proceedings of the 2017 CHI Conference on Human Factors in Computing Systems, p. 1295-1306', 2017),
('Lise Getoor andBen Taskar, eds. Statistical Relational Learning. Cambridge, MA: MIT Press',2007),
('The Astronomical Journal 136 (2008) 1490-1501', 2008),
('INTERNATIONAL JOURNAL OF APPROXIMATE REASONING, 88:110-127', 2017)
;
ALTER TABLE papers 
ADD cid INT NOT NULL ;
 
UPDATE papers AS P
SET P.cid = 1
WHERE P.title = 'Structured embedding models for grouped data​';
 
UPDATE papers AS P
SET P.cid = 2
WHERE P.title = '​Topographic factor analysis: A Bayesian model for inferring brain networks from neural data​';

UPDATE papers AS P
SET P.cid = 3
WHERE P.title = 'Nonconvex finite-sum optimization via SCSG methods​';

UPDATE papers AS P
SET P.cid = 4
WHERE P.title = 'Nonparametric combinatorial sequence models​​';
 
UPDATE papers AS P
SET P.cid = 5
WHERE P.title = 'Inferring Cognitive Models from Data using Approximate Bayesian Computation';

UPDATE papers AS P
SET P.cid = 6
WHERE P.title = 'BLOG: Probabilistic Models with Unknown Objects​';


UPDATE papers AS P
SET P.cid = 7
WHERE P.title = 'Blind Date: Using Proper Motions to Determine the Ages of Historical Images';

UPDATE papers AS P
SET P.cid = 8
WHERE P.title = 'Learning structures of Bayesian networks for variable groups';

ALTER TABLE papers 
ADD CONSTRAINT FOREIGN KEY (cid) REFERENCES conferences(cid) ON DELETE NO ACTION ;

SELECT P.title, C.name, C.year FROM papers AS P , conferences AS C WHERE P.cid=C.cid ORDER BY C.name ASC, C.year DESC;
