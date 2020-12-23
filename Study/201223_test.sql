/*
test
*/

--조건절
select department_id,
       employee_id,
       first_name,
       salary
from employees
where (department_id, salary) in (select department_id,                        
                                  max(salary)
                                  from employees
                                  group by department_id);

--테이블에서 조인
select e.department_id,
       e.employee_id,
       e.first_name,
       e.salary
from employees e, (select department_id, max(salary) salary
                   from employees
                   group by department_id) s 
where e.department_id = s.department_id
and e.salary = s.salary;


select department_id, max(salary) salary
                   from employees
                   group by department_id;
