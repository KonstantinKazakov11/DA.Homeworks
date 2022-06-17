--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/
/* Write your PL/SQL query statement below */
select 
d.Name as Department, 
a. Name as Employee, 
a. Salary 
from (
select e.*, 
dense_rank() over (partition by DepartmentId order by Salary desc) as drn 
from Employee e 
) a 
join Department d
on a.DepartmentId = d.Id 
where drn <=3
--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17
select member_name, 
status, 
SUM(amount*unit_price) as costs 
from FamilyMembers
join Payments
on Familymembers.member_id = payments.family_member
where Year (date)='2005'
GROUP BY member_name, status
--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13
select name
from passenger 
group by name
having count(name)>1
-- 2 вар
select name 
from (
select name, count(*) as c
from passenger 
group by name
) a 
where c > 1
--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
select count (first_name) as COUNT
from (select first_name
from student 
where first_name = 'Anna') a
--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35
select count (class) as COUNT
from Schedule
where date = '2019-09-02'
--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
select count (first_name) as COUNT
from student 
where first_name = 'Anna'
--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32
select floor(avg(YEAR(current_date)-YEAR(birthday)))as age
from FamilyMembers
--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27
select good_type_name, Sum(amount*unit_price) as costs
from GoodTypes
join Goods
on goodtypes.good_type_id=goods.type
join Payments
on goods. good_id=payments.good
where YEAR (date) = 2005
group by good_type_name
--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37
select MIN (TIMESTAMPDIFF(YEAR, birthday, current_date)) as YEAR
from student
--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44
select MAX(TIMESTAMPDIFF(year, birthday, current_date)) as max_year
from student 
join Student_in_class
on student.id=student_in_class.student 
join class 
on student_in_class.class=class.id 
where class.name like '10%'
--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20
select fm.status, fm.member_name, sum (p.amount*p.unit_price) as costs
from familymembers as fm 
join payments as p 
on fm.member_id=p.family_member
join goods as g 
on p.good= g. good_id 
join goodtypes as gt 
on g.type = gt.good_type_id
where good_type_name = 'entertainment'
group by fm.status, fm.member_name
--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55
delete from company 
where company.id IN (
select company from trip 
group by company
having count(id) = (
select min(count) 
from (
select count(id) AS count 
from Trip 
group by company) 
as min_count)
)
--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45
select classroom 
from Schedule
group by classroom
having count(classroom) = 
(select count(classroom) 
from Schedule 
group by classroom
order by count(classroom) DESC 
LIMIT 1)
--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43
select last_name
from Teacher
join Schedule
    on Teacher.id=Schedule.teacher
join Subject
    on Schedule.subject=Subject.id
where Subject.name = 'Physical Culture'
order by Teacher.last_name
--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63
select concat(last_name, '.', left (first_name, 1), '.', left (middle_name, 1), '.') as name
from student 
order by last_name, first_name
