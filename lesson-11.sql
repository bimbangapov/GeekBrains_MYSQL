use test;

show tables;

drop table if exists products;
create table products (
	id int unsigned not null,
	name varchar(150),
	id_catalogs int,
	created_at datetime default current_timestamp(),
	updated_at datetime default current_timestamp() on update current_timestamp(),
	primary key (id));
	
drop table if exists catalogs;
create table catalogs (
	id int unsigned not null,
	name varchar(150),
	created_at datetime default current_timestamp(),
	updated_at datetime default current_timestamp() on update current_timestamp(),
	primary key (id));

drop table if exists users;
create table users (
	id int unsigned not null,
	name varchar(150),
	created_at datetime default current_timestamp(),
	updated_at datetime default current_timestamp() on update current_timestamp(),
	primary key (id));

drop table if exists logs;
create table logs (	
	created_at datetime,
	name_of_table varchar(50),
	id int,
	name varchar(150)) ENGINE = archive;

drop trigger if exists insert_user;
delimiter //
create trigger insert_user before insert on users
for each row 
BEGIN 
	insert into logs (created_at, name_of_table,id,name) values (NEW.created_at,'users',NEW.id,NEW.name);
END //
delimiter ; 

drop trigger if exists insert_catalogs;
delimiter //
create trigger insert_catalogs before insert on catalogs
for each row 
BEGIN 
	insert into logs (created_at, name_of_table,id,name) values (NEW.created_at,'catalogs',NEW.id,NEW.name);
END //
delimiter ; 

drop trigger if exists insert_products;
delimiter //
create trigger insert_products before insert on products
for each row 
BEGIN 
	insert into logs (created_at, name_of_table,id,name) values (NEW.created_at,'products',NEW.id,NEW.name);
END //
delimiter ; 

insert into users (id,name) values (1,'ivan ivanov');
insert into users (id,name) values (2,'Petr Petrov');
insert into catalogs (id,name) values (1,'motherboard');
insert into products (id,name,id_catalogs) values (1,'asus x552',1);
select * from users;
select * from logs;




		
