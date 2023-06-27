/*
    < GROUP BY 절 >
    그룹기준을 제시할 수 있는 구문 (해당 그룹 기준별로 여러 그룹을 묶을 수 있음)
    여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
*/

SELECT SUM(SALARY)
FROM EMPLOYEE;  --> 전체 사원을 하나의 그룹으로 묶어서 총 합을 구한 결과

-- 각 부서별 총 급여 합
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 사원 수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)   -- 3
FROM EMPLOYEE   -- 1
GROUP BY DEPT_CODE -- 2
ORDER BY DEPT_CODE; -- 4

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- 각 직급별
SELECT JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 각 직급별 총 사원수, 보너스를 받는 사원수, 급여 합, 평균급여, 최저급여, 최대급여 (별칭지어서) + 직급명 오름차순 정렬
SELECT JOB_CODE AS "직급", COUNT(*) AS "총 사원수", COUNT(BONUS) AS "보너스를 받는 사원수",
       SUM(SALARY) AS "급여 합", ROUND(AVG(SALARY)) AS "평균급여",
       MIN(SALARY) AS "최저급여", MAX(SALARY) AS "최대급여"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;
-- ORDER BY 1;  이것도 가능 (JOB_CODE가 1열이니까)

-- GROUP BY 절에 함수식 기술 가능
-- 남/여별 총 사원 수
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여'), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

-- GROUP BY 절에 여러 컬럼 기술 가능
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1;

--===========================================================================================
/*
    < HAVING 절 >
    그룹에 대한 조건을 제시할 때 사용되는 구문 (주로 그룹함수식을 가지고 조건을 제시할 때 사용)
*/

-- 각 부서별 평균 급여 조회 (부서코드, 평균급여)
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

-- 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE AVG(SALARY) >= 3000000    -- 오류!! (그룹함수 가지고 조건 제시시 WHERE 절에서 안됨)
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, AVG(SALARY)   -- 4
FROM EMPLOYEE   -- 1
GROUP BY DEPT_CODE  -- 2
HAVING AVG(SALARY) >= 3000000;  -- 3

-- 직급별 총 급여합 (단 직급별 급여합 1000만원 이상인 직급만을 조회). 직급코드, 급여합 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

SELECT *
FROM EMPLOYEE;

-- 부서별 보너스를 받는 사원이 없는 부서만을 조회. 부서코드, 보너스를 받는 사원의 수 조회
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

---------------------------------------------------------------------------------
/*
    < SELECT문 실행 순서 >
    5. SELECT *|조회하고자 하는 컬럼 별칭 | 산술식 "별칭" | 함수식 AS "별칭"
    1. FROM 조회하고자 하는 테이블명
    2. WHERE 조건식 (연산자들 가지고 기술)
    3. GROUP BY 그룹기준으로 삼을 컬럼 | 함수식
    4. HAVING 조건식 (그룹함수를 가지고 기술)
    6. ORDER BY 컬럼명 | 컬럼순서 | 별칭 [ 'ASC' | 'DESC' ] { NULLS FIRST | NULLS LAST }
*/

--===========================================================================================
/*
    < 집합 연산자 == SET OPERATION >
    
    여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
    
    - UNION         : OR | 합집합 (두 쿼리문 수행한 결과값을 더한 후 중복되는 값은 한번만 더해지도록)
    - INTERSECT     : AND | 교집합 (두 쿼리문 수행한 결과값에 중복된 결과값)
    - UNION ALL     : 합집합 + 교집합 (중복된 부분이 두 번 표현될 수 있음)
    - MINUS         : 선행 결과값에서 후행 결과값을 뺀 나머지 (차집합)
*/

-- 부서코드가 D5인 사원 또는 급여가 300만원 초과인 사원들 조회 (사번, 이름, 부서코드, 급여)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; -- 6개행 (박나라, 하이유, 김해술, 심봉선, 윤은해, 대북혼)

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8개행 (선동일, 송종기, 노홍철, 유재석, 정중하, 심봉선, 대북혼, 전지연)

-- 1. UNION(합집합)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 위의 쿼리문 대신 아래처럼 WHERE 절에 OR 써도 해결 가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

---------------------------------------------------------------------------------
-- 2. INTERSECT(교집합)
-- 부서코드가 D5 이면서 급여까지도 300만원 초과인 사원 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 위의 쿼리문 대신 아래처럼 WHERE 절에 AND 써도 해결 가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

---------------------------------------------------------------------------------

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- 오류!! 각 쿼리문의 SELECT절에 작성되어있는 컬럼 개수 동일해야됨

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, BONUS -- HIRE_DATE는 불가능 (날짜타입)
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- 컬럼 개수 뿐만 아니라 각 컬럼 자리마다 동일한 타입으로 기술해야함

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
--ORDER BY EMP_NAME
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, BONUS -- HIRE_DATE는 불가능 (날짜타입)
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_NAME;
-- ORDER BY 절을 붙이고자 한다면 마지막에 한번 기술히야함

---------------------------------------------------------------------------------
-- 3. UNION ALL : 여러개의 쿼리 결과를 무조건 다 더하는 연산자 (중복값 나옴)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

----------------------------------------------------------------------------------
-- 4. MINUS : 선행 SELECT 결과에서 후행 SELECT 결과를 뺀 나머지 (차집합)
-- 부서코드가 D5인 사원들 중 급여가 300만원 초과한 사원들을 제외해서 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 위 쿼리문 대신 아래처럼도 가능하긴 함
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;
