USE lecture;

CREATE TABLE dt_demo (
	id 			INT AUTO_INCREMENT PRIMARY KEY,
	name 	 	VARCHAR(20) NOT NULL,
    nickname 	VARCHAR(20),
    birth 	 	DATE,
    score 	 	FLOAT,  -- 부동소수점(floating-point) 소수점의 위치가 고정되어 있지 않음, 소수 자릿수 유동적, 2진수
    salary		DECIMAL(10, 3),  -- 소수점의 위치 및 소수 자릿수 고정(최대 자릿수, 소수점 자릿수), 10진수
			-- 최대값 9999999.999
    description TEXT,
    is_active 	BOOL DEFAULT TRUE,  -- 불 방식(Boolean) TRUE/FALSE 값만 가짐
	created_at 	DATETIME DEFAULT CURRENT_TIMESTAMP
);
DESC dt_demo;

INSERT INTO dt_demo (name, nickname, birth, score, salary, description)
VALUES
('김철수', 'kim', '1995-01-01', 88.75, 3500000.50, '우수한 학생입니다.'),
('이영희', 'lee', '1990-05-15', 92.30, 4200000.00, '성실하고 열심히 공부합니다.'),
('박민수', 'park', '1988-09-09', 75.80, 2800000.75, '기타 사항 없음'),
('노아영', 'noh', '1989-05-24', 84.40, 3300000.00, '적극적입니다.');

SELECT * FROM dt_demo;
SELECT * FROM dt_demo WHERE score>=80;
SELECT * FROM dt_demo WHERE description NOT LIKE '%학생%';
SELECT * FROM dt_demo WHERE birth<'2000-01-01';