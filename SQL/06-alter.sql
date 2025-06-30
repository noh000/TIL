USE lecture;
SELECT * FROM members;

-- 테이블 컬럼구조(스키마) 변경
-- 컬럼 추가
ALTER TABLE members ADD COLUMN age INT NOT NULL DEFAULT(20);
ALTER TABLE members ADD COLUMN juso VARCHAR(100) DEFAULT('미입력');
-- 컬럼명+데이터 타입 수정
ALTER TABLE members CHANGE COLUMN juso address VARCHAR(100);
-- 데이터 타입 수정
ALTER TABLE members MODIFY COLUMN address VARCHAR(50);
-- 컬럼 삭제
ALTER TABLE members DROP COLUMN age;