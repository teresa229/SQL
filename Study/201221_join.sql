/*****************
*join
*****************/

--카티젼 프로덕트(Cartesian Product) --> where절이 없는 경우
select first_name,
       department_name
from employees, departments;

select first_name,
       department_name,
       em.department_id
from employees em, departments de
where em.department_id = de.department_id;

--uniq join
select first_name,
       em.department_id, 
       department_name,
       de.department_id
from   employees em, departments de
where  em.department_id = de.department_id;

--예제
--모든 직원이름
select em.first_name,
       jo.job_title,
       de.department_name
from employees em, job jo, departments de
where em.job_id = jo.job_id
and em.department_id = de.department_id;
 
--left join
select em.department_id,
       em.first_name,
       de.department_id
from employees em left outer join departments de
on em.department_id = de.department_id;

--left join --> 오라클 표현
select  em.department_id, 
        em.first_name, 
        de.department_name
from employees em, departments de
where em.department_id = de.department_id(+); 

/*비교 파일
select em.department_id
from employees em, departments de
where em.department_id = de.department_id;

select de.department_id
from employees em, departments de
where em.department_id = de.department_id;
*/

--right join
select em.department_id,
       em.first_name,
       de.department_name
from employees em right outer join departments de
on em.department_id = de.department_id;

--right join --> 오라클 표현
select  em.department_id, 
        em.first_name, 
        de.department_name
from employees em, departments de
where em.department_id(+) = de.department_id; 


--right 조인 -> left조인  :방향만 바꾸어 버린다. 값은 같다.
select em.department_id,
       em.first_name,
       de.department_name
from departments de left outer join employees em 
on em.department_id = de.department_id;

--full outer join
select em.department_id,
       em.first_name,
       de.department_name,
       de.department_id
from employees em full outer join departments de
on em.department_id = de.department_id;

-- 잘못 사용한 경우
select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from employees em, departments de
where em.department_id(+) = de.department_id(+) ;   -- 사용X


--alias 알리아스
--테이블 명 alias 설정하면 계속 사용해야 한다.
select em.department_id,
       em.first_name,
       de.department_name,
       de.department_id
from employees em , departments de
where em.department_id = de.department_id;


--오류
select  employees.department_id, --테이블명 alias 사용
        em.first_name,
        de.department_name,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id
order by em.department_id desc;


--join 실행순서 체크
select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id
order by em.department_id desc;    --order by 부분 이상할 수 있으니 생각해 볼것


--full outer join : null 모두 포함.
select e.department_id, e.first_name, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id ; 


--self join
select emp.employee_id, emp.first_name, 
       emp.manager_id, man.first_name as manager 
from employees emp, employees man
where emp.manager_id = man.employee_id;


--잘못된 사용예 :오류가 안나고 만들어 질 때도 있다.
select*
from employees em, locations lo
where em.salary = lo.location_id; --우연히 숫자가 맞은 것임. 급여와 주소가 같게 읽어버리는 상황

select *
from departments;

select *
from employees;