--�������ϸ� : exercise3.sql
-- scott_create_table.sql �� �����Ͽ� scott ���� �������� �����Ű�� 
-- course1 �� couse2 ���̺��� ������ �Ŀ� �����Ѵ�.

-- 1. ���տ����� �ǽ� 

-- 1.1 course1 �� course2 �� ��� �����ϴ� �л����� �̸�, ��ȭ ��ȣ �׸��� 
--    ���̸� ����Ͻÿ�.

select name, phone, age
from course1
union
select name, phone, age
from course2;
  
-- 1.2 course1 �̵� course2 �� �����ϴ� �л����� �̸�, ��ȭ ��ȣ �׸��� 
--    ���̸� ����ϴµ� ���̰� ���� ������ ����Ͻÿ�.

select name, phone, age
from course1
union
select name, phone, age
from course2
order by age desc;

-- 1.3 course1�� ���������� course2 �� �������� �ʴ� �л����� �̸��� ����Ͻÿ�.

select name
from course1
minus
select name
from course2;

-- 1.4 course2�� ���������� course1 �� �������� �ʴ� �л����� �̸��� ��ȭ��ȣ�� 
--    �̸� ������ ����Ͻÿ�.

select name,phone
from course2
minus
select name, phone
from course1
order by name asc;

--2. ��� ������ ������ ����� ���Ͻÿ�. 
--       (�Ҽ��� ���� ��°�ڸ������� ��Ÿ���� ��°�ڸ� ���ʹ� �����Ͻÿ�)

--	 ���� ���  
    -----------

select trunc(avg(sal), 2) as "���� ���"
from emp;


--3. ��� �������� �޴� Ŀ�̼��� ���� ���Ͻÿ�.
--	Ŀ�̼� ��
   -----------
   
select sum(comm) as "Ŀ�̼� ��"
from emp;
	  

--4. �� ���޺��� �ѿ����� ����ϵ� �ѿ����� ���� ������ ����Ͻÿ�.

--	���޸�    	�ѿ���
	----------------------------
--	xxxx          xxx
--	 :	   :


select job as ���޸�, sum(sal) as �ѿ���
from emp
group by job
order by sum(sal) asc;
--order by �ѿ���; ���� �ص� ��.
--order by 2(�ι�° ��); ���� �ص� ��. ������ ���� ���� �ʴ� ������ �����Ѵ�.

--5. �� �μ����� �ٹ��ϴ� �������� ����� �˰�ʹ�. ���� �������� ����ϴ� SQL
--    �� �ۼ��Ͻÿ� .

--	�μ�����	   �������
	----------------------------
--	����          1��
--	30�� �μ�   6��
--	20�� �μ�   4��
--	10�� �μ�   3��

select nvl2(deptno, TO_CHAR(deptno)||'�� �μ�', '����') as �μ�����, count(*)||'��' as �������
from emp
group by deptno;

--2�� ��� : case ���� ����ϱ�
select case deptno
when 10 then '10�� �μ�'
when 20 then '20�� �μ�'
when 30 then '30�� �μ�'
else '����' 
end �μ�����,
count(*)||'��' �������
from emp
group by deptno;

-- 3�� ��� : decode ���� ����ϱ�
select decode(deptno, 10, '10�� �μ�', 20, '20�� �μ�', 30, '30�� �μ�', '����') �μ�����, count(*)||'��' �������
from emp
group by deptno;




--6. �⵵���� ����� �Ի��ߴ��� �˰�ʹ�. ���� �������� ����ϴ� SQL
--    �� �ۼ��Ͻÿ� . (���� �Ի��� ������ ���)

--	�Ի�⵵ 	   �Ի� �ο���
	----------------------------
--	1981��	   10��
--	1987��	   2��
--	1982��	   1��
--	1980��	   1��


select to_char(hiredate, 'YYYY')||'�⵵' as �Ի�⵵, count(*)||'��' as �������
from emp
group by to_char(hiredate, 'YYYY')
order by count(*) desc;

--7. ��ü �������� ���ڸ� �μ������� ���� �������� ����ϴ� SQL
--    �� �ۼ��Ͻÿ� .

--	2019�� 12�� 27�� �������� 14���� �ٹ����Դϴ�.

select to_char(sysdate, 'YYYY"�� "MM"�� "DD"�� "')||'�������� '||count(*)||'���� �ٹ� ���Դϴ�.' as �������
from emp;

--8. ���޺� �ѿ����� ����ϵ�, ������ 'MANAGER'�� �������� �����Ͻÿ�. 
--   �׸��� �� �ѿ����� 5000���� ū ���޿� �ѿ��޸� ����Ͻÿ�.

--	���޸�	�ѿ���
	----------------------------
--	xxxx          xxx
--	 :	   :


select job as ���޸�, sum(sal) as �ѿ���
from emp
where job != 'MANAGER'
group by job
having sum(sal)>5000;

--9. 30�� �μ��� ������ ����� ����� �˻��Ѵ�.
-- ��������� ����+Ŀ�̼�(null�̸� 0���� ���)�̸� 
-- ��� ����� �Ҽ��� ���� �� �ڸ�(�ݿø�)���� ���ϵ� ������� ����Ѵ�.
 --             ������       ��տ���
              ---------------------------
 --             xxxx         xxx.xx
--	              :	           :

select job as ������, to_char(round(avg(sal+nvl(comm,0)*12),2), '999,999.00') as ��տ���
from emp
where deptno = 30
group by job;

--10. ���� �Ի��ο��� ���� �������� ����ϴ� SQL �� �ۼ��Ͻÿ� . 
--     �Ի������ ���������̸� �Ի��ο��� 2�� �̻��� ��쿡�� ����Ѵ�.


	02��	2��
	04��	2��
	05��	2��
	09��	2��
	12��	3��


select to_char(hiredate, 'MM')||'��' as ����, count(*)||'��'
from emp
group by to_char(hiredate, 'MM')
having count(*) >= '2'
order by to_char(hiredate, 'MM') asc;
