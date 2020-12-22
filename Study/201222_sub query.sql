/**********************
*sub Query
***********************/
  
-- SubQuery > 하나의 SQL 질의문 속에 다른 SQL 질의문이 포함되어 있는 형태
-- #1 'Den'(11000)보다 급여를 많이 받는 사람의 이름과 급여 출력
select first_name,
       salary
from employees
where first_name = 'Den'; --11000

select first_name,
       salary
from employees
where salary > 11000;
-- ※'Den'의 급여가 변경될 경우 사용 불가

- #2 'Den'(11000)보다 급여를 많이 받는 사람의 이름과 급여 출력
select first_name,
       salary
from employees
where salary > (select salary
                from employees
                where first_name = 'Den');

-- 단일행 SubQuery > SubQuery의 결과가 1개의 Row인 경우

--예제)
--급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
--1. 가장 적은 급여 액수
--2. 2100을 받는 직원의 이름, 급여, 사원번호는?
--3. 질문 조합

--1)
select min(salary)
from employees;

--2) 2100을 받는 직원의 이름, 급여, 사원번호는?
--3) 질문 조합
select first_name,
       salary,
       employee_id
from employees
where salary = (select min(salary)
                from employees);

--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
--1. 평균 급여 3000
--2. 3000보다 작은 사람 리스트
--3. 조합

--1) 평균 급여 6461.83
select avg(salary)
from employees;

--2) 6461.83 보다 작은 사람 리스트
select first_name,
       salary
from employees
where salary < 6461.83; --평균급여가 변경될 경우 사용 불가

--3) 조합
select first_name,
       salary
from employees
where salary < (select avg(salary)
                from employees);
                
                
--예제)
--부서번호가 110인 직원의 급여와 같은
--사번, 이름, 급여 출력
--step 1. 부서번호 110인 직원의 이름, 급여,...리스트
select first_name,
       salary,
       department_id
from employees
where department_id = 110;

--step 2. 전체직원 중 급여가 12008, 8300인 직원
select employee_id,
       first_name,
       salary
from employees
where salary = 12008
or salary = 8300;

select employee_id,
       first_name,
       salary
from employees
--where salary in (12008,8300);
where salary in (select salary
                 from employees
                 where department_id = 110);  --여러개 나올지 한개가 나올지 '연산자'를 결정해 주어야 한다.

--step.2-1 >> JOIN(SubQuery ANY)
select employee_id,
       first_name,
       salary
from employees
where salary >any (select salary  -- OR연산자 >> salary > 8300
                   from employees
                   where department_id = 110);

--step.2-2 >> JOIN(SubQuery ALL)                  
select employee_id,
       first_name,
       salary
from employees
where salary >all (select salary  -- AND연산자 >> salary > 12008
                   from employees
                   where department_id = 110);                  

-- TABLE JOIN
--예제)
--각 부서별로 최고급여를 받는 사원을 출력하세요
--부서별 분리,
select *
from employees
where salary in max(salary);

--1. 비교할 리스트 만들었다.
select --employee_id --﻿group by의 문법으로 인해 못 구함.
       department_id,
       max(salary)
from employees
group by department_id;
/*  값 확인 위해.
select first_name,
       salary
from employees
where department_id=100;
*/

--다중행 변환
--각 부서별로 최고급여를 받는 사원 출력
select first_name,
       employee_id,
       salary,  --       max(salary)
       department_id
from employees
where (department_id, salary) in ( select department_id,
                                          max(salary)
                                     from employees
                                     group by department_id);

--ANY
--예제)
--부서번호가 110인 직원의 급여보다 큰 모든 직원의
--사번, 이름, 급여 출력 (OR -> 8300보다 큰)

--부서번호 100인 직원의 급여 리스트
select salary
from employees
where department_id = 110; --12008, 8300

--비교 1)
select employee_id,
       first_name,
       salary
from employees
where salary > 12008;

--비교 2)
select employee_id,
       first_name,
       salary
from employees
where salary > 8300;

-- >any  or연산자: salary>8300
select employee_id,
       first_name,
       salary
from employees
where salary >any (select salary
                   from employees
                   where department_id = 110)
                   ;
                   
select employee_id,
       first_name,
       salary
from employees
where salary >all (select salary
                   from employees
                   where department_id = 110)
                   ;
                   
-- sub Query로 테이블 자리 --> join으로 사용
-- 각 부서별로 최고급여를 받는 사원을 출력하세요
-- 1. 각 부서별로 최고 급여 테이블
select department_id,
       max(salary)
from employees
group by department_id;

--2. 직원테이블 (1)테이블을 join한다.
select e.employee_id,
       e.first_name,
       e.salary eSalary,
       e.department_id,
       s.department_id,
       s.salary sSalary
from employees e, (select department_id,
                          max(salary) as salary
                   from employees
                   group by department_id) s
where e.department_id = s.department_id
and e.salary = s.salary