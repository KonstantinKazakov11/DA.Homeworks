--task1  (lesson7)
-- sqlite3: ������� �������� ������ � �� (sqlite3, project name: task1_7). � ������� table1 �������� 1000 ����� � ���������� ���������� (3 �������, ��� int) �� 0 �� 1000.
-- ����� ��������� ����������� ������������� ���� ���� �������
create table table1_7 as 
select cast(random() * 1000 as int) as a, cast(random() * 1000 as int) as b, cast(random() * 1000 as int) as c
from generate_series(1,1000)

select* from table1_7
--� ������������ � ������� �� ����������

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/
/* Write your PL/SQL query statement below */
select email
from (
    select email, count (*) as c
    from person
group by email
    )
where c > =2;

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/
/* Write your PL/SQL query statement below */
select e.Name as Employee
from Employee e
where e.Salary >
(select Salary from Employee e1 where e1.Id = e.ManagerId);
--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/
/* Write your PL/SQL query statement below */
/* Write your PL/SQL query statement below */
select 
Score,
dense_rank () over (order by score desc) as rank
from Scores;
 
--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/
/* Write your PL/SQL query statement below */
select 
Person.firstName, Person.lastName, Address.city, Address.state
from Person
left join Address
on Person.personId = Address.personId;