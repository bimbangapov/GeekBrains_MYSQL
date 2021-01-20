use vk_filled;

select * from likes limit 10;

select * from users limit 10;

select * from profiles limit 10;

-- kto postavil bolshe laikov
select 
	count(*) as male,
	(select count(*) as male from likes join profiles p on p.users_id = likes.users_id and p.gender = 'f') as female
from likes
join profiles p on p.users_id = likes.users_id 
where p.gender = 'm'; 

select 
	p.gender as gender,
	count(*) as `count`
from likes join 
profiles p on p.users_id = likes.users_id 
group by gender 
order by `count` desc
limit 1;


-- kolichestvo laikov 10 samym molodym
select count(l.target_id) as count_likes_of_10_mostly_young_people
from profiles p 
join likes l on l.users_id = p.users_id and l.target_type_id = 2
order by p.birthday desc;

-- kto menshe vsego ispolzuet socseti 

select 
	CONCAT(u.first_name,' ',u.last_name) as name,
	count(m2.from_user_id) as messages
	from users u 
join messages m2 on u.id = m2.from_user_id
group by name 
ORDER by messages
limit 10;

-- ДЗ 7 урока


