use vk_filled;
select * from profiles ;
delete from profiles where users_id = 0;

create table likes ( 
	id int unsigned not null auto_increment primary key,
	users_id int unsigned not null,
	target_id int unsigned not null,
	target_type_id int unsigned not null, 
	created_at DATETIME default current_timestamp
);

create table target_types (
	id int unsigned not null auto_increment primary key,
	name varchar(255) not null unique,
	created_at datetime default current_timestamp 
);
insert into target_types (name) values 
	('messages'),
	('users'),
	('media'),
	('posts');
	
insert into likes 
	select 
	id,
	floor(1+(rand()*100)),
	floor(1+(rand()*100)),
	floor(1+(rand()*4)),
	CURRENT_TIMESTAMP 
from messages;

select * from likes;
select * from target_types;

create table posts (
	id int unsigned not null auto_increment primary key,
	user_id int unsigned not null,
	community_id int unsigned,
	head varchar(255),
	body text not null,
	media_id int unsigned,
	is_public boolean default true,
	is_archivied boolean default true,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp
);

desc profiles;

alter table profiles 
	add constraint profiles_user_id_fk
		foreign key (users_id) references users(id)
			on delete cascade;
SET FOREIGN_KEY_CHECKS=0;			
alter table messages 
	add constraint messages_to_user_id_fk
		foreign key (to_user_id) references users(id),
	add constraint messages_from_user_id_fk
		foreign key (from_user_id) references users(id);
		
select * from messages ;
SELECT * from users u;
desc messages;

alter table communities_users 
	add constraint community_fk
		foreign key (community_id) references communities(id),
	add constraint community_users_fk
		foreign key (user_id) references users(id);
		
alter table friendship 
	add constraint friendship_friend_fk
		foreign key (friend_id) references users(id),
	add constraint friendship_user_fk
		foreign key (user_id) references users(id);	
alter table friendship 
	add constraint friendship_status_fk
		foreign key (status_id) references friendship_statuses(id);
		
alter table likes 
	add constraint likes_user_id_fk
		foreign key (users_id) references users(id),
	add constraint target_type_id_fk
		foreign key (target_type_id) references target_types(id);

alter table media 
	add constraint media_users_id_fk
		foreign key (user_id) references users(id),
	add constraint media_media_type_id_fk
		foreign key (media_type_id) references media_types(id);

alter table posts 
	add constraint posts_users_id_fk
		foreign key (user_id) references users(id),	
	add constraint posts_community_id_fk
		foreign key (community_id) references communities(id),
	add constraint posts_community_media_id_fk
		foreign key (media_id) references media(id);
-- Задание 3.	Определить кто больше поставил лайков (всего) - мужчины или женщины

select  
 count(users_id) as women,
 (select count(users_id) from likes where users_id in (select users_id from profiles where gender = 'm')) as men
from likes 
where
 users_id in (select users_id from profiles where gender = 'f');

-- Задание 4. Подсчитать общее количество лайков десяти самым молодым пользователям 
-- (сколько лайков получили 10 самых молодых пользователей).
CREATE TEMPORARY TABLE most_young_users (id int);

insert into most_young_users(id) 
select users_id from profiles order by  birthday desc limit 10;

select * from most_young_users
-- получили 19 лайков
select count(id) from likes where target_type_id = 2 and (target_id in (select * from most_young_users));

-- Exercise 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
select * from users;
select DISTINCT from_user_id from messages m2 order by from_user_id desc limit 10;

-- Меньше всех отправляли сообщения.
select 
	id,
	first_name,
	last_name,
	(select count(from_user_id) from messages where from_user_id = users.id) as count_sent_messages
from users
order by count_sent_messages
limit 10;
select CONCAT(first_name,' ', last_name) from users;
