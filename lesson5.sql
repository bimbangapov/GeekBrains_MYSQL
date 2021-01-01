create database test;
use test;
create table test_table_users(
	id INT,
	name varchar (50),
	created_at varchar(50),
	updated_at varchar(50)
	);

insert into test_table_users (id, name)
values (1, 'Ivan Ivanov'),(2,'Petr_Petrov');

select * from test_table_users;
-- Задание 1. Пусть в таблице users поля created_at и updated_at оказались не заполнеными, заполнить их текущей датой и временем.
update test_table_users set created_at = now();
update test_table_users set updated_at = now();
-- Задание 2. Привести к varchar 
ALTER table test_table_users modify column created_at datetime;
ALTER table test_table_users modify column updated_at datetime;

create table test_storehouse (
	id int,
	name_of_products varchar (50),
	values_of_products int
	);
-- остортировать таблицу по values, чтобы нулевые значения были в конце
insert into test_storehouse (id, name_of_products, values_of_products)
values (1, 'motherboard', 0),(2, 'videocart', 0),(3,'ram',2),(4,'korpus',4);
-- 1 вариант, "хардкод"(((
SELECT * 
from test_storehouse 
order by case when values_of_products = 0 then 1000000000 else values_of_products end;                                                              
-- исправленный вариант
Select * from test_storehouse order by if(values_of_products > 0, 0, 1), values_of_products;


-- выбрать пользователей родившихся в августе и мае
select * from test_table_users where DATE_FORMAT(birthday_date, '%M') in ('may','august'); 

-- отсортировать (5,1,2)

select * 
from test_storehouse where id in (5,1,2) order by FIELD(id,5,1,2); 


alter table test_table_users add column birthday_date DATE;
SELECT * from test_table_users ttu;

insert into test_table_users (birthday_date)
values ('1995-12-1'),('1994-11-1');

update test_table_users set birthday_date = '1995-12-1' where id=1;
update test_table_users set birthday_date = '1990-12-1' where id=2;

delete from test_table_users where id is NULL;
-- Подсичтать ср возраст
select avg((datediff(now(),birthday_date))/365.25) as age from test_table_users ;

-- Подчситать кол-во др, которые приходятся на каждый из днней недели, текущего года

SELECT 
	date_format (date(concat_ws('-',year(now()),month(birthday_date),day(birthday_date))),'%W'),
	count(*) as total
from test_table_users 
Group by birthday_date order by total desc;

-- Подсчитайте произведение чисел в столбце таблицы
select round(exp(sum(ln(id)))) from test_storehouse ts;


