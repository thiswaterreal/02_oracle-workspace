-- 일단 ~19번까지 풀기
-- <전체조회>
SELECT * FROM TB_CLASS; 
SELECT * FROM TB_CLASS_PROFESSOR;
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_STUDENT;

-- 1.
SELECT DEPARTMENT_NAME AS "학과 명", CATEGORY AS "계열"
FROM TB_DEPARTMENT;

-- 2.
SELECT DEPARTMENT_NAME || '과의 정원은 ' || CAPACITY || ' 명 입니다.'
FROM TB_DEPARTMENT;

-- 3.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001' AND SUBSTR(STUDENT_SSN, 8, 1) IN ('2', '4')
      AND ABSENCE_YN = 'Y'; 

-- 4.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY 1 DESC;

-- 5.
SELECT DEPARTMENT_NAME, CATEGORY, CAPACITY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

-- 6.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 8.
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9.
SELECT DISTINCT(CATEGORY)
FROM TB_DEPARTMENT;

-- 10.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE SUBSTR(ENTRANCE_DATE, 1, 2) = '02' AND STUDENT_ADDRESS LIKE '%전주%' AND ABSENCE_YN = 'N';

/*
    1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른
순으로 표시하는 SQL 문장을 작성하시오.( 단, 헤더는 "학번", "이름", "입학년도" 가
표시되도록 핚다.)
*/
SELECT STUDENT_NO, STUDENT_NAME, ENTRANCE_DATE
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY 2;

/*
    2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 핚 명 있다고 핚다. 그 교수의
이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. (* 이때 올바르게 작성핚 SQL 
문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)
*/
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

/*
    3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단
이때 나이가 적은 사람에서 맋은 사람 순서로 화면에 출력되도록 맊드시오. (단, 교수 중
2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 핚다. 나이는 ‘맊’으로
계산핚다.)
*/
SELECT PROFESSOR_NAME AS "교수이름", 
       FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('19' || SUBSTR(PROFESSOR_SSN, 1, 6), 'YYYYMMDD'))/12) AS "만나이"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) IN ('1', '3')
ORDER BY 2;

/*
    4. 교수들의 이름 중 성을 제외핚 이름만 출력하는 SQL 문장을 작성하시오. 출력 헤더는
?이름? 이 찍히도록 핚다. (성이 2 자인 경우는 교수는 없다고 가정하시오)
*/
SELECT LTRIM(PROFESSOR_NAME, SUBSTR(PROFESSOR_NAME,1,1)) AS "이름"
FROM TB_PROFESSOR;

/*
    5. 춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼 것인가?
이때, 19 살에 입학하면 재수를 하지 않은 것으로 간주한다.
-- 입학년도 - 내가 태어난 년도
-- 2010 - 1990 = 20살,,
*/
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6))) > 19;

/*
    6. 2020 년 크리스마스는 무슨 요일인가?
*/
SELECT TO_CHAR(TO_DATE(20201225), 'DAY')
FROM DUAL;

/*
    7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') 은 각각 몇 년 몇
월 몇 일을 의미핛까? 또 TO_DATE('99/10/11','RR/MM/DD'), 
TO_DATE('49/10/11','RR/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미핛까?
*/
SELECT EXTRACT(YEAR FROM TO_DATE('990630', 'YYMMDD')) AS "년도",
       EXTRACT(MONTH FROM TO_DATE('990630', 'YYMMDD')) AS "월",
       EXTRACT(DAY FROM TO_DATE('990630', 'YYMMDD')) AS "일"
FROM DUAL;
SELECT EXTRACT(YEAR FROM TO_DATE('490630', 'YYMMDD')) AS "년도",
       EXTRACT(MONTH FROM TO_DATE('490630', 'YYMMDD')) AS "월",
       EXTRACT(DAY FROM TO_DATE('490630', 'YYMMDD')) AS "일"
FROM DUAL;
SELECT EXTRACT(YEAR FROM TO_DATE('990630', 'RRMMDD')) AS "년도",
       EXTRACT(MONTH FROM TO_DATE('990630', 'RRMMDD')) AS "월",
       EXTRACT(DAY FROM TO_DATE('990630', 'RRMMDD')) AS "일"
FROM DUAL;
SELECT EXTRACT(YEAR FROM TO_DATE('490630', 'RRMMDD')) AS "년도",
       EXTRACT(MONTH FROM TO_DATE('490630', 'RRMMDD')) AS "월",
       EXTRACT(DAY FROM TO_DATE('490630', 'RRMMDD')) AS "일"
FROM DUAL;

/*
    8. 춘 기술대학교의 2000 년도 이후 입학자들은 학번이 A 로 시작하게 되어있다. 2000 년도
이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
*/
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

/*
    9. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 단,
이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한
자리까지만 표시한다.
*/
SELECT ROUND(AVG(POINT), 1) AS "평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

/*
    10. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 맊들어 결과값이
출력되도록 하시오.
*/
SELECT DEPARTMENT_NO AS "학과번호", COUNT(*) AS "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

/*
    11. 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을 작성하시오.
*/
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

/*
     12. 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 
단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여
소수점 이하 핚 자리까지맊 표시핚다.
*/
--ROUND(AVG(POINT), 1) AS "평점"

SELECT SUBSTR(TERM_NO, 1, 4) AS "년도", ROUND(AVG(POINT),1) AS "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

/*
    13. 학과 별 휴학생 수를 파악하고자 핚다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을
작성하시오.
*/
--SELECT DEPARTMENT_NO, COUNT(DECODE(ABSENCE_YN, 'Y', 1)) 
SELECT DEPARTMENT_NO AS "학과코드명", NVL(SUM(DECODE(ABSENCE_YN, 'Y', 1)), 0) AS "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

/*
    14. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 핚다. 어떤 SQL 
문장을 사용하면 가능하겠는가?
*/
SELECT STUDENT_NAME AS "동일이름", COUNT(*) AS "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1;

/*
    15. 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점 , 
총 평점을 구하는 SQL 문을 작성하시오. (단, 평점은 소수점 1 자리까지맊 반올림하여
표시핚다.)
*/
SELECT SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2), ROUND(AVG(POINT), 1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY TERM_NO
ORDER BY 1;

SELECT *
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
ORDER BY 1;

/*
    1. 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고,
정렬은 이름으로 오름차순 표시하도록 핚다.
*/
SELECT STUDENT_NAME AS "학생 이름", STUDENT_ADDRESS AS "주소지"
FROM TB_STUDENT
ORDER BY 1;

/*
2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
*/
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY 2 DESC;

/*
3. 주소지가 강원도나 경기도인 학생들 중 1900 년대 학번을 가진 학생들의 이름과 학번, 
주소를 이름의 오름차순으로 화면에 출력하시오. 단, 출력헤더에는 "학생이름","학번",
"거주지 주소" 가 출력되도록 핚다.
*/
SELECT STUDENT_NAME AS "학생이름", STUDENT_NO AS "학번", STUDENT_ADDRESS AS "거주지 주소"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '%강원%' OR STUDENT_ADDRESS LIKE '%경기%') AND SUBSTR(STUDENT_NO, 1, 1) = '9';

/*
4. 현재 법학과 교수 중 가장 나이가 맋은 사람부터 이름을 확인핛 수 있는 SQL 문장을
작성하시오. (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아
내도록 하자)
*/
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '005'
ORDER BY 2;

/*
5. 2004 년 2 학기에 'C3118100' 과목을 수강핚 학생들의 학점을 조회하려고 핚다. 학점이
높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을
작성해보시오.
*/
SELECT STUDENT_NO, POINT
FROM TB_GRADE
WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100';

/*
6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL 
문을 작성하시오.
*/

-- 전체조회
SELECT *
FROM TB_GRADE;
