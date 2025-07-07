USE lecture;

-- 같은 테이블의 데이터를 조인

SELECT
 상사.name AS 상사명,
 직원.name AS 직원명
FROM employees 상사
LEFT JOIN employees 직원 ON 직원.id=상사.id+1;

-- 고객 간 구매 패턴 유사성
SELECT
  c1.customer_name AS customer1,
  c2.customer_name AS customer2,
  COUNT(DISTINCT s1.category) AS common_category_count,
  GROUP_CONCAT(DISTINCT s1.category) AS common_category
  FROM sales s1
INNER JOIN sales s2
  ON s1.category = s2.category
  AND s1.customer_id < s2.customer_id
INNER JOIN customers c1 ON s1.customer_id = c1.customer_id
INNER JOIN customers c2 ON s2.customer_id = c2.customer_id
GROUP BY c1.customer_name, c2.customer_name;