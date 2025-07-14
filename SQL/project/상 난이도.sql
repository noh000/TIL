-- 1. **월별 매출 및 전월 대비 증감률**  
--    - 각 연월(YYYY-MM)별 총 매출과, 전월 대비 매출 증감률을 구하세요.  
--    - 결과는 연월 오름차순 정렬하세요.

WITH monthly_sales AS (
    SELECT
        TO_CHAR(invoice_date, 'YYYY-MM') AS 연월,
        SUM(total) AS 월별매출
    FROM invoices
    GROUP BY TO_CHAR(invoice_date, 'YYYY-MM')
),
monthly_growth AS (
    SELECT
        연월,
        월별매출,
        LAG(월별매출, 1) OVER(ORDER BY 연월) AS 전월매출
    FROM monthly_sales
)
SELECT
    연월,
    월별매출,
    CASE 
        WHEN 전월매출 IS NULL THEN 'N/A'  -- 전월 데이터가 없는 첫번째 월
        WHEN 전월매출 = 0 THEN 'N/A'  -- 전월 매출이 0인 경우 분모가 0이 되어 오류 발생
        ELSE ROUND((월별매출 - 전월매출) * 100.0 / 전월매출, 2) || '%'
    END AS 전월대비증감률
FROM monthly_growth
ORDER BY 연월;


-- 2. **장르별 상위 3개 아티스트 및 트랙 수**  
-- 각 장르별로 트랙 수가 가장 많은 상위 3명의 아티스트(`artist_id`, `name`, `track_count`)를 구하세요.  
-- 동점일 경우 아티스트 이름 오름차순 정렬.

WITH track_count AS (
	SELECT
		t.genre_id,
		ar.artist_id,
		ar.name,
		COUNT(t.track_id) AS 장르별트랙수
	FROM tracks t
	LEFT JOIN albums al ON al.album_id = t.album_id
	LEFT JOIN artists ar ON ar.artist_id = al.artist_id
	GROUP BY t.genre_id, ar.artist_id, ar.name
),
genre_rank AS (
	SELECT
		g.name AS 장르명,
		tc.name  AS 아티스트명,
		장르별트랙수,
		ROW_NUMBER() OVER(
            PARTITION BY g.name 
            ORDER BY 장르별트랙수 DESC, tc.name ASC
        ) AS 랭킹
	FROM track_count tc
	JOIN genres g ON tc.genre_id=g.genre_id
)
SELECT
	장르명, 아티스트명, 장르별트랙수
FROM genre_rank
WHERE 랭킹 <= 3
ORDER BY 장르명, 랭킹;


-- 3. **고객별 총구매액 및 등급 산출**  
-- 각 고객의 총구매액을 구하고,  
-- 상위 20%는 'VIP', 하위 20%는 'Low', 나머지는 'Normal' 등급을 부여하세요.

WITH total_sum AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        COALESCE(SUM(i.total), 0) AS 총구매액
    FROM customers c
    LEFT JOIN invoices i ON c.customer_id = i.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
),
customer_rank AS (
    SELECT
        customer_id,
        first_name,
        last_name,
        총구매액,
        PERCENT_RANK() OVER (ORDER BY 총구매액 DESC) AS 순위백분율
    FROM total_sum
)
SELECT
    customer_id,
    first_name,
    last_name,
    총구매액,
    CASE
        WHEN 순위백분율 <= 0.2 THEN 'VIP'
        WHEN 순위백분율 < 0.8 THEN 'Normal'
        ELSE 'Low'
    END AS 고객등급
FROM customer_rank
ORDER BY 총구매액 DESC;


-- 4. **국가별 재구매율(Repeat Rate)**  
-- 각 국가별로 전체 고객 수, 2회 이상 구매한 고객 수, 재구매율을 구하세요.  
-- 결과는 재구매율 내림차순 정렬.

WITH invoice_count AS (
	SELECT
		billing_country AS country,
		customer_id,
		COUNT(invoice_id) AS 구매횟수
	FROM invoices
	GROUP BY billing_country, customer_id
	HAVING COUNT(invoice_id) >= 2
),
repeat_customers AS (
	SELECT
		country,
		COUNT(customer_id) AS 다회구매자수
	FROM invoice_count
	GROUP BY country
),
country_count AS (
	SELECT
		country,
		COUNT(customer_id) AS 전체고객수
	FROM customers
	GROUP BY country
)
SELECT
	cc.country,
    cc.전체고객수,
    COALESCE(rc.다회구매자수, 0) AS 다회구매자수,
    CASE 
        WHEN cc.전체고객수 = 0 THEN 0
        ELSE ROUND((COALESCE(rc.다회구매자수, 0)/ cc.전체고객수), 2)
    END AS 재구매율
FROM country_count cc
LEFT JOIN repeat_customers rc ON cc.country = rc.country
ORDER BY 재구매율 DESC;


-- 5. **최근 1년간 월별 신규 고객 및 잔존 고객**  
-- 최근 1년(마지막 인보이스 기준 12개월) 동안,  
-- 각 월별 신규 고객 수(new_customers),  -> 각 달마다 해당 달에 역대 최초 구매(Invoice 확인)한 고객
-- 해당 월에 구매한 기존 고객 수(retained_customers)를 구하세요.