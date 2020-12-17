--셀렉트 문
select * from employees;

select * DEPARTMENTS_SEQ.nextval

?select emplyee_id, first_name, last_name from emplyees;

select employee_id, first_name, last_name from employees;
--사원의 이름과 전화번호 입사일 연봉을 출력하세요.
select first_name,
       phone_number,
       hire_date,
       salary
       from employees;
       
/*출력할 때 컬럼에 별명 사용하기*/
select employee_id as empNo, -- as생략가능.
       first_name "f- Name", --특수문자를 넣으면,대소문자,공백 따옴표 넣기
       salary "연봉"
from employees;

--예제 1
select first_name "이름",
       phone_number "전화번호",
       hire_date "입사일",
       salary "급여",
from employees;

--예제 2
select employee_id "사원번호",
       first_name "이름",
       last_name "성",
       salary "급여",
       phone_number "전화번호",
       email "이메일",
       hire_date "입사일"
from employees;

/*연결 연산자(Concatenation)로 컬럼들 붙이기*/
select first_name || last_name
from employees;

select first_name || ' ''hire date is'' ' || last_name as name
from employees;


/*산술 연산자 사용하기*/
select job_id
from employees;

--예제
select first_name || '-' || last_name as 성명,
       salary 급여,
       salary*12 as 연봉,
       salary*12+5000 as 연봉2,
       phone_number as 전화번호
from employees;

/*select문 where절 */
select first_name
from employees
where department_id = 10;

--예제
select first_name,
       salary
from employees
where salary >= 15000;

select first_name,
       hire_date
from employees
where hire_date >= '07.01.01';

select first_name,
       salary
from employees
where first_name = 'Lex'; --일치하는 것만 찾아냄.

--예제
/*연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요*/
select first_name,
       salary
from employees
where salary <=14000
      or salary >=17000;
      
/*입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요*/
select first_name,
       hire_date
from employees
where hire_date >= '04/01/01'
      and hire_date <= '05/12/31';
      
/* BETWEEN 연산자로 특정구간 값 출력하기 */
select first_name,
       salary
from employees
where salary between 14000 and 17000;   
   
--between 같은 표현
select first_name,
       salary
from employees
where salary >= 14000 
      and salary <= 17000;

/*IN 연산자로 여러 조건을 검사하기 */   
select first_name,
       last_name,
       salary
from employees
where first_name in('Neena','Lex','John');

--in 같은 표현 
select first_name,
       last_name,
       salary
from employees
where first_name = 'Neena'
      or first_name = 'Lex'
      or first_name = 'John';

--예제
select first_name,
       last_name,
       salary
from employees
where salary in (2100,3100,4100,5100);


/*Like 연산자로 비슷한것들 모두 찾기*/
select first_name,
       last_name,
       salary
from employees
where first_name like 'L%'; --첫글자가 L

--like연산자
select first_name,
       last_name,
       salary
from employees
where first_name like '_L__'; -- 첫글자 의미 '_' , 전체가 4글자인 아이.


select first_name,
       last_name,
       salary
from employees
where first_name like '%am'; -- % : 몇글자든 상관없지만 am으로 끝나는 아이들을 갖고 와라.
--'%a%' :어디에는 a가 있으면 나온다.
--'A%'  : A대문자 a로 시작하는 글자
--'%a'; : 마지막에 a
--'%am%'; : am이 들어가는 글자
--'_a'; : 두글자인데 두번째 글자가 a
--'_a%'; : 두번째 글자가 a 뒤에는 몇글자가 나오든 상관이 없다.
--'_a___'; : 두번째 글자가 a이고 전체 4글자인 경우

--예제


--이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
select first_name,
       salary
from employees
where first_name like '%am%';

--이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
select first_name,
       salary
from employees
where first_name like '_a%';

--이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select first_name,
       salary
from employees
where first_name like '___a';

--이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select first_name || '-' || last_name 성명,
       salary
from employees
where first_name like '__a_';

/*NULL*/
-- 직원테이블에서 급여가 13000에서 15000 사이인
-- 직원의 이름, 급여, 커미션%, 급여*커미션 출력하세요.
select first_name,
       salary,
       commission_pct,
       salary*commision_pct
from employees
where salary between 13000 and 15000;

/*커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
*/
--커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select first_name,
       commision_pct
from employees
where commission_pct is not null;

--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select first_name,
       manager_id,
       commission_pct
from employees
where manager_id is null
      and commission_pct is null;

/*PK*/
select email
from employees
where employee_id = 110;

select문
  select절
  from절
  where절
  order by 절 정렬
  

       first_name
--[예제]
--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select department_id,
       first_name,
       salary
from employees
order by department_id asc;

--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select first_name,
       salary
from employees
where salary>=10000
order by salary desc;

--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요  
select department_id as "부서번호",
       salary as "급여",
       first_name as "이름"
from employees
order by department_id asc, salary desc;

--[예제]
--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select department_id as "부서번호",
       salary as "급여",
       first_name as "이름"
from employees
order by department_id asc; 

--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select first_name as "이름",
       salary as "급여"
from employees
where salary >= 10000
order by salary desc;

--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요
select department_id as "부서번호",
       salary as "급여",
       first_name as "이름"
from employees
order by department_id asc, salary desc;

