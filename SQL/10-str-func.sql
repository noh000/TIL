USE lecture;
SELECT * FROM dt_demo;

-- 함수(function)를 사용하여 파생 결과값 조회

-- 길이
SELECT length('hello sql');
SELECT nickname, length(nickname) FROM dt_demo;
SELECT name, char_length(name) FROM dt_demo;

-- 연결(Concatenate:사슬같이 잇다)
SELECT concat('hello', ' ', 'SQL', '!!');
SELECT concat(name, '(', score,')') AS 'info' FROM dt_demo;

-- 대소문자 변환
SELECT
	nickname,
    upper(nickname) AS 'UN',
    lower(nickname) AS 'LN'
FROM dt_demo;

-- 부분 문자열(sub_string) 추출 (문자열, 시작점, 길이)
SELECT substring('hello sql', 2, 4);
SELECT left('hello sql', 7);
SELECT right('hello sql', 5);

SELECT
	description,
    concat(
		substring(description, 1, 5), '···'
	) AS 'intro',
    concat(
		left(description, 3),
        "···",
        right(description, 3)
	) AS 'summary'
FROM dt_demo;

-- 문자열 치환
SELECT replace('a@test.com', 'test.com', 'gmail.com');
SELECT description, replace(description, '.', '!!') FROM dt_demo;



-- 특정 문자열 위치 추출
SELECT LOCATE('@', 'username@gmail.com');  -- username@gmail.com에서 @이 있는 위치(숫자)

SELECT
  description,
  SUBSTRING(description, 1, LOCATE('학생', description) - 1) AS '학생 설명'
FROM dt_demo;