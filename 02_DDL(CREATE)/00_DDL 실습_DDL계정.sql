--실습문제--

--도서관리 프로그램을 만들기 위한 테이블을 만들기
--이때, 제약조건에 이름을 부여할 것
-- 각 컬럼에 주석달기




-- (부모테이블) <- (자식테이블) 참조하고 있으면 부모테이블 삭제 안됨
-- (자식테이블) 먼저 삭제하고
-- (부모테이블) 삭제!! 후 다시 부모테이블 생성!!

--1. 출판사들에 대한 데이터를 담기 위한 출판사 테이블(TB_PUBLISHER)

-- 컬럼: 
-- PUB_NO(출판사번호) --기본키(PUBLISHER_PK)
-- PUB_NAME(출판사명) --NOT NULL(PUBLICHSER_NN)
-- PHONE(출판사전화번호) --제약조건 없음

-- 3개 정도의 샘플 데이터 추가하기

CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT PUBLISHER_PK PRIMARY KEY,
    PUB_NAME VARCHAR2(20) CONSTRAINT PUBLISHER_NN NOT NULL,
    PHONE VARCHAR2(13)
);

DROP TABLE TB_PUBLISHER;
SELECT * FROM TB_PUBLISHER;

COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '출판사번호';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '출판사명';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '출판사전화번호';

INSERT INTO TB_PUBLISHER VALUES(1, '짱구출판사', '010-1111-2222');
INSERT INTO TB_PUBLISHER VALUES(2, '맹구출판사', '010-3333-4444');
INSERT INTO TB_PUBLISHER VALUES(3, '유리출판사', '010-5555-6666');





--2. 도서들에 대한 데이터를 담기 위한 도서 테이블(TB_BOOK)

-- 컬럼:
-- BK_NO(도서번호) --기본키(BOOK_PK)
-- BK_TITLE(도서명) --NOT NULL(BOOK_NN_TITLE)
-- BK_AUTHOR(저자명) --NOT NULL(BOOK_NN_AUTHOR)
-- BK_PRICE(가격)
-- BK_STOCK(재고) --기본값 1로 지정
-- BK_PUB_NO(출판사번호) --외래키(BOOK_FK)(TB_PUBLISHER 테이블을 참조하도록)

-- 이때 참조하고 있는 부모데이터 삭제 시 자식데이터도 삭제되도록 설정

-- 5개 정도의 샘플 데이터 추가하기

CREATE TABLE TB_BOOK(
    BK_NO NUMBER CONSTRAINT BOOK_PK PRIMARY KEY,
    BK_TITLE VARCHAR2(20) CONSTRAINT BOOK_NN_TITLE NOT NULL,
    BK_AUTHOR VARCHAR2(20) CONSTRAINT BOOK_NN_AUTHOR NOT NULL,
    BK_PRICE NUMBER,
    BK_STOCK NUMBER DEFAULT 1,
    BK_PUB_NO NUMBER REFERENCES TB_PUBLISHER(PUB_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN TB_BOOK.BK_NO IS '도서번호';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '도서명';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '저자명';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '가격';
COMMENT ON COLUMN TB_BOOK.BK_STOCK IS '재고';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '출판사번호';

INSERT INTO TB_BOOK VALUES(1, '흰둥이육아법', '신짱아', 9000, 3, 3);
INSERT INTO TB_BOOK VALUES(2, '훈이는왜그래', '신짱구', 5000, DEFAULT, 2);
INSERT INTO TB_BOOK VALUES(3, '짱구성장일기', '봉미선', 6500, DEFAULT, 3);
INSERT INTO TB_BOOK VALUES(4, '짱구는못말려', '신형만', 8000, 5, 2);
INSERT INTO TB_BOOK VALUES(5, '짱구의대탐험', '흰둥이', 7500, DEFAULT, 1);

SELECT * FROM TB_BOOK;
DELETE FROM TB_BOOK; --데이터 전체 삭제







--3. 회원에 대한 데이터를 담기 위한 회원 테이블(TB_MEMBER)

--컬럼명: 
--MEMBER_NO(회원번호) --기본키(MEMBER_PK)
--MEMBER_ID(아이디) --중복금지(MEMBER_UQ)
--MEMBER_PWD(비밀번호) NOT NULL(MEMBER_NN_PWD)
--MEMBER_NAME(회원명) NOT NULL(MEMBER_NN_NAME)
--GENDER(성별) 'M' 또는 'F'로 입력되도록 제한(MEMBER_CK_GEN)
--ADDRESS(주소)
--PHONE(연락처)
--STATUS(탈퇴여부) --기본값으로 'N' 그리고 'Y' 혹은 'N'으로 입력되도록 제약조건(MEMBER_CK_STA)
--ENROLL_DATE(가입일) --기본값으로 SYSDATE, NOT NULL 조건(MEMBER_NN_EN)

--5개 정도의 샘플 데이터 추가하기

CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) CONSTRAINT MEMBER_UQ UNIQUE,
    MEMBER_PWD VARCHAR2(20) CONSTRAINT MEMBER_NN_PWD NOT NULL,
    MEMBER_NAME VARCHAR2(20) CONSTRAINT MEMBER_NN_NAME NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEMBER_CK_GEN CHECK(GENDER IN ('M', 'F')),
    ADDRESS VARCHAR2(50),
    PHONE VARCHAR2(13),
    STATUS CHAR(3) DEFAULT 'N' CONSTRAINT MEMBER_CK_STA CHECK(STATUS IN ('N', 'Y')),
    ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT MEMBER_NN_EN NOT NULL
);

COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS '회원번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '아이디';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '비밀번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS '회원명';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '성별';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '연락처';
COMMENT ON COLUMN TB_MEMBER.STATUS IS '탈퇴여부';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '가입일';

SELECT * FROM TB_MEMBER;
DELETE FROM TB_MEMBER; --데이터 전체 삭제

INSERT INTO TB_MEMBER VALUES(1, 'user01', 'pass01', '이롤리', 'F', '서울시 동작구', '010-1111-2222', 'N', '22/01/01');
INSERT INTO TB_MEMBER VALUES(2, 'user02', 'pass02', '이둥글', 'F', NULL, '010-1111-2222', 'N', '20/08/01');
INSERT INTO TB_MEMBER VALUES(3, 'user03', 'pass03', '이옹옹', 'M', '서울시 서초구', NULL, 'N', '21/09/01');
INSERT INTO TB_MEMBER VALUES(4, 'user04', 'pass04', '김궁둥', 'M', '전라도 고창군', '010-5555-6666', 'Y', '18/01/01');
INSERT INTO TB_MEMBER VALUES(5, 'user05', 'pass05', '박골골', 'F', '경기도 가평군', '010-8888-9999', 'N', SYSDATE);


--4. 도서를 대여한 회원에 대한 데이터를 담기 위한 대여목록 테이블(TB_RENT)

--컬럼:
--RENT_NO(대여번호) --기본키(RENT_PK)
--RENT_MEM_NO(대여회원번호) --외래키(RENT_FK_MEM) TB_MEMBER와 참조하도록
--이때 부모데이터 삭제 시 NULL값이 되도록 옵션 설정

--RENT_BOOK_NO(대여도서번호) --외래키(RENT_FK_BOOK) TB_BOOK와 참조하도록
--이때 부모데이터 삭제 시 NULL값이 되도록 옵션설정

--RENT_DATE(대여일) --기본값 SYSDATE

--샘플데이터 3개정도 추가하기

CREATE TABLE TB_RENT(
    RENT_NO NUMBER CONSTRAINT RENT_PK PRIMARY KEY,
    RENT_MEM_NO NUMBER CONSTRAINT RENT_FK_MEM REFERENCES TB_MEMBER ON DELETE SET NULL,
    RENT_BOOK_NO NUMBER CONSTRAINT RENT_FK_BOOK REFERENCES TB_BOOK ON DELETE SET NULL,
    RENT_DATE DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN TB_RENT.RENT_NO IS '대여번호';
COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS '대여회원번호';
COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS '대여도서번호';
COMMENT ON COLUMN TB_RENT.RENT_DATE IS '대여일';

SELECT * FROM TB_RENT;
DELETE FROM TB_RENT; --데이터 전체 삭제

INSERT INTO TB_RENT VALUES(1, 2, 2, '22/01/01');
INSERT INTO TB_RENT VALUES(2, 4, 1, '20/06/01');
INSERT INTO TB_RENT VALUES(3, 5, 3, '21/04/01');

--2번 도서를 대여한 회원의 이름, 아이디, 대여일, 반납예정일(대여일+7)을 조회하시오.
SELECT * FROM TB_BOOK;      -- BK_NO
SELECT * FROM TB_MEMBER;    --                  MEMBER_NO
SELECT * FROM TB_RENT;      -- RENT_BOOK_NO     RENT_MEM_NO

SELECT BK_NO AS "도서번호", BK_TITLE AS "도서명", BK_AUTHOR AS "저자명", MEMBER_NAME AS "대여 회원명", MEMBER_ID AS "아이디", RENT_DATE AS "대여일", RENT_DATE + 7 AS "반납예정일"
FROM TB_BOOK
JOIN TB_RENT ON (BK_NO = RENT_BOOK_NO)
JOIN TB_MEMBER ON (RENT_MEM_NO = MEMBER_NO)
WHERE BK_NO = 2;




