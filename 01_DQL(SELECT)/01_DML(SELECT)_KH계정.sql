/*
    <SELECT>
    데이터 조회할 때 사용되는 구문
    
    >> RESULT SET : SELECT문을 통해 조회된 결과물 (즉, 조회된 행들의 집합을 의미)
    
    [표현법]
    SELECT 조회하고자 하는 컬럼1, 컬럼2, ....
    FROM 테이블명;
    
    * 반드시 존재하는 컬럼으로 써야한다!! 없는 컬럼 쓰면 오류남!!
    
*/

-- EMPLOYEE 테이블의 모든 컬럼{*} 조회
-- SELECT EMP_ID, EMP_NAME
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- JOB 테이블의 모든 컬럼 조회
SELECT *
FROM JOB;

------------------------------ 실습문제 -----------------------------
-- 1. JOB 테이블의 직급명만 조회
SELECT JOB_NAME
FROM JOB;

-- 2. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT;

-- 3. DEPARTMENT 테이블의 부서코드, 부서명만 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회
SELECT * --EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    < 컬럼값을 통한 산술연산 >
    SELECT절 컬럼명 작성 부분에 산술연산 기술 가능 (이때, 산술연산된 결과 조회)
*/
-- EMPLOYEE 테이블의 사원명, 사원의연봉(급여 * 12) 조회
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스, 연봉, 보너스 포함된 연봉((급여+보너스*급여)*12) 조회
SELECT EMP_NAME, SALARY, BONUS, SALARY * 12, ((SALARY + BONUS * SALARY)*12)
FROM EMPLOYEE;
--> 산술연산 과정 중 NULL 값이 존재할 경우, 산술연산한 결과값 마저도 무조건 NULL로 나옴
--> NULL 값을 처리해보자!
SELECT EMP_NAME, SALARY, NVL(BONUS, 0), SALARY * 12, ((SALARY + NVL(BONUS, 0) * SALARY)*12)
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 입사일
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 입사일, 근무일수(오늘날짜 - 입사일)
-- DATE 형식끼리도 연산 가능!
-- *** 오늘날짜 : SYSDATE ***
SELECT EMP_NAME, HIRE_DATE, (SYSDATE - HIRE_DATE)
FROM EMPLOYEE;
-- DATE - DATE : 결과값은 일 단위가 맞음
-- 단, 값이 지저분한 이유는 DATE 형식 년/월/일/시/분/초 단위로 시간정보까지도 관리를 하기 때문!
-- 함수적용하면 깔끔한 결과 확인 가능 => 나중에 배움

-----------------------------------------------------------------------
/*
    < 컬럼명에 별칭 지정하기 >
    산술연산을 하게되면 컬럼명 지저분함.. 이때 컬럼명으로 별칭 부여해서 깔끔하게 보여줌
    
    [표현법]
    컬럼명 별칭 / 컬럼명 AS 별칭 / 컬럼명 "별칭" / 컬럼명 AS "별칭"
    
    AS 붙이든 안붙이든 부여하고자 하는 별칭에 띄어쓰기 혹은 특수문자가 포함될 경우 반드시 쌍따옴표로 묶어야함
*/

SELECT EMP_NAME 사원명, SALARY AS 급여, SALARY * 12 "연봉(원)", (SALARY + SALARY * BONUS)*12 AS "총 소득(보너스포함)"
FROM EMPLOYEE;

------------------------------------------------------------------------------
/*
    < 리터럴 >
    임의로 지정한 문자열('')
    
    SELECT 절에 리터럴을 제시하면 마치 테이블상에 존재하는 데이터처럼 조회 가능
    조회된 RESULT SET의 모든 행에 반복적으로 같이 출력
*/

-- EMPLOYEE 테이블의 사번, 사원명, 급여 조회
SELECT EMP_NO, EMP_NAME, SALARY, '원' AS "단위"
FROM EMPLOYEE;

/*
    < 연결 연산자 : || >
    여러 컬럼값들을 마치 하나의 컬럼인 것 처럼 연결하거나, 컬럼값과 리터럴을 연결할 수 있음
    
    System.out.println("num의 값 : " + num);
*/

-- 사번, 이름, 급여를 하나의 컬럼으로 조회
SELECT EMP_NO || EMP_NAME || SALARY
FROM EMPLOYEE;

-- 컬럼값과 리터럴값 연결
-- XXX의 월급은 XXX원 입니다. => 컬럼명 별칭 : 급여정보
SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' AS "급여정보"
FROM EMPLOYEE;

-------------------------------------------------------------------------
/*
    < DISTINCT >
    컬럼에 중복된 값들을 한 번씩만 표현하고자 할 때 사용
*/
-- 현재 우리회사에 어떤 직급의 사람들이 존재하는지 궁금함.

SELECT JOB_CODE
FROM EMPLOYEE; -- 현재는 23명의 직급이 전부 다 조회가 됨.

-- EMPLOYEE에 직급코드(중복제거) 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; -- 중복제거 되어 7행만 조회

-- 사원들이 어떤 부서에 속해있는지 궁금
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; -- null : 아직 부서배치 안된 사람

-- ** 유의 사항 : DISTINCT는 SELECT 절에 딱 한번만!! 기술 가능
/* (구문오류. 2번썼기때문에)
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
FROM EMPLOYEE;
*/

SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;
-- (JOB_CODE, DEPT_CODE) 쌍으로 묶어서 중복 판별

-- ========================================================================

/*
    < WHERE 절 >
    조회하고자 하는 테이블로부터 특정 조건에 만족하는 데이터만을 조회하고자 할 때 사용
    이때, WHERE절에 조건식을 제시하게 됨
    조건식에서는 다양한 연산자들 사용 가능!
    
    [표현식]
    SELECT 컬럼1, 컬럼2, ....
    FROM 테이블명
    WHERE 조건식;
    
    [비교연산자]
    >, <, >=, <=        --> 대소비교
    =                   --> 동등비교
    !=, ^=, <>          --> 동등하지 않은지 비교
*/

-- EMPLOYEE 에서 부서코드가 'D9'인 사원들만 조회 (이때, 모든 컬럼 조회)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 에서 부서코드가 'D1'인 => 사원들의 사원명, 급여, 부서코드 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE에서 부서코드가 'D1'이 아닌 사원들의 사번, 사원명, 부서코드 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D1';
--WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

-- 급여가 400만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE에서 재직중(EMP_YN 컬럼값이 'N')인 사원들의 사번, 사원명, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

------------------------------ 실습문제 --------------------------------

-- 1. 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉(보너스 미포함) 조회
SELECT EMP_NAME, SALARY, HIRE_DATE, SALARY*12 AS "연봉"
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. 연봉이 5000만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회
SELECT EMP_NAME, SALARY, SALARY*12 AS "연봉", DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;
--WHERE 연봉 >= 50000000;  <= 오류!! (WHERE 절에서는 SELECT 절에 작성된 별칭 사용 불가!!)

-- 쿼리 실행 순서
-- FROM 절 ==> WHERE 절 ==> SELECT 절

-- 3. 직급코드 'J3'이 아닌 사람들의 사번, 사원명, 직급코드, 퇴사여부 조회
SELECT EMP_NO, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- 부서코드가 'D9' 이면서 급여가 500만원 이상인 사원들의 사번, 사원명, 급여, 부서코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- 부서코드가 'D6'이거나 급여가 300만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- 급여가 350만원 이상 600만원 이하를 받는 사원들의 사원명, 사번, 급여 조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE 3500000 <= SALARY <= 6000000;            -- 오류!! (자바랑 마찬가지로 안됨)
--WHERE 3500000 <= SALARY AND SALARY <= 6000000; -- 가능하지만 순서 별로..
WHERE SALARY >= 3500000 AND SALARY <= 6000000;  -- 일반적으로 이 순서!!

/*
    < BETWEEN AND >
    조건식에서 사용되는 구문
    몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용되는 연산자
    
    [표현법]
    비교대상컬럼 BETWEEN A(값1) AND B(값2)
    => 해당 컬럼값이 A(값1) 이상이고 B(값2) 이하인 경우
*/

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 위의 쿼리 범위 밖의 사람들 조회하고 싶다면? 350 미만 + 600 초과
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY < 3500000 OR SALARY > 6000000;       -- 가능
--WHERE NOT SALARY BETWEEN 3500000 AND 6000000;     -- 가능
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;       -- 가능
-- NOT : 논리부정연산자 => 자바에서의 !
-- 컬럼명 앞 또는 BETWEEN 앞에 기입 가능

-- 입사일이 '90/01/01' ~ '01/01/01'
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01'; -- DATE 형식은 대소비교 가능
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

/*
    < LIKE >
    비교하고자 하는 컬럼값이 내가 제시한 특정 패턴에 만족될 경우 조회
    
    [표현법]
    비교대상컬럼 LIKE '특정패턴'
    
    - 특정패턴 제시시 '%', '_' 를 와일드 카드로 사용할 수 있음
    
    >> '%' : 0글자 이상
    EX) 비교대상컬럼 LIKE '문자%'       => 비교대상의 컬럼값이 문자로 '시작' 되는 것을 조회
        비교대상컬럼 LIKE '%문자'       => 비교대상의 컬럼값이 문자로 '끝' 나는 것을 조회
        비교대상컬럼 LIKE '%문자%'      => 비교대상의 컬럼값에 해당 문자가 '포함' 되는 것을 조회 (키워드 검색)
       
    >> '_' : 1글자 이상
    EX) 비교대상컬럼 LIKE '_문자'       => 비교대상의 컬럼값의 문자앞에 무조건 한글자만 올 경우 조회
        비교대상컬럼 LIKE '__문자'      => 비교대상의 컬럼값의 문자앞에 무조건 두글자가 올 경우 조회
        비교대상컬럼 LIKE '_문자_'      => 비교대상의 컬럼값의 문자 앞과 문자 뒤에 무조건 한글자씩 올 경우 조회
    
*/
-- 사원들 중 성이 '전'씨인 사원들의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 사원들 중 이름이 '하'로 끝나는 사원들의 사원명, 주민번호, 전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하';

-- 사원들 중 이름에 '하'가 포함된 사원들의 사원명, 주민번호, 전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 이름의 가운데 글자가 '하'인 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

-- 전화번호의 3번째 자리가 1인 사원들의 사번, 사원명, 전화번호, 이메일 조회 (ex) 011-)
-- 와일드카드 : _(1글자), %(0글자 이상)
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%'; -- '%'뒤부터는 뭐 와도 상관없어용~ 인 뜻!

-- ** 특이케이스 **
-- 이메일 중 _ 기준으로 앞글자가 3글자인 사원들의  사번, 이름, 이메일 조회
-- EX) sim_bs@kh.or.kr, sun_di@kh.or.kr
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%'; -- (_4개적음) 원했던 결과 도출 못함..
-- 와일드카드로 사용하고있는 문자와 컬럼값에 담긴 문자가 동일하기 때문에 제대로 조회 안됨!!
--> 어떤게 와일드카드이고 어떤게 데이터 값인지 구분 지어야 함
--> 데이터 값으로 취급하고자 하는 값 앞에 나만의 와일드 카드를 제시하고 나만의 와일드 카드를 ESCAPE OPTION으로 등록해야 함
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';

-- 위의 사원들이 아닌 그 외의 사원들 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE NOT EMAIL LIKE '___$_%' ESCAPE '$';     -- 가능
WHERE EMAIL NOT LIKE '___$_%' ESCAPE '$';       -- 가능

-------------------------------------- 실습문제 ------------------------------------

-- 1. EMPLOYEE에서 이름이 '연'으로 끝나는 사원들의 사원명, 입사일, 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. EMPLOYEE에서 전화번호 처음 3자리가 010이 아닌 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 3. EMPLOYEE에서 이름에 '하'가 포함되어있고, 급여가 240만원 이상인 사원들의 사원명, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND SALARY >= 2400000;

-- 4. DEPARTMENT에서 해외영업부인 부서들의 코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';     -- '%해외영업%' 도 가능

---------------------------------------------------------------------------------

/*
    < IS NULL / IS NOT NULL >
    컬럼값에 NULL이 있을 경우, NULL값 비교에 사용되는 연산자
*/

-- 보너스를 받지 않는 사원(BONUS 값이 NULL)들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS = NULL;      정상적으로 조회 안됨 ***주의***
WHERE BONUS IS NULL;

-- 보너스를 받는 사원(BONUS 값이 NULL이 아닌)들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS != NULL;     정상적으로 조회 안됨 ***주의***
WHERE BONUS IS NOT NULL;
-- WHERE NOT BONUS IS NULL;
-- NOT은 컬럼명 또는 IS 뒤에서 사용 가능

-- 사수가 없는 사원(MANAGER_ID 값이 NULL인)들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- 부서배치를 아직 받지는 않았지만(DEPT_CODE 값이 NULL인), 보너스는 받는 사원(BONUS 값이 NULL이 아닌)들의 이름, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

----------------------------------------------------------------------------------

/*
    < IN >
    비교대상컬럼값이 내가 제시한 목록중에 일치하는 값이 있는지
    
    [표현법]
    비교대상컬럼 IN ('값1', '값2', '값3', ....);
*/

-- 부서코드 'D6' 이거나 'D8' 이거나 'D5'인 부서원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';  가능하지만 길다
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- 그 외의 사람들
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D6', 'D8', 'D5');

--================================================================================

/*
    < 연산자 우선순위 >
    0. ()
    1. 산술연산자 :  +  -  /  * 
    2. 연결연산자 :  || 
    3. 비교연산자 :  >  <  =  >=  <=  !=  <>  ^= 
    4. IS NULL / LIKE '특정패턴' / IN
    5. BETWEEN AND
    6. NOT(논리연산자)
    7. AND(논리연산자)
    8. OR(논리연산자)
*/

-- 직급코드가 J7이거나 J2인 사원들 중 급여가 200만원 이상인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;

------------------------------- 실습문제 -----------------------------
-- 1. 사수가 없고, 부서배치도 받지 않은 사원들의 (사원명, 사수사번, 부서코드) 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 2. 연봉(보너스미포함)이 3000만원 이상이고, 보너스를 받지 않는 사원들의 (사번, 사원명, 급여, 보너스) 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE SALARY*12 >= 30000000 AND BONUS IS NULL;

-- 3. 입사일이 '95/01/01' 이상이고, 부서배치를 받은 사원들의 (사번, 사원명, 입사일, 부서코드) 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND DEPT_CODE IS NOT NULL;

-- 4. 급여가 200만원 이상 500만원 이하이고, 입사일이 '01/01/01' 이상이고, 보너스를 받지 않는 사원들의
-- (사번, 사원명, 급여, 입사일, 보너스) 조회
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 5000000 AND HIRE_DATE >= '01/01/01' AND BONUS IS NULL;

-- 5. 연봉(보너스포함)이 NULL이 아니고, 이름에 '하'가 포함되어 있는 사원들의 (사번, 사원명, 급여, 보너스포함연봉) 조회
SELECT EMP_ID, EMP_NAME, SALARY, (SALARY + SALARY * BONUS)*12 AS "(보너스포함)연봉"
FROM EMPLOYEE
WHERE (SALARY + SALARY * BONUS)*12 IS NOT NULL AND EMP_NAME LIKE '%하%';
--WHERE BONUS IS NOT NULL AND EMP_NAME LIKE '%하%';  <= 이것도 가능

---------------------------------------------------------------------------------
SELECT EMP_ID, EMP_NAME, SALARY --3
FROM EMPLOYEE --1
WHERE DEPT_CODE IS NULL; --2
-- 따라서 WHERE절에서 별칭을 사용할 수 없음 --

--===============================================================================
/*
    < ORDER BY 절 >
    가장 마지막 줄에 작성! 뿐만아니라 실행순서 또한 마지막에 실행
    
    [표현법]
    SELECT 조회할 컬럼, 컬럼, 산술연산식 AS "별칭", ..
    FROM 조회할 테이블명
    WHERE 조건식
    ORDER BY 정렬하고싶은컬럼|별칭|컬럼순번 [ASC|DESC] [NULLS FIRST | NULLS LAST]
    
    - ASC   : 오름차순 정렬 (생략시 기본값)
    - DESC  : 내림차순 정렬
    
    - NULLS LAST    : 정렬하고자 하는 컬럼값에 NULL이 있을 경우, 해당 데이터를 맨 '뒤'에 배치 (생략시 ASC일때의 기본값)
    - NULLS FIRST   : 정렬하고자 하는 컬럼값에 NULL이 있을 경우, 해당 데이터를 맨 '앞'에 배치 (생략시 DESC일때의 기본값)
*/

SELECT *
FROM EMPLOYEE
--ORDER BY BONUS;
--ORDER BY BONUS ASC;               -- 오름차순(ASC) 정렬일 때 기본적으로 NULLS LAST 구나!
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC;              -- 내림차순(DESC) 정렬일 때 기본적으로 NULLS FIRST 구나!
--ORDER BY BONUS DESC NULLS LAST;
ORDER BY BONUS DESC, SALARY ASC;    -- 정렬기준 여러개 제시 가능 (첫번째 기준의 컬럼값이 동일한 경우, 두번째 기준 컬럼가지고 정렬)

-- 전체 사원의 사원명, 연봉 조회 (이때 연봉별 내림차순 정렬 조회)
SELECT EMP_NAME, SALARY*12 AS "연봉"  --2
FROM EMPLOYEE   --1
--ORDER BY SALARY*12 DESC;
--ORDER BY 연봉 DESC;   --3 (가장 마지막 우선순위를 갖기 때문에 별칭 사용 가능)
ORDER BY 2 DESC;        -- (컬럼 순서 사용 가능. 단, 컬럼 개수보다 큰 숫자 안됨)

-- ** 내림차순(NULL, 9, 8 ... 1) 그치만 NULL값이 뒤로 가도록 해보자! (9, 8, ... 1, NULL)
SELECT EMP_NAME, BONUS
FROM EMPLOYEE
ORDER BY 2 DESC NULLS LAST;

