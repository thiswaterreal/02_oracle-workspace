<<<<<<< HEAD
/*
SCOTT_��������
1. EMP���̺��� COMM �� ���� NULL�� �ƴ� ���� ��ȸ
2. EMP���̺��� Ŀ�̼��� ���� ���ϴ� ���� ��ȸ
3. EMP���̺��� �����ڰ� ���� ���� ���� ��ȸ
4. EMP���̺��� �޿��� ���� �޴� ���� ������ ��ȸ
5. EMP���̺��� �޿��� ���� ��� Ŀ�̼��� �������� ���� ��ȸ
6. EMP���̺��� �����ȣ, �����,����, �Ի��� ��ȸ (��, �Ի����� �������� ���� ó��)
7. EMP���̺��� �����ȣ, ����� ��ȸ (�����ȣ ���� �������� ����)
8. EMP���̺��� ���, �Ի���, �����, �޿� ��ȸ
(�μ���ȣ�� ���� ������, ���� �μ���ȣ�� ���� �ֱ� �Ի��� ������ ó��)
9. ���� ��¥�� ���� ���� ��ȸ
10. EMP���̺��� ���, �����, �޿� ��ȸ
(��, �޿��� 100���������� ���� ��� ó���ϰ� �޿� ���� �������� ����)
11. EMP���̺��� �����ȣ�� Ȧ���� ������� ��ȸ
12. EMP���̺��� �����, �Ի��� ��ȸ (��, �Ի����� �⵵�� ���� �и� �����ؼ� ���)
13. EMP���̺��� 9���� �Ի��� ������ ���� ��ȸ
14. EMP���̺��� 81�⵵�� �Ի��� ���� ��ȸ
15. EMP���̺��� �̸��� 'E'�� ������ ���� ��ȸ
16. EMP���̺��� �̸��� �� ��° ���ڰ� 'R'�� ������ ���� ��ȸ
16-1. LIKE ���
16-2. SUBSTR() �Լ� ���
17. EMP���̺��� ���, �����, �Ի���, �Ի��Ϸκ��� 40�� �Ǵ� ��¥ ��ȸ
18. EMP���̺��� �Ի��Ϸκ��� 38�� �̻� �ٹ��� ������ ���� ��ȸ
19. ���� ��¥���� �⵵�� ����
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
