DA.HOMEWORK

-- ������� 20: ������� ������� ������ hd PC ������� �� ��� ��������������, ������� ��������� � ��������. �������: maker, ������� ������ HD.
+
select maker, avg(hd)
from product 
join pc  
on product.model=pc.model
where maker in(select distinct maker 
from product 
where type = 'printer')
group by maker




--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

-- ������� 1: ������� name, class �� ��������, ���������� ����� 1920
+
select name, class 
from ships
where launched >1920

-- ������� 2: ������� name, class �� ��������, ���������� ����� 1920, �� �� ������� 1942
+
select name, class 
from ships 
where launched > 1920 and launched <=1942

-- ������� 3: ����� ���������� �������� � ������ ������. ������� ���������� � class
+
select count(class), class
from ships
group by class

-- ������� 4: ��� ������� ��������, ������ ������ ������� �� ����� 16, ������� ����� � ������. (������� classes)
+
select class, country
from classes 
where bore >=16

-- ������� 5: ������� �������, ����������� � ��������� � �������� ��������� (������� Outcomes, North Atlantic). �����: ship.
+
select ship
from outcomes
where battle = 'North Atlantic' and result='sunk'

-- ������� 6: ������� �������� (ship) ���������� ������������ �������
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

-- ������� 7: ������� �������� ������� (ship) � ����� (class) ���������� ������������ �������
??? 

--- �������� ������������ ������� ��� �������� �������� ����� (�� �� ���� �� �� ��������� ����������� (������6))     �� �� ������������
select ship, class
from ships
join outcomes 
on name = ship
where result='sunk' 
--- �� �������� ���������� "��������� �����������" ��� ��� ��������� ����������� �������� ���������� �����
and date =  
(
select max(date) 
from battles 
join outcomes 
on outcomes.battle=battles.name 
where result='sunk'
)


---��� ��� ����� � ������� ������
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
 


-- ������� 8: ������� ��� ����������� �������, � ������� ������ ������ �� ����� 16, � ������� ���������. �����: ship, class
???
--- �������� ������������ ������� ��� �������� �������� ����� (�� �� ���� �� �� ��������� �����������(������6)

select ship, ships.class
from ships
join outcomes 
on name = ship
where result='sunk' 
---- � ����������� ������������ �������, � �������� �������� �����, ������ ����� 14, �� ���� �� ������ 16 � �� �������� ��� �������

and name in
(select classes.class
from classes
join ships
on ships.class=classes.class
where bore >=16)


-- ������� 9: ������� ��� ������ ��������, ���������� ��� (������� classes, country = 'USA'). �����: class
+
select class
from classes 
where country = 'USA'
-- ������� 10: ������� ��� �������, ���������� ��� (������� classes & ships, country = 'USA'). �����: name, class
+
select name, ships.class
from ships
join classes 
on ships.class=classes.class
where country = 'USA'





---��� ��� ����� � ������� ������

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
