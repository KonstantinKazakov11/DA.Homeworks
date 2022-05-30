DA.HOMEWORK

-- Задание 20: Найдите средний размер hd PC каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.
+
select maker, avg(hd)
from product 
join pc  
on product.model=pc.model
where maker in(select distinct maker 
from product 
where type = 'printer')
group by maker




--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

-- Задание 1: Вывести name, class по кораблям, выпущенным после 1920
+
select name, class 
from ships
where launched >1920

-- Задание 2: Вывести name, class по кораблям, выпущенным после 1920, но не позднее 1942
+
select name, class 
from ships 
where launched > 1920 and launched <=1942

-- Задание 3: Какое количество кораблей в каждом классе. Вывести количество и class
+
select count(class), class
from ships
group by class

-- Задание 4: Для классов кораблей, калибр орудий которых не менее 16, укажите класс и страну. (таблица classes)
+
select class, country
from classes 
where bore >=16

-- Задание 5: Укажите корабли, потопленные в сражениях в Северной Атлантике (таблица Outcomes, North Atlantic). Вывод: ship.
+
select ship
from outcomes
where battle = 'North Atlantic' and result='sunk'

-- Задание 6: Вывести название (ship) последнего потопленного корабля
?

select ship
from outcomes
join battles 
on outcomes.battle=battles.name
where result='sunk' 
and date =  
(
select max(date) 
from battles 
join outcomes 
on outcomes.battle=battles.name 
where result='sunk'
)

-- Задание 7: Вывести название корабля (ship) и класс (class) последнего потопленного корабля
??? 

--- Название потопленного корабля для которого известен класс (но из всех он НЕ ПОСЛЕДНИЙ потопленный (задача6))     но он единственный
select ship, class
from ships
join outcomes 
on name = ship
where result='sunk' 
--- не работает определние "последний потопленный" так для последних потопленных кораблей неизвестен класс
and date =  
(
select max(date) 
from battles 
join outcomes 
on outcomes.battle=battles.name 
where result='sunk'
)


---код все имена и наличие класса
with t0 as
  (
  select ship as name from outcomes
    union
  select name from ships
  )
  select *
  from t0
  left join Ships
  on t0.name = ships.name
 


-- Задание 8: Вывести все потопленные корабли, у которых калибр орудий не менее 16, и которые потоплены. Вывод: ship, class
???
--- Название потопленного корабля для которого известен класс (но из всех он не последний потопленный(задача6)

select ship, ships.class
from ships
join outcomes 
on name = ship
where result='sunk' 
---- у полученного потопленного корабля, у которого известен класс, калибр равен 14, то есть он меньше 16 и не попадает под условие

and name in
(select classes.class
from classes
join ships
on ships.class=classes.class
where bore >=16)


-- Задание 9: Вывести все классы кораблей, выпущенные США (таблица classes, country = 'USA'). Вывод: class
+
select class
from classes 
where country = 'USA'
-- Задание 10: Вывести все корабли, выпущенные США (таблица classes & ships, country = 'USA'). Вывод: name, class
+
select name, ships.class
from ships
join classes 
on ships.class=classes.class
where country = 'USA'





---код все имена и наличие класса

with t0 as
  (
  select ship as name from outcomes
    union
  select name from ships
  )
  select *
  from t0
  left join Ships
  on t0.name = ships.name
