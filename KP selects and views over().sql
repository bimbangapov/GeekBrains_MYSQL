select * from films limit 10;


select films.name_of_film, category.name_of_category from films 
join category on category.id = films.category_id 
where category.name_of_category = 'film';

create view all_films as 
select films.name_of_film, category.name_of_category from films 
join category on category.id = films.category_id 
where category.name_of_category = 'film';

select * from all_films;



select films.name_of_film, DATA(films.date_of_release) from films 
join genre_of_film on genre_of_film.id_of_film = films.id 
join genre on genre.id = genre_of_film.id_of_genre 
join category on category.id = films.category_id 
where genre.name_of_genre = 'drama' and category.name_of_category = 'film' ;

create view drama_films as 
select films.name_of_film from films 
join genre_of_film on genre_of_film.id_of_film = films.id 
join genre on genre.id = genre_of_film.id_of_genre 
join category on category.id = films.category_id 
where genre.name_of_genre = 'drama' and category.name_of_category = 'film' ;

select * from drama_films;


select 
	Concat(first_name, ' ', last_name) as name_of_actor,
	(year(CURRENT_DATE()) - year(birthday)) as age
from actors order by birthday 
limit 100;


select actors.id as id,
	Concat(actors.first_name, ' ', actors.last_name) as name_of_actor,
	count(likes.target_id) as count_of_likes
from actors 
left join likes on likes.target_id = actors.id 
left join target_types on target_types.id = likes.target_type_id 
where actors.id = likes.target_id and target_types.target_name = 'actor'
group by id
order by count_of_likes desc;


select
	likes.target_id as id,
	films.name_of_film,
	count(likes.target_type_id) as count_likes
from likes 
join target_types on target_types.id = likes.target_type_id 
join films on likes.target_id = films.id
where likes.target_type_id = 1
group by id
order by count_likes desc;


select distinct actors.country_of_birth,  
count(actors.id) over (partition by actors.country_of_birth) as count_of_actors_from_country
from actors order by country_of_birth;


select genre.name_of_genre as ganre,
count(films.id) as count_of_films  
from films
join genre_of_film on genre_of_film.id_of_film = films.id 
join genre on genre.id = genre_of_film.id_of_genre
group by ganre;


select 
	DISTINCT films.name_of_film as 'name of film',
	count(films.id) over (partition by actors_in_films.id_of_actor) as count_of_actors
from actors_in_films
join films on films.id = actors_in_films.id_of_film
order by count_of_actors desc; 


