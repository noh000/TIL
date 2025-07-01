USE lecture;

-- 테이블 생성
CREATE TABLE sample (
	name VARCHAR(30),
    age INT
);

SHOW TABLES;  -- 테이블 목록

-- 테이블 삭제
DROP TABLE sample;

CREATE TABLE members (  -- 테이블명
	id INT AUTO_INCREMENT PRIMARY KEY,  -- 회원 고유번호 (정수, 자동증가)
										-- PRIMARY KEY 테이블당 1개 필수
    name VARCHAR(30) NOT NULL,  -- 이름 (필수 입력)
    email VARCHAR(100) UNIQUE,  -- 이메일 (중복 불가능)
    join_date DATE DEFAULT(CURRENT_DATE)  -- 가입일 (기본값_오늘)
);

-- 테이블 상세내역 확인
DESC members;