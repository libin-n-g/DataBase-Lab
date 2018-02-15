drop database canteen;
create database canteen;
use canteen;
create table menu (
id int not null,
name varchar(50) not null,
type enum('healthy','unhealthy'),
PRIMARY KEY(id)
);
create table `order`(
id INT not null,
count int not null,
PRIMARY KEY(id)

);
Create table price(
id INT not NULL,
amount float,
FOREIGN KEY (id) REFERENCES menu(id)
);

CREATE TRIGGER init
after insert ON menu
FOR EACH ROW
INSERT INTO `order` values (new.id, 0);
-- DELIMITER ;

insert into menu values (1, 'test', 'healthy');

drop trigger init;

insert into menu values (2, 'test2', 'healthy2');

select * from `order`;

select * from menu;
 
DELIMITER //
CREATE TRIGGER init_price
after insert ON menu
FOR EACH ROW
BEGIN 
    IF new.`type`='healthy'
       THEN BEGIN INSERT INTO price values (new.id, 10);
    END;
    ELSE
       BEGIN INSERT INTO price values (new.id, 5);
    END;
    END IF;
    END;//
DELIMITER ;


DELIMITER //
CREATE TRIGGER price_checker
before insert ON price
FOR EACH ROW
BEGIN
  IF NEW.amount < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'price can not be negative';
  END IF;
END; //
DELIMITER ;

ALTER table menu
add spicy VARCHAR(2);


DELIMITER //
CREATE TRIGGER spicy_checker
before insert ON menu
FOR EACH ROW
BEGIN
  IF NEW.spicy<>'Y' AND NEW.spicy<>'N' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'wrong spicy level!';
  END IF;
END; //

DELIMITER ;
