SET PASSWORD FOR 'root'@'localhost' = PASSWORD('password');
CREATE DATABASE expert_system_libin_n_george;
use expert_system_libin_n_george;
CREATE TABLE authors(
aid INT NOT NULL,
name VARCHAR(30) NOT NULL,
UNIQUE(name),
PRIMARY KEY(aid)
);

CREATE TABLE papers (
pid INT NOT NULL,
title VARCHAR(200) NOT NULL,
corresponding_author INT NOT NULL,
FOREIGN KEY(corresponding_author) references authors(aid) ON DELETE NO ACTION,
PRIMARY KEY(PID));

CREATE TABLE year (
pid INT NOT NULL,
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

INSERT INTO authors (aid, name)
VALUES
(1, 'M. Rudolph'),
(2, 'F. Ruiz'),
(3, 'S. Athey'),
(4, 'D. Blei'),
(5, 'J. Manning'),
(6, 'R. Ranganath'),
(7, 'K. Norman'),
(8, 'L. Lei'),
(9, 'C. Ju'),
(10, 'J. Chen'),
(11, 'M. I. Jordan'),
(12, 'F. Wauthier'),
(13, 'N. Jojic'),
(14, 'Sahely Bhadra'),
(15, 'Samuel Kashi'),
(16, 'Juho Rousu');

INSERT INTO papers (pid, title, corresponding_author) VALUES
(1,'Structured embedding models for grouped data​', 4),
(2,'​Topographic factor analysis: A Bayesian model for inferring brain networks from neural data​', 4),
(3,'Nonconvex finite-sum optimization via SCSG methods​', 11),
(4,'Nonparametric combinatorial sequence models​​', 11),
(5,'Multi-view kernel completion​', 14);

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

INSERT INTO authors (aid, name) VALUES
(17, 'Antti Kangasrääsiö'),
(18, 'Kumaripaba Athukorala'),
(19, 'Andrew Howes'),
(20, 'Jukka Corander'),
(21, 'Antti Oulasvirta'),
(22, 'B. Milch'),
(23, 'B. Marthi'),
(24, 'S. Russell'),
(25, 'D. Sontag'),
(26, 'D. L. Ong'),
(27, 'A. Kolobov'),
(28, 'Jonathan T. Barron'),
(29, 'David W. Hogg'),
(30, 'Dustin Lang1'),
(31, 'Sam Roweis')
;

INSERT INTO papers (pid, title, corresponding_author) VALUES
(5,'Inferring Cognitive Models from Data using Approximate Bayesian Computation', 15),
(6,'BLOG: Probabilistic Models with Unknown Objects​', 25),
(7, 'Blind Date: Using Proper Motions to Determine the Ages of Historical Images', 31)
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

INSERT INTO authors (aid, name) VALUES
(32, 'Pekka Parviainen');
INSERT INTO papers (pid, title, corresponding_author) VALUES
(8,'Learning structures of Bayesian networks for variable groups',15);
INSERT INTO year (pid, published_year) VALUES
(8, 2017);
INSERT INTO written_by  (pid, aid) VALUES
(8, 32),
(8, 15);

SELECT P.title FROM papers AS P , year AS Y WHERE Y.published_year=2017 AND P.pid = Y.pid;

SELECT P.title FROM papers AS P , written_by AS W WHERE W.aid=( SELECT A.aid FROM authors AS A WHERE A.name='Samuel Kashi') AND P.pid = W.pid;

SELECT P.title FROM papers AS P , written_by AS W WHERE COUNT(W) > 2 AND P.pid = W.pid; 
