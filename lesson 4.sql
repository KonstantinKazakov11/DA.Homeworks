lesson 4 DA.Homework

--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type
with all_products as ( 
  select model, price  
  from pc 
    union all   
  select model, price  
  from laptop  
    union all 
  select model, price  
  from printer 
) 
select product.model, product.type, maker
from all_products
join product
on product.model=all_products.model
order by type
--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"
select*,
case when price > (select AVG(price) from printer) 
then 1
else 0
end flag
from printer

--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)
select*
from ships
where class is NULL
--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.
??
--1
select name
from battles  
where year(battles.date) not in (
select launched
from ships  
where launched is not null
)
--2
select distinct battles.name, year(battles.date)
from battles
where year(battles.date) not in (
	select ships.launched
	from ships
	where ships.launched is not null
)
--3
select name 
from battles
where DATEPART(yy, date) not in (
select DATEPART(yy, date) 
from battles 
join ships on DATEPART(yy, date)= launched)

 
--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.
select distinct battle
from outcomes o 
where ship in (
select name
from ships 
where class ='Kongo')

--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag
create view all_products_flag_300 as
with all_products as ( 
  select model, price  
  from pc 
    union all   
  select model, price  
  from laptop  
    union all 
  select model, price  
  from printer
  )
  select model, price, 
  case when price > 300 then 1 else 0 end flag
  from all_products
 select *
 from all_products_flag_300
--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag
create view all_products_flag_avg_price as
with all_products as ( 
  select model, price  
  from pc 
    union all   
  select model, price  
  from laptop  
    union all 
  select model, price  
  from printer
  )
  select model, price, 
  case when price > (select avg (price) from all_products) then 1 else 0 end flag
  from all_products
  
  select *
  from all_products_flag_avg_price
  
--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model
select product.model
from printer  
join product 
on printer.model=product.model
where maker = 'A'
and price > (
select avg (price) 
	from product
	join printer 
	on printer.model=product.model 
	where maker = 'D'
	)
and  price > (select avg (price) 
	from product
	join printer 
	on printer.model=product.model 
	where maker = 'C')
--task4 (lesson4)
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model
with all_products as ( 
  select model, price  
  from pc 
    union all   
  select model, price  
  from laptop  
    union all 
  select model, price  
  from printer
  )
select all_products.model
from all_products
join product 
on all_products.model=product.model
where maker = 'A'
and price > (
select avg (price) 
	from product
	join all_products
	on all_products.model=product.model 
	where maker = 'D'
	)
and  price > (select avg (price) 
	from product
	join all_products 
	on all_products.model=product.model 
	where maker = 'C')
--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)
with all_products as ( 
  select model, price  
  from pc 
    union all   
  select model, price  
  from laptop  
    union all 
  select model, price  
  from printer
  )
  select avg(price)
  from product 
  join all_products 
  on all_products.model = product.model 
  where maker ='A'
--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. Во view: maker, count
create view count_products_by_makers as
with all_products as ( 
  select model, price  
  from pc 
    union all   
  select model, price  
  from laptop  
    union all 
  select model, price  
  from printer
  )
select count(*), maker
from product  
join all_products 
on product.model = all_products.model
group by maker

select *
from count_products_by_makers
order by maker
--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)
-- график построен
px

request = """
select maker, count
from count_products_by_makers
order by maker
"""
df = pd.read_sql_query(request,conn)
fig = px.bar(x=df.maker.to_list(), y=df['count'].to_list(), labels={'x':'maker', 'y':'count'})
fig.show()
--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'
create table printer_updated as
select code, printer.model, color, product.type, price 
from printer
join product  
on printer.model=product.model 
where maker <>'D'

select *
from printer_updated

--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя (название printer_updated_with_makers)
create view printer_updated_with_makers as
select *, maker
from printer_updated
join product 
on product.model=printer_updated.model
---2
create view printer_updated_with_makers as
select code, product.maker,product.type, product.model,price, color
from printer_updated
join product 
on product.model=printer_updated.model

select*
from printer_updated_with_makers
--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)
---1
create view sunk_ships_by_classes as
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
	
	select *
	from sunk_ships_by_classes
	

--task11 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)
----график сделать не смог не понимаю (count и sunks)
	px

request = """
select class, sum
from sunk_ships_by_classes
order by class

"""
df = pd.read_sql_query(request,conn)
fig = px.bar(x=df.maker.to_list(), y=df['sum'].to_list(), labels={'x':'class', 'y':''sunks''})
fig.show()
	
	
	
--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество орудий больше или равно 9 - то 1, иначе 0
create table classes_with_flag as
select *,
case when numGuns >=9 then 1 else 0 end flag
from classes

select *
from classes_with_flag
--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)
select count(*), country 
from classes
group by country
-- график построен
px

request = """
select country, count(*)
from classes
group by country
"""
df = pd.read_sql_query(request,conn)
fig = px.bar(x=df.country.to_list(), y=df['count'].to_list(), labels={'x':'country', 'y':'count'})
fig.show()
--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".
select count(*)
from ships  
where name like 'O%' or name like 'M%'
--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.
select count(*)
from ships  
where name like '% %' 
--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)
select count(*), launched
from ships
group by launched

-- график построен
px

request = """
select launched, count(*)
from ships
group by launched
"""
df = pd.read_sql_query(request,conn)
fig = px.bar(x=df.launched.to_list(), y=df['count'].to_list(), labels={'x':'launched', 'y':'count'})
fig.show()
