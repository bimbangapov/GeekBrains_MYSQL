DROP FUNCTION IF EXISTS is_row_exists;
DELIMITER //

CREATE FUNCTION is_row_exists (target_id INT, target_type_id INT)
RETURNS BOOLEAN READS SQL DATA

BEGIN
  DECLARE table_name VARCHAR(50);
  SELECT name FROM target_types WHERE id = target_type_id INTO table_name;
  
  CASE table_name
    WHEN 'messages' THEN
      RETURN EXISTS(SELECT 1 FROM messages WHERE id = target_id);
    WHEN 'users' THEN 
      RETURN EXISTS(SELECT 1 FROM users WHERE id = target_id);
    WHEN 'media' THEN
      RETURN EXISTS(SELECT 1 FROM media WHERE id = target_id);
    WHEN 'posts' THEN
      RETURN EXISTS(SELECT 1 FROM posts WHERE id = target_id);
    ELSE 
      RETURN FALSE;
  END CASE;
  
END//

DELIMITER ;
show function;

SELECT is_row_exists(1000, 1);


DROP TRIGGER IF EXISTS likes_validation;
DELIMITER // 

CREATE TRIGGER likes_validation BEFORE INSERT ON likes
FOR EACH ROW 
BEGIN 
	IF !is_row_exists(NEW.target_id,NEW.target_type_id) THEN 
		SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "Error adding like! Target table doesn't contain row id provided";
	END IF;
END//

DELIMITER ;

insert into likes (user_id, target_id, target_type_id) values (34,556,2);
-- здесь у меня выходит ошибка [42S22]: Unknown column 'user_id' in 'field list'


CREATE INDEX users_emails_idx ON users(email);
CREATE INDEX messages_from_user_id_to_user_id on messages(from_user_id, to_user_id);
-- как сделать индекс на поле с типом text???

-- индекс на город и страны в профайлах
CREATE INDEX city_profile ON profiles(city);
CREATE INDEX country_profile ON profiles(country);
-- индекс на имя групп
CREATE INDEX name_comunities on communities(name);
-- индекс на заголовки постов
CREATE INDEX head_of_posts on posts(head);
-- индекс на имя файла
CREATE INDEX filename_of_media ON media(filename);

use vk_filled;
Select * from media;

select media.media_type_id,
	sum(media.size) as total_size_by_type,
	(select sum(size)  from media m2) as total_size, 
	(select sum(media.size)/(select sum(size)  from media m2)  * 100 ) as "%%",
	mt.name
from media
join media_types mt on media.media_type_id = mt.id
group by media.media_type_id ;

select distinct media_types.name as name,
sum(media.`size`) over(partition by media.media_type_id) as size_by_type,
sum(media.`size`) over() as total_size,
-- вопрос почему здесь нельзя просто разделить два столбца через алиасы (size_by_type / total_size)
sum(media.`size`) over(partition by media.media_type_id) / sum(media.`size`) over() * 100 as "%%" 
from media 
join media_types on media_types.id = media.media_type_id;

-- 2. Задание на оконные функции
-- Построить запрос, который будет выводить следующие столбцы:
-- имя группы
-- среднее количество пользователей в группах
-- самый молодой пользователь в группе
-- самый старший пользователь в группе
-- общее количество пользователей в группе
-- всего пользователей в системе
-- отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100

select distinct communities.name,
	sum(communities_users.user_id) over () as sum_of_all_people_in_communities,
	count(communities.name) over () as sum_of_commnuties,
	sum(communities_users.user_id) over () / count(communities.name) over () as average,
	max(profiles.birthday) over (partition by communities.name) as youngest,
	min(profiles.birthday) over (partition by communities.name) as oldest,
	sum(communities_users.user_id) over(partition by communities.name) as count_of_people_in_comminity,
	sum(profiles.users_id) over() as count_of_all_users,
	sum(communities_users.user_id) over(partition by communities.name) / sum(profiles.users_id) over() * 100 as "%%"
from communities 
join communities_users on communities.id = communities_users.community_id
join users on users.id = communities_users.user_id 
join profiles on users.id = profiles.users_id;

