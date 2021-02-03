create database kp;
use kp;
-- Составить общее текстовое описание БД и решаемых ею задач; 
-- БД кинофильмов, хранящая информацию о фильмах, актерах снимающихся в них, новости и различную информацию о мире кино
-- Хранит информацию о пользователях и их лайках.
-- Аналог сайта кинопоиск

create table films (
	id int unsigned not null auto_increment primary key,
	name_of_film varchar(255) not null,
	category_id int unsigned not null,
	date_of_release DATE not null,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp
);


drop table if exists category;
create table category (
	id int unsigned not null auto_increment primary key,
	name_of_category varchar(255) not null,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp
);

create table actors (
	id int unsigned not null auto_increment primary key,
	first_name varchar(100) not null,
	last_name varchar(100) not null,
	gender char(1) not null,
	birthday DATE, 
	country_of_birth varchar(100) not null,
	height int unsigned not null,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp
);

create table genre (
	id int unsigned not null auto_increment primary key,
	name_of_genre varchar(100) not null,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp
);

create table genre_of_film (
	id_of_film int unsigned not null,
	id_of_genre int unsigned not null,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp
);

create table actors_in_films (
	id_of_film int unsigned not null,
	id_of_actor int unsigned not null,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp
);

create table description_of_film (
 	id_of_film int unsigned not null,
 	description text,
 	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp
)engine = archive;

create table users (
	id int unsigned not null auto_increment primary key,
	login varchar(100) not null,
	name varchar(100) not null,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp
);
drop table if exists target_of_likes;
create table target_types (
	id int unsigned not null auto_increment primary key,
	target_name varchar(100) not null,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp
);
drop table if exists likes;
create table likes (
	id int unsigned not null auto_increment primary key,
	user_id int unsigned not null,
	target_id int unsigned not null,
	target_type_id int unsigned not null,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp
);

create table news (
	id int unsigned not null auto_increment primary key,
	head varchar(100) not null,
	body text not null,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp
);

insert into target_types (target_name) values ('films');
insert into target_types (target_name) values ('actor');
insert into target_types (target_name) values ('news');
select * from target_of_like;

insert into category (name_of_category) values ('film');
insert into category (name_of_category) values ('cartoon');
insert into category (name_of_category) values ('serial');
insert into category (name_of_category) values ('short film');

insert into genre (name_of_genre) values ('comedy');
insert into genre (name_of_genre) values ('drama');
insert into genre (name_of_genre) values ('melodrama');
insert into genre (name_of_genre) values ('action');
insert into genre (name_of_genre) values ('documentary');
insert into genre (name_of_genre) values ('horror');
insert into genre (name_of_genre) values ('musical');
insert into genre (name_of_genre) values ('scientific');

select * from genre ;
select count(*) from users u2 ;

Select * from likes ;

drop table if exists target_of_likes;

desc likes;

update actors set actors.gender = 'f' where id BETWEEN 1 and 2500;
update actors set actors.gender = 'm' where id BETWEEN 2500 and 5000;

select * from actors where id between 4900 and 5000;




