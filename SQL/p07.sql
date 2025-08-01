USE practice;

CREATE TABLE dt_demo2 AS SELECT * FROM lecture.dt_demo;
SELECT * FROM dt_demo2;

SELECT
-- id
	id,
-- name
	name,
-- 닉네임 (NULL -> '미설정')
	IFNULL(nickname, '미설정') AS 닉네임,
-- 출생년도 (19xx년생)
	concat(YEAR(birth),'년생') AS 출생년도1,
    date_format(birth, '%Y년생') AS 출생년도2,
-- 나이 (TIMESTAMPDIFF 로 나이만 표시)
	TIMESTAMPDIFF(YEAR, birth, curdate()) AS 나이,
-- 점수 (소수 1자리 반올림, Null -> 0)
	IF(score IS NULL, 0, round(score, 1)) AS 점수1,
	round(IFNULL(score, 0), 1) AS 점수2,
	CASE
		WHEN score IS NULL THEN 0
        ELSE round(score, 1)
	END AS 점수3,
-- 등급 (A >= 90 / B >= 80 / C >= 70 / D)
	CASE
		WHEN score IS NULL THEN 'F'
        WHEN score>=90 THEN 'A' 
        WHEN score>=80 THEN 'B'
        WHEN score>=70 THEN 'C'
        ELSE 'D'
	END AS 등급,
-- 상태 (is_active 가 1 이면 '활성' / 0 '비활성')
	IF(is_active=1, '활성', '비활성') AS 상태1,
    CASE
		WHEN is_active=1 THEN '활성'
        ELSE '비활성'
	END AS 상태2,
-- 연령대 (청년 < 30 < 청장년 < 50 < 장년)
	CASE
		WHEN TIMESTAMPDIFF(YEAR, birth, curdate())<=30 THEN '청년'
		WHEN TIMESTAMPDIFF(YEAR, birth, curdate())<36 THEN '청장년'
        ELSE '장년'
	END AS 연령대
FROM dt_demo2;