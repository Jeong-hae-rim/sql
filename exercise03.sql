

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