USE lecture;

-- 테이블 관계
-- 일대일(1:1) -> 민감한 정보를 분리하거나 접근 제어를 편리하게 하기 위해

CREATE TABLE employees(
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  hire_date DATE NOT NULL
);

CREATE TABLE employee_details(
  emp_id INT PRIMARY KEY,
  social_number VARCHAR(20) UNIQUE,
  address TEXT,
  salary DECIMAL(20),
  FOREIGN KEY (emp_id) REFERENCES employees(id) ON DELETE CASCADE  -- 부모 데이터(employees) 삭제 시 자식 데이터(employee_details)도 삭제
);

INSERT INTO employees VALUES
(1, '김철수', '2023-01-01'),
(2, '이영희', '2023-02-01'),
(3, '박민수', '2023-03-01');

INSERT INTO employee_details VALUES
(1, '123456-1234567', '서울시 강남구', 5000000),
(2, '234567-2345678', '서울시 서초구', 4500000),
(3, '345678-3456789', '부산시 해운대', 4000000);

SELECT * FROM employee_details;

-- '김철수' 의 주소?
-- [직원 테이블에서 이름이 '김철수' 인 사람과 id] 가 같은 ed 테이블 주소

SELECT address FROM employee_details
WHERE emp_id=(SELECT id FROM employees WHERE name='김철수');

-- 직원 <-> 직원정보를 합쳐서, 김철수의 주소 검색
SELECT ed.address
FROM employees e
INNER JOIN employee_details ed ON e.id = ed.emp_id
WHERE e.name='김철수';