USE lecture;
DESC members;

-- 데이터 입력 (CREATE)
INSERT INTO members (name, email) VALUES ('노아영', 'ay@gmail.com');
INSERT INTO members (name, email) VALUES ("김서영", "sy@gmail.com");

INSERT INTO members (email, name) VALUES
('jy@gmail.com', '정주영'),
('hy@gmail.com', '강현영');

-- 전체 데이터 확인 (READ)
SELECT * FROM members;
-- 단일 데이터 확인 (READ)
SELECT * FROM members WHERE id=1;
