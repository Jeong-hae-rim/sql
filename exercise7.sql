--���� ���ϸ� : exercise7.sql

-- ��� �ǽ������� EMP�� DEPT ���̺��� ������ ������ ���� ����� �����ϰ�
-- ����� ���� Ȯ���� ���� ROLLBACK ����� �����Ѵ�.

-- [ �׽�Ʈ ���� : ��!! ]
-- ������ Ȯ��
-- �������� �䱸�Ǵ� DML �� ����
-- ������ Ȯ��
-- rollback

-- 1. EMP ���̺��� ������ȣ�� 7499���� ������ ������ 5000�޷��� �����Ѵ�.

update emp
set sal = 5000
where empno = '7499';

ROLLBACK;

-- 2. EMP���̺��� �μ���ȣ�� 20���� �������� ������ ���� ���޿��� 10% �λ��� �ݾ����� �����Ѵ�.

update emp
set sal = sal + (sal*0.1)
where deptno = '20';

rollback;


-- 3. DEPT ���̺� �Ʒ��� �������� �����͸� �Է��Ѵ�.
-- �μ���ȣ: 50, �μ���ġ: BOSTON,  �μ���: RESERCH

insert into dept (deptno, loc, dname)
values (50, 'BOSTON', 'RESERCH');

rollback;

-- 4. EMP ���̺� �Ʒ��� ���� �����͸� �����Ѵ�.
-- ������ȣ: 9900, �����̸�: JACKSON, ����: SALESMAN, �μ���ȣ: 10, ���� : 800

insert into emp (empno, ename, job, deptno, sal)
values (9900, 'JACKSON', 'SALESMAN', 10, 800);

rollback;

-- 5. DEPT ���̺� �Ʒ��� �������� �����͸� �Է��Ѵ�.
-- �μ���ȣ: 60, �μ���ġ: NULL,  �μ���: MARKETING

insert into dept (deptno, loc, dname)
values (60, NULL, 'MARKETING');

rollback;

-- 6. ������ȣ�� 7698���� ������ �μ���ȣ�� 7369�� ������ 
-- �μ���ȣ�� �����Ѵ�.

update emp
set deptno = (select deptno from emp where empno = '7698')
where deptno = (select deptno from emp where empno = '7369');

rollback;

--�̷� ������ε� ����.

update emp
set deptno = (select deptno from emp where empno = '7369')
where empno = 7698;

rollback;

-- 7. 20�� �μ��� �������� ��� �����Ѵ�.

delete from emp
where deptno = '20';

rollback;


-- 8. ������ 1000 ������ �������� �����Ѵ�.

delete from emp
where sal <= '1000';

rollback;


-- 9. ������ȣ�� 7900 �� ������ ������ ���� ���޿��� 5% ������Ű��
         �μ���ȣ�� 40���� �����Ѵ�.
         
update emp
set  sal = sal*1.05, deptno = 40
where empno = 7900;

rollback;

-- 10. ���縦 �������� �Ի����� 38�� �̻��� �����鿡 ���Ͽ� 
--          ������ 2��� �����ϰ� Ŀ�̼ǵ� 3000���� �����Ѵ�.
--         (�Ի����� �⵵�� �������� �ݿø��Ͽ� ����Ѵ�.)

update emp
set sal = sal*2, comm = 3000
where to_char(sysdate, 'YYYY') - to_char(round(hiredate, 'YYYY'), 'YYYY')>=38;

rollback;
