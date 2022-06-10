select*
from product

create index type_idx on product_table_copy (type)

--task1  (lesson6)
-- ������������ �����: ������� ������� all_products_with_index ��� ����������� ���� ������ �� ����� code (union all). ������� ������ �� ���� type
create table all_products_with_index as
select product.model, maker, price, product.type 
from (
select code, model, price
   from pc
   union all 
    select code, model, price
    from printer 
   union all 
    select code, model, price
    from laptop  
    ) as foo
    join product  
    on product.model = foo.model
    
    create index type1_idx on all_products_with_index (type)
    
    -----
    
    select avg(price), type
    from all_products_with_index
    group by type
    
    explain select avg(price), type
    from all_products_with_index
    group by type
    
    explain analyse select avg(price), type
    from all_products_with_index
    group by type
--task2  (lesson6)
--������������ �����: ������� ������ ���� ���������� PC � ������������� � ����� ���� ���� �� ������ ��������. �����: model, maker

select distinct pc.model, maker 
from pc 
join product 
on product.model = pc.model
where pc.price > any (select (price) from printer)
order by maker


--task3  (lesson6)
--������������ �����: ������� ����� ������ �������� (��, ��-�������� ��� ��������), �������� ����� ������� ����. �������: model
--����� ������� �������� �� �����
select model  
from
  (
  select model, price from pc
      where price = (select max(price) from pc)
   union
   select model, price from Laptop 
      where price = (select max(price) from laptop)
   union
   select model, price from Printer
      where price = (select max(price) from printer)) a

---����� ������� ����� ����
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
   select*
   from all_products
where price = (select max (price) from all_products)

--task4  (lesson6)
-- ������������ �����: ������� ������� all_products_with_index_task4 ��� ����������� ���� ������ �� ����� code (union all) � ������� ���� (flag) �� ���� > ������������ �� ��������. ������� ������ �� flag
create table all_products_with_index_task4 as
select product.model, maker, price, product.type, 
case when price > (select max(price) from printer) then 1 else 0 end flag
from (
select code, model, price
   from pc
   union all 
    select code, model, price
    from printer 
   union all 
    select code, model, price
    from laptop  
    ) as foo
    join product  
    on product.model = foo.model
 create index flag_idx on all_products_with_index_task4 (flag)
--task5  (lesson6)
-- ������������ �����: ������� ������� all_products_with_index_task5 ��� ����������� ���� ������ �� ����� code (union all) � ������� ���� (flag) �� ���� > ������������ �� ��������. ����� �������� ��������� (����� ������� �������) �� ������ ��������� �������� � ������� ����������� ���� (price_index). �� ����� price_index ������� ������
create table all_products_with_index_task5 as
select product.model, maker, price, product.type, 
case when price > (select max(price) from printer) then 1 else 0 end flag,
row_number () over (order by price) as price_index
from (
select code, model, price
   from pc
   union all 
    select code, model, price
    from printer 
   union all 
    select code, model, price
    from laptop  
    ) as foo
    join product  
    on product.model = foo.model
    
 create index price_idx on all_products_with_index_task5 (price_index)