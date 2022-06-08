Homework. lesson 5

--ñõåìà ÁÄ: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- Êîìïüşòåğíàÿ ôèğìà: Ñäåëàòü view (pages_all_products), â êîòîğîé áóäåò ïîñòğàíè÷íàÿ ğàçáèâêà âñåõ ïğîäóêòîâ (íå áîëåå äâóõ ïğîäóêòîâ íà îäíîé ñòğàíèöå). Âûâîä: âñå äàííûå èç laptop, íîìåğ ñòğàíèöû, ñïèñîê âñåõ ñòğàíèö

sample:
1 1
2 1
1 2
2 2
1 3
2 3

-----ĞÅØÅÍÈÅ ñîãëàñíî SAMPLE
create view pages_all_products as
select code, model, speed, ram, hd, price, screen, 
   	case when num % 2 = 0 
    	then total/3
    	else total/6
    end as num_of_pages,
	case when num % 2 = 0 
      	then num/2 
      	else num/2 + 1 
	end as page_num  
from (
      select *, row_number() over(order by model desc) as num, 
             count(*) over() as total 
      from Laptop
) a

select *
from pages_all_products

-----÷åğíîâèê 1
select code, model, speed, ram, hd, price, screen, 
    case when num % 2 = 0 
      	then num/2 
      	else num/2 + 1 
	end as page_num, 
    case when num % 2 = 0 
    	then total/3
    	else total/6
    end as num_of_pages
from (
      select *, row_number() over(order by model desc) as num, 
             count(*) over() as total 
      from Laptop
) a
------÷åğíîâèê 2
select code, model, speed, ram, hd, price, screen, 
   	case when num % 2 = 0 
    	then total/3
    	else total/6
    end as num_of_pages,
	case when num % 2 = 0 
      	then num/2 
      	else num/2 + 1 
	end as page_num  
from (
      select *, row_number() over(order by model desc) as num, 
             count(*) over() as total 
      from Laptop
) a

----
drop view pages_all_products


------ïğîáíîå
create view pages_all_products as
select code, model, speed, ram, hd, price, screen, 
    case when num % 2 = 0 
      	then num/2 
      	else num/2 + 1 
	end as page_num, 
    case when total % 2 = 0 
    	then total/2 
    	else total/2 + 1 
    end as num_of_pages
from (
      select *, row_number() over(order by model desc) as num, 
             count(*) over() as total 
      from Laptop
) a

select *
from pages_all_products

--task2 (lesson5)
-- Êîìïüşòåğíàÿ ôèğìà: Ñäåëàòü view (distribution_by_type), â ğàìêàõ êîòîğîãî áóäåò ïğîöåíòíîå ñîîòíîøåíèå âñåõ òîâàğîâ ïî òèïó óñòğîéñòâà. Âûâîä: ïğîèçâîäèòåëü, òèï, ïğîöåíò (%)
create view distribution_by_type as
select maker, type, count(*) * 100.0 / (select count(*) from product) as percent
from product
group by maker, type
order by maker

select * 
from distribution_by_type
--task3 (lesson5)
-- Êîìïüşòåğíàÿ ôèğìà: Ñäåëàòü íà áàçå ïğåäûäóùåíğ view ãğàôèê - êğóãîâóş äèàãğàììó. Ïğèìåğ https://plotly.com/python/histograms/
--êğóãîâàÿ äèàãğàììà ïî òèïó
px

request = """
select *
from distribution_by_type
order by type
"""
df = pd.read_sql_query(request,conn)
fig = px.pie(df, values='percent', names='type', color='type',
             )
fig.show()
----ñòîëáèêîâàÿ äèàãğàììà
px

request = """
select maker, type
from distribution_by_type
order by type
"""
df = pd.read_sql_query(request,conn)
fig = px.bar(x=df.maker.to_list(), y=df.type.to_list(), labels={'x':'maker', 'y':'type'})
fig.show()

select percent, type, maker
from distribution_by_type

--task4 (lesson5)
-- Êîğàáëè: Ñäåëàòü êîïèş òàáëèöû ships (ships_two_words), íî íàçâàíèå êîğàáëÿ äîëæíî ñîñòîÿòü èç äâóõ ñëîâ
create table ships_two_words as
select *
from ships s 
where name like '% %'
select *
from ships_two_words
--task5 (lesson5)
-- Êîğàáëè: Âûâåñòè ñïèñîê êîğàáëåé, ó êîòîğûõ class îòñóòñòâóåò (IS NULL) è íàçâàíèå íà÷èíàåòñÿ ñ áóêâû "S"
select*
from ships
where class is null and class like 'S%'
--task6 (lesson5)
-- Êîìïüşòåğíàÿ ôèğìà: Âûâåñòè âñå ïğèíòåğû ïğîèçâîäèòåëÿ = 'A' ñî ñòîèìîñòüş âûøå ñğåäíåé ïî ïğèíòåğàì ïğîèçâîäèòåëÿ = 'C' è òğè ñàìûõ äîğîãèõ (÷åğåç îêîííûå ôóíêöèè). Âûâåñòè model
---- Íåò ïğèíòåğîâ ñ ïğîèçâîäèòåëåì "Ñ"
---Ïğîâåğêà âñå ïğèíòåğû
select*
from printer
join product 
on printer.model=product.model
order by maker
---ğåøåíèå ïåğâîé ÷àñòè
---- Íåò ïğèíòåğîâ ñ ïğîèçâîäèòåëåì "Ñ"
select printer.model
from printer  
join product 
on printer.model=product.model
where maker = 'A' and price >
(select avg(price) 
from printer
join product 
on printer.model=product.model
where maker = 'C')
----ĞÅØÅÍÈÅ
select *
from (
select *,
row_number() over (order by price desc) as rn
from printer
join product 
on printer.model = product.model
where maker = 'A'  ) a
where rn >=1 and rn <=3
----ĞÅØÅÍÈÅ ÈÒÎÃÎÂÎÅ (ó÷èòûâàÿ, ÷òî íåò ïğèíòåğîâ ïğîèçâîäèòåëåé "C")
select model
from (
select printer.model,
row_number() over (partition by maker order by price desc) as rn
from printer
join product 
on printer.model = product.model
where maker = 'A' ) a
where rn >=1 and rn <=3


-----ÏÎËÍÎÅ ğåøåíèå ñîãëàñíî óñëîâèş
select model
from (
select printer.model,
row_number() over (partition by maker order by price desc) as rn
from printer
join product 
on printer.model = product.model
where maker = 'A'and price >
(select avg(price) 
from printer
join product 
on printer.model=product.model
where maker = 'C' ) ) a
where rn >=1 and rn <=3

