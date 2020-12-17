/*단일행 함수*/
--문자함수 – INITCAP(컬럼명)
select email,
       initcap(email), --첫글자 대문자
       department_id
from employees
where department_id = 100;

--문자함수 – LOWER(컬럼명) / UPPER(컬럼명)
select first_name,
       lower(first_name),
       upper(first_name)
from employees
where department_id = 100;

--문자함수 – SUBSTR(컬럼명, 시작위치, 글자수) 일부 가져오기
select first_name,
       substr(first_name,3),
       substr(first_name,1,3), --1번부터 3번까지 잘라라. 파라미터3개
       substr(first_name,-3,2) 
from employees
where department_id = 100;

--문자함수 – LPAD(컬럼명, 자리수, ‘채울문자’) /  RPAD(컬럼명, 자리수, ‘채울문자’)
select first_name,
       lpad(first_name,10,'*'),
       rpad(first_name,10,'*'), 
from employees
where department_id = 100;

--문자함수 – REPLACE (컬럼명, 문자1, 문자2)
select first_name,
       replace(first_name,'a','*'),
       department_id
from employees
where department_id = 100;

--함수 조합
select first_name,
       replace(first_name, 'a', '*'),
       substr(first_name, 2, 3),
       replace(first_name,substr(first_name, 2, 3), '*') --a가 아니라 두번째를 별표로 바꾸겠다.
from employees
where department_id = 100;

--숫자함수 – ROUND(숫자, 출력을 원하는 자리수) 
--테이블이 필요없는 경우. 가상의 테이블 dual을 만들어 줌. select와 from은 짝이다.
select round(123.456, 2) r2,  --r2 별명  --r-1 -기호때문에 따옴표 필요. 이름이 없는 경우
       round(123.456, 0) r0,
       round(123.456, -1) "r-1"
from dual;

--응용
select salary,
       round(salary, -3) "sR2" --대소문자를 맞추기 위해 "" 나머지는 ''작은 따옴표
from employees;

--숫자함수 – TRUNC(숫자, 출력을 원하는 자리수) 
select trunc(123.456, 2) r2,
       trunc(123.456, 0) r0,
       trunc(123.456, -1) "r-1"
from dual;

--날짜함수 – SYSDATE 과로가 없어..함수라고 하기도 애매하다.
select sysdate
from dual;

select sysdate,
       first_name
from employees;

--단일함수>날짜함수 – MONTH_BETWEEN(d1, d2) 
select sysdate,
       hire_date,
       months_between(sysdate,hire_date) as "workMonth",
       trunc(months_between(sysdate,hire_date),0) "근무개월"
from employees
where department_id = 100;

--날짜 함수 Last_day(d1) -- 그달의 마지막날
select last_day('20/06/06'),
       last_day(sysdate)
from dual;

--변환함수
--to_char(숫자, '출력모양') 숫자형 -> 문자형으로 변환하기
select first_name,
       salary,
       salary*12,
       to_char(salary*12,'$999,999.00'),
       to_char(salary*12,'999,999.00'),
       to_char(salary*12,'999,999')
from employees
where department_id = 100;

--TO_CHAR(숫자, ‘출력모양’)  숫자형문자형으로 변환하기
select sysdate,
       to_char(sysdate,'YYYY') YYYY,
       to_char(sysdate,'YY') YY,
       to_char(sysdate,'MM') MM,
       to_char(sysdate,'MONTH') MONTH,
       to_char(sysdate,'DD') DD,
       to_char(sysdate,'DAY') DAY,
       to_char(sysdate,'HH') HH,
       to_char(sysdate,'HH24') HH,
       to_char(sysdate,'HH') MI,
       to_char(sysdate,'SS') SS
from dual;

--변환함수>TO_CHAR(날짜, ‘출력모양’)  날짜문자형으로 변환하기
select sysdate,
       to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'),
       to_char(sysdate,'YYYY/MM/DD'),
       to_char(sysdate,'YYYY"년"MM"월"DD"일"')
from dual;

--EMPLOYEES 시분초 꺼내기
select first_name,
       hire_date,
       to_char(hire_date,'YYYY-MM-DD HH24:MI:SS') --hire_date에는 시분초가 없었다. 00:00:00
from employees;

--일반함수>NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)
select first_name,
       commission_pct,
       NVL(commission_pct,0), --NULL일 경우 가져온 값을 넣어달라.
       NVL2(commission_pct,100,0) --null아닐때값, null일때 값
from employees;