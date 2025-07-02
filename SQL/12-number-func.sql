USE lecture;

-- 수소점 함수
SELECT
	name,
    score AS 원점수,
    round(score) AS 반올림,
    round(score, 1) AS 반올림_자릿수1,
    ceil(score) AS 올림,
    floor(score) AS 내림,
    TRUNCATE(score, 1) AS 버림_자릿수1
FROM dt_demo;

-- 사칙연산
SELECT 
	10 DIV 3 AS 몫,
	10 % 3 AS 나머지,
    MOD(10, 3) AS 나머지2,  -- modulo 나머지
    power(10, 2) AS 거듭제곱,
    sqrt(16) AS 루트,
    abs(-10) AS 절대값;
    
SELECT * FROM dt_demo;
SELECT
	id, name,
    id%2 AS 나머지,
    CASE
		WHEN id%2=0 THEN '짝수'
        ELSE '홀수'
	END
FROM dt_demo;

-- 조건문 IF, CASE
SELECT 
	name, score,
    IF(score>=80, '우수', '보통') AS 평가  -- 경우의 수 두가지
FROM dt_demo;

SELECT 
	name, 
    IFNULL(score, 0) AS 점수,  -- IFNULL(값, 대체값)
	CASE
		WHEN score IS NULL THEN 'F'
        WHEN score>=90 THEN 'A'
        WHEN score>=80 THEN 'B'
        WHEN score>=70 THEN 'C'
        ELSE 'D'
	END AS 학점
FROM dt_demo;