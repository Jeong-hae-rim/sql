--QUESTION
--제출파일명 : exercise6.sql
--모두 서브쿼리를 사용해서 해결합니다.

-- 1. 'DALLAS'에서 근무하는 직원의 이름, 직위, 부서번호를 출력하시오.
--이름         직위         부서번호              
---------- --------- ----------
--SCOTT	   ANALYST	20
--SMITH	   CLERK		20
--JONES	   MANAGER	20
--FORD	   ANALYST	20

select e.ename 이름, e.job 직위, e.deptno 부서번호
from emp e
where deptno = (select deptno from dept d where loc = 'DALLAS');

--2. 'SMITH'보다 월급을 많이 받는 직원들의 이름과 월급 그리고 부서명을 출력한다.
--직원명               급여             부서명         
---------- ---------- ------------
--SCOTT		3000	RESEARCH
--ALLEN		1600	SALES
--WARD		1250	SALES
--JONES		2975	RESEARCH
--MARTIN	1250	SALES
--BLAKE		2850	SALES
--CLARK		2450	ACCOUNTING
--KING		5000	ACCOUNTING
--TURNER	1500	SALES
--JAMES		950	SALES
--FORD		3000	RESEARCH
--MILLER		1300	ACCOUNTING

select e.ename 직원명, e.sal 급여, d.dname 부서명
from emp e join dept d using (deptno)
where sal > (select sal from emp where ename = 'SMITH');

--3. 30번 부서의 직원들과 동일한 해에 입사한 직원들의 이름, 월급, 
--   부서번호 그리고 입사년도를 출력한다.(30번부서 제외하고)
--Ename        Sal            DeptNo         HireYear
---------- ---------- ---------- ----------
--FORD	   3000	       20		1981
--KING	   5000	       10		1981
--CLARK	   2450	       10		1981
--JONES	   2975	       20		1981

select ename, sal, deptno, to_char(hiredate, 'YYYY') HireYear
from emp
where to_char(hiredate, 'YYYY') in (select to_char(hiredate, 'YYYY') from emp where deptno = '30')
and deptno != '30';

--4. 'BLAKE'와 같은 부서에 있는 직원들의 이름과 입사일을 뽑는데 'BLAKE'는 빼고 출력한다. 
--ENAME      HIREDATE
---------- --------
--JAMES	     81/12/03
--TURNER     81/09/08
--BLAKE	     81/05/01
--MARTIN     81/09/28
--WARD	     81/02/22
--ALLEN	     81/02/20

select ename, hiredate
from emp
where deptno = (select deptno from emp where ename = 'BLAKE')
and ename not like 'BLAKE'
order by hiredate desc;

--5. 평균급여보다 많은 급여를 받는 직원들의 직원번호, 이름, 월급을
-- 출력하되, 월급이 높은 사람 순으로 출력한다.
--  EMPNO ENAME    SAL
---------- ------ ----------
--7839	KING	5,000원
--7788	SCOTT	3,000원
--7902	FORD	3,000원
--7566	JONES	2,975원
--7698	BLAKE	2,850원
--7782	CLARK	2,450원

select empno, ename, to_char(sal, '999,999')||'원' SAL
from emp
where sal > (select avg(sal) from emp) --서브쿼리로 평균급여 해결
order by sal desc;


--6. 이름에 'T'를 포함하고 있는 직원들과 같은 부서에서 근무하고
--   있는 직원의 직원번호와 이름을 출력한다.
--EMPNO ENAME     
---------- ----------
--7902	FORD
--7566	JONES
--7369	SMITH
--7788	SCOTT
--7900	JAMES
--7844	TURNER
--7698	BLAKE
--7654	MARTIN
--7521	WARD
--7499	ALLEN  

select empno, ename
from emp
where deptno in (select deptno from emp where ename like '%T%' group by deptno);

--7 급여가 평균급여보다 많고,이름에 S자가 들어가는 직원과 동일한
--  부서에서 근무하는 모든 직원의 직원번호,이름 및 급여를 출력하시오.
--EMPNO      ENAME      SAL
----------  --------  -------
--7902	     FORD	      3000
--7566	     JONES      2975
--7788	     SCOTT      3000
--7698	     BLAKE      2850

select empno, ename, sal
from emp
where sal > (select avg(sal) from emp) --단일행이라 대소 연산자 가능
and deptno in (select deptno from emp where ename like '%S%' group by deptno);


--8. 30번 부서에 있는 직원들 중에서 가장 많은 월급을 받는 직원보다
--   많은 월급을 받는 직원들의 이름, 부서번호, 월급을 출력한다. 
--   (단, ALL 또는 ANY 연산자를 사용할 것) : 안 쓰고도 해결 가능?
--  이름    부서번호   월급
--------------------------------
--JONES	20	2975
--SCOTT	20	3000
--FORD	20	3000
--KING	10	5000

select ename 이름, deptno 부서번호, sal 월급
from emp
where sal > ALL (select sal from emp where deptno = '30');
--서브쿼리에서 최고값을 뽑아내면 ALL, ANY 안 쓰고도 해결 가능.

select ename 이름, deptno 부서번호, sal 월급
from emp
where sal > (select MAX(sal) from emp where deptno = '30');

--9. SALES 부서에서 일하는 직원들의 부서번호, 이름, 직업을 출력한다.
--DEPTNO    ENAME       JOB      
---------- ---------- ---------
--30번 부서  ALLEN	       SALESMAN
--30번 부서  WARD	       SALESMAN
--30번 부서  MARTIN      SALESMAN
--30번 부서  BLAKE	       MANAGER
--30번 부서  TURNER      SALESMAN
--30번 부서  JAMES	       CLERK

select e.deptno||'번 부서' DEPTNO, e.ename, e.job
from emp e, dept d
where e.deptno = d.deptno
and d.dname = (select d.dname from dept d where d.dname = 'SALES');

select deptno||'번 부서' DEPTNO, ename, job
from emp
where deptno = (select deptno from dept where dname = 'SALES');

--10. 'KING'에게 보고하는 모든 직원의 이름과 급여를 출력한다. 
--     (KING에게 보고하는 직원이란 mgr이 KING인 직원을 의미함) 
--이름         입사날짜
---------- ----------
--JONES	   1981년 04월 02일
--BLAKE	   1981년 05월 01일
--CLARK	   1981년 06월 09일

select ename, to_char(hiredate, 'YYYY"년"MM"월"DD"일"') 입사날짜
from emp
where mgr = (select empno from emp where ename like 'KING');

--JONES	   1981년 4월 2일
--BLAKE	   1981년 5월 1일
--CLARK	   1981년 6월 9일

select ename, to_char(hiredate, 'YYYY"년"fmMM"월"DD"일"') 입사날짜
from emp
where mgr = (select empno from emp where ename like 'KING');

--fm 나온 시점부터 0을 제거해줌