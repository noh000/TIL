USE lecture;

-- 테이블 관계
-- 다대다(M:N)
-- 한 테이블의 하나의 데이터가 다른 테이블의 여러 데이터와 연결될 수 있고, 그 반대도 가능
-- ex) 학생 1명은 여러 수업을 들을 수 있음 + 수업 1개에 여러 학생이 들을 수 있음

CREATE TABLE students (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20)
);

CREATE TABLE courses (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  classroom VARCHAR(20)  
);

-- 반드시 중간테이블(Junction Table) 통해 관계 구현
CREATE TABLE students_courses (
  student_id INT,
  course_id INT,
  grade VARCHAR(5),
  PRIMARY KEY (student_id, course_id),  -- 복합 PK
  FOREIGN KEY(student_id) REFERENCES students(id),
  FOREIGN KEY(course_id) REFERENCES courses(id)
);

-- 데이터 삽입
INSERT INTO students VALUES
(1, '김학생'),
(2, '이학생' ),
(3, '박학생');

INSERT INTO courses VALUES
(1, 'MySQL 데이터베이스', 'A관 101호'),
(2, 'PostgreSQL 고급', 'B관 203호'),
(3, '데이터 분석', 'A관 704호');

INSERT INTO students_courses VALUES
(1, 1, 'A'),  -- 김학생이 MySQL 수강
(1, 2, 'B+'), -- 김학생이 PostgreSQL 수강
(2, 1, 'A-'), -- 이학생이 MySQL 수강
(2, 3, 'B'),  -- 이학생이 데이터분석 수강
(3, 2, 'A+'), -- 박학생이 PostgreSQL 수강
(3, 3, 'A');  -- 박학생이 데이터분석 수강

-- 학생별 수강과목
SELECT
  s.name,
  group_concat(c.name)  -- 같은 그룹에 있는 여러 값을 콤마로 연결
FROM students_courses sc
INNER JOIN students s ON sc.student_id=s.id
INNER JOIN courses c ON sc.course_id=c.id
GROUP BY s.name;

SELECT
  c.name AS 과목명,
  c.classroom AS 강의실,
  COUNT(sc.student_id) AS 수강인원,
  GROUP_CONCAT(s.name) AS 수강학생명,
  AVG(
    CASE
      WHEN sc.grade='A+' THEN 4.3
      WHEN sc.grade='A' THEN 4.0
      WHEN sc.grade='A-' THEN 3.7
      WHEN sc.grade='B+' THEN 3.3
      WHEN sc.grade='B' THEN 3.0
    END
  ) AS 학점평균
FROM students_courses sc
INNER JOIN students s ON sc.student_id=s.id
INNER JOIN courses c ON sc.course_id=c.id
GROUP BY c.name, c.classroom;