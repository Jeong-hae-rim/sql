-- ������ ������ �������� �ذ��Ͽ� �����Ѵ�.
-- �������ϸ� : exercise1.sql

--1. ��� ���̺��� ����Ʈ�� ����Ͻÿ�.

select * from tab;

--2. emp ���̺�� dept ���̺��� ������ ����Ͻÿ�.

desc emp;
desc dept;

--3. ���(emp)���̺��� ��� �����͸� ����Ͻÿ�.

select * from emp;

--4. ������̺��� �����ȣ, ����̸�, ������ ����Ͻÿ�.

select empno, ename, sal
from emp;

--5. ������̺��� ���޿��� �̴µ� �ߺ��� �����Ͱ� ���� ����Ͻÿ�.

select distinct sal
from emp;

--6. ������̺��� ����̸��� ������ ����ϴµ� ������ �÷�����
-- "�� ��","�� ��"���� �ٲ㼭 ����Ͻÿ�. ��, ALIAS�� ���� �߰�

select ename as "�� ��", sal as "��  ��"
from emp;

--7. ������̺��� ����̸�, ������ �̰�, ���ް� Ŀ�̼���  ���� ����
-- ����ϴµ� �÷����� '�Ǳ޿�'�̶�� �ؼ� ����Ͻÿ�.
-- ��, NULL���� ��Ÿ���� �ʰ� �Ͻÿ�.(Ŀ�̼� �ȹ޴»������)


select ename, sal, sal+comm as "�Ǳ޿�"
from emp
where comm is not null;


--8. ������̺��� 'FORD'�̶�� ����� �����ȣ, �̸�, ������ ����Ͻÿ�.

select *
from emp
where ename = 'FORD';

--9. ������̺��� ������ 'SALESMAN'�� ����� �����ȣ, �̸�, ������
-- ����Ͻÿ�.

select *
from emp
where job = 'SALESMAN';

--10. ������̺��� �����ȣ�� 7499, 7521, 7654�� ����� �����ȣ, �̸�
-- ������ ����Ͻÿ�.

select *
from emp
where empno = '7499' 
or empno = '7521'
or empno = '7654';

--11. ������̺��� ������ 1500���� 3000������ ����� �����ȣ, �̸�,
-- ������ ����Ͻÿ�.

select empno, ename, sal
from emp
where sal between 1500 and 3000;


--12. ��� ���̺��� �Ŵ����� ���� ������ �̸��� ����Ͻÿ�.

select ename
from emp
where mgr is null ;

--13. ������̺��� ������ ���� ������ ��� ������ ����Ͻÿ�.

select *
from emp
order by sal asc;

--14. ������̺��� ������ �̸��� �Ի����� ����ϴµ� �ֱٿ� �Ի��� ������ ����Ͻÿ�.

select ename, hiredate
from emp
order by hiredate desc;

--15. ��� ���̺��� 30�� �μ��� �ٹ��ϴ� �������� �̸��� ����ϴµ�
-- �Ի����� ������ ������ ����Ͻÿ�.

select *
from emp
where deptno = 30
order by hiredate asc;