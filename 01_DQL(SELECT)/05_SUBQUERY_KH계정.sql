/*
    * 서브쿼리 (SUBQUERY) == '부조회'
    - 하나의 SQL문 안에 포함된 또 다른 SELECT문
    - 메인 SQL문을 위해 보조 역할을 하는 쿼리문
*/

-- 간단 서브쿼리 예시 1
-- 노옹철 사원과 같은 부서에 속한 사원들 조회하고 싶음
-- 1) 먼저 노옹철 사원의 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';     --D9

-- 2) 부서코드가 D9인 사원들 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 위의 1, 2를 하나의 쿼리문으로..
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '노옹철');
                   
-- 간단 서브쿼리 예시 2
-- 전 직원의 평균급여보다 더 많은 급여를 받는 사원들의 사번, 이름, 직급코드, 급여 조회
-- 1) 전 직원의 평균 급여 조회
SELECT AVG(SALARY)
FROM EMPLOYEE;      -- 대략 3047663원 인걸 알아냄

-- 2) 급여가 3047663원 이상인 사원들 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047663;

-- 위의 1, 2를 하나의 쿼리문으로..
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM EMPLOYEE);
                
---------------------------------------------------------------------------------
/*
    * 서브쿼리의 구분
      서브쿼리 수행한 결과값이 몇 행 몇 열이냐에 따라서 분류됨
      
      - 단일행 서브쿼리 : 서브쿼리의 조회 결과값의 개수가 오로지 1개 일때 (한 행 한 열) /
      - 다중행 서브쿼리 : 서브쿼리의 조회 결과값이 여러행 일때 (여러행 한열) => 동명이인 노옹철 / IN, ANY, ALL
      - 다중열 서브쿼리 : 서브쿼리의 조회 결과값이 한 행이지만 컬럼이 여러개일 때 (한 행 여러 열) / = > <
      - 다중행 다중열 서브쿼리 : 서브쿼리 조회 결과값이 여러행 여러컬럼일 때 (여러행 여러열) / () IN ()
      
      >> 서브쿼리 종류가 뭐냐에 따라서 서브쿼리 앞에 붙는 연산자가 달라짐!! *** 중요 ***
*/

--==================================< 단일행 서브쿼리 >===================================
/*
    1. 단일행 서브쿼리 (SINGLE ROW SUBQUERY)
    서브쿼리의 조회 결과값의 개수가 오로지 1개일 때 (한행 한열)
    일반 비교 연산자 사용 가능
    =, !=, ^=, <>, <, >, >=, <= ...
*/

-- 1) 전 직원의 평균급여'보다 급여를 더 적게 받는 사원들의 사원명, 직급코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)     
                FROM EMPLOYEE);         -- 3047662.6 전직원의 평균 급여
                
-----------------------------------------               
-- 2) 최저 급여'를 받는 사원의 사번, 이름, 급여, 입사일
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)     
                FROM EMPLOYEE);         -- 1380000 전직원들중 최저 급여
                
-----------------------------------------                
-- 3) 노옹철 사원의 급여'보다 더 많이 받는 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY         
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');  -- 3700000 노옹철 사원의 급여
                
-- >> 오라클 전용구문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE (DEPT_CODE = DEPT_ID)
AND SALARY > (SELECT SALARY
              FROM EMPLOYEE
              WHERE EMP_NAME = '노옹철');

-- >> ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');

-----------------------------------------               
-- 4) 부서별: 급여합이 가장 큰 부서'의 부서코드, 급여 합 조회
-- 4_1) 먼저 부서별 급여합 중에서도 가장 큰 값 하나만 조회
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE; --17700000

-- 4_2) 부서별 급여합이 177700000원인 부서 조회 (부서코드, 급여합)
SELECT DEPT_CODE, SUM(SALARY)       -- GROUP으로 묶은것들의 합계니까, 그룹함수여도 단일행함수 같이 쓸 수 있음
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;

-- 위의 두 단계를 하나의 쿼리문으로..
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);

-----------------------------------------                       
-- 직접해보자
-- 전지연 사원과 같은 부서'원들의 사번, 사원명, 전화번호, 입사일, 부서명
-- 단, 전지연은 제외!
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '전지연') -- D1
AND EMP_NAME != '전지연';

-- >> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_CODE = (SELECT DEPT_CODE
                 FROM EMPLOYEE
                 WHERE EMP_NAME = '전지연') -- D1
AND EMP_NAME != '전지연';

-- >> ANSI 구문
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '전지연') -- D1
AND EMP_NAME != '전지연';

--==================================< 다중행 서브쿼리 >===================================
/*
    2. 다중행 서브쿼리 (MULTI ROW SUBQUERY)
    서브쿼리를 수행할 결과값이 여러 행 일때 (컬럼(열)의 한개)
    
    - IN 서브쿼리 : 여러개의 결과값 중에서 한개라도 일치하는 값이 있다면   // '=' 대신 같은 느낌
    
    - > ANY 서브쿼리 : 여러개의 결과값 중에서 '한개라도' 클 경우 (여러개의 결과값 중에서 가장 작은 값 보다 클 경우)
    - < ANY 서브쿼리 : 여러개의 결과값 중에서 '한개라도' 작을 경우 (여러개의 결과값 중에서 가장 큰 값 보다 작은 경우)

    비교대상 > ANY (값1, 값2, 값3)
    비교대상 > 값1 OR 비교대상 > 값2 OR 비교대상 > 값3                  // > <  대신?
    
    - > ALL 서브쿼리 : 여러개의 '모든' 결과값들 보다 클 경우
    - < ALL 서브쿼리 : 여러개의 '모든' 결과값들 보다 작을 경우
    
    비교대상 > ALL (값1, 값2, 값3)
    비교대상 > 값1 AND 비교대상 > 값2 AND 비교대상 > 값3
    
*/

-- 1) 유재식 또는 윤은해 사원과 같은 직급'인 사원들의 사번, 사원명, 직급코드, 급여
-- 1_1) 유재식 또는 윤은해 사원이 어떤 직급인지 조회
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('유재식', '윤은해');   -- J3, J7

-- 1_2) J3, J7인 직급의 사원들 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');

-- 위의 두 단계를 하나의 쿼리문으로..
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME IN ('유재식', '윤은해'));      -- J3, J7 (다중행)
                   -- = 이라고 쓰면 오류!! 여러 행으로 조회했기 때문
                   -- 만약에 결과값이 여러 개 나올 것 같으면 그냥 안전하게 IN 으로 가자
                   
----------------------------------------
-- 사원 => 대리 => 과장 => 차장 => 부장 ..
-- 2) (대리 직급임에도 불구하고) 과장 직급 급여들' 중 최소 급여보다 < 많이 받는 (대리)직원 조회 (사번, 이름, 직급, 급여)
-- 2_1) 먼저 과장 직급인 사원들의 급여 조회
SELECT SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND J.JOB_NAME = '과장';  -- 2200000 2500000 3760000 (과장들의 급여)

-- 2_2) 직급이 대리이면서 급여값이 위의 목록들 값 중에 하나라도 큰 사원
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > ANY (2200000, 2500000, 3760000);       -- 이 중 하나의 값보다 크기만 하면 됨! (ANY!!)

-- 위의 두 단계를 하나의 쿼리문으로..
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > ANY (SELECT SALARY
                  FROM EMPLOYEE E, JOB J
                  WHERE E.JOB_CODE = J.JOB_CODE
                  AND J.JOB_NAME = '과장');

-- 사실 단일행 서브쿼리로도 가능!
-- 나의 쿼리
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE SALARY > (SELECT MIN(SALARY)
                FROM EMPLOYEE
                JOIN JOB USING (JOB_CODE)
                WHERE JOB_NAME = '과장')  -- 2200000 (과장들 중 최소 급여)
AND JOB_NAME = '대리';

-- 수업
/*
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > (SELECT MIN(SALARY)
                  FROM EMPLOYEE E, JOB J
                  WHERE E.JOB_CODE = J.JOB_CODE
                  AND JOB_NAME = '과장');
*/
-----------------------------------------                  
-- 3) (과장 직급임에도 불구하고) 차장 직급인 사원들의 모든 급여'보다도 더 많이 받는 사원들의 사번, 이름, 직급명, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '과장'
AND SALARY > ALL (SELECT SALARY
                    FROM EMPLOYEE E, JOB J
                    WHERE E.JOB_CODE = J.JOB_CODE
                    AND JOB_NAME = '차장');         -- 2800000, 1550000, 2490000, 2480000 (차장들의 급여)
                                                    -- 이 모두의 값보다 커야함 (ALL!!)

--==================================< 다중열 서브쿼리 >===================================
/*
    3. 다중열 서브쿼리
    결과값은 한 행이지만 나열된 컬럼수가 여러개일 경우
*/

-- 1) '하이유' 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원들 조회 (사원명, 부서코드, 직급코드, 입사일자)
-- 단일행 서브쿼리 ** 2개의 서브쿼리로 작성할 것!
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '하이유')      -- D5 (DEPT_CODE)
AND JOB_CODE = (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '하이유');     -- J5 (JOB_CODE)

-- >> 다중열 서브쿼리로
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
--WHERE (DEPT_CODE, JOB_CODE) = (하이유 사원의 부서코드 하이유 사원의 직급코드);
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE                      -- D5, D6
                               FROM EMPLOYEE
                               WHERE EMP_NAME = '하이유'); -- 순서 중요함!!, 개수 맞춰야함!!

--------------------------------------------
-- '박나라' 사원과 같은 직급코드, 같은 사수를 가지고 있는 사원들의 사번, 사원명, 직급코드, 사수사번 조회
-- 단일행 서브쿼리
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE JOB_CODE = (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '박나라')     -- J7 (JOB_CODE)
AND MANAGER_ID = (SELECT MANAGER_ID
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '박나라');    -- 207 (MANAGER_ID)
                    
-- 다중열 서브쿼리
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '박나라');      -- J7, 207 (JOB_CODE, MANAGER_ID)



-- 1. 찾고자하는 핵심!! (메인 컬럼)이 무엇인지 생각
-- 2. 부조회 : 'SELECT 메인 컬럼' 을 필두로 촤라락 작성
-- 3. 메인조회 : WHERE 절에 (메인컬럼) = (부조회)

--==================================< 다중열 다중열 서브쿼리 >===================================
/*
    4. 다중행 다중열 서브쿼리
    서브쿼리 조회 결과값이 여러행, 여러열 인 경우
*/

-- 1) 각 직급별 최소 급여'를 받는 사원 조회 (사번, 사원명, 직급코드, 급여)

-- >> 각 직급별 최소 급여 조회
SELECT JOB_CODE, MIN(SALARY)    -- 3
FROM EMPLOYEE   -- 1
GROUP BY JOB_CODE;   -- 2                       -- J1, J2, J3 ... J7 : 여러행

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000
OR    JOB_CODE = 'J7' AND SALARY = 1380000;     -- (JOB_CODE, SALARY) : 여러열
... -- 너무 많아..

-- 서브쿼리를 적용해서 해보자
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE); -- 서브쿼리가 다중행, 다중열

-- 2) 각 부서별 최고 급여를 받는 사원 조회 (사번, 사원명, 직급코드, 급여)
-- >> 각 부서별 최고 급여 조회
SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                              FROM EMPLOYEE
                              GROUP BY DEPT_CODE);
                              
--=====================================< 인라인 뷰 >==========================================
/*
    5. 인라인 뷰 (INLINE - VIEW)
    
    서브쿼리를 수행한 결과를 마치 테이블처럼 사용! ( WHERE 절에서 별칭 사용 가능!)
*/

-- 사원들의 사번, 이름, 보너스 포함 연봉 (별칭부여 : 연봉), 부서코드 조회 => 보너스 포함 연봉이 절대 NULL이 안나오게
-- 단, 보너스 포함 연봉이 3000만원 이상인 사원들만 조회
-- (급여 + 급여 * 보너스)*12
SELECT EMP_NO, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0))*12 AS "연봉", DEPT_CODE   -- 3
FROM EMPLOYEE   -- 1
WHERE (SALARY + SALARY * NVL(BONUS, 0))*12 >= 30000000; -- 2

SELECT EMP_NO, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0))*12 AS "연봉", DEPT_CODE
FROM EMPLOYEE;
-- 이 조회 결과를 마치 존재하는 테이블인 것 마냥 사용할 수 있음!! 그게 바로 인라인뷰!

SELECT EMP_NO, EMP_NAME, 연봉, DEPT_CODE  -- ,MANAGER_ID 불가. 내가 각색한 테이블에 없기 때문
FROM (SELECT EMP_NO, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0))*12 AS "연봉", DEPT_CODE
FROM EMPLOYEE)  -- 1
WHERE 연봉 >= 30000000;   -- 2 (별칭을 적어!!)

-- >> 인라인 뷰를 주로 사용하는 예  =>  TOP-N 분석 (상위 몇개만 보여주고 싶을 때 : BEST 상품!)

-- 전 직원 중 급여가 가장 높은 상위 5명만 조회

-- * ROWNUM : 오라클에서 제공해주는 컬럼, 조회된 순서대로 1부터 순번을 부여해주는 컬럼

SELECT ROWNUM, EMP_NAME, SALARY --2
FROM EMPLOYEE   --1
ORDER BY SALARY DESC;   --3
-- FROM -> SELECT ROWNUM (이때 순번이 부여됨. 정렬도 하기전에 이미 순번 부여)
--> 뭔가 좀 이상함.. => 실행순서 때문!

SELECT ROWNUM, EMP_NAME, SALARY --2
FROM EMPLOYEE   --1
WHERE ROWNUM <= 5   --3
ORDER BY SALARY DESC;   --4
--> 정상적인 결과가 조회되지 않음!! (SALARY 로 정렬이 되기도 전에 5명이 추려지고나서 정렬)

-- ORDER BY 절이 다 수행된 결과를 가지고, ROWNUM 부여 후, 5명 추려야함
SELECT EMP_NAME, SALARY, DEPT_CODE  --2
FROM EMPLOYEE   --1
ORDER BY SALARY DESC; -- 3 정렬끝

-- 위 정렬끝난거 갖고와서 ROWNUM 순번 부여
SELECT ROWNUM, EMP_NAME, SALARY     --3
FROM (SELECT EMP_NAME, SALARY, DEPT_CODE
        FROM EMPLOYEE
        ORDER BY SALARY DESC)   --1
WHERE ROWNUM <= 5;  --2

-- ROWNUM 이랑 전체컬럼 조회하고 싶음 => 오류!!
SELECT ROWNUM, * --EMP_NAME, SALARY     --3
FROM (SELECT * --EMP_NAME, SALARY, DEPT_CODE
        FROM EMPLOYEE
        ORDER BY SALARY DESC)   --1
WHERE ROWNUM <= 5;

--> 별칭 부여하는 방법으로
SELECT ROWNUM, E.* --EMP_NAME, SALARY     --3
FROM (SELECT * --EMP_NAME, SALARY, DEPT_CODE
        FROM EMPLOYEE
        ORDER BY SALARY DESC) E  --1
WHERE ROWNUM <= 5;

-------------------------------
-- 1. 가장 최근에 입사한 사원 5명 조회 (사원명, 급여, 입사일)
SELECT * --EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;     --정렬끝

--> ROWNUM
SELECT *    --ROWNUM, EMP_NAME, SALARY, HIRE_DATE
FROM (SELECT EMP_NAME, SALARY, HIRE_DATE
        FROM EMPLOYEE
        ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <= 5;
--> RANK() OVER (정렬기준)
SELECT *   --EMP_NAME, SALARY, HIRE_DATE, 순위
FROM (SELECT EMP_NAME, SALARY, HIRE_DATE, RANK() OVER(ORDER BY HIRE_DATE DESC) AS "순위"
        FROM EMPLOYEE)
WHERE 순위 <= 5;

-- 2. 각 부서별 평균급여가 가장 높은 3개의 부서 조회 (부서코드, 평균급여)
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY AVG(SALARY) DESC;   --정렬끝

SELECT ROWNUM, E.*
FROM (SELECT DEPT_CODE, FLOOR(AVG(SALARY))
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY AVG(SALARY) DESC) E
WHERE ROWNUM <= 3;

SELECT ROWNUM, DEPT_CODE, FLOOR(AVG(SALARY)     -- 얘는 왜 안돼? 그룹으로 묶은적이 없으니까 그룹함수도 쓸 수 없지..
FROM (SELECT DEPT_CODE, FLOOR(AVG(SALARY))
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY AVG(SALARY) DESC) 
WHERE ROWNUM <= 3;


-- 별칭줘서도 해보자
SELECT ROWNUM, FLOOR(평균급여)
FROM (SELECT DEPT_CODE, AVG(SALARY) AS "평균급여"
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM <= 3;

----------------------------------------------------------------------------------
/*
    * 순위 매기는 함수 ( WINDOW FUNCTION )
      RANK() OVER(정렬기준)               |               DENSE_RANK() OVER(정렬기준)
    
    - RANK() OVER(정렬기준) : 동일한 순위 이후의 등수를 동일한 인원수 만큼 건너뛰고 순위 계산
                             EX) 공동 1위가 2명 그 다음 순위는 3위                                   => 공동1등, 공동1등, 3등 (1,1,3)
    - DENSE_RANK() OVER(정렬기준) : 동일한 순위가 있다고 해도 그 다음 등수를 무조건 1씩 증가시킴
                                   EX) 공동1위가 2명이더라도 그 다음 순위를 2위                       => 공동1등, 공동1등, 2등 (1,1,2)
    >> 두 함수는 무조건 SELECT절에서만 사용 가능!!
*/

-- 급여가 높은 순대로 순위를 매겨서 조회
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE;
-- 공동 19위 2명 그 뒤의 순위는 21 => 마지막 순위랑 조회된 행 수랑 같음

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE;
-- 공동 19위 2명 그 뒤의 순위는 20 => 마지막 순위랑 조회된 행 수가 다름


-- 상위 5명만 조회
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE;
--WHERE 순위 <= 5; --2 .불가능 별칭사용불가능
--WHERE RANK() OVER(ORDER BY SALARY DESC) <= 5; -- RANK는 SELECT절에서만 사용 가능

-- 결국, 인라인뷰를 쓸 수 밖에 없음!
SELECT *
FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS "순위"
        FROM EMPLOYEE)
WHERE 순위 <= 5;
