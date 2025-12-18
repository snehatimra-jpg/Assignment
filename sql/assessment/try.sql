create database try;

use try;

create table employees(
Employee_id int auto_increment primary key, 
name  varchar (100),
position varchar (100), 
salary decimal (10, 2), 
hire_date date);

create table employee_audit(
audit_id int auto_increment primary key,
employee_id int,
name varchar(100),
position varchar(100),
salary decimal(10,2),
hire_date date,
action_date timestamp default current_timestamp);

insert into employees (name, position, salary, hire_date) VALUES 
('John Doe', 'Software Engineer', 80000.00, '2022-01-15'), 
('Jane Smith', 'Project Manager', 90000.00, '2021-05-22'), 
('Alice Johnson', 'UX Designer', 75000.00, '2023-03-01');

select * from employees;
 
delimiter $$
create procedure getemployees(in ename varchar(100), in eposition varchar(100), in esalary decimal(10,2), in ehire_date date)
begin
			insert into employees( name, position, salary, hire_date) 
            values(ename, eposition, esalary, ehire_date);
end $$ ;
call getemployees('mona timra', 'nurse', 35000.00, '2025-10-20');

delimiter $$ ;
create trigger employee_insert
after insert on employees
for each row
begin
    insert into employee_audit
    (employee_id, name, position, salary, hire_date)
    values
    (new.Employee_id, new.name, new.position, new.salary, new.hire_date);
end $$ ;

select * from employee_audit;
