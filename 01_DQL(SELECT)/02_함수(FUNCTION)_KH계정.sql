/*
    < �Լ� FUNCTION >
    ���޵� �÷����� �о�鿩�� �Լ��� ������ ����� ��ȯ��
    
    - ������ �Լ� : N���� ���� �о�鿩�� N���� ������� ���� (���ึ�� �Լ� ���� ��� ��ȯ)
    - �׷� �Լ� : N���� ���� �о�鿩�� 1���� ������� ���� (�׷��� ���� �׷캰�� �Լ� ���� ��� ��ȯ)
    
    >> SELECT ���� �������Լ�, �׷��Լ��� �Բ� ��� ����
    ��? ��� ���� ������ �ٸ��� ����
    
    >> �Լ����� ����� �� �ִ� ��ġ : SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
*/

--======================================= ���� ó�� �Լ� =========================================
/*  
    * LENGTH / LENGTHB      => ����� NUMBER Ÿ��
    
    LENGTH(�÷�|'���ڿ���')   : �ش� ���ڿ� ���� ���� �� ��ȯ
    LENGTHB(�÷�|'���ڿ���')  : �ش� ���ڿ� ���� ����Ʈ �� ��ȯ
    
    '��', '��', '��' �� ���ڴ� 3BYTE
    ������, ����, Ư�� �� ���ڴ� 1BYTE
*/

SELECT SYSDATE
FROM DUAL;  -- �������̺� : ���̺� �� �� ���� �� ���°�

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL;

SELECT LENGTH('ORACLE'), LENGTH('ORACLE')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
        EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;  -- ���ึ�� �� ����ǰ� ���� => ������ �Լ�

---------------------------------------------------------------------------------
/*
    * INSTR
    ���ڿ��κ��� Ư�� ������ ������ġ�� ã�Ƽ� ��ȯ
    
    INSTR(�÷�|'���ڿ�', 'ã�����ϴ� ����', ['ã�� ��ġ�� ���۰�'], [����])   => ������� NUMBER Ÿ��
    
    ã����ġ�� ���۰�
    1   : �տ������� ã�ڴ�.
    -1  : �ڿ������� ã�ڴ�.
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;        --(3) ã�� ��ġ�� ���۰��� 1 �⺻�� => �տ������� ã��, ������ 1 �⺻��
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;     --(3)
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;    --(10)
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;  --(9)
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL;  --(3)

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_��ġ", INSTR(EMAIL, '@') AS "@��ġ"
FROM EMPLOYEE; --12:35

---------------------------------------------------------------------------------
/*
    * SUBSTR
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ (�ڹٿ��� SUBSTRING() �޼ҵ�� ����)
    
    SUBSTR(STRING, POSITION, [LENGTH])  => ������� CHARACTER Ÿ��
    - STRING    : ����Ÿ���÷� �Ǵ� '���ڿ���'
    - POSITION  : ���ڿ��� ������ ���� ��ġ��
    - LENGTH    : ������ ���� ���� (������ ������ �ǹ�)
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;       --(THEMONEY)
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;    --(ME)
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;    --(SHOWME)
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;   --(THE)

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "����"
FROM EMPLOYEE;

-- ���� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- ���� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (1,3)    -- ���������� �ڵ� ����ȯ
ORDER BY 1;                            -- �⺻�����δ� ��������

-- �Լ� ��ø ���
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS "���̵�"
FROM EMPLOYEE;

---------------------------------------------------------------------------------
/*
    *LPAD / RPAD
    ���ڿ��� ��ȸ�� �� ���ϰ��ְ� ��ȸ�ϰ��� �� �� ���
    
    LPAD / RPAD (STRING, ���������� ��ȯ�� ������ ����, [�����̰����ϴ� ����])
    
    ���ڿ��� �����̰����ϴ� ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���� ��ŭ�� ���ڿ��� ��ȯ
*/

SELECT EMP_NAME, RPAD(EMAIL, 20)    -- �����̰����ϴ� ���� ������ �⺻���� ����
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850101-2****** ���
SELECT RPAD('850101-2', 14, '*')
FROM DUAL;

SELECT EMP_NAME, RPAD(�ֹι�ȣ������ �����ڸ����� ������ ���ڿ�, 14, '*')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8) || '*******'
FROM EMPLOYEE;

---------------------------------------------------------------------------------
/*
    LTRIM / RTRIM
    ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
    
    LTRIM / RTRIM (STRING, ['�����ҹ��ڵ�'])  => �����ϸ� ���� ����
    
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ���� �� ���ڿ� ��ȯ
*/

SELECT LTRIM('      K  H  ') FROM DUAL; -- ���� ã�Ƽ� ��� �����ϰ�, ���� �ƴ� ���� ������ ������ ��ȯ
SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL; -- ������ ���ڰ� �ֱ⸸ �ϸ� ���� ������� ����
SELECT RTRIM('5782KH123', '0123456789') FROM DUAL;

/*
    * TRIM
    ���ڿ��� �� / �� / ���ʿ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    
    TRIM([[LEADING, TRAILING, 'BOTH'] �����ϰ��� �ϴ� ���ڵ� FROM] STRING) 
*/

-- �⺻�����δ� ���ʿ� �ִ� ���ڵ� �� ã�Ƽ� ����
SELECT TRIM('      K  H    ') FROM DUAL;
--SELECT TRIM('ZZZZKHKZZZZ', 'Z') FROM DUAL;  -- �Ұ���
SELECT TRIM('Z' FROM 'ZZZZKHZZZZ') FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL;   -- LEADING : �� ���� => LTRIM�� ����
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL;  -- TRAILING : �� ���� => RTRIM�� ����
SELECT TRIM(BOTH 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL;      -- BOTH : ���� �� ���� => ������ �⺻�� 

/*
    * LOWER / UPPER / INITCAP
    
    LOWER / UPPER / INITCAP (STRING)    => ������� CHARACTER Ÿ��
    
    LOWER   : ���� �� �ҹ��ڷ� ������ ���ڿ� ��ȯ (�ڹٿ����� toLowerCase() �޼ҵ�� ����)
    UPPER   : ���� �� �빮�ڷ� ������ ���ڿ� ��ȯ (�ڹٿ����� toUpperCase() �޼ҵ�� ����)
    INITCAP : �ܾ� �ձ��ڸ��� �빮�ڷ� ������ ���ڿ� ��ȯ
*/

SELECT LOWER('Welcome To My World!') FROM DUAL;
SELECT UPPER('Welcome To My World!') FROM DUAL;
SELECT INITCAP('Welcome To My World!') FROM DUAL;

---------------------------------------------------------------------------------
/*
    * CONCAT
    ���ڿ� �ΰ� ���޹޾� �ϳ��� ��ģ �� ��� ��ȯ
    
    CONCAT(STRING, STRING)  => ����� CHARACTER Ÿ��
*/

SELECT CONCAT('ABC', '���ݸ�', '123') FROM DUAL;   -- �����߻�!! : 2���� ���� �� ����
SELECT 'ABC' || '���ݸ�' || '123' FROM DUAL;

---------------------------------------------------------------------------------
/*
    * REPLACE
    
    REPLACE(STRING, STR1, STR2)     => ������� CHARACTER Ÿ��
*/

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;

--======================================= ���� ó�� �Լ� =========================================
/*
    * ABS
    ������ ���밪�� �����ִ� �Լ�
    
    ABS(NUMBER)     => ������� NUMBER Ÿ��
*/

SELECT ABS(-10) FROM DUAL;
SELECT ABS(-5.7) FROM DUAL;

---------------------------------------------------------------------------------
/*
    * MOD
    �� ���� ���� ���������� ��ȯ���ִ� �Լ� (�ڹ��� % �����ڿ� ����)
    
    MOD(NUMBER, NUMBER)     => ����� NUMBER Ÿ��
*/

SELECT MOD(10,3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

---------------------------------------------------------------------------------
/*
    * ROUND
    �ݿø��� ����� ��ȯ
    
    ROUND(NUMBER, [��ġ])     => ������� NUMBER Ÿ��
*/

SELECT ROUND(123.456) FROM DUAL;        --(123) ��ġ ������ 0
SELECT ROUND(123.456, 1) FROM DUAL;     --(132.5)
SELECT ROUND(123.456, 5) FROM DUAL;     --(123.456) �Ҽ������� ū �� ������ �� ���� �״�� ���
SELECT ROUND(123.456, -1) FROM DUAL;    --(120)
SELECT ROUND(123.456, -2) FROM DUAL;    --(100)

---------------------------------------------------------------------------------
/*
    * CEIL
    (������)�ø�ó�� ���ִ� �Լ�
    
    CEIL(NUMBER)
*/

SELECT CEIL(123.152) FROM DUAL;     -- 5�̻� �ƴϾ ������!! �ø� / ��ġ ���� �Ұ�

---------------------------------------------------------------------------------
/*
    * FLOOR
    (������)�Ҽ��� �Ʒ� ����ó���ϴ� �Լ�
    
    FLOOR(NUMBER)
*/

SELECT FLOOR(123.152) FROM DUAL;    -- 5�̻� �ƴϾ ������!! ���� / ��ġ ���� �Ұ�
SELECT FLOOR(123.952) FROM DUAL;

---------------------------------------------------------------------------------
/*
    * TRUNC (�����ϴ�)
    �Ҽ��� ��ġ �����Ͽ� ����ó�����ִ� �Լ�
    TRUNC(NUMBER, [��ġ])
*/

SELECT TRUNC(123.456) FROM DUAL;        --(123) ��ġ���� ���ϸ� FLOOR�� ������ (�׳� ����)
SELECT TRUNC(123.456, 1) FROM DUAL;     --(123.4) �Ҽ��� �Ʒ� ù°�ڸ����� ǥ��
SELECT TRUNC(123.456, -1) FROM DUAL;    --(120)

--======================================= ��¥ ó�� �Լ� =========================================
/*
    * SYSDATE : �ý��� ��¥ �� �ð� ��ȯ (���� ��¥ �� �ð�)
*/
SELECT SYSDATE FROM DUAL;

---------------------------------------------------------------------------------
/*
    * MONTHS_BETWEEN(DATE1, DATE2) : �� ��¥ ������ ���� �� => ���������� DATE1 - DATE2 �� ������ 30,31 �� �����
                                     => �������  NUMBER Ÿ��
*/
-- EMPLOYEE ���� �����, �Ի���, �ٹ����, �ٹ��ϼ�, �ٹ�������
SELECT EMP_NAME, HIRE_DATE, 
FLOOR(MONTHS_BETWEEN(SYSDATE - HIRE_DATE)/12) AS "�ٹ����",
FLOOR(SYSDATE - HIRE_DATE) || '��' AS "�ٹ��ϼ�",
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '����' AS "�ٹ�������"
FROM EMPLOYEE;

---------------------------------------------------------------------------------
/*
    * ADD_MONTHS(DATE, NUMBER) : Ư����¥�� �ش� ���ڸ�ŭ�� �������� ���ؼ� ��¥�� ��ȯ
                                => ������� DATE Ÿ��
*/
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;

-- EMPLOYEE ���� �����, �Ի���, �Ի��� 6������ �� ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6) AS "������ ���� ��¥" 
FROM EMPLOYEE;

---------------------------------------------------------------------------------
/*
    * NEXT_DAY(DATE, ����) : Ư����¥ ���Ŀ� ����� �ش� ������ ��¥�� ��ȯ���ִ� �Լ�
                             => ������� DATE Ÿ��
*/
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
-- 1.��, 2.��, 3.ȭ, ....
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY('20230329', 7) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;  -- �Ұ���. ���� �� KOREAN �̱� ����

-- ��� ����
SELECT * FROM NLS_SESSION_PARAMETERS;

---------------------------------------------------------------------------------
/*
    * LAST_DAY(DATE) : �ش� ���� ������ ��¥�� ���ؼ� ��ȯ
                        => ������� DATE Ÿ��
*/
SELECT LAST_DAY(SYSDATE) FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- EMPLOYEE ���� �����, �Ի���, �Ի��� ���� ������ ��¥, �Ի��� �޿� �ٹ��� �ϼ�
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

---------------------------------------------------------------------------------
/*
    * EXTRACT : Ư�� ��¥�κ��� �⵵|��|�� ���� �����ؼ� ��ȯ�ϴ� �Լ�
    
    EXTRACT(YEAR FROM DATE)     : �⵵�� ����
    EXTRACT(MONTH FROM DATE)    : ���� ����
    EXTRACT(DAY FROM DATE)      : �ϸ� ����
    
    => ������� NUMBER Ÿ��
*/

-- �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT EMP_NAME,
EXTRACT(YEAR FROM HIRE_DATE) AS "�Ի�⵵",
EXTRACT(MONTH FROM HIRE_DATE) AS "�Ի��",
EXTRACT(DAY FROM HIRE_DATE) AS "�Ի���"
FROM EMPLOYEE
ORDER BY "�Ի�⵵", "�Ի��", "�Ի���";

--======================================= ����ȯ �Լ� =========================================
/*
    * TO_CHAR : ���� Ÿ�� �Ǵ� ��¥ Ÿ���� ���� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    TO_CHAR(����|��¥, [����])    => ������� CHARACTER Ÿ��
*/

-- ����Ÿ�� => ����Ÿ��
SELECT TO_CHAR(1234) FROM DUAL; --'1234' �� �ٲ�� �ִ°���
SELECT TO_CHAR(1234, '99999') FROM DUAL;    --( 1234) 5ĭ¥�� ���� Ȯ��, ������ ����, ��ĭ ����
SELECT TO_CHAR(1234, '00000') FROM DUAL;    --(01234)
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;   --(��1234) ���� ������ ����(LOCAL)�� ȭ�����
SELECT TO_CHAR(1234, '$99999') FROM DUAL;   --($1234)

SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;  --(��1,234)

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
FROM EMPLOYEE;

-- ��¥Ÿ�� => ����Ÿ��
SELECT SYSDATE FROM DUAL;                       -- (���ʳ�����) �� �޷�
SELECT TO_CHAR(SYSDATE) FROM DUAL;              -- '23/06/23'
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;   -- HH   : 12�ð� ����
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;    -- HH24 : 24�ð� ����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY')FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;

-- ex) 1990�� 02�� 06�� ��������
SELECT TO_CHAR(HIRE_DATE, 'YYYY�� MM�� DD��')  -- ���� ���� ������ ���, "" �� ����
FROM EMPLOYEE;

SELECT TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"')  -- ���� �ȴ�
FROM EMPLOYEE;

-- �⵵�� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- ���� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- �ϰ� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'DDD'),     -- ���� �������� ������ ��ĥ°����
       TO_CHAR(SYSDATE, 'DD'),      -- �� �������� ������ ��ĥ°����
       TO_CHAR(SYSDATE, 'D')        -- �� �������� ��ĥ°����
FROM DUAL;

-- ���ϰ� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'DAY'),     --(������)
       TO_CHAR(SYSDATE, 'DY')       --(��)
FROM DUAL;

---------------------------------------------------------------------------------
/*
    * TO_DATE : '����Ÿ�� �Ǵ� ����Ÿ��' => '��¥Ÿ��' ���� ��ȯ�����ִ� �Լ�
    
    TO_DATE(����|����, [����])
*/

SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE(100101) FROM DUAL;

SELECT TO_DATE(070101) FROM DUAL;   -- ����!!
SELECT TO_DATE('070101') FROM DUAL; -- ù���ڰ� 0�� ���, ����Ÿ������ �����ϰ� �ؾ���

SELECT TO_DATE('041030 143000') FROM DUAL;                      -- ����!!
SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;   -- ������ �����ָ� ��������

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;   --(2014��)
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL;   --(2098��)   => YY : ������ ���缼��� �ݿ�.. 20�� ����
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL;   --(1998��)   => RR : �ش� ���ڸ� �⵵ ���� 50 �̸��̸� 20����, 50�̻��̸� 19����
