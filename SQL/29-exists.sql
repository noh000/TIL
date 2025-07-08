-- EXISTS 서브쿼리 결과가 한 줄이라도 **존재**하면 TRUE
-- WHERE EXISTS (SELECT 1 ... 의 형태로 주로 사용됨

-- 전자제품을 구매한 고객 정보
SELECT
  customer_id, customer_name, customer_type
FROM customers
WHERE customer_id IN (  -- 결과 리스트를 메모리에 생성, 시간/공간적으로 비효율
  SELECT customer_id FROM sales WHERE category='전자제품'
);

-- EXISTS 사용, 같은 결과
SELECT
  customer_id, customer_name, customer_type
FROM customers c
-- 고객이 전자제품을 구매한 기록이 하나라도 있으면 해당 고객을 포함
WHERE EXISTS (
  SELECT 1 FROM sales s
  WHERE s.customer_id=c.customer_id AND s.category='전자제품'  -- JOIN 없이도 외부값 참조 가능
);


-- 전자제품과 의류를 모두 구매해 본적이 있고 동시에 50만원 이상 구매 이력도 가진 고객들
SELECT
  c.customer_name,
  c.customer_type
FROM customers c
WHERE 
  -- 전자제품 구매
  EXISTS(SELECT 1 FROM sales s1 WHERE s1.customer_id = c.customer_id AND s1.category = '전자제품')
  AND
  -- 의류 구매
  EXISTS(SELECT 1 FROM sales s2 WHERE s2.customer_id = c.customer_id AND s2.category = '의류')
  AND
  -- 50만원 이상
  EXISTS(SELECT 1 FROM sales s3 WHERE s3.customer_id = c.customer_id AND s3.total_amount >= 500000);
  

-- NOT EXISTS
-- 판매 이력이 없는 상품들
SELECT
    p.product_name,
    p.category,
    p.selling_price
FROM products p
WHERE NOT EXISTS (
    SELECT 1 FROM sales s WHERE s.product_name = p.product_name
)
ORDER BY p.category, p.selling_price DESC;