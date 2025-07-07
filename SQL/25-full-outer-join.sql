USE lecture;

-- 데이터 무결성 검사 (비어있는 데이터 찾기)
-- MySQL에는 FULL OUTER JOIN 명령어가 없음

SELECT
 c.customer_name,
 s.product_name
FROM customers c
LEFT JOIN sales s ON c.customer_id=s.customer_id
WHERE s.customer_id IS NULL

UNION

SELECT
 c.customer_name,
 s.product_name
FROM customers c
RIGHT JOIN sales s ON c.customer_id=s.customer_id
WHERE c.customer_id IS NULL;