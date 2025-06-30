USE practice;
DESC userinfo;
SELECT * FROM userinfo;

ALTER TABLE userinfo ADD COLUMN email VARCHAR(40) DEFAULT('ex@gmail.com');
ALTER TABLE userinfo MODIFY COLUMN nickname VARCHAR(100);
ALTER TABLE userinfo DROP COLUMN reg_date;
UPDATE userinfo SET email='aoa@gmail.com' WHERE id=1;