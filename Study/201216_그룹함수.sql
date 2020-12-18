/*************************
*그룹함수
**************************/


--오류발생   -> 이유 공부해둘 것
select avg(salary), --한개
       first_name   --여러개 값이라 오류
from employees;

--그룹함수 avg()
select avg(salary)
from employees;

--그룹함수 count()
select count(*) ---null과 상관없이 알려줌. null포함.
from employees;

select count(commission_pct) --commission_pct 컬럼의 null포함하지 않는다.
from employees;

select count(*) -조건절 추가
from employees
where salary>16000;

--그룹함수 sum()
select sum(salary), count(*)
from employees;

--그룹함수 - avg()
--1. avg()
select count(*),
       sum(salary),
       avg(salary) 
from employees;

--2. avg()
select count(*),
       sum(salary),
       avg(nvl(salary,0)) --null을 0처리
from employees;

--﻿그룹함수 - max() / min()
select max(salary)
from employees;

select min(salary)
from employees;

--정렬이 필요한 경우 많은 연산을 수행해야 한다.
select max(salary),
       min(salary),
       count(*)
from employees;

/***********
*group by 절
***********/
select department_id,
       avg(salary)
from employees;  --오류

select department_id,
       avg(salary)
from employees
group by department_id
order by department_id asc;

--GROUP BY 절 - 자주하는 오류
select department_id, --그룹
       count(*)       --그룹
       sum(salary),   --그룹
   --  job_id         --개별로 여러개라 들어갈 수 없다. 표현할 수 없다.
from employees
group by department_id; --/오류

--정상 Group에 들어있는 department_id, job_id
select department_id,
       job_id,
       count(*),
       sum(salary),
       avg(salary)
from employees
group by department_id, job_id   --대분류, 소분류
order by department_id asc;

--[예제]
--연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력하세요
select department_id "부서번호",
       count(*) "인원수",
       sum(salary) "급여합계"
from employees
where sum(salary) >= 20000 --그룹함수는 where쓰지 못한다.
group by department_id, employee_id;

--having 절
select department_id "부서번호",
       count(*) "인원수",
       sum(salary) "급여합계"
from employees
group by department_id
having sum(salary)>= 20000;
--and department_id = 100;

/*********
*CASE ~ END 문
**********/

select employee_id,
       salary,
       job_id,
       case when job_id = 'AC_ACCOUNT' then salary*0.1
            when job_id = 'SA_REP' then salary*0.2
            when job_id = 'ST_CLERK' then salary*0.3
            else salary*0
       end bonus
from employees;

       case when job_id >=5000 then salary*0.1
            when job_id >= 3000 then salary*0.2
            when job_id >= 1000 then salary*0.3   --job_id 범위 수정이 불가능하다.
            else salary*0

select employee_id,
       salary,
       job_id,
       decode(job_id,'AC_ACCOUNT',salary*0.1
                     'SA_REP', salary*0.2
                     'ST_CLERK', salary*0.3
                     salary*0
              )as bonus
from employees;

--[예제]
--직원의 이름, 부서, 팀을 출력하세요
--팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’ 60~100이면 ‘B-TEAM’ 110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요.
select  first_name || '-' || last_name "Name",
        department_id,
        case when department_id >= 10 and department_id <= 50 then 'A-TEAM'
             when department_id >= 60 and department_id <= 100 then 'B-TEAM'
             when department_id >= 110 and department_id <= 150 then 'c-TEAM'
             else '팀없음'    -- else employee_id>150 then '팀없음'
         end as team
from employees;

select*
from employees;