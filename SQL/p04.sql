USE practice;

SELECT * FROM userinfo;
INSERT INTO userinfo (nickname, phone, email) VALUES
('김철수', '01112345378', 'kim@test.com'),
('이영희', NULL, 'lee@gmail.com'),
('박민수', '01612345637', NULL),
('최영수', '01745367894', 'choi@naver.com');

SELECT * FROM userinfo WHERE id>=3;
SELECT * FROM userinfo WHERE email LIKE '%gmail.com' OR email LIKE '%naver.com';
SELECT * FROM userinfo WHERE nickname IN ('김철수', '박민수');
SELECT * FROM userinfo WHERE email IS NULL;
SELECT * FROM userinfo WHERE nickname LIKE '%수%';
SELECT * FROM userinfo WHERE phone LIKE '010%';
SELECT * FROM userinfo WHERE 
nickname LIKE '%a%' AND 
email LIKE '%gmail.com' AND 
phone LIKE '010%';
SELECT * FROM userinfo WHERE 
(nickname LIKE '김%' OR nickname LIKE '이%') 
AND email LIKE '%gmail.com';

SELECT * FROM userinfo WHERE phone NOT LIKE '010________';
SELECT * FROM userinfo WHERE email LIKE '%gmail.com' AND id>5;
SELECT * FROM userinfo WHERE phone IS NOT NULL;