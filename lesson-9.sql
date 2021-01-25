-- В базе данных shop и sample присутствуют одни и те же таблицы, 
-- учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
use test;
select * from test_table_users ttu ;
create database test2;
use test2;
create table users (
	id int,
	name varchar(255),
	created_at datetime,
	updated_at datetime,
	birthday_date date);

select * from test.test_table_users ttu where id = 1;

start transaction;

insert into test2.users 
select * from test.test_table_users ttu where id = 1;

select * from users;
commit;

-- Создайте представление, сделал представление селекта на то кто больще поставил лайков из БД ВК.
use vk_filled;
create view most_likes as
select 
	count(*) as male,
	(select count(*) as male from likes join profiles p on p.users_id = likes.users_id and p.gender = 'f') as female
from likes
join profiles p on p.users_id = likes.users_id 
where p.gender = 'm'; 

select * from most_likes;

select CURTIME();

drop function if exists hello;
delimiter //

create function hello()
returns text not deterministic
begin
	if curtime() > '00:00:00' and curtime() < '06:00:00' then 
		select 'Доброй ночи';
	
	elseif (curtime() > '06:00:00') and (curtime() < '12:00:00') then 
		select 'Доброй утро';

	elseif (curtime() > '12:00:00') and (curtime() < '18:00:00') then 
		select 'Доброй день';

	elseif (curtime() > '12:00:00') and (curtime() < '18:00:00') then 
		select 'Доброй день';	
	
	elseif (curtime() > '18:00:00') and (curtime() < '23:59:00') then 
		select 'Добрый вечер';
	end if; 
end//


hour(curtime()) ;
select "Доброй утро";