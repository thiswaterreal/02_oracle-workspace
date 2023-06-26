<<<<<<< HEAD
/*
SCOTT_연습문제
1. EMP테이블에서 COMM 의 값이 NULL이 아닌 정보 조회
2. EMP테이블에서 커미션을 받지 못하는 직원 조회
3. EMP테이블에서 관리자가 없는 직원 정보 조회
4. EMP테이블에서 급여를 많이 받는 직원 순으로 조회
5. EMP테이블에서 급여가 같을 경우 커미션을 내림차순 정렬 조회
6. EMP테이블에서 사원번호, 사원명,직급, 입사일 조회 (단, 입사일을 오름차순 정렬 처리)
7. EMP테이블에서 사원번호, 사원명 조회 (사원번호 기준 내림차순 정렬)
8. EMP테이블에서 사번, 입사일, 사원명, 급여 조회
(부서번호가 빠른 순으로, 같은 부서번호일 때는 최근 입사일 순으로 처리)
9. 오늘 날짜에 대한 정보 조회
10. EMP테이블에서 사번, 사원명, 급여 조회
(단, 급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)
11. EMP테이블에서 사원번호가 홀수인 사원들을 조회
12. EMP테이블에서 사원명, 입사일 조회 (단, 입사일은 년도와 월을 분리 추출해서 출력)
13. EMP테이블에서 9월에 입사한 직원의 정보 조회
14. EMP테이블에서 81년도에 입사한 직원 조회
15. EMP테이블에서 이름이 'E'로 끝나는 직원 조회
16. EMP테이블에서 이름의 세 번째 글자가 'R'인 직원의 정보 조회
16-1. LIKE 사용
16-2. SUBSTR() 함수 사용
17. EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
18. EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회
19. 오늘 날짜에서 년도만 추출
*/
=======
drop table emp;
drop table dept;
drop table bonus;
drop table salgrade;


CREATE TABLE EMP
(EMPNO number not null,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR number,
HIREDATE date,
SAL number,
COMM number,
DEPTNO number);

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800,null,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,200,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,'1981-04-02',2975,30,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,300,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,'1981-04-01',2850,null,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,'1981-06-01',2450,null,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,'1982-10-09',3000,null,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',null,'1981-11-17',5000,3500,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100,null,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,'1981-10-03',950,null,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,'1981-10-3',3000,null,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,'1982-01-23',1300,null,10);

CREATE TABLE DEPT
(DEPTNO number,
DNAME VARCHAR2(14),
LOC VARCHAR2(13) );

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

CREATE TABLE BONUS
(
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
SAL number,
COMM number
);


CREATE TABLE SALGRADE
( GRADE number,
LOSAL number,
HISAL number);

INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

commit;
>>>>>>> 042551df99d82c5bf9fac8ae4cbc3bdc74035a75
