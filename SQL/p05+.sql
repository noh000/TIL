USE practice;
SELECT * FROM userinfo;

ALTER TABLE userinfo ADD COLUMN age INT DEFAULT 20;
UPDATE userinfo SET age=33 WHERE id IN (1,4,7);
UPDATE userinfo SET age=27 WHERE id IN (2,3);
UPDATE userinfo SET age=19 WHERE id IN (5);

SELECT * FROM userinfo ORDER BY nickname LIMIT 3;
SELECT * FROM userinfo WHERE email LIKE '%gmail%' ORDER BY age DESC;

SELECT nickname, phone, age 
FROM userinfo
ORDER BY age DESC, phone
LIMIT 3;

-- null 제외 조회
SELECT * FROM userinfo
ORDER BY phone IS NULL,  -- NULL=TRUE(1), NOT NULL=FALSE(0) 오름차순에서 FALSE(0)->TRUE(1) 순서로 정렬
age DESC, phone
LIMIT 3;

-- 이름 오름차순으로 정렬하되 알파벳 순 1번은 제외하고 3명만 조회 -> 페이지네이션(게시판 1페이지, 2페이지...)
SELECT * FROM userinfo ORDER BY nickname 
LIMIT 3
OFFSET 1;