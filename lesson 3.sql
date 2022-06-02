DA. Homework LESSON 3

--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.
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
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.

select c.class, min(launched)  "year launch"
from classes c 
full join ships s 
on c.class=s.class
group by c.class

--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.
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
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).

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
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
select maker
from product 
where model in (select model from pc 
		where speed = (select max(speed) from pc 
	where ram = (select min(ram) from pc))
		and ram = (select min (ram) from pc))
and maker in (select maker from product
	where product.type = 'Printer')
group by maker

