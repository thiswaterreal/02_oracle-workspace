--(시험대비를해보자)
------------------------------- QUIZ 1 --------------------------------
-- 보너스를 받지 않지만, 부서배치는 된 사원 조회
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CPDE != NULL;
-- NULL 값에 대해 정상적으로 비교 처리 되지 않음! 왜?

--> 문제점     : NULL값 비교할때는 단순한 일반 비교연산자를 통해 비교할 수 없음!
--> 해결방법    : IS NULL / IS NOT NULL 연산자를 이용하여 비교해야함
--> 조치한 SQL문
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CPDE IS NOT NULL;

------------------------------- QUIZ 2 --------------------------------
-- 검색하고자 하는 내용
-- JOB_CODE J7 이거나 J6 이면서 SALARY값이 200만원 이상이고
-- BONUS가 있고, 여자이며, 이메일주소는 _앞에 3글자만 있는 사원의
-- EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS 를 조회하려고 함.
-- 정상적으로 조회가 잘된다면 실행결과는 2행 이어야 함.

-- 위의 내용을 실행시키고자 작성한 SQL문은 아래와 같음
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE '____%' AND BONUS IS NULL;
-- 위의 SQL문 실행시 원하는 결과가 제대로 조회되지 않는다. 이때 어떤 문제점들(5개)이 있는지
-- 모두 찾아서 서술해볼것! 그리고 조치된 완벽한 SQL문을 작성해볼 것!
-- SUBSTR(컬럼, 시작인덱스, 개수) *** 인덱스 1부터 시작 ***

--> 문제점(5개) : AND OR 우선순위, > , $없음, IS NULL, 여자구분 누락
-- 1. OR 연산자와 AND 연산자 나열되어있을 경우, AND연산자 연산이 먼저 수행됨! 문제에서 요구한 내용으로 OR연산이 먼저 수행되어야함!
-- 2. 급여값에 대한 비교가 잘못되어있음. >이 아닌 >= 으로 비교해야함
-- 3. 보너스가 있는 이라는 조건에 IS NULL이 아닌 IS NOT NULL로 비교해야함
-- 4. 여자에 대한 조건이 누락되어있음
-- 5. 이메일에 대한 비교시 네번째 자리에 있는 _를 데이터값으로 취급하기 위해서는 새 와일드 카드를 제시해야되고, 또 ESCAPE로 등록까지 해야함

--> 해결방법 : (), >=, $, IS NOT NULL, 여자구분추가
--> 조치된 SQL문
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4')
--AND EMP_NO LIKE '_______2%'
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL;

------------------------------- QUIZ 3 --------------------------------
-- [계정생성구문] CREATE USER 계정명 IDENTIFIED BY 비밀번호;

-- 계정명 : SCOTT, 비밀번호 : TIGER 계정을 생성하고 싶다!
-- 이때 일반사용자 계정인 KH계정에 접속해서 CREATE USER SCOTT; 로 실행하니 문제 발생!

--> 문제점
-- 1. 사용자 계정 생성은 무조건!! 관리자 계정에서만 가능!!
-- 2. SQL문이 잘못되어있음. 비번까지 입력해야함

--> 조치내용
-- 1. 관리자계정에서 생성해야한다
-- 2. CREATE USER SCOTT IDENTIFIED BY TIGER;

-- 위의 SQL(CREATE)문만 실행 후 접속을 만들어 접속을 하려고 했더니 실패!
-- 뿐만 아니라 해당 계정에 테이블 생성같은것도 되지 않음.. 왜??

--> 문제점
-- 1. 사용자 계정 생성 후 최소한의 권한 부여해줘야함

--> 조치내용
-- 1. GRANT CONNECT, RESOURCE TO SCOTT; 구문 실행하여 권한 부여!!

------------------------------------------------------------------------
-- 부서코드가 D5인 사원들의 총 연봉 합
SELECT SUM(SALARY * 12)   -- ,EMP_NAME : 그룹함수이기 때문에 단일행함수 쓰면 오류남 *****
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

------------------------------------------------------------------------
-- 5. COUNT(*|컬럼|DISTINCT 컬럼) : 조회된 행 개수를 세서 반환

--    COUNT(*)            : 조회된 결과의 모든 행 개수를 세서 반환
--    COUNT(컬럼)          : 제시한 해당 컬럼값이 NULL이 아닌것만 행 개수 세서 반환
--    COUNT(DISTINCT 컬럼) : 해당 컬럼값 중복을 제거한 후 행 개수 세서 반환

-- 전체 사원 수
SELECT COUNT(*)
FROM EMPLOYEE;

-- 여자 사원 수 
SELECT COUNT(*) -- 3
FROM EMPLOYEE   -- 1
WHERE SUBSTR(EMP_NO, 8, 1) IN('2', '4');    -- 2

-- 보너스를 받는 사원 수
SELECT COUNT(BONUS) -- 컬럼이 NULL이 아닌!!것만(값 존재) 카운팅함
FROM EMPLOYEE;
--WHERE BONUS IS NOT NULL;

-- 부서배치를 받은 사원 수
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- 현재 사원들이 몇개의 부서에 분포되어있는지
SELECT COUNT(DISTINCT DEPT_CODE)    --6 (D1 D2 D5 D6 D8 D9)
FROM EMPLOYEE;
----------------------------------------------------------------------------------

-- 여자 사원 수 
SELECT COUNT(*) -- 3
FROM EMPLOYEE   -- 1
WHERE SUBSTR(EMP_NO, 8, 1) IN('2', '4');    -- 2

-- GROUP BY로 묶으면?   //뭘까뭘까뭘까
SELECT SUBSTR(EMP_NO, 8, 1) IN ('2'), COUNT(*) -- 3
FROM EMPLOYEE   -- 1
WHERE SUBSTR(EMP_NO, 8, 1);    -- 2 

-- GROUP BY 절에 함수식 기술 가능
-- 남/여별 총 사원 수
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여'), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);
