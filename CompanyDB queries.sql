drop table if exists Employee;
drop table if exists Department;
create table Employee(
EmpID int primary key,
[Name] varchar(50),
DeptID int,
Salary decimal(10,2),
JoinDate date
);

create table Department(
DeptID int primary key,
DeptName varchar(50)
);

insert into Department values
( 1, 'HR'),
(2, 'IT'),
(3, 'Finance');

insert into Employee values
(101, 'Alice', 1, 50000, '2022-01-15'),
(102, 'Bob', 2, 60000, '2021-06-10'),
(103, 'Charles', 2, 70000, '2020-11-01'),
(104, 'Daisy', 3, 65000, '2023-02-20'),
(105, 'Emily', 1, 55000, '2022-12-01');

select * from Employee;
select * from Department;

insert into Employee values
(106, 'Frank', 3, 62000, '2023-04-10');

update Employee set salary = 58000 where Name = 'Emily';

delete from Employee where EmpID = 106;

select [Name], Salary from Employee;

select * from Employee where DeptID = 2;

select * from Employee where Salary > 60000;

select Name, upper(Name) as UpperName, len(Name) as NameLength from Employee;

select Name, substring(Name, 1, 3) as ShortName from Employee;

select Name, datediff(Day, JoinDate, getdate()) as DaysInCompany from Employee;

select DeptID, count (*) as EmployeeCount from Employee group by DeptID;

select avg(Salary) as AvgSalary from Employee;

select DeptID, sum(Salary) as TotalSalary from Employee group by DeptID;

select * from Employee where DeptID in (1,2);

select max(Salary) as HighestSalary from Employee;

select DeptID, count(EmpID) as EmpCount from Employee group by DeptID;

select DeptID, avg(Salary) as AvgSalary from Employee
where Salary > 50000
group by DeptID having avg(Salary) > 55000;

select DeptID, count (*) as TotalEmp from Employee group by DeptID having count(*) > 1;

select e.Name, d.DeptName from Employee e
inner join Department d on e.DeptID = d.DeptID;

select e.Name, d.DeptName from Employee e
left join Department d on e.DeptID = d.DeptID;

select e.Name, d.DeptName from Employee e
right join Department d on e.DeptID = d.DeptID;

select e.Name, d.DeptName from Employee e
cross join Department d;

select d.DeptName, count(e.EmpID) as TotalEmp
from Department d
left join Employee e on d.DeptID = e.DeptID group by d.DeptName;

select * from Employee where Salary > (select avg(Salary) from Employee);

select distinct e.Name as EmployeeName, d.DeptName as Department
from Employee e
join Department d on e.DeptID = d.DeptID
where e.Name like 'A%' or e.Salary between 50000 and 60000;

