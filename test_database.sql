create database test;
use test;
--1 задание, заполнить пол€ столбцов updated_at created_at текущим датой и временем

create table test_table_users(
	id INT,
	name varchar (50),
	created_at varchar(50),
	updated_at varchar(50)
	);

insert into test_table_users (id, name)
values (1, 'Ivan Ivanov'),(2,'Petr_Petrov');

select * from test_table_users;

update test_table_users set created_at = now();
update test_table_users set updated_at = now();

--задание 2. ѕривести их к типу DATETIME
ALTER table test_table_users modify column created_at datetime;
ALTER table test_table_users modify column updated_at datetime;

create table test_storehouse (
	id int,
	name_of_products varchar (50),
	values_of_products int
	);

insert into test_storehouse (id, name_of_products, values_of_products)
values (1, 'motherboard', 0),(2, 'videocart', 0),(3,'ram',2),(4,'korpus',4);

--задание 3. ¬ таблице складских запасов storehouses_products в поле value могут встречатьс€ самые разные цифры: 
--0, если товар закончилс€ и выше нул€, если на складе имеютс€ запасы. Ќеобходимо отсортировать записи таким образом, 
--чтобы они выводились в пор€дке увеличени€ значени€ value. ќднако нулевые запасы должны выводитьс€ в конце, после всех записей.
SELECT * 
from test_storehouse 
order by case when values_of_products = 0 then 1000000000 else values_of_products end;                                                              

alter table test_table_users add column birthday_date DATE;
SELECT * from test_table_users ttu;

insert into test_table_users (birthday_date)
values ('1995-12-1'),('1994-11-1');

update test_table_users set birthday_date = '1995-12-1' where id=1;
update test_table_users set birthday_date = '1990-12-1' where id=2;

delete from test_table_users where id is NULL;

-задание 1. найти ср возраст сотрудников
select avg((datediff(now(),birthday_date))/365.25) from test_table_users ttu ;

select dayname(birthday_date),DAYOFWEEK(birthday_date) from test_table_users ttu ;
select count(case when dayofweek(birthday_date) = 7 then 5 else 0 end) from test_table_users ttu ;



