/*
    DQL ( QUERY 데이터 질의 언어 )         : SELECT
    
    DML ( MANIPULATION 데이터 조작 언어 )  : [SELECT], INSERT, UPDATE, DELETE
    DDL ( DEFINITION 데이터 정의 언어 )    : CREATE, ALTER, DROP
    DCL ( CONTROL 데이터 제어 언어 )       : GRANT, REVOKE, [COMMIT, ROLLBACK]
    
    TCL ( TRANSACTION 트랜젝션 제어 언어 ) : COMMIT, ROLLBACK

    < DML : DATE MANIPULATION LANGUAGE >
    데이터 조작 언어
    
    테이블에 값을 '삽입(INSERT)' 하거나, '수정(UPDATE)' 하거나, '삭제(DELECT)' 하는 구문
*/

/*
    1. INSERT
        테이블에 새로운 행을 추가하는 구문
        
        [표현법]
        1)  INSERT INTO 테이블명 VALUES (값1, 값2, ...);       **중요**
        
            테이블에 모든 컬럼에 대한 값을 직접 제시해서 한 행 INSERT 하고자 할 때 사용
            컬럼 순번을 지켜서 VALUES에 값을 나열해야됨!
            
            부족하게 값을 제시했을 경우 => not enough values 오류!!
            값을 더 많이 제시했을 경우 => too many values 오류!!
            
*/  
INSERT INTO EMPLOYEE
VALUES (900, '차은우', '900101-1234567', 'cha_00@kh.or.kr', '01011112222',
        'D1', 'J7', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);   --DEFAULT => ENT_YN : 'N'

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '차은우';

/*
        2)  INSERT INTO 테이블명 (컬럼명, 컬럼명, 컬럼명) VALUES (값1, 값2, 값3);      **중요**
        
            테이블에 내가 선택한 컬럼에 대한 값만 INSERT 할 때 사용
            그래도 한 행 단위로 추가되기 때문에
            선택이 안된 컬럼은 기본적으로는 NULL 이 들어감!
            => NOT NULL 제약조건이 걸려있는 컬럼은 반드시!! 선택해서 직접 값 제시해야함!!
            단, DEFAULT 값이 있는 경우, NULL 이 아닌 DEFAULT 값이 들어간다
*/
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES (901, '주지훈', '880202-1111111', 'J1', 'S2', SYSDATE);

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '주지훈';
-- ENT_YN 은 'N'로 DEFAULT 값이 들어가있음

INSERT
  INTO EMPLOYEE
       (
         EMP_ID
       , EMP_NAME
       , EMP_NO
       , JOB_CODE
       , SAL_LEVEL
       , HIRE_DATE
       )
VALUES
       (
         901
       , '주지훈'
       , '880202-1111111'
       , 'J1'
       , 'S2'
       , SYSDATE
       );
       
---------------------------------------------------------------------------------

/*
            (+ 추가로 알아두면 좋지요ㅎㅎ)
        3)  INSERT INTO 테이블명 (서브쿼리);
            VALUES 로 값 직접 명시하는거 대신에
            서브쿼리 조회된 결과값을 통째로 INSERT 가능! (여러 행 INSERT 가능!)
*/

-- 새로운 테이블 셋팅
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- 전체 사원들의 사번, 이름, 부서명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- 부서없는 사람들도 나오도록 == 모든 EMPLOYEE (LEFT JOIN)

-- 위의 내가 원하는 데이터 삽입
INSERT INTO EMP_01 (
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
);

SELECT * FROM EMP_01;

--================================================================================

/*
    2. INSERT ALL
*/

--> 우선 테스트할 테이블 만들기
-- 구조만 배껴서,,
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
   FROM EMPLOYEE
   WHERE 1 = 0;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE 1 = 0;
   
SELECT * FROM EMP_DEPT;   
SELECT * FROM EMP_MANAGER;

-- 부서코드가 D1인 사원들의 사번, 이름, 부서코드, 입사일, 사수사번 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

/*
    [표현식]
    INSERT ALL
    INTO 테이블명1 VALUES(컬럼명, 컬럼명, ...)
    INTO 테이블명2 VALUES(컬럼명, 컬럼명, ...)
    서브쿼리;
*/

INSERT ALL
INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES (EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';

-- * 조건을 사용해서 각 테이블에 INSERT 가능?

-- 2000년도 이전 입사한 입사자들에 대한 정보 담을 테이블
-- 테이블 구조만 배껴서 먼저 만들기
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1 = 0;

-- 2000년도 이후 입사한 입사자들에 대한 정보 담을 테이블
-- 테이블 구조만 배껴서..
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1 = 0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

-- // 일단 서브쿼리는
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    [표현식]
    INSERT ALL
    WHEN 조건1 THEN
        INTO 테이블명1 VALUES (컬럼명, 컬럼명)
    WHEN 조건2 THEN
        INTO 테이블명2 VALUES (컬럼명, 컬럼명)
    서브쿼리
*/

INSERT ALL
WHEN HIRE_DATE < '2000/01/01' THEN
    INTO EMP_OLD VALUES (EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES (EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT * FROM EMP_OLD;  -- 8
SELECT * FROM EMP_NEW;  -- 17

--================================================================================
/*
    3. UPDATE
        테이블에 기록되어있는 기존의 데이터를 '수정' 하는 구문
        
    [표현식]
    UPDATE 테이블명
    SET 컬럼명 = 바꿀값,
        컬럼명 = 바꿀값,
        ...             --> 여러개의 컬럼값 동시 변경 가능 ( ',' 로 나열해야함!! AND 아님!! )
    [WHERE 조건];       --> 생략하면 전체 행의 모든 행의 데이터가 변경된다..! 그래서 꼭 조건을 쓰자!
*/

-- 복사본 테이블 만든 후 작업
CREATE TABLE DEPT_COPY
AS SELECT * 
   FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- D9 부서의 부서명을 '전략기획팀'으로 수정
UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀';    --총무부(원본)
-- WHERE 조건을 안줬더니 전부 다 '전략기획팀' 으로 바뀜..

ROLLBACK;

UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'    --총무부(원본)
WHERE DEPT_ID = 'D9';
-- 이제야 1행만 업데이트됨

-- 우선 복사본 떠서 진행
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
   FROM EMPLOYEE;
   
SELECT * FROM EMP_SALARY;

-- 노옹철 사원의 급여를 100만원으로 변경! 데이터 백업
SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME = '노옹철';  -- 3700000

UPDATE EMP_SALARY
SET SALARY = 1000000
WHERE EMP_NAME = '노옹철';

-- 선동일 사원의 급여를 700만원으로 변경하고, 보너스도 0.2로 변경
SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '선동일';  -- 8000000 / 0.3

UPDATE EMP_SALARY
SET SALARY = 7000000,
    BONUS = 0.2
WHERE EMP_NAME = '선동일';

-- 전체사원의 급여를 기존의 급여를 10프로 인상한 금액 (기존급여 * 1.1)
SELECT EMP_NAME, SALARY FROM EMP_SALARY;    -- 25개 행 확인해두고

UPDATE EMP_SALARY
SET SALARY = SALARY * 1.1;  --25개 행 이(가) 업데이트되었습니다. (전체니까 WHERE 조건 필요X)

SELECT * FROM EMP_SALARY;

---------------------------------------------------------------------------------
-- * UPDATE시 서브쿼리 사용 가능
/*
    UPDATE 테이블명
    SET 컬럼명 = 서브쿼리(바꿀값)
    WHERE 조건;
*/

-- 방명수 사원의 급여와 보너스 값을 유재식 사원의 급여와 보너스 값으로 변경
SELECT EMP_NAME, SALARY, BONUS      -- 1518000	/ NULL
FROM EMP_SALARY
WHERE EMP_NAME = '방명수';

SELECT EMP_NAME, SALARY, BONUS      -- 3740000	/ 0.2
FROM EMP_SALARY
WHERE EMP_NAME = '유재식';

-- 단일행 서브쿼리 (1행1열)
UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME = '유재식'),
    BONUS = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';         -- 3740000  / 0.2 (잘 바뀜)

-- 다중열 서브쿼리 (위와 결과값 같음)
UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

-- ASIA 지역에서 근무하는 사원들의 보너스 값을 0.3으로 변경
-- 1) ASIA 지역에서 근무하는 사원들 조회     -- EMP_ID : 19행
SELECT EMP_ID
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';
-- 2) 보너스 값 0.3으로 변경
UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID
                FROM EMP_SALARY
                JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                WHERE LOCAL_NAME LIKE 'ASIA%');
-- 3) 확인조회
SELECT * FROM EMP_SALARY
WHERE EMP_NAME = '차은우';

----------------------------------------------------------------------------------
-- UPDATE 시에도 해당 컬럼에 대한 제약조건 위배되면 안됨!
-- 사번이 200 번인 사원의 이름을 NULL로 변경

UPDATE EMPLOYEE
SET EMP_NAME = NULL
WHERE EMP_ID = 200;
-- ORA-01407: cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL
-- NOT NULL 제약조건 위배되어 안됨!! (제약조건 : "EMP_NAME" IS NOT NULL)

-- 노옹철 사원의 직급코드 J9로 변경
UPDATE EMPLOYEE
SET JOB_CODE = 'J9'
WHERE EMP_NAME = '노옹철';
-- ORA-02291: integrity constraint (KH.SYS_C007151) violated - parent key not found
-- FOREIGN_KEY 제약조건 위배되어 안됨!! (JOB 테이블(부모테이블) 가보면 J9 없음)

--================================================================================
COMMIT;
/*
    4. DELETE
        테이블에 기록된 데이터를 삭제하는 구문 (한 행 단위로 삭제됨)
        
    [표현식]
    DELETE FROM 테이블명
    [WHERE 조건;]     --> WHERE절 조건 제시 안하면 전체 행 다 삭제됨
*/

-- 차은우 사원의 데이터 지우기
DELETE FROM EMPLOYEE;
-- WHERE 조건 안걸어서 전체 다 삭제됨..

ROLLBACK;   -- 마지막 커밋 시점으로 돌아감

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '차은우';

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '주지훈';

SELECT * FROM EMPLOYEE;

COMMIT;   -- 현재까지의 수정사항 저장!

ROLLBACK; -- COMMIT 시점이 차은우, 주지훈 삭제한 뒤기 때문에 ROLLBACK 해도 돌아갈 수 없음

-- DEPT_ID 가 D1 인 부서를 삭제
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
-- ORA-02292: integrity constraint (KH.SYS_C007150) violated - child record found
-- 외래키 제약 조건
-- D1의 값을 가져다쓰는(참조하는) 자식데이터가 있기 때문에 삭제가 안됨!!

SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

-- DEPT_ID 가 D3 인 부서를 삭제
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';

SELECT * FROM DEPARTMENT;

ROLLBACK;

-- * TRUNCATE : 테이블의 전체 행을 삭제할 때 사용되는 구문
--              DELETE 보다 수행속도가 빠름 (데이터 많을 경우 촤라락 삭제됨)
--              그러나, 별도의 조건 제시 불가!! / ROLLBACK 불가!!!!!!!
-- [표현식] TRUNCATE TABLE 테이블명

SELECT * FROM EMP_SALARY;
COMMIT;

DELETE FROM EMP_SALARY;
ROLLBACK;

TRUNCATE TABLE EMP_SALARY;
ROLLBACK;   -- 다시 돌아오지 않음.. 잘가..



