

select LENGTH('한글'), LENGTHB( '한글' )
from dual;                 

select job, substr(job, 1, 2), substr(job, 3, 2), substr(job,5)
from emp;

select job, length(job)
from emp
where length(job) >= 6;

select concat(empno, ename), concat(empno, concat(', ' , ename))
from emp
where ename = 'SMITH';

select sysdate, to_char(sysdate, 'ww') as w
from dual;

select * from emp;
select * from dept;

select * from emp, dept;

select * from emp, dept where emp.deptno = dept.deptno;

select * from emp, dept where emp.deptno = dept.deptno(+);

select * from emp, dept where emp.deptno(+) = dept.deptno;

select * from emp, dept where emp.deptno(+) = dept.deptno(+) ;

↓

select * from emp, dept where emp.deptno = dept.deptno(+) 
union
select * from emp, dept where emp.deptno(+) = dept.deptno;

select * from salgrade;

select *from emp, salgrade where emp.sal between salgrade.losal and salgrade.hisal;

select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename, e2.mgr
from emp e1, emp e2
where e1.mgr = e2.empno;

select e.ename, m.ename
from emp e, emp m
where e.mgr = m.empno;

select e.ename, nvl(m.ename, '없음')
from emp e, emp m
where e.mgr = m.empno(+);