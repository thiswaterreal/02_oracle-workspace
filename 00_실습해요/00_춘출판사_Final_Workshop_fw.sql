/*
1. 4�� ���̺� ���Ե� ������ �� ���� ���ϴ� SQL ������ ����� SQL ������ �ۼ��Ͻÿ�. 
*/

/*
--2. 4�� ���̺��� ������ �ľ��Ϸ��� �Ѵ�. ���õ� ���ó�� TABLE_NAME, COLUMN_NAME, DATA_TYPE,
DATA_DEFAULT, NULLABLE, CONSTRAINT_NAME, CONSTRAINT_TYPE, R_CONSTRAINT_NAME ����
��ȸ�ϴ� SQL ������ �ۼ��Ͻÿ�.
*/

/*
3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
SELECT BOOK_NO, BOOK_NM
FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >= 25;

/*
4. �޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� ���� ���� ǥ�õǴ� �۰�
�̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT *
FROM (SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
        FROM TB_WRITER
        WHERE SUBSTR(MOBILE_NO, 1, 3) = '019' AND WRITER_NM LIKE '��%'
        ORDER BY 1)
WHERE ROWNUM = 1;

/*
5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��� �����
���۰�(��)������ ǥ�õǵ��� �� ��)
*/
SELECT COUNT(DISTINCT(WRITER_NO)) AS "�۰�(��)"   -- �۰� �ߺ� ����(102)
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE = '�ű�'
GROUP BY COMPOSE_TYPE;

SELECT *
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE = '�ű�';         -- �۰� �ߺ� ��(155)

/*
6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
(�������°� ��ϵ��� ���� ���� ������ ��)
*/
SELECT COMPOSE_TYPE, COUNT(*)
FROM TB_BOOK_AUTHOR
GROUP BY COMPOSE_TYPE
HAVING COUNT(*) >= 300 AND COMPOSE_TYPE IS NOT NULL
ORDER BY 2 DESC;

/*
7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT * FROM TB_BOOK;
--SELECT * FROM TB_PUBLISHER;
SELECT *
FROM(SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
     FROM TB_BOOK
     ORDER BY ISSUE_DATE DESC)
WHERE ROWNUM = 1;

/*
8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
��, ��������(��٣���) �۰��� ���ٰ� �����Ѵ�. (��� ����� ���۰� �̸���, ���� ������ ǥ�õǵ��� �Ұ�)
*/
SELECT * FROM TB_WRITER;        -- WRITER_NO
SELECT * FROM TB_BOOK_AUTHOR;   -- WRITER_NO

SELECT *
FROM (SELECT WRITER_NM, COUNT(*)
        FROM TB_WRITER
        JOIN TB_BOOK_AUTHOR USING (WRITER_NO)
        GROUP BY WRITER_NM
        ORDER BY 2 DESC)
WHERE ROWNUM <= 3;

/*
9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���. ������ ������� ���� �� �۰���
������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�. (COMMIT ó���� ��)
*/
SELECT * FROM TB_BOOK;          -- BOOK_NO               (ISSUE_DATE)
SELECT * FROM TB_BOOK_AUTHOR;   -- BOOK_NO  WRITER_NO
SELECT * FROM TB_WRITER;        --          WRITER_NO    (REGIST_DATE)
-- ��..�ϴ� ��ȸ
SELECT BOOK_NO, WRITER_NO, ISSUE_DATE, REGIST_DATE
FROM TB_BOOK
JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
JOIN TB_WRITER USING (WRITER_NO);

UPDATE TB_WRITER W
SET REGIST_DATE = (SELECT MIN(ISSUE_DATE)
                    FROM TB_BOOK
                    JOIN TB_BOOK_AUTHOR A USING (BOOK_NO)
                    WHERE W.WRITER_NO = A.WRITER_NO);
                    
SELECT * FROM TB_WRITER;
ROLLBACK;                    

COMMIT;

/*
10. ���� �������� ���� ���̺��� ������ �������� ���� ���� �����ϰ� �ִ�. �����δ� �������� ���� �����Ϸ�
�� �Ѵ�. ���õ� ���뿡 �°� ��TB_BOOK_TRANSLATOR�� ���̺��� �����ϴ� SQL ������ �ۼ��Ͻÿ�. 
(Primary Key ���� ���� �̸��� ��PK_BOOK_TRANSLATOR���� �ϰ�, Reference ���� ���� �̸���
��FK_BOOK_TRANSLATOR_01��, ��FK_BOOK_TRANSLATOR_02���� �� ��)
*/
CREATE TABLE TB_BOOK_TRANSLATOR(
    BOOK_NO VARCHAR2(10),
    WRITER_NO VARCHAR2(10),
    TRANS_LANG VARCHAR2(60),
    CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY(BOOK_NO, WRITER_NO),
    CONSTRAINT FK_BOOK_TRANSLATOR_01 FOREIGN KEY(BOOK_NO) REFERENCES TB_BOOK,
    CONSTRAINT FK_BOOK_TRANSLATOR_02 FOREIGN KEY(WRITER_NO) REFERENCES TB_WRITER
); -- ����Ű�� ��� ���̺�����ĸ� ����!!

COMMENT ON COLUMN TB_BOOK_TRANSLATOR.BOOK_NO IS '���� ��ȣ';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.WRITER_NO IS '�۰� ��ȣ';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.TRANS_LANG IS '���� ���';

/*
11. ���� ���� ����(compose_type)�� '�ű�', '����', '��', '����'�� �ش��ϴ� �����ʹ�
���� ���� ���� ���̺��� ���� ���� ���� ���̺�(TB_BOOK_ TRANSLATOR)�� �ű�� SQL 
������ �ۼ��Ͻÿ�. ��, ��TRANS_LANG�� �÷��� NULL ���·� �ε��� �Ѵ�. (�̵��� �����ʹ� ��
�̻� TB_BOOK_AUTHOR ���̺� ���� ���� �ʵ��� ������ ��)
*/
SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_BOOK_TRANSLATOR;

SELECT BOOK_NO, WRITER_NO FROM TB_BOOK_AUTHOR WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');

INSERT INTO TB_BOOK_TRANSLATOR (BOOK_NO, WRITER_NO)
                                (SELECT BOOK_NO, WRITER_NO 
                                FROM TB_BOOK_AUTHOR 
                                WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����'));


DELETE FROM TB_BOOK_AUTHOR
WHERE (BOOK_NO, WRITER_NO, COMPOSE_TYPE) IN (SELECT BOOK_NO, WRITER_NO, COMPOSE_TYPE
                                            FROM TB_BOOK_AUTHOR 
                                            WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����'));

ROLLBACK;

/*
12. 2007�⵵�� ���ǵ� ������ �̸��� ������(����)�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT * FROM TB_BOOK;              -- BOOK_NO
SELECT * FROM TB_BOOK_TRANSLATOR;   -- BOOK_NO     WRITER_NO
SELECT * FROM TB_WRITER;            --             WRITER_NO

SELECT BOOK_NM, WRITER_NM, ISSUE_DATE
FROM TB_BOOK
JOIN TB_BOOK_TRANSLATOR USING (BOOK_NO)
JOIN TB_WRITER USING (WRITER_NO)
WHERE EXTRACT(YEAR FROM ISSUE_DATE) = '2007'
ORDER BY 1;

/*
13. 12�� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �並 �����ϴ� SQL
������ �ۼ��Ͻÿ�. (�� �̸��� ��VW_BOOK_TRANSLATOR���� �ϰ� ������, ������, ��������
ǥ�õǵ��� �� ��)
*/
CREATE OR REPLACE VIEW VW_BOOK_TRANSLATOR
AS SELECT BOOK_NM, WRITER_NM, ISSUE_DATE
    FROM TB_BOOK
    JOIN TB_BOOK_TRANSLATOR USING (BOOK_NO)
    JOIN TB_WRITER USING (WRITER_NO)
    WHERE EXTRACT(YEAR FROM ISSUE_DATE) = '2007'
    ORDER BY 1
WITH READ ONLY;
-- ORA-01031: insufficient privileges
-- privileges : ���� => ������ ���ٴ� ����

-- ������ ������ �����ؼ� ���� �ο�
GRANT CREATE VIEW TO finalfinal;   -- �����ڰ���(������)����!!

SELECT * FROM VW_BOOK_TRANSLATOR;

/*
14. ���ο� ���ǻ�(�� ���ǻ�)�� �ŷ� ����� �ΰ� �Ǿ���. ���õ� ���� ������ �Է��ϴ� SQL
������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
(�� ���ǻ�  / 02-6710-3737 / Default �� ���)
*/
SELECT * FROM TB_PUBLISHER;

INSERT INTO TB_PUBLISHER
VALUES ('�� ���ǻ�', '02-6710-3737', DEFAULT);

COMMIT;

/*
15. ��������(��٣���) �۰��� �̸��� ã������ �Ѵ�. �̸��� �������� ���ڸ� ǥ���ϴ� SQL ������
�ۼ��Ͻÿ�.
*/
SELECT * FROM TB_WRITER;

SELECT WRITER_NM, COUNT(*)
FROM TB_WRITER
GROUP BY WRITER_NM
HAVING COUNT(*) >= 2;

/*
16. ������ ���� ���� �� ���� ����(compose_type)�� ������ �����͵��� ���� �ʰ� �����Ѵ�. �ش� �÷���
NULL�� ��� '����'���� �����ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
*/
SELECT * FROM TB_BOOK_AUTHOR WHERE COMPOSE_TYPE IS NULL;

UPDATE TB_BOOK_AUTHOR
SET COMPOSE_TYPE = '����'
WHERE COMPOSE_TYPE IS NULL;

COMMIT;
/*
17. �������� �۰� ������ �����Ϸ��� �Ѵ�. �繫���� �����̰�, �繫�� ��ȭ ��ȣ ����(���)�� 3�ڸ��� �۰���
�̸��� �繫�� ��ȭ ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT * FROM TB_WRITER;

SELECT WRITER_NM, OFFICE_TELNO
FROM TB_WRITER
WHERE OFFICE_TELNO LIKE '02%'
AND OFFICE_TELNO LIKE '______-%'
ORDER BY 1;

/*
18. 2006�� 1�� �������� ��ϵ� �� 31�� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT WRITER_NM
FROM TB_WRITER
--��.. 2006�� - ��ϳ⵵ >= 31��
WHERE EXTRACT(YEAR FROM TO_DATE(20060101)) - EXTRACT(YEAR FROM REGIST_DATE) > 31
ORDER BY 1;

/*
19. ���� ��� �ٽñ� �α⸦ ��� �ִ� 'Ȳ�ݰ���' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ�. 'Ȳ�ݰ���' 
���ǻ翡�� ������ ���� �� ��� ������ 10�� �̸��� ������� ����, �����¸� ǥ���ϴ� SQL ������
�ۼ��Ͻÿ�. (��� ������ 5�� �̸��� ������ ���߰��ֹ��ʿ䡯��, �������� ���ҷ��������� ǥ���ϰ�, 
�������� ���� ��, ������ ������ ǥ�õǵ��� �Ѵ�. )
*/
SELECT * FROM TB_BOOK;      --PUBLISHER_NM

SELECT BOOK_NM, PRICE, STOCK_QTY
FROM TB_BOOK
WHERE PUBLISHER_NM = 'Ȳ�ݰ���'
AND STOCK_QTY < 10;

-- ��� 10 �̸��� ���
SELECT STOCK_QTY
FROM TB_BOOK
WHERE PUBLISHER_NM = 'Ȳ�ݰ���'
AND STOCK_QTY < 10;

/*
UPDATE TB_BOOK
SET STOCK_QTY = '�߰��ֹ��ʿ�'
WHERE STOCK_QTY IN (SELECT STOCK_QTY
                    FROM TB_BOOK
                    WHERE PUBLISHER_NM = 'Ȳ�ݰ���'
                    AND STOCK_QTY < 10);
                    */
-- �÷� �߰��ؼ� ������ ǥ���ϵ��� ������ �ϳ�..??

/*
--20. '��ŸƮ��' ���� �۰��� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� �����
��������,�����ڡ�,�����ڡ��� ǥ���� ��)
*/
SELECT * FROM TB_BOOK WHERE BOOK_NM = '��ŸƮ��'; --1991081002               -- BOOK_NO
SELECT * FROM TB_BOOK_TRANSLATOR WHERE BOOK_NO = 1991081002;  -- 647 ������  -- BOOK_NO     WRITER_NO
SELECT * FROM TB_WRITER ORDER BY 2; --��ƮȦƮ 286 ����                           --             WRITER_NO
SELECT * FROM TB_BOOK_TRANSLATOR;
SELECT * FROM TB_WRITER WHERE WRITER_NM LIKE '��ƮȦƮ%';
SELECT * FROM TB_BOOK_AUTHOR;

SELECT BOOK_NM, WRITER_NM, WRITER_NM
FROM TB_BOOK
JOIN TB_BOOK_AUTHOR A USING (BOOK_NO)
JOIN TB_WRITER W ON (A.WRITER_NO = W.WRITER_NO)
WHERE BOOK_NM = '��ŸƮ��';
-- ��ü����

/*
--21. ���� �������� ���� �����Ϸκ��� �� 30���� ����ǰ�, ��� ������ 90�� �̻��� ������ ���� ������, ���
����, ���� ����, 20% ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ��������, �����
������, ������(Org)��, ������(New)���� ǥ���� ��. ��� ������ ���� ��, ���� ������ ���� ��, ������
������ ǥ�õǵ��� �� ��)
*/