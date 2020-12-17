--����Ʈ ��
select * from employees;

select * DEPARTMENTS_SEQ.nextval

?select emplyee_id, first_name, last_name from emplyees;

select employee_id, first_name, last_name from employees;
--����� �̸��� ��ȭ��ȣ �Ի��� ������ ����ϼ���.
select first_name,
       phone_number,
       hire_date,
       salary
       from employees;
       
/*����� �� �÷��� ���� ����ϱ�*/
select employee_id as empNo, -- as��������.
       first_name "f- Name", --Ư�����ڸ� ������,��ҹ���,���� ����ǥ �ֱ�
       salary "����"
from employees;

--���� 1
select first_name "�̸�",
       phone_number "��ȭ��ȣ",
       hire_date "�Ի���",
       salary "�޿�",
from employees;

--���� 2
select employee_id "�����ȣ",
       first_name "�̸�",
       last_name "��",
       salary "�޿�",
       phone_number "��ȭ��ȣ",
       email "�̸���",
       hire_date "�Ի���"
from employees;

/*���� ������(Concatenation)�� �÷��� ���̱�*/
select first_name || last_name
from employees;

select first_name || ' ''hire date is'' ' || last_name as name
from employees;


/*��� ������ ����ϱ�*/
select job_id
from employees;

--����
select first_name || '-' || last_name as ����,
       salary �޿�,
       salary*12 as ����,
       salary*12+5000 as ����2,
       phone_number as ��ȭ��ȣ
from employees;

/*select�� where�� */
select first_name
from employees
where department_id = 10;

--����
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
where first_name = 'Lex'; --��ġ�ϴ� �͸� ã�Ƴ�.

--����
/*������ 14000 �����̰ų� 17000 �̻��� ����� �̸��� ������ ����ϼ���*/
select first_name,
       salary
from employees
where salary <=14000
      or salary >=17000;
      
/*�Ի����� 04/01/01 ���� 05/12/31 ������ ����� �̸��� �Ի����� ����ϼ���*/
select first_name,
       hire_date
from employees
where hire_date >= '04/01/01'
      and hire_date <= '05/12/31';
      
/* BETWEEN �����ڷ� Ư������ �� ����ϱ� */
select first_name,
       salary
from employees
where salary between 14000 and 17000;   
   
--between ���� ǥ��
select first_name,
       salary
from employees
where salary >= 14000 
      and salary <= 17000;

/*IN �����ڷ� ���� ������ �˻��ϱ� */   
select first_name,
       last_name,
       salary
from employees
where first_name in('Neena','Lex','John');

--in ���� ǥ�� 
select first_name,
       last_name,
       salary
from employees
where first_name = 'Neena'
      or first_name = 'Lex'
      or first_name = 'John';

--����
select first_name,
       last_name,
       salary
from employees
where salary in (2100,3100,4100,5100);


/*Like �����ڷ� ����Ѱ͵� ��� ã��*/
select first_name,
       last_name,
       salary
from employees
where first_name like 'L%'; --ù���ڰ� L

--like������
select first_name,
       last_name,
       salary
from employees
where first_name like '_L__'; -- ù���� �ǹ� '_' , ��ü�� 4������ ����.


select first_name,
       last_name,
       salary
from employees
where first_name like '%am'; -- % : ����ڵ� ��������� am���� ������ ���̵��� ���� �Ͷ�.
--'%a%' :��𿡴� a�� ������ ���´�.
--'A%'  : A�빮�� a�� �����ϴ� ����
--'%a'; : �������� a
--'%am%'; : am�� ���� ����
--'_a'; : �α����ε� �ι�° ���ڰ� a
--'_a%'; : �ι�° ���ڰ� a �ڿ��� ����ڰ� ������ ����� ����.
--'_a___'; : �ι�° ���ڰ� a�̰� ��ü 4������ ���

--����


--�̸��� am �� ������ ����� �̸��� ������ ����ϼ���
select first_name,
       salary
from employees
where first_name like '%am%';

--�̸��� �ι�° ���ڰ� a �� ����� �̸��� ������ ����ϼ���
select first_name,
       salary
from employees
where first_name like '_a%';

--�̸��� �׹�° ���ڰ� a �� ����� �̸��� ����ϼ���
select first_name,
       salary
from employees
where first_name like '___a';

--�̸��� 4������ ����� ������ �ι�° ���ڰ� a�� ����� �̸��� ����ϼ���
select first_name || '-' || last_name ����,
       salary
from employees
where first_name like '__a_';

/*NULL*/
-- �������̺��� �޿��� 13000���� 15000 ������
-- ������ �̸�, �޿�, Ŀ�̼�%, �޿�*Ŀ�̼� ����ϼ���.
select first_name,
       salary,
       commission_pct,
       salary*commision_pct
from employees
where salary between 13000 and 15000;

/*Ŀ�̼Ǻ����� �ִ� ����� �̸��� ���� Ŀ�̼Ǻ����� ����ϼ���
���Ŵ����� ���� Ŀ�̼Ǻ����� ���� ������ �̸��� ����ϼ���
*/
--Ŀ�̼Ǻ����� �ִ� ����� �̸��� ���� Ŀ�̼Ǻ����� ����ϼ���
select first_name,
       commision_pct
from employees
where commission_pct is not null;

--���Ŵ����� ���� Ŀ�̼Ǻ����� ���� ������ �̸��� ����ϼ���
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

select��
  select��
  from��
  where��
  order by �� ����
  

       first_name
--[����]
--�μ���ȣ�� ������������ �����ϰ� �μ���ȣ, �޿�, �̸��� ����ϼ���
select department_id,
       first_name,
       salary
from employees
order by department_id asc;

--�޿��� 10000 �̻��� ������ �̸� �޿��� �޿��� ū�������� ����ϼ���
select first_name,
       salary
from employees
where salary>=10000
order by salary desc;

--�μ���ȣ�� ������������ �����ϰ� �μ���ȣ�� ������ �޿��� ���� ������� �μ���ȣ �޿� �̸��� ����ϼ���  
select department_id as "�μ���ȣ",
       salary as "�޿�",
       first_name as "�̸�"
from employees
order by department_id asc, salary desc;

--[����]
--�μ���ȣ�� ������������ �����ϰ� �μ���ȣ, �޿�, �̸��� ����ϼ���
select department_id as "�μ���ȣ",
       salary as "�޿�",
       first_name as "�̸�"
from employees
order by department_id asc; 

--�޿��� 10000 �̻��� ������ �̸� �޿��� �޿��� ū�������� ����ϼ���
select first_name as "�̸�",
       salary as "�޿�"
from employees
where salary >= 10000
order by salary desc;

--�μ���ȣ�� ������������ �����ϰ� �μ���ȣ�� ������ �޿��� ���� ������� �μ���ȣ �޿� �̸��� ����ϼ���
select department_id as "�μ���ȣ",
       salary as "�޿�",
       first_name as "�̸�"
from employees
order by department_id asc, salary desc;

