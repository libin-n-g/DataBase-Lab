source lab4_2.sql;

use canteen;

create table store (
item_name VARCHAR(50),
quantity INT,
PRIMARY KEY(item_name)
);
CREATE TABLE cart (
item_name VARCHAR(50),
quantity INT,
price FLOAT,
status ENUM('old', 'new'),
PRIMARY KEY(item_name)
);

DELIMITER //
CREATE FUNCTION raise_by_ten (num FLOAT)
returns FLOAT
BEGIN
declare next_num FLOAT;
SET next_num = num + 10;
return next_num;
END;//
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_order1
before insert ON store
FOR EACH ROW
BEGIN
  IF NEW.quantity = 0 THEN
     	UPDATE cart SET quantity = raise_by_ten(quantity) where item_name=new.item_name and status='new';
	UPDATE cart SET status = 'new' where item_name=new.item_name and status='old';
	UPDATE cart SET price = quantity*( select amount FROM price where
	id = (select id from menu where name = NEW.item_name))
	where item_name=new.item_name;
  END IF;
END; //

DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_order2
before update ON store
FOR EACH ROW
BEGIN
  IF NEW.quantity = 0 THEN
     	UPDATE cart SET quantity = raise_by_ten(quantity) where item_name=new.item_name and status='new';
	UPDATE cart SET status = 'new' where item_name=new.item_name and status='old';
	UPDATE cart SET price = quantity*( select amount FROM price where
	id = (select id from menu where name = NEW.item_name))
	where item_name=new.item_name;
  END IF;
END; //

DELIMITER ;

