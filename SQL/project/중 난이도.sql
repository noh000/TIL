-- 1. **직원별 담당 고객 수 집계**  
-- 각 직원(`employee_id`, `first_name`, `last_name`)이 담당하는 고객 수를 집계하세요.  
-- 고객이 한 명도 없는 직원도 모두 포함하고, 고객 수 내림차순으로 정렬하세요.

SELECT
	e.employee_id, 
	e.first_name, 
	e.last_name,
	COUNT(c.customer_id) AS customer_count
FROM employees e
LEFT JOIN customers c ON c.support_rep_id = e.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY customer_count DESC;


-- 2. **가장 많이 팔린 트랙 TOP 5**  
--    - 판매량(구매된 수량)이 가장 많은 트랙 5개(`track_id`, `name`, `총 판매수량`)를 출력하세요.  
--    - 동일 판매수량일 경우 트랙 이름 오름차순 정렬하세요.

-- A1. CTE + 윈도우 함수
-- EXPLAIN ANALYSE Execution Time: 28.127 ms
WITH track_sales AS(
	SELECT
		t.track_id,
		t.name,
		SUM(ii.quantity) AS 총판매수량,
		ROW_NUMBER() OVER(ORDER BY SUM(ii.quantity) DESC, t.name) AS 총판매순위
	FROM tracks t
	INNER JOIN invoice_items ii ON ii.track_id = t.track_id 
	GROUP BY t.track_id, t.name
)
SELECT
	track_id,
	name,
	총판매수량
FROM track_sales
WHERE 총판매순위 <=5;

-- A2. ORDER BY + 윈도우 함수
-- EXPLAIN ANALYSE Execution Time: 28.808 ms
SELECT
	t.track_id,
	t.name,
	SUM(ii.quantity) AS 총판매수량
FROM tracks t
INNER JOIN invoice_items ii ON ii.track_id = t.track_id 
GROUP BY t.track_id, t.name
ORDER BY ROW_NUMBER() OVER(ORDER BY SUM(ii.quantity) DESC, t.name) 
-- 동일 판매량 = 같은 순위, 이름순 정렬 추가로 필요
-- ORDER BY RANK() OVER(ORDER BY SUM(ii.quantity) DESC), t.name
LIMIT 5;


-- 3. **2010년 이전에 가입한 고객 목록**  
-- 2010년 1월 1일 이전에 첫 인보이스를 발행한 고객의 `customer_id`, `first_name`, `last_name`, `첫구매일`을 조회하세요.

SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
	MIN(i.invoice_date) AS 첫구매일
FROM invoices i
LEFT JOIN customers c ON c.customer_id=i.customer_id
WHERE i.invoice_date < '2010-01-01'::DATE
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.customer_id;


-- 4. **국가별 총 매출 집계 (상위 10개 국가)**  
-- 국가(`billing_country`)별 총 매출을 집계해, 매출이 많은 상위 10개 국가의 국가명과 총 매출을 출력하세요.

SELECT
	billing_country,
	SUM(total) AS 국가별총매출
FROM invoices
GROUP BY billing_country
ORDER BY 국가별총매출 DESC
LIMIT 10;


-- 5. **각 고객의 최근 구매 내역**  
-- 각 고객별로 가장 최근 인보이스(`invoice_id`, `invoice_date`, `total`) 정보를 출력하세요.

WITH max_invoice AS (
	SELECT
		i1.customer_id AS customer_id,
		MAX(i1.invoice_date) AS 최근구매일
	FROM invoices i1
	GROUP BY i1.customer_id
)
SELECT
	i2.customer_id,
	i2.invoice_id,
	i2.invoice_date,
	total
FROM invoices i2
JOIN max_invoice mi ON i2.customer_id=mi.customer_id
WHERE i2.invoice_date=mi.최근구매일;