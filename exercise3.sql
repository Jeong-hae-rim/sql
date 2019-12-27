--제출파일명 : exercise3.sql
-- scott_create_table.sql 을 복사하여 scott 계정 영역에서 수행시키고 
-- course1 과 couse2 테이블을 생성한 후에 진행한다.

-- 1. 집합연산자 실습 

-- 1.1 course1 과 course2 를 모두 수강하는 학생들의 이름, 전화 번호 그리고 
--    나이를 출력하시오.

select name, phone, age
from course1
union
select name, phone, age
from course2;
  
-- 1.2 course1 이든 course2 든 수강하는 학생들의 이름, 전화 번호 그리고 
--    나이를 출력하는데 나이가 많은 순으로 출력하시오.

select name, phone, age
from course1
union
select name, phone, age
from course2
order by age desc;

-- 1.3 course1은 수강하지만 course2 는 수강하지 않는 학생들의 이름을 출력하시오.

select name
from course1
minus
select name
from course2;

-- 1.4 course2는 수강하지만 course1 은 수강하지 않는 학생들의 이름과 전화번호를 
--    이름 순으로 출력하시오.

select name,phone
from course2
minus
select name, phone
from course1
order by name asc;

--2. 모든 직원들 월급의 평균을 구하시오. 
--       (소수점 이하 둘째자리까지만 나타내고 셋째자리 부터는 절삭하시오)

--	 월급 평균  
    -----------

select trunc(avg(sal), 2) as "월급 평균"
from emp;


--3. 모든 직원들이 받는 커미션의 합을 구하시오.
--	커미션 합
   -----------
   
select sum(comm) as "커미션 합"
from emp;
	  

--4. 각 직급별로 총월급을 출력하되 총월급이 낮은 순으로 출력하시오.

--	직급명    	총월급
	----------------------------
--	xxxx          xxx
--	 :	   :


select job as 직급명, sum(sal) as 총월급
from emp
group by job
order by sum(sal) asc;
--order by 총월급; 으로 해도 됨.
--order by 2(두번째 열); 으로 해도 됨. 하지만 이제 쓰지 않는 쪽으로 지향한다.

--5. 각 부서에서 근무하는 직원들의 명수를 알고싶다. 다음 형식으로 출력하는 SQL
--    을 작성하시오 .

--	부서정보	   직원명수
	----------------------------
--	미정          1명
--	30번 부서   6명
--	20번 부서   4명
--	10번 부서   3명

select nvl2(deptno, TO_CHAR(deptno)||'번 부서', '미정') as 부서정보, count(*)||'명' as 직원명수
from emp
group by deptno;

--2번 방법 : case 구문 사용하기
select case deptno
when 10 then '10번 부서'
when 20 then '20번 부서'
when 30 then '30번 부서'
else '미정' 
end 부서정보,
count(*)||'명' 직원명수
from emp
group by deptno;

-- 3번 방법 : decode 구문 사용하기
select decode(deptno, 10, '10번 부서', 20, '20번 부서', 30, '30번 부서', '미정') 부서정보, count(*)||'명' 직원명수
from emp
group by deptno;




--6. 년도별로 몇명이 입사했는지 알고싶다. 다음 형식으로 출력하는 SQL
--    을 작성하시오 . (많이 입사한 순으로 출력)

--	입사년도 	   입사 인원수
	----------------------------
--	1981년	   10명
--	1987년	   2명
--	1982년	   1명
--	1980년	   1명


select to_char(hiredate, 'YYYY')||'년도' as 입사년도, count(*)||'명' as 직원명수
from emp
group by to_char(hiredate, 'YYYY')
order by count(*) desc;

--7. 전체 직원들의 숫자를 부서정보를 다음 형식으로 출력하는 SQL
--    을 작성하시오 .

--	2019년 12월 27일 기준으로 14명이 근무중입니다.

select to_char(sysdate, 'YYYY"년 "MM"월 "DD"일 "')||'기준으로 '||count(*)||'명이 근무 중입니다.' as 출력형식
from emp;

--8. 직급별 총월급을 출력하되, 직급이 'MANAGER'인 직원들은 제외하시오. 
--   그리고 그 총월급이 5000보다 큰 직급와 총월급만 출력하시오.

--	직급명	총월급
	----------------------------
--	xxxx          xxx
--	 :	   :


select job as 직급명, sum(sal) as 총월급
from emp
where job != 'MANAGER'
group by job
having sum(sal)>5000;

--9. 30번 부서의 업무별 년봉의 평균을 검색한다.
-- 연봉계산은 월급+커미션(null이면 0으로 계산)이며 
-- 출력 양식은 소수점 이하 두 자리(반올림)까지 통일된 양식으로 출력한다.
 --             업무명       평균월급
              ---------------------------
 --             xxxx         xxx.xx
--	              :	           :

select job as 업무명, to_char(round(avg(sal+nvl(comm,0)*12),2), '999,999.00') as 평균월급
from emp
where deptno = 30
group by job;

--10. 월별 입사인원을 다음 형식으로 출력하는 SQL 을 작성하시오 . 
--     입사월별로 오름차순이며 입사인원이 2명 이상인 경우에만 출력한다.


	02월	2명
	04월	2명
	05월	2명
	09월	2명
	12월	3명


select to_char(hiredate, 'MM')||'월' as 월별, count(*)||'명'
from emp
group by to_char(hiredate, 'MM')
having count(*) >= '2'
order by to_char(hiredate, 'MM') asc;
