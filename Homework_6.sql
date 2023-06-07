DROP DATABASE IF EXISTS lesson6;
CREATE DATABASE IF NOT EXISTS `lesson6` ;
USE lesson6;

DELIMITER //
-- задание 1
--  функция, которая принимает кол-во сек и форматирует их в кол-во дней часов.

DROP FUNCTION IF EXISTS second_to//
CREATE FUNCTION second_to (sec INT)
RETURNS TEXT DETERMINISTIC
BEGIN
  DECLARE res TEXT DEFAULT '';
  DECLARE tmp INT DEFAULT 0;
  IF (sec > 0) THEN
    SET res = CONCAT( MOD(sec, 60), ' ', 'seconds' );
    SET tmp = sec DIV 60;
    IF tmp > 0 THEN 
      SET res = CONCAT( MOD(tmp, 60), ' ', 'minutes', res );
      SET tmp = tmp DIV 60;
    END IF;
    IF tmp > 0 THEN 
      SET res = CONCAT( MOD(tmp, 24), ' ', 'hours', res );
      SET tmp = tmp DIV 24;
    END IF;
    IF  tmp > 0 THEN
      SET res = CONCAT( tmp, ' ', 'days', res );
	  END IF;
  ELSE
    SET res = 'неверное значение';
  END IF;

  RETURN res;
END//

SELECT second_to(123456)//

-- задание 2
-- Процедура выводит только четные числа от 1 до вводимого числа.

DROP PROCEDURE IF EXISTS even_num//
CREATE PROCEDURE even_num (IN num INT)
BEGIN
  DECLARE i INT DEFAULT 2;
  DROP TABLE IF EXISTS temp;
  CREATE TEMPORARY TABLE temp (even INT);
  IF (num > 0) THEN
    WHILE i <= num DO
      INSERT INTO temp (even) VALUES (i);
      SET i = i + 2;
	  END WHILE;
  ELSE
    SELECT 'Неверное значение';
  END IF;
  SELECT * FROM temp;
  
END//

CALL even_num(10)//