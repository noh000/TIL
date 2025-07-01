USE lecture;
SELECT * FROM students;

-- 이름 ㄱㄴㄷ 순으로 정렬
SELECT * FROM students ORDER BY name;  -- 정렬 디폴트 = ASC
SELECT * FROM students ORDER BY name ASC;  -- 오름차순
SELECT * FROM students ORDER BY name DESC;  -- 내림차순

ALTER TABLE students ADD COLUMN grade VARCHAR(1) DEFAULT 'B';
UPDATE students SET grade='A' WHERE id<=3;
UPDATE students SET grade='C' WHERE id BETWEEN 8 AND 10;

-- 다중 컬럼 정렬 -> 순서대로
SELECT * FROM students ORDER BY
age ASC, grade DESC;
SELECT * FROM students ORDER BY
grade DESC, age ASC;

SELECT * FROM students 
WHERE age<40 
ORDER BY grade, age DESC 
LIMIT 5;