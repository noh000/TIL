USE lecture;
SELECT * FROM dt_demo;

-- 현재 날짜+시간
SELECT now();
SELECT current_timestamp;

-- 현재 날짜
SELECT curdate();
SELECT current_date;

-- 현재 시간
SELECT curtime();
SELECT current_time;

-- 날짜 변환
SELECT 
	name,
    birth AS '원본',
    date_format(birth, '%Y년 %m월 %d일') AS 한국식, 
    date_format(birth, '%Y-%m') AS 연월, 
    date_format(birth, '%M %D, %Y') AS 영문식, 
    date_format(birth, '%w') AS 요일번호, 
    date_format(birth, '%W') AS 요일이름 
FROM dt_demo;

SELECT
	created_at AS 원본시간,
    date_format(created_at, '%Y-%m-%d %H:%i') AS 분까지,
    date_format(created_at, '%p %H:%i') AS 'AM/PM'
FROM dt_demo;

-- 날짜 계산
SELECT
	name,
    birth,
    -- datediff 시간 무시하고 "날짜 차이"만 계산 ex)디데이계산
    datediff(curdate(), birth) AS 일자수,  
    -- TIMESTAMPDIFF(결과 단위, 날짜1, 날짜2)
    TIMESTAMPDIFF(YEAR, birth, curdate())
FROM dt_demo;

SELECT
	name, birth,
    date_add(birth, INTERVAL 100 DAY) AS 백일_후,
    date_add(birth, INTERVAL 1 YEAR) AS 돌,
    date_sub(birth, INTERVAL 10 MONTH) AS 수정
FROM dt_demo;

-- 계정 생성 후 경과 시간
SELECT 
	name, created_at,
    TIMESTAMPDIFF(HOUR, created_at, now()) AS 가입후_시간,
    TIMESTAMPDIFF(DAY, created_at, now()) AS 가입후_일수
FROM dt_demo;

-- 날짜 추출
SELECT 
	name, 
    birth,
    YEAR(birth),
    MONTH(birth),
    DAY(birth),
    dayofweek(birth) AS 요일번호,
    dayname(birth) AS 요일,
    quarter(birth) AS 분기
FROM dt_demo;

-- 월별, 연도별
SELECT 
	YEAR(birth) AS 출생년도,
    count(*) AS 인원수
FROM dt_demo
GROUP BY YEAR(birth)
ORDER BY 출생년도;

SELECT
    (YEAR(birth) DIV 10) * 10 AS 출생연도_10년단위,
    COUNT(*) AS 인원수
FROM dt_demo
GROUP BY 출생연도_10년단위
ORDER BY 출생연도_10년단위;