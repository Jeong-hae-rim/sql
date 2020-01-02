

--1. employees 테이블의 구조를 파악할 수 있는 SQL 명령을 작성하시오.

desc employees;


--2. departments 테이블의 구조를 파악할 수 있는 SQL 명령을 작성하시오.

desc departments;

--3. 오늘 날짜를 출력하는 SQL 명령을 작성하시오.
--날짜의 작성 형식 : 2020년 1월 2일 

select to_char(sysdate, 'yyyy"년"mm"월"dd"일"') "날짜의 작성 형식" from dual;

--4. 직원들이 총 몇명인지 출력하시오.

select count(*)||'명' 직원수 from employees;

--5. 올해의 크리스마스가 무슨 요일인지 출력하시오.

select to_char(to_date('2020/12/25', 'YYYY/MM/DD'), 'DAY') "2020/12/25"
from dual;

--6. 부서 배치가 되지 않은 직원의 id(employee_id), 이름(first_name), 해당 직원을 담당하는 매니저 ID, 매니저의 이름을 조회하여 
--다음 형식으로 출력하시오. 

--사번 사원 이름 매니저 사번 매니저 이름
---------------------------------------------------------------------
--178 Kimberely 149 Eleni

select e.employee_id 사번, e.first_name "사원 이름", e.manager_id "매니저 사번", m.first_name "매니저 이름"
from employees e, employees m
where e.manager_id = m.employee_id(+)
and e.department_id is null;


--7. 입사월 별로 직원의 최고급여를 조회하여 출력하시오. 단, 출력시 최고급여 내림차순으로 정렬되어 출력하며 최고급여가 10000 이상인 직원만 출력합니다. 

--입사월	최고급여
--------------------------
--6월 24,000원
--1월	17,000원
--9월	17,000원
--10월	14,000원
--     :
--11월 10,500원

select to_char(hire_date, 'mm"월"') 입사월, to_char(salary, '999,999')||'원' 최고급여
from employees
where salary > '10000'
order by salary desc;

--8. 입사년도별 직원 수를 구하여 출력하시오. 단, 급여가 5000에서 10000 인 사이만 직원만 그리고 직원수가 7명 이상인 경우만 출력하시오. 또한 출력은 입사년도 순으로 정렬하시오.
--입사년도 조건에 맞는 직원수
-----------------------------------------------
--05	11
--06	9
--07	8

select to_char(hire_date, 'yy') 입사년도, count(*) "조건에 맞는 직원 수"
from employees
where salary between 5000 and 10000
GROUP BY TO_CHAR(HIRE_DATE,'yy')
having count(*)>=7
ORDER BY TO_CHAR(HIRE_DATE,'yy');


--9. 입사일이 6월인 직원의 이름(first_name), 부서이름(department_name) 및 ‘축-입사기념달’을 출력하시오. 
--직원이름 오름차순으로 정렬하여 출력 합니다.

--이름 부서이름 축하메시지
--------------------------------------------------------------
--David IT 축-입사기념달
--Donald Shipping 축-입사기념달

-- :

--William Accounting 축-입사기념달 


select e.first_name 이름, d.department_name 부서이름, '축-입사기념달' 축하메세지
from employees e, departments d
where e.department_id = d.department_id
and To_char(hire_date,'mm')='06'
order by e.first_name asc;


--10. 'Den'과 동일 부서에서 근무하는 직원들의 최대월급, 최소월급 그리고 월급의 평균을 구하시오.
--단, 평균값을 출력할때 백단위까지만 출력하시오.

--최대월급 최소월급 월급평균
---------------------------------------------------
--11000 2500 4150

select max(salary) 최대월급, MIN(salary) 최소월급, round(avg(salary), 0) 월급평균
from employees
where department_id = (select department_id from employees where first_name = 'Den');
