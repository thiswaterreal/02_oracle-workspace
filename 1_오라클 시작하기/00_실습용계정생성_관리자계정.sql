<<<<<<< HEAD

SELECT * FROM DBA_USERS; 

CREATE USER scott IDENTIFIED BY tiger; 

=======
-- ���� ��� �����鿡 ���ؼ� ��ȸ�ϴ� ��ɹ�
SELECT * FROM DBA_USERS;  -- �̰� ������ �������� ���Ա� ������ ���δ�.
-- ��ɹ� �ϳ� ���� (������ ��� ��ư Ŭ�� | CTRL + ENTER)

-- �Ϲ� ����� ���� �����ϴ� ���� (������ ������ ���������� �� �� ����)
-- [ǥ����] CREATE USER ������ IDENTIFIED BY ��й�ȣ ;

CREATE USER scott IDENTIFIED BY tiger; -- �������� ��ҹ��� �Ȱ���

-- ���� �߰��غ��� => ����!

-- ������ ������ �Ϲ� ����� �������� �ּ����� ���� (������ ����, ����) �ο�
-- [ǥ����] GRANT ����1, ����2, .. TO ������
>>>>>>> 042551df99d82c5bf9fac8ae4cbc3bdc74035a75
GRANT RESOURCE, CONNECT TO scott;