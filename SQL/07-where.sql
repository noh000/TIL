-- SELECT 컬럼 FROM 테이블
-- WHERE 조건
-- ORDER BY 정렬기준
-- LIMIT 데이터 개수

USE lecture;
CREATE TABLE students (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    age INT
);
DESC students;

INSERT INTO students (name, age) VALUES
('노 아영','36'),
('이 금자','62'),
('정 희연','44'),
('김 보람','19'),
('김 영건','24'),
('고 보람','39'),
('유 창준','40'),
('하 준서','12'),
('박 용호','58'),
('오 영서','26');
SELECT * FROM students;

SELECT * FROM students WHERE name='노 아영';
SELECT * FROM students WHERE age>=20;
SELECT * FROM students WHERE id<>1;  -- 여집합 (해당 조건 아닌)
SELECT * FROM students WHERE id!=1;  -- 여집합 (해당 조건 아닌)

SELECT * FROM students WHERE age BETWEEN 19 AND 36;  -- 19 이상, 36 이하

SELECT * FROM students WHERE id IN (1, 3, 5, 7);  -- 값의 리스트(list of valuses), 이 중 하나만 맞아도 OK

-- 문자열 부분 일치 LIKE
SELECT * FROM students WHERE name LIKE '김%';  -- '김'으로 시작하는 name 찾기 (뒤에 글자수 상관X)
SELECT * FROM students WHERE name LIKE '%연'; -- '연'로 끝나는 name 찾기 (앞에 글자수 상관X)
SELECT * FROM students WHERE name LIKE '%보%'; -- '보'가 들어가는 name 찾기 (앞뒤 글자수 상관X, 맨앞뒤도 OK)
SELECT * FROM students WHERE name LIKE '이 __';  -- '이'로 시작하고 뒤에 두 글자(__)가 있는 사람 찾기