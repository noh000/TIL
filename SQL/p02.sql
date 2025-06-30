USE practice;
SELECT * FROM userinfo;

INSERT INTO userinfo (nickname, phone) VALUES
('aoa', '01012345678'),
('bob', '01023456789'),
('coc', '01034567890'),
('dod', '01045678901'),
('eoe', '01056789012');

SELECT * FROM userinfo WHERE id=3;
SELECT * FROM userinfo WHERE nickname='bob';
UPDATE userinfo SET phone='01099998888' WHERE id=2;
DELETE FROM userinfo WHERE id=2;