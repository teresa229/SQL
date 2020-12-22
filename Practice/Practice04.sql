/*Practice03*/ --서브쿼리(SUBQUERY) SQL 문제입니다.

/*
문제1.
평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
(56건)
*/

--평균급여
select avg(salary)
from employees;  --6461.83

--평균 급여보다 적은 급여
select first_name,
       salary
from employees
where salary < (select avg(salary)
                from employees)
                ;
                
--답 : 평균 급여보다 적은 급여 받는 직원은 몇명
select count(salary)
from employees
where salary < (select avg(salary)
                from employees)
                ;



/*
문제2. 
평균급여 이상, 최대급여 이하의 월급을 받는 사원의 
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력하세요 
(51건)
*/
--평균급여 이상, 최대급여 이하의 월급을 받는 사원
select *
from employees;

--평균급여, 최대급여
select avg(salary),
       max(salary)
from employees
group by department_id;

--평균급여 이상(평균급여 6461.83...)
select employee_id,
       first_name,
       salary
from employees
where salary >= (select avg(salary)
                 from employees);

--최대급여 이하(최대급여 24000)
select employee_id,
       first_name,
       salary
from employees
where salary <any (select max(salary)     --<= 값이 다르네;;
                   from employees);
                   
--답 1:  salary, avg(salary), max(salary) 같게 나오지;;      
select employee_id,
       first_name,
       salary,
       avg(salary),
       max(salary)
from employees
where salary >= (select avg(salary)
                 from employees)
      and salary <= (select max(salary)
                     from employees)
group by employee_id, first_name, salary
order by salary asc;                    

--답2- step 1 고민:
select employee_id,
       first_name
from employees
where salary >= (select avg(salary)
                 from employees)
      and salary <= (select max(salary)
                     from employees);  51개
--답2- step 2 고민:                     
select employee_id "직원번호",
       first_name "이름",
       salary "급여",
       avg(salary)"평균급여",
       max(salary)"최대급여"
from employees
group by employee_id, first_name, salary
having  salary >= (select avg(salary)
                   from employees)
        and salary <= (select max(salary)
                       from employees)
order by salary desc;




/*
문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 나라아이디(country_id) 를 출력하세요
(1건)
*/ 
--직원 소속된 부서 주소 알아보기
-- id찾기
select first_name,
       last_name,
       department_id --90
from employees;

-- 답 1:
select lo.location_id,
       lo.street_address,
       lo.postal_code,
       lo.city,
       lo.state_province,
       lo.country_id
from employees emp, departments de, locations lo
where emp.employee_id = de.manager_id
      and de.location_id = lo.location_id
      and first_name in (select first_name
                         from employees
                         where first_name = 'Steven')
      and last_name in (select last_name
                        from employees
                        where last_name = 'King'); --영어 대문자로 동일하게 표현해야 한다.

-- 답 : 용어 수정해 봄.
select de.location_id,
       lo.street_address,
       lo.postal_code,
       lo.city,
       lo.state_province,
       lo.country_id
from employees emp, departments de, locations lo
where emp.employee_id = de.manager_id
      and de.location_id = lo.location_id
      and emp.first_name in (select emp.first_name
                         from employees
                         where emp.first_name = 'Steven')
      and emp.last_name in (select emp.last_name
                        from employees
                        where emp.last_name = 'King'); 

-- 답 2 step1: location_id 1700
select emp.first_name,
       emp.last_name,
       emp.department_id,
       de.department_name,
       de.location_id
from employees emp, departments de
where emp.department_id = de.department_id
      and emp.first_name = 'Steven'
      and emp.last_name = 'King' ;

-- 답 2 step2:
select location_id,
       street_address,
       postal_code,
       city,
       state_province,
       country_id
from locations
where location_id = (select location_id
                     from employee emp, department de
                     where emp.department_id = de.department_id
                     and emp.first_name = 'Steven'
                     and emp.last_name = 'King');
                     
select loc.location_id,
       loc.street_address,
       loc.postal_code,
       loc.city,
       loc.state_province,
       loc.country_id
from locations loc,(select emp.first_name,
                           emp.last_name,
                           emp.department_id,
                           de.department_name,
                           de.location_id
                    from employees emp, departments de
                    where emp.department_id = de.department_id
                    and emp.first_name = 'Steven'
                    and emp.last_name = 'King') empe
where loc.location_id = empe.location_id ;



/*
문제4.
job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로 출력하세요  -ANY연산자 사용
(74건)
*/
--job_id 가 'ST_MAN' 인 직원의 급여
select job_id,
       salary
from employees; --8000, 8200, 7900, 6500, 5800

--job_id 가 'ST_MAN'
select job_id,
       salary
from employees
where job_id = 'ST_MAN';

--보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로 출력
select employee_id "사번",
       first_name || '-' || last_name "이름",
       salary "급여"
from employees
where salary <any (select salary
                   from employees
                   where salary < 8200);
--order by salary desc;

--답
select employee_id "사번",
       first_name || '-' || last_name "이름",
       salary "급여"
from employees
where salary <any (select salary 
                   from employees
                   where job_id = 'ST_MAN')  
order by salary desc; 



/*
문제5. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)
*/
--각 부서별로 최고의 급여를 받는 사원
--직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id) 조회
--조회결과는 급여의 내림차순
--조건절비교, 테이블조인 2가지 방법

--1)급여를 받는 사원
select department_id,
       salary
from employees;  107개

--2)각 부서별로 최고의 급여를 받는 사원
select department_id,
       max(salary)
from employees
group by department_id;  12개

--답 1 정리 : TABLE JOIN
select e.employee_id "직원번호",
       e.first_name "이름",
       e.salary "급여",
       e.department_id "부서번호"
from employees e,(select department_id,
                         max(salary) salary --salary :컬럼명으로 적음. 맨 아랫줄을 위해.
                  from employees
                  group by department_id) s
where e.department_id = s.department_id
and e.salary = s.salary;  

--답 2 정리 : 조건절
select employee_id "직원번호",
       first_name "이름",
       salary "급여",
       department_id "부서번호"
from employees 
where (department_id,salary) in (select department_id,
                                        max(salary)
                                 from employees
                                 group by department_id); 



/*
문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 
(19건)
*/
--각 업무(job) 별로 연봉(salary)의 총합
--연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회

--1)각 업무(job) 별로 연봉(salary)의 총합
select job_id,
       salary
from employees; 107개 나열


--답 : job_title 없음
select job_id,
       sum(salary)
from employees
group by job_id
order by sum(salary) desc;

--답 1:
select job.job_title,
       sum(salary)
from employees emp, jobs job
where emp.job_id = job.job_id
group by job_title
order by sum(salary) desc;

--답 2: 총합이 안나오는 이유??
select job_title,
       salary,
       sum(salary)
from employees emp, jobs job, (select job_id,
                                      sum(salary) sum
                               from employees
                               group by job_id) js
where emp.job_id = job.job_id
--and emp.salary = js.sum
group by job_title,salary
order by salary desc;

--답 3: step 1 업무별 salary 총합
select  job_id,
        sum(salary) salary
from employees
group by job_id;

--답 3: step 2 job_title 조회
select  job_title "업무명",
        job_id "업무아이디"
from jobs;

--답 3: step 3
select  job.job_title "업무명",
        job.job_id "업무아이디",
        emp.salary "연봉총합"
from jobs job, (select  job_id,
                        sum(salary) salary
                from employees
                group by job_id) emp
where job.job_id = emp.job_id
order by emp.salary desc;


/*
문제7.
자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 
(38건)
*/
--자신의 부서 평균 급여
--연봉(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회

--)데이터 확인
select employee_id "직원번호",
       first_name "이름",
       salary "급여",
       department_id
from employees
where salary > (select avg(salary)
                from employees)
                ;   51개
                
--1)각 부서별로 평균급여 테이블
select department_id,
       avg(salary)
from employees
group by department_id
order by department_id asc; 12개 null포함

--답 : 각 부서별로 평균 급여보다 큰 사람
select emp.employee_id "직원번호",
       emp.first_name "이름",
       emp.salary "급여",
       emp.department_id
from employees emp,(select department_id,
                           avg(salary) avgS
                    from employees
                    group by department_id) s
where emp.department_id = s.department_id
      and emp.salary > S.avgS
order by department_id asc;


/*
문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요
*/
--입사일이 11번째에서 15번째의 직원
--사번, 이름, 급여, 입사일을 입사일 순서로 출력

--입사일이 11번째에서 15번째의 직원 확인
select employee_id "직원번호",
       first_name "이름",
       salary "급여",
       hire_date "입사일"
from employees
order by hire_date asc;

--답 출력
select employee_id "직원번호",
       first_name "이름",
       salary "급여",
       hire_date "입사일"
from employees
where hire_date > '03/05/18'
and hire_date < '04/01/28';



