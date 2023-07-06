--=======================================< // 단일행 함수 // >=========================================
/*
    < 함수 FUNCTION >
    전달된 컬럼값을 읽어들여서 함수를 실행한 결과를 반환함
    
    - 단일행 함수 : N개의 값을 읽어들여서 N개의 결과값을 리턴 (매행마다 함수 실행 결과 반환)
    - 그룹 함수 : N개의 값을 읽어들여서 1개의 결과값을 리턴 (그룹을 지어 그룹별로 함수 실행 결과 반환)
    
    >> SELECT 절에 단일행함수, 그룹함수를 함께 사용 못함
    왜? 결과 행의 개수가 다르기 때문
    
    >> 함수식을 기술할 수 있는 위치 : SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절
*/

--======================================= 문자 처리 함수 =========================================
/*  
    * LENGTH / LENGTHB      => 결과값 NUMBER 타입
    
    LENGTH(컬럼|'문자열값')   : 해당 문자열 값의 글자 수 반환
    LENGTHB(컬럼|'문자열값')  : 해당 문자열 값의 바이트 수 반환
    
    '김', '나', 'ㄱ' 한 글자당 3BYTE
    영문자, 숫자, 특문 한 글자당 1BYTE
*/

SELECT SYSDATE
FROM DUAL;  -- 가상테이블 : 테이블 쓸 거 없을 때 쓰는것

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL;

SELECT LENGTH('ORACLE'), LENGTH('ORACLE')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
        EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;  -- 매행마다 다 실행되고 있음 => 단일행 함수

---------------------------------------------------------------------------------
/*
    * INSTR
    문자열로부터 특정 문자의 시작위치를 찾아서 반환
    
    INSTR(컬럼|'문자열', '찾고자하는 문자', ['찾을 위치의 시작값'], [순번])   => 결과값은 NUMBER 타입
    
    찾을위치의 시작값
    1   : 앞에서부터 찾겠다.
    -1  : 뒤에서부터 찾겠다.
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;        --(3) 찾을 위치의 시작값은 1 기본값 => 앞에서부터 찾음, 순번도 1 기본값
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;     --(3)
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;    --(10)
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;  --(9)
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL;  --(3)

--SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_위치", INSTR(EMAIL, '@') AS "@위치"
SELECT EMAIL, INSTR (EMAIL, '_')
FROM EMPLOYEE;


---------------------------------------------------------------------------------
/*
    * SUBSTR
    문자열에서 특정 문자열을 추출해서 반환 (자바에서 SUBSTRING() 메소드와 유사)
    
    SUBSTR(STRING, POSITION, [LENGTH])  => 결과값이 CHARACTER 타입
    - STRING    : 문자타입컬럼 또는 '문자열값'
    - POSITION  : 문자열을 추출할 시작 위치값
    - LENGTH    : 추출할 문자 개수 (생락시 끝까지 의미)
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;       --(THEMONEY)
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;    --(ME)
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;    --(SHOWME)
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;   --(THE)

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "성별"
FROM EMPLOYEE;

-- 여자 사원만 조회
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- 남자 사원만 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (1,3)    -- 내부적으로 자동 형변환
ORDER BY 1;                            -- 기본적으로는 오름차순

-- 함수 중첩 사용
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS "아이디"
FROM EMPLOYEE;

---------------------------------------------------------------------------------
/*
    *LPAD / RPAD
    문자열을 조회할 때 통일감있게 조회하고자 할 때 사용
    
    LPAD / RPAD (STRING, 최종적으로 반환할 문자의 길이, [덧붙이고자하는 문자])
    
    문자열에 덧붙이고자하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이 만큼의 문자열을 반환
*/

SELECT EMP_NAME, RPAD(EMAIL, 20)    -- 덧붙이고자하는 문자 생략시 기본값이 공백
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850101-2****** 출력
SELECT RPAD('850101-2', 14, '*')
FROM DUAL;

SELECT EMP_NAME, RPAD(주민번호값으로 성별자리까지 추출한 문자열, 14, '*')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8) || '*******'
FROM EMPLOYEE;

---------------------------------------------------------------------------------
/*
    LTRIM / RTRIM
    문자열에서 특정 문자를 제거한 나머지를 반환
    
    LTRIM / RTRIM (STRING, ['제거할문자들'])  => 생략하면 공백 제거
    
    문자열의 왼쪽 혹은 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거 후 문자열 반환
*/

SELECT LTRIM('      K  H  ') FROM DUAL; -- 공백 찾아서 계속 제거하고, 공백 아닌 문자 나오면 끝나서 반환
SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL; -- 제거할 문자가 있기만 하면 순서 상관없이 제거
SELECT RTRIM('5782KH123', '0123456789') FROM DUAL;

/*
    * TRIM
    문자열의 앞 / 뒤 / 양쪽에 지정한 문자들을 제거한 나머지 문자열 반환
    
    TRIM([[LEADING, TRAILING, 'BOTH'] 제거하고자 하는 문자들 FROM] STRING) 
*/

-- 기본적으로는 양쪽에 있는 문자들 다 찾아서 제거
SELECT TRIM('      K  H    ') FROM DUAL;
--SELECT TRIM('ZZZZKHKZZZZ', 'Z') FROM DUAL;  -- 불가능
SELECT TRIM('Z' FROM 'ZZZZKHZZZZ') FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL;   -- LEADING : 앞 제거 => LTRIM과 유사
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL;  -- TRAILING : 뒤 제거 => RTRIM과 유사
SELECT TRIM(BOTH 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL;      -- BOTH : 양쪽 다 제거 => 생략시 기본값 

/*
    * LOWER / UPPER / INITCAP
    
    LOWER / UPPER / INITCAP (STRING)    => 결과값은 CHARACTER 타입
    
    LOWER   : 전부 다 소문자로 변경한 문자열 반환 (자바에서의 toLowerCase() 메소드와 유사)
    UPPER   : 전부 다 대문자로 변경한 문자열 반환 (자바에서의 toUpperCase() 메소드와 유사)
    INITCAP : 단어 앞글자마다 대문자로 변경한 문자열 반환
*/

SELECT LOWER('Welcome To My World!') FROM DUAL;
SELECT UPPER('Welcome To My World!') FROM DUAL;
SELECT INITCAP('Welcome To My World!') FROM DUAL;

---------------------------------------------------------------------------------
/*
    * CONCAT
    문자열 두개 전달받아 하나로 합친 후 결과 반환
    
    CONCAT(STRING, STRING)  => 결과값 CHARACTER 타입
*/

SELECT CONCAT('ABC', '초콜릿', '123') FROM DUAL;   -- 오류발생!! : 2개만 받을 수 있음
SELECT 'ABC' || '초콜릿' || '123' FROM DUAL;

---------------------------------------------------------------------------------
/*
    * REPLACE
    
    REPLACE(STRING, STR1, STR2)     => 결과값은 CHARACTER 타입
*/

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;

--======================================= 숫자 처리 함수 =========================================
/*
    * ABS
    숫자의 절대값을 구해주는 함수
    
    ABS(NUMBER)     => 결과값은 NUMBER 타입
*/

SELECT ABS(-10) FROM DUAL;
SELECT ABS(-5.7) FROM DUAL;

---------------------------------------------------------------------------------
/*
    * MOD
    두 수를 나눈 나머지값을 반환해주는 함수 (자바의 % 연산자와 유사)
    
    MOD(NUMBER, NUMBER)     => 결과값 NUMBER 타입
*/

SELECT MOD(10,3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

---------------------------------------------------------------------------------
/*
    * ROUND
    반올림한 결과를 반환
    
    ROUND(NUMBER, [위치])     => 결과값은 NUMBER 타입
*/

SELECT ROUND(123.456) FROM DUAL;        --(123) 위치 생략시 0
SELECT ROUND(123.456, 0) FROM DUAL;     --(132)
SELECT ROUND(123.456, 1) FROM DUAL;     --(132.5)
SELECT ROUND(123.456, 5) FROM DUAL;     --(123.456) 소수점보다 큰 값 넣으면 걍 원본 그대로 출력
SELECT ROUND(123.456, -1) FROM DUAL;    --(120)
SELECT ROUND(123.456, -2) FROM DUAL;    --(100)

---------------------------------------------------------------------------------
/*
    * CEIL
    (무조건) 소수점에서 올림처리 해주는 함수
    
    CEIL(NUMBER)
*/

SELECT CEIL(123.152) FROM DUAL;     -- 5이상 아니어도 무조건!! 올림 / 위치 지정 불가

---------------------------------------------------------------------------------
/*
    * FLOOR
    (무조건)소수점 아래 버림처리하는 함수
    
    FLOOR(NUMBER)
*/

SELECT FLOOR(123.152) FROM DUAL;    -- 5이상 아니어도 무조건!! 버림 / 위치 지정 불가
SELECT FLOOR(123.952) FROM DUAL;

---------------------------------------------------------------------------------
/*
    * TRUNC (절삭하다)
    소수점 위치 지정하여 버림처리해주는 함수
    TRUNC(NUMBER, [위치])
*/

SELECT TRUNC(123.456) FROM DUAL;        --(123) 위치지정 안하면 FLOOR와 동일함 (그냥 버림)
SELECT TRUNC(123.456, 1) FROM DUAL;     --(123.4) 소수점 아래 첫째자리까지 표현
SELECT TRUNC(123.456, 2) FROM DUAL;     --(123.45)
SELECT TRUNC(123.456, -1) FROM DUAL;    --(120)

--======================================= 날짜 처리 함수 =========================================
/*
    * SYSDATE : 시스템 날짜 및 시간 반환 (현재 날짜 및 시간)
*/
SELECT SYSDATE FROM DUAL;

---------------------------------------------------------------------------------
/*
    * MONTHS_BETWEEN(DATE1, DATE2) : 두 날짜 사이의 개월 수 => 내부적으로 DATE1 - DATE2 후 나누기 30,31 이 진행됨
                                     => 결과값은  NUMBER 타입
*/
-- EMPLOYEE 에서 사원명, 입사일, 근무일수, 근무개월수, 근무년수
SELECT EMP_NAME, HIRE_DATE, 
FLOOR(SYSDATE - HIRE_DATE) || '일' AS "근무일수",
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' AS "근무개월수",
FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) || '년' AS "근무년수"
FROM EMPLOYEE;

---------------------------------------------------------------------------------
/*
    * ADD_MONTHS(DATE, NUMBER) : 특정날짜에 해당 숫자만큼의 개월수를 더해서 날짜를 반환
                                => 결과값은 DATE 타입
*/
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;

-- EMPLOYEE 에서 사원명, 입사일, 입사후 6개월이 된 날짜 조회
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6) AS "수습이 끝난 날짜" 
FROM EMPLOYEE;

---------------------------------------------------------------------------------
/*
    * NEXT_DAY(DATE, 요일) : 특정날짜 이후에 가까운 해당 요일의 날짜를 반환해주는 함수
                             => 결과값은 DATE 타입
*/
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;
-- 1.일, 2.월, 3.화, .... 7.토
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY('20230329', 7) FROM DUAL;
SELECT SYSDATE, NEXT_DAY('2023/03/29', 7) FROM DUAL;
SELECT SYSDATE, NEXT_DAY('23/03/29', 7) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;  -- 불가능. 현재 언어가 KOREAN 이기 때문

-- 언어 변경
SELECT * FROM NLS_SESSION_PARAMETERS;

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

---------------------------------------------------------------------------------
/*
    * LAST_DAY(DATE) : 해당 월의 마지막 날짜를 구해서 반환
                        => 결과값은 DATE 타입
*/
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE 에서 사원명, 입사일, 입사한 달의 마지막 날짜, 입사한 달에 근무한 일수
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

---------------------------------------------------------------------------------
/*
    * EXTRACT : 특정 날짜로부터 년도|월|일 값을 추출해서 반환하는 함수
    
    EXTRACT(YEAR FROM DATE)     : 년도만 추출
    EXTRACT(MONTH FROM DATE)    : 월만 추출
    EXTRACT(DAY FROM DATE)      : 일만 추출
    
    => 결과값은 NUMBER 타입
*/

-- 사원명, 입사년도, 입사월, 입사일 조회
SELECT EMP_NAME,
        EXTRACT(YEAR FROM HIRE_DATE) AS "입사년도",
        EXTRACT(MONTH FROM HIRE_DATE) AS "입사월",
        EXTRACT(DAY FROM HIRE_DATE) AS "입사일"
FROM EMPLOYEE
ORDER BY "입사년도", "입사월", "입사일";

SELECT EXTRACT (YEAR FROM SYSDATE)
FROM DUAL;

--======================================= 형변환 함수 =========================================
/*
    * TO_CHAR : 숫자 타입 또는 날짜 타입의 값을 문자타입으로 변환시켜주는 함수
    
    TO_CHAR(숫자|날짜, [포맷])    => 결과값은 CHARACTER 타입
*/

-- 숫자타입 => 문자타입
SELECT TO_CHAR(1234) FROM DUAL; --'1234' 로 바뀌어 있는거임
SELECT TO_CHAR(1234, '99999') FROM DUAL;    --( 1234) 5칸짜리 공간 확보, 오른쪽 정렬, 빈칸 공백     // 9 : 빈자리 공백
SELECT TO_CHAR(1234, '00000') FROM DUAL;    --(01234)                                          // 0 : 빈자리  0
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;   --(￦1234) 현재 설정된 나라(LOCAL)의 화폐단위
SELECT TO_CHAR(1234, '$99999') FROM DUAL;   --($1234)

SELECT TO_CHAR(1234, 'L999,999') FROM DUAL;  --(￦1,234)
SELECT TO_CHAR(1234, '999,999') FROM DUAL;  --(1,234)

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')    --(￦8,000,000) / 9 = 공백 / 0 = 0채움 **
FROM EMPLOYEE;

-- 날짜타입 => 문자타입 (존재하는 포맷)
SELECT SYSDATE FROM DUAL;                       -- (연필나오는) 찐 달력
SELECT TO_CHAR(SYSDATE) FROM DUAL;              -- '23/06/23'

SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;   -- HH   : 12시간 형식
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;    -- HH24 : 24시간 형식

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY, MM, YY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YEAR, MONTH, DD, DAY') FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;

-- ex) 1990년 02월 06일 형식으로
SELECT TO_CHAR(HIRE_DATE, 'YYYY년 MM월 DD일')          --  오류! 없는 포맷 제시할 경우, "" 로 묶기
FROM EMPLOYEE;

SELECT TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"')    -- 이제 된당 **
FROM EMPLOYEE;

-- 년도와 관련된 포맷
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- 월과 관련된 포맷
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- 일과 관련된 포맷
SELECT TO_CHAR(SYSDATE, 'DDD'),     -- 올해 기준으로 오늘이 며칠째인지
       TO_CHAR(SYSDATE, 'DD'),      -- 월 기준으로 오늘이 며칠째인지
       TO_CHAR(SYSDATE, 'D')        -- 주 기준으로 며칠째인지
FROM DUAL;

-- 요일과 관련된 포맷
SELECT TO_CHAR(SYSDATE, 'DAY'),     --(월요일)
       TO_CHAR(SYSDATE, 'DY')       --(월)
FROM DUAL;

---------------------------------------------------------------------------------
/*
    * TO_DATE : '숫자타입 또는 문자타입' => '날짜타입' 으로 변환시켜주는 함수
    
    TO_DATE(숫자|문자, [포맷])
*/

SELECT TO_DATE(20100101) FROM DUAL;      --(10/01/01)
SELECT TO_DATE(100101) FROM DUAL;        --(10/01/01)

SELECT TO_DATE(070101) FROM DUAL;        -- 에러!!
SELECT TO_DATE('070101') FROM DUAL;      -- 첫글자가 0인 경우, 문자타입으로 변경하고 해야함 **

SELECT TO_DATE('041030 143000') FROM DUAL;                      -- 에러!!
SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;   -- 포맷을 정해주면 가능해짐

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;   --(2014년)
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL;   --(2098년)   => YY : 무조건 현재세기로 반영.. 20을 붙임
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL;   --(1998년)   => RR : 해당 두자리 년도 값이 50 미만이면 20붙이고, 50이상이면 19붙임 **

---------------------------------------------------------------------------------
/*
    * TO_NUMBER : 문자타입의 데이터를 숫자타입으로 변환시켜주는 함수
    
    TO_NUMBER(문자, [포맷])     => 결과값은 NUMBER 타입
*/

SELECT TO_NUMBER('05123475') FROM DUAL;     -- 0이 빠져서 숫자타입으로 저장됨

SELECT '10000000' + '55000' FROM DUAL;      -- 오라클에서는 자동형변환 잘되어있음
--SELECT '10,000,000' + '55,000' FROM DUAL;   -- 오류!! 안에 숫자만 있어야 자동형변환 됨
SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('55,000', '99,999') FROM DUAL;     -- 강제형변환 **

--======================================= NULL 처리 함수 =========================================
/*
    < 중요!! >
    
    * NVL(컬럼, 해당 컬림이 NULL일 경우 반환할 값)
*/

SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- 전 사원의 이름, (보너스 포함)연봉
SELECT EMP_NAME, (SALARY + SALARY * BONUS)*12, (SALARY + SALARY * NVL(BONUS, 0))*12     --**
FROM EMPLOYEE;

-- 전 사원의 부서코드, 부서 유무
SELECT DEPT_CODE, NVL(DEPT_CODE, '부서없음')
FROM EMPLOYEE;

---------------------------------------------------------------------------------
/*
    * NVL2(컬럼, 반환값1, 반환값2)
    
    컬럼값이 존재할 경우, 반환값1 반환
    컬럼값이 NULL일 경우, 반환값2 반환
*/

SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.1)
FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '부서 O', '부서 X')
FROM EMPLOYEE;

---------------------------------------------------------------------------------
/*
    * NULLIF(비교대상1, 비교대상2)
    
    두 개의 값이 일치하면, NULL 반환
    두 개의 값이 일치하지 않으면, 비교대상1 반환
*/

SELECT NULLIF('123', '123') FROM DUAL;      --(NULL)
SELECT NULLIF('123', '456') FROM DUAL;      --(123)

--======================================= 선택 함수 =========================================
/*
    * DECODE(비교하고자 하는 대상(컬럼|산술연산|함수식), 비교값1, 결과값1, 비교값2, 결과값2, ...)

    자바에서의 동등비교!!
    SWITCH(비교대상) {
    CASE 비교값1 : BREAK;
    CASE 비교값2 : BREAK;
    ...
    DEFAULT : BREAK;
    }
*/

-- 사번, 사원명, 주민번호
SELECT EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1),
DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남',
                             '2', '여') AS "성별"
FROM EMPLOYEE;

-- 직원의 급여 조회시 각 직급별로 인상해서 조회
-- J7인 사원은 급여를 10% 인상 (SALARY * 1.1)
-- J6인 사원은 급여를 15% 인상 (SALARY * 1.15)
-- J5인 사원은 급여를 20% 인상 (SALARY * 1.2)
-- 그 외의 사원은 급여를 5% 인상 (SALARY * 1.05)

-- 사원명, 직급코드, 기존급여, 인상된급여
SELECT EMP_NAME, JOB_CODE, SALARY,
       DECODE(JOB_CODE, 'J7', SALARY * 1.1,
                        'J6', SALARY * 1.15,
                        'J5', SALARY * 1.2,
                        SALARY * 1.05) AS "인상된 급여"
FROM EMPLOYEE;

---------------------------------------------------------------------------------

/*
    * CASE WHEN THEN
    
    CASE WHEN 조건식1 THEN 결과값1
         WHEN 조건식2 THEN 결과값2
         ...
         ELSE 결과값N
    END
    
    => 자바에서의 IF -  ELSE IF - ELSE 문과 유사 (조건절)
*/
SELECT EMP_NAME, SALARY,
       CASE WHEN SALARY >= 5000000 THEN '고급 개발자'
            WHEN SALARY >= 3500000 THEN '중급 개발자'
            ELSE '초급'
       END AS "레벨"
FROM EMPLOYEE;

/*
SELECT CASE WHEN 이조건이면 THEN 뭐
            WHEN 이조건이면 THEN 뭐
            WHEN 이조건이면 THEN 뭐
            ELSE 뭐
        END
FROM EMPLOYEE;
*/

--=======================================< 그룹 함수 (SUM, AVG, COUND, MIN, MAX) >=========================================
-- 1. SUM(숫자타입컬럼) : 해당 컬럼 값들의 총 합계를 구해서 반환해주는 함수

-- EMPLOYEE 테이블의 전 사원의 급여 합
SELECT SUM(SALARY)
FROM EMPLOYEE;  -- 전체 사원이 한 그룹으로 묶임 (한 행)

-- 남자 사원들의 총 급여 합
SELECT SUM(SALARY)  -- 3
FROM EMPLOYEE   -- 1
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');   -- 2

-- 부서코드가 D5인 사원들의 총 연봉 합
SELECT SUM(SALARY * 12) AS "합계"   -- ,EMP_NAME : 그룹함수이기 때문에 단일행함수와 함께 쓰면 오류남 ********
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

---------------------------------------------------------------------------------
-- 2. AVG(숫자타입) ; 해당 컬럼값들의 평균값을 구해서 반환
-- 사원들의 평균 급여(=월급)
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 사원들의 평균 연봉
SELECT ROUND(AVG(SALARY*12))
FROM EMPLOYEE;

---------------------------------------------------------------------------------
-- 3. MIN(여러타입) : 해당 컬럼값들 중에 가장 작은 값 구해서 반환
SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)   -- 문자는 'ㄱ'
FROM EMPLOYEE;

---------------------------------------------------------------------------------
-- 4. MAX(여러타입) : 해당 컬럼값들 중에 가장 큰 값 구해서 반환
SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)   -- 문자는 'ㅎ'
FROM EMPLOYEE;

---------------------------------------------------------------------------------
-- 5. COUNT(*|컬럼|DISTINCT 컬럼) : 조회된 행 개수를 세서 반환

--    COUNT(*)             : 조회된 결과의 모든 행 개수를 세서 반환
--    COUNT(컬럼)          : 제시한 해당 컬럼값이 NULL이 아닌것만 행 개수 세서 반환 *********(NULL 값은 세지 X!!!)
--    COUNT(DISTINCT 컬럼) : 해당 컬럼값 중복을 제거한 후 행 개수 세서 반환

-- 전체 사원 수
SELECT COUNT(*)
FROM EMPLOYEE;

-- 여자 사원 수 
SELECT COUNT(*) -- 9
FROM EMPLOYEE   -- 1
WHERE SUBSTR(EMP_NO, 8, 1) IN('2', '4');    -- 2

-- 보너스를 받는 사원 수
SELECT COUNT(BONUS) -- 컬럼이 NULL이 아닌!!것만(값 존재) 카운팅 함 **********
FROM EMPLOYEE;
--WHERE BONUS IS NOT NULL;

-- 부서배치를 받은 사원 수
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- 현재 사원들이 몇개의 부서에 분포되어있는지
SELECT COUNT(DISTINCT DEPT_CODE)    --6 (D1 D2 D5 D6 D8 D9)
FROM EMPLOYEE;