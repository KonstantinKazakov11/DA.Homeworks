lesson 4 DA.Homework

--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� (pc, printer, laptop). �������: model, maker, type
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
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, � ���� ���� ����� ������� PC - "1", � ��������� - "0"
select*,
case when price > (select AVG(price) from printer) 
then 1
else 0
end flag
from printer

--task15 (lesson3)
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)
select*
from ships
where class is NULL
--task16 (lesson3)
--�������: ������� ��������, ������� ��������� � ����, �� ����������� �� � ����� �� ����� ������ �������� �� ����.
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
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.
select distinct battle
from outcomes o 
where ship in (
select name
from ships 
where class ='Kongo')

--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag
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
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ c������ . �� view ��� �������: model, price, flag
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
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model
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
-- ������������ �����: ������� ��� ������ ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model
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
-- ������������ �����: ����� ������� ���� ����� ���������� ��������� ������������� = 'A' (printer & laptop & pc)
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
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) �� ������� �������������. �� view: maker, count
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
-- �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)
-- ������ ��������
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
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) � ������� �� ��� ��� �������� ������������� 'D'
create table printer_updated as
select code, printer.model, color, product.type, price 
from printer
join product  
on printer.model=product.model 
where maker <>'D'

select *
from printer_updated

--task9 (lesson4)
-- ������������ �����: ������� �� ���� ������� (printer_updated) view � �������������� �������� ������������� (�������� printer_updated_with_makers)
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
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes). �� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)
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
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)
----������ ������� �� ���� �� ������� (count � sunks)
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
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag: ���� ���������� ������ ������ ��� ����� 9 - �� 1, ����� 0
create table classes_with_flag as
select *,
case when numGuns >=9 then 1 else 0 end flag
from classes

select *
from classes_with_flag
--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)
select count(*), country 
from classes
group by country
-- ������ ��������
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
-- �������: ������� ���������� ��������, � ������� �������� ���������� � ����� "O" ��� "M".
select count(*)
from ships  
where name like 'O%' or name like 'M%'
--task15 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ������� �� ���� ����.
select count(*)
from ships  
where name like '% %' 
--task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)
select count(*), launched
from ships
group by launched

-- ������ ��������
px

request = """
select launched, count(*)
from ships
group by launched
"""
df = pd.read_sql_query(request,conn)
fig = px.bar(x=df.launched.to_list(), y=df['count'].to_list(), labels={'x':'launched', 'y':'count'})
fig.show()
