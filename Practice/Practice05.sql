/*Practice05*/ --혼합 SQL 문제입니다.

/*
문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)
*/
--담당 매니저 : 커미션비율이 없고, 월급이 3000초과인 직원
--이름, 매니저아이디, 커미션 비율, 월급

select manager_id,
       first_name,
       commission_pct,
       salary
from employees
where salary > '3000'
and commission_pct is null
and manager_id is not null;


/*
문제2. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)
*/
--부서별로 최고의 급여를 받는 사원
--직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회
--조건절비교
--급여의 내림차순
select *
from employees;

select employee_id "직원번호",
       first_name "이름",
       salary "급여",
       to_char(hire_date,'YYYY-MM-DD day') as "입사일",
       replace(phone_number,'.','-') "전화번호",
       department_id "부서번호"
from employees
where (department_id, salary) in (select department_id,
                                         max(salary)
                                  from employees
                                  group by department_id)
order by salary desc;

/*
문제3
매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.
(9건)
*/
--매니저별로 평균급여 최소급여 최대급여
--매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여

select manager_id,
      -- first_name,
       round(avg(salary),1),
       min(salary),
       max(salary)
from employees
where hire_date > '2005/01/01'
group by manager_id;     16명으로 추려짐.

--테이블에 조인 x
select emp.manager_id,
       emp.first_name,
       mana.round(avg(salary),1),
       mana.min(salary),
       mana.max(salary)
from employees emp, (select manager_id,
                            round(avg(salary),1),
                            min(salary),
                            max(salary)
                     from employees
                     where hire_date > '2005/12/31'
                     group by manager_id) mana
where emp.manager_id = mana.manager_id;

--조건절에 조인
select manager_id,
       first_name,
       round(avg(salary),1),
       min(salary),
       max(salary)
from employees emp
where avg(salary) > 5000
and (manager_id,salary )in (select manager_id,
                                   round(avg(salary),1),
                                   min(salary),
                                   max(salary)
                              from employees
                              where hire_date > '2005/12/31'
                              group by manager_id);
                              
/*                            
문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/
--
select em.employee_id,
       em.first_name,
       de.department_name,
       em.manager_id,
       em.department_id
from employees em,departments de
where em.department_id = de.department_id;

select employee_id,
       first_name,
       manager_id,
       department_id
from employees; -- 178	Kimberely	149	

select em.employee_id,
       em.first_name,
       de.department_name,
       em.manager_id,
       em.department_id
from employees em, employees man, departments de
where em.department_id = de.department_id
and em.employee_id= man.manager_id ;


/*
문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/
--2005년 이후 입사한 직원중
--입사일이 11번째에서 20번째
--사번, 이름, 부서명, 급여, 입사일 출력
--입사일 순서로 출력

select ro.rnum,
       ro.employee_id,
       ro.first_name,
       ro.department_id,
       ro.department_name,
       ro.salary,
       ro.hire_date;

--순서 전
select rownum rnum,
       o.employee_id,
       o.first_name,
       o.department_id,
       o.department_name,
       o.salary,
       o.hire_date
from (select em.employee_id,
             em.first_name,
             em.department_id,
             de.department_name,
             em.salary,
             em.hire_date
             from employees em, departments de
             where hire_date > '05/01/01'
             and em.department_id = de.department_id
             order by hire_date asc) o;

--답: 순서 넣기
select ro.rnum,
       ro.employee_id,
       ro.first_name,
       ro.department_id,
       ro.department_name,
       ro.salary,
       ro.hire_date
from (select rownum rnum,
             o.employee_id,
             o.first_name,
             o.department_id,
             o.department_name,
             o.salary,
             o.hire_date
      from (select em.employee_id,
                   em.first_name,
                   em.department_id,
                   de.department_name,
                   em.salary,
                   em.hire_date
                   from employees em, departments de
                   where hire_date > '05/01/01'
                   and em.department_id = de.department_id
                   order by hire_date asc) o
       )ro
where rnum >= 11
and rnum <= 20;


/*
문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?
*/
--가장 늦게 입사한 직원
--이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)
--데이터 나열
select e.hire_date,
       e.first_name || '-' || last_name,
       e.salary,
       d.department_name
from employees e, departments d
where e.department_id = d.department_id
order by hire_date desc;

--데이터 알고 임의로 정리함.. 공통의 2개를 어떻게 나오게 해야하지?
select ro.rnum,
       ro.hire_date,
       ro.first_name || '-' || ro.last_name,
       ro.salary,
       ro.department_name
from  (select rownum rnum,
              o.hire_date,
              o.first_name,
              o.last_name,
              o.salary,
              o.department_name
       from (select e.hire_date,
                    e.first_name,
                    e.last_name,
                    e.salary,
                    d.department_name
             from employees e, departments d
             where e.department_id = d.department_id
             order by hire_date desc) o
        )ro
where rnum >= 1
and rnum < 3 ;



/*
문제7.
평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
*/
--평균연봉(salary)이 가장 높은 부서 직원들
--직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회

select *
from employees;

--부서별 평균연봉 정보
select avg(salary),
       department_id
from employees
group by department_id
order by avg(salary) desc; -->department id = 90



/*
문제8.
평균 급여(salary)가 가장 높은 부서는? 
*/ 
--부서별 평균연봉 정보
select de.department_id,
       de.department_name,
       em.employee_id,
       avg(salary)
from employees em, departments de
where em.department_id = de.department_id
order by avg(salary) desc;

--order by avg(salary) desc;


/*
문제9.
평균 급여(salary)가 가장 높은 지역은? 
*/



/*
문제10.
평균 급여(salary)가 가장 높은 업무는? 
*/



