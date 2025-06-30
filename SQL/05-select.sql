USE lecture;

-- 모든 컬럼, 모든 레코드
SELECT * FROM members;
-- 모든 컬럼, id 레코드(기준)
SELECT * FROM members WHERE id=4;
-- name, email 컬럼, 모든 레코드
SELECT name, email FROM members;
-- email 컬럼, name 레코드(기준)
SELECT email FROM members WHERE name='김서영'