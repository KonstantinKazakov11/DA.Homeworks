DA. Homework LESSON 3

--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--�������: ��� ������� ������ ���������� ����� �������� ����� ������, ����������� � ���������. �������: ����� � ����� ����������� ��������.
select class, sum (case when result ='sunk'
	then 1
	else 0
	end) as sunks
from (
	select c.class, name 
	from classes c 
	left join ships s 
	on c. class=s.class 
	union 
	select class, ship
	from classes 
	join outcomes o 
	on class=ship
	) as sh
	left join outcomes o
	on sh.name=o.ship 
	group by class
	


--task2
--�������: ��� ������� ������ ���������� ���, ����� ��� ������ �� ���� ������ ������� ����� ������. ���� ��� ������ �� ���� ��������� ������� ����������, ���������� ����������� ��� ������ �� ���� �������� ����� ������. �������: �����, ���.

select c.class, min(launched)  "year launch"
from classes c 
full join ships s 
on c.class=s.class
group by c.class

--task3
--�������: ��� �������, ������� ������ � ���� ����������� �������� � �� ����� 3 �������� � ���� ������, ������� ��� ������ � ����� ����������� ��������.
select class, sum(CASE WHEN result='sunk' 
THEN 1 
ELSE 0 
END) as sunks
  from (
    select c.class, name from classes c
      join ships s on c.class=s.class
    union
    select class, ship from classes 
      join outcomes on class=ship
  ) as sh
  left join outcomes o on sh.name=o.ship
  group by class
  having
    sum(CASE WHEN result='sunk' 
    THEN 1 
    ELSE 0 
    END) > 0
    and (select count(sp.name) from (
            select s.name, s.class from ships s
            union
            select o.ship, o.ship from outcomes o
          ) as sp
        where sp.class = sh.class
        group by sp.class
        )>=3
--task4
--�������: ������� �������� ��������, ������� ���������� ����� ������ ����� ���� �������� ������ �� ������������� (������ ������� �� ������� Outcomes).

with sh as (
  select name, class from ships
  union
  select ship, ship from outcomes
)
select
  name
  from sh join classes c on sh.class=c.class
  where numguns >= all(
    select ch.numguns from classes ch 
      where ch.displacement=c.displacement
        and ch.class in (select sh.class from sh)
    )

--task5
--������������ �����: ������� �������������� ���������, ������� ���������� �� � ���������� ������� RAM � � ����� ������� ����������� ����� ���� ��, ������� ���������� ����� RAM. �������: Maker
select maker
from product 
where model in (select model from pc 
		where speed = (select max(speed) from pc 
	where ram = (select min(ram) from pc))
		and ram = (select min (ram) from pc))
and maker in (select maker from product
	where product.type = 'Printer')
group by maker

