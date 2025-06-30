SELECT * FROM members;

-- 데이터 변경 (UPDATE)
UPDATE members SET name='정주영', email='jy@gmail.com' WHERE id=3;
UPDATE members SET name='강현영', email='hy@gmail.com' WHERE id=4;

-- 데이터 삭제 (DELETE)
DELETE FROM members WHERE id=3;
-- 데이터 전체 삭제 (DELETE)
DELETE FROM members;