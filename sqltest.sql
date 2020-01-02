

--1. employees ���̺��� ������ �ľ��� �� �ִ� SQL ����� �ۼ��Ͻÿ�.

desc employees;


--2. departments ���̺��� ������ �ľ��� �� �ִ� SQL ����� �ۼ��Ͻÿ�.

desc departments;

--3. ���� ��¥�� ����ϴ� SQL ����� �ۼ��Ͻÿ�.
--��¥�� �ۼ� ���� : 2020�� 1�� 2�� 

select to_char(sysdate, 'yyyy"��"mm"��"dd"��"') "��¥�� �ۼ� ����" from dual;

--4. �������� �� ������� ����Ͻÿ�.

select count(*)||'��' ������ from employees;

--5. ������ ũ���������� ���� �������� ����Ͻÿ�.

select to_char(to_date('2020/12/25', 'YYYY/MM/DD'), 'DAY') "2020/12/25"
from dual;

--6. �μ� ��ġ�� ���� ���� ������ id(employee_id), �̸�(first_name), �ش� ������ ����ϴ� �Ŵ��� ID, �Ŵ����� �̸��� ��ȸ�Ͽ� 
--���� �������� ����Ͻÿ�. 

--��� ��� �̸� �Ŵ��� ��� �Ŵ��� �̸�
---------------------------------------------------------------------
--178 Kimberely 149 Eleni

select e.employee_id ���, e.first_name "��� �̸�", e.manager_id "�Ŵ��� ���", m.first_name "�Ŵ��� �̸�"
from employees e, employees m
where e.manager_id = m.employee_id(+)
and e.department_id is null;


--7. �Ի�� ���� ������ �ְ�޿��� ��ȸ�Ͽ� ����Ͻÿ�. ��, ��½� �ְ�޿� ������������ ���ĵǾ� ����ϸ� �ְ�޿��� 10000 �̻��� ������ ����մϴ�. 

--�Ի��	�ְ�޿�
--------------------------
--6�� 24,000��
--1��	17,000��
--9��	17,000��
--10��	14,000��
--     :
--11�� 10,500��

select to_char(hire_date, 'mm"��"') �Ի��, to_char(salary, '999,999')||'��' �ְ�޿�
from employees
where salary > '10000'
order by salary desc;

--8. �Ի�⵵�� ���� ���� ���Ͽ� ����Ͻÿ�. ��, �޿��� 5000���� 10000 �� ���̸� ������ �׸��� �������� 7�� �̻��� ��츸 ����Ͻÿ�. ���� ����� �Ի�⵵ ������ �����Ͻÿ�.
--�Ի�⵵ ���ǿ� �´� ������
-----------------------------------------------
--05	11
--06	9
--07	8

select to_char(hire_date, 'yy') �Ի�⵵, count(*) "���ǿ� �´� ���� ��"
from employees
where salary between 5000 and 10000
GROUP BY TO_CHAR(HIRE_DATE,'yy')
having count(*)>=7
ORDER BY TO_CHAR(HIRE_DATE,'yy');


--9. �Ի����� 6���� ������ �̸�(first_name), �μ��̸�(department_name) �� ����-�Ի���ޡ��� ����Ͻÿ�. 
--�����̸� ������������ �����Ͽ� ��� �մϴ�.

--�̸� �μ��̸� ���ϸ޽���
--------------------------------------------------------------
--David IT ��-�Ի����
--Donald Shipping ��-�Ի����

-- :

--William Accounting ��-�Ի���� 


select e.first_name �̸�, d.department_name �μ��̸�, '��-�Ի����' ���ϸ޼���
from employees e, departments d
where e.department_id = d.department_id
and To_char(hire_date,'mm')='06'
order by e.first_name asc;


--10. 'Den'�� ���� �μ����� �ٹ��ϴ� �������� �ִ����, �ּҿ��� �׸��� ������ ����� ���Ͻÿ�.
--��, ��հ��� ����Ҷ� ����������� ����Ͻÿ�.

--�ִ���� �ּҿ��� �������
---------------------------------------------------
--11000 2500 4150

select max(salary) �ִ����, MIN(salary) �ּҿ���, round(avg(salary), 0) �������
from employees
where department_id = (select department_id from employees where first_name = 'Den');
