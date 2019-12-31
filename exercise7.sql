--생성 파일명 : exercise7.sql

-- 모든 실습문제는 EMP와 DEPT 테이블의 데이터 보존을 위해 명령을 수행하고
-- 변경된 것을 확인한 다음 ROLLBACK 명령을 수행한다.

-- [ 테스트 순서 : 꼭!! ]
-- 변경전 확인
-- 문제에서 요구되는 DML 문 수행
-- 변경후 확인
-- rollback

-- 1. EMP 테이블에서 직원번호가 7499번인 직원의 월급을 5000달러로 변경한다.

update emp
set sal = 5000
where empno = '7499';

ROLLBACK;

-- 2. EMP테이블에서 부서번호가 20번인 직원들의 월급을 현재 월급에서 10% 인상한 금액으로 변경한다.

update emp
set sal = sal + (sal*0.1)
where deptno = '20';

rollback;


-- 3. DEPT 테이블에 아래의 조건으로 데이터를 입력한다.
-- 부서번호: 50, 부서위치: BOSTON,  부서명: RESERCH

insert into dept (deptno, loc, dname)
values (50, 'BOSTON', 'RESERCH');

rollback;

-- 4. EMP 테이블에 아래와 같은 데이터를 삽입한다.
-- 직원번호: 9900, 직원이름: JACKSON, 직업: SALESMAN, 부서번호: 10, 월급 : 800

insert into emp (empno, ename, job, deptno, sal)
values (9900, 'JACKSON', 'SALESMAN', 10, 800);

rollback;

-- 5. DEPT 테이블에 아래의 조건으로 데이터를 입력한다.
-- 부서번호: 60, 부서위치: NULL,  부서명: MARKETING

insert into dept (deptno, loc, dname)
values (60, NULL, 'MARKETING');

rollback;

-- 6. 직원번호가 7698번인 직원의 부서번호를 7369번 직원의 
-- 부서번호로 변경한다.

update emp
set deptno = (select deptno from emp where empno = '7698')
where deptno = (select deptno from emp where empno = '7369');

rollback;

--이런 방법으로도 가능.

update emp
set deptno = (select deptno from emp where empno = '7369')
where empno = 7698;

rollback;

-- 7. 20번 부서의 직원들을 모두 삭제한다.

delete from emp
where deptno = '20';

rollback;


-- 8. 월급이 1000 이하인 직원들을 삭제한다.

delete from emp
where sal <= '1000';

rollback;


-- 9. 직원번호가 7900 인 직원의 월급을 현재 월급에서 5% 증가시키고
         부서번호를 40으로 변경한다.
         
update emp
set  sal = sal*1.05, deptno = 40
where empno = 7900;

rollback;

-- 10. 현재를 기준으로 입사한지 38년 이상인 직원들에 대하여 
--          월급을 2배로 변경하고 커미션도 3000으로 변경한다.
--         (입사일은 년도를 기준으로 반올림하여 계산한다.)

update emp
set sal = sal*2, comm = 3000
where to_char(sysdate, 'YYYY') - to_char(round(hiredate, 'YYYY'), 'YYYY')>=38;

rollback;
