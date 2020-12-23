/********************************************
*rownum
*********************************************/
--급여를 가장 많이 받는 5명의 직원의 이름을 출력하세요

--rownum 이 order by보다 먼저 생겨서 번호가 섞인다.
select rownum as num,
       employee_id,
       first_name,
       salary
from employees
order by salary desc;

--정렬하고 rownum을 사용
select rownum,
       o.employee_id,
       o.first_name,
       o.salary
from (select emp.employee_id,
             emp.first_name,
             emp.salary
      from employees emp
      order by salary desc) o --salary로 정렬된다.
where rownum >=1 --where절 조건이 2부터 오류가 난다. --계속 'rownum 1'이 되어 통과가 안된다. 해당되는 것이 없다.
and rownum <=5;

--일련번호주고 바로 조건을 판단해서
select*
from '정렬,일련번호' or
where rownum >=11
and rownum <=20;

--
select ro.rnum,
       ro.employee_id,
       ro.first_name,
       ro.salary
from (select rownum rnum,
              o.employee_id,
              o.first_name,
              o.salary
       from (select emp.employee_id,
                    emp.first_name,
                    emp.salary
             from employees emp
             order by salary desc) o
      )ro
where rnum >= 1
and rnum <= 5;


/********************************************/
--예제
--07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? 
--07년에 입사한 직원
--급여가 많은 직원중 3에서 7등
--이름 급여 입사일 출력

select hire_date,
       first_name,
       salary
from employees
where hire_date > '07/01/01'
order by salary desc;


--순서 정렬
select rownum rnum,
       o.hire_date,
       o.first_name,
       o.salary
from (select hire_date,
             first_name,
             salary
      from employees
      where hire_date > '07/01/01'
      order by salary desc)o;

--정리
select ro.rnum,
       ro.hire_date,
       ro.first_name,
       ro.salary
from (select rownum rnum,
             o.hire_date,
             o.first_name,
             o.salary
      from (select hire_date,
                   first_name,
                   salary
            from employees
            where hire_date >= '07/01/01'
            and hire_date <= '07/12/31' ---07년 범위 설정 주의
            order by salary desc)o
            )ro   --rownum와 order by 모두 만족하게 만들었다는 의미가 있다. 
where rnum >= 3
and rnum <= 7;