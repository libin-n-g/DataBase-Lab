START TRANSACTION;
CREATE TABLE Avg_sal (
asalary DOUBLE
);
SET @av = (SELECT avg(salary) FROM instructor);
INSERT INTO Avg_sal VALUES
(@av);
COMMIT;


START TRANSACTION;
CREATE TABLE Avg_sal_rollback(
asalary DOUBLE
);
SET @av = (SELECT avg(salary) FROM instructor);
INSERT INTO Avg_sal_rollback VALUES
(@av);
ROLLBACK;
SELECT @@GLOBAL.tx_isolation, @@tx_isolation;
SELECT @@SESSION.tx_isolation, @@tx_isolation;
SELECT @@tx_isolation, @@tx_isolation;

CREATE USER 'libin_dummy'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON 'University'.* TO 'libin_dummy'@'%';
