/*
    * DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    오라클에서 제공하는 객체(OBJECT)를 새로이 만들고(CREATE), 구조를 변경(ALTER), 구조 자체를 삭제(DROP)
    즉, 실제 데이터 값이 아닌 구조 자체를 정의하는 언어
    주로 DB관리자, 설계자가 사용함
    
    오라클에서 제공하는 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), 
                                  인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGER),
                                  프로시져(PROCEDUER), 함수(FUNCTION), 동의어(SYNONYM), 사용자(USER)
                                  
    < CREAGE >
    객체를 새로이 생성하는 구문
*/

/*
    1. 테이블 생성
    - 테이블이란? 행(ROW)과 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
                 모든 데이터들은 테이블을 통해서 저장됨!
                 (DBMS 용어 중 하나로, 데이터를 일종의 표 형태로 표현한 것)
                 
    [표현식]
    CREATE TABLE 테이블명(
        컬럼명 자료형(크기),
        컬럼명 자료형(크기),
        컬럼명 자료형,
        ...
    );
    
    * 자료형
    - 문자 (CHAR(바이트 크기) | VARCHAR2(바이트크기)) => 반드시 크기 지정 해야함
        > CHAR : 최대 2000바이트까지 지정 가능. 지정한 범위 안에서만 써야함 / 고정길이 (지정한 크기보다 더 적은 값이 들어와도 공백으로 채워진다)
                 고정된 글자수의 데이터만이 담길 경우 사용 => 일반적으로 '한'글자! (Y/N, M/F)
        
        > VARCHAR2 : 최대 4000바이트까지 지정 가능. 가변 길이(담긴 값에 따라서 공간의 크기 맞춰짐)
                     몇 글자의 데이터가 들어올지 모르는 경우 , 긴 글이 들어오는 경우
    
    - 숫자 (NUMBER)
    - 날짜 (DATE)
    
*/

-- 회원에 대한 데이터를 담기 위한 테이블 MEMBER 생성하기
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

-- 만약 컬럼명에 오타가 발생했다면?
-- 다시 만들면 될까? ㄴㄴ 삭제하고 다시 만들어야 함!!
-- DROP TABLE 테이블명;
DROP TABLE MEMBER;



