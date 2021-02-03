drop function if exists film;
delimiter //
create function film(a int) 
returns varchar(255) deterministic
begin 
	    declare nameOfFilm varchar(255);
	
	select name_of_film into nameOfFilm from films where id=a; 
	return (nameOfFilm);
end//
delimiter ;

select film(1);


drop function if exists cartoon;
delimiter //
create function count_of_cartoon() 
returns int deterministic
begin 
	    declare allCartoons int;
	
	select count(id) into allCartoons from films where category_id = 2; 
	return (allCartoons);
end//
delimiter ;
select count_of_cartoon();

drop function if exists is_row_exists;
delimiter //
create function is_row_exists (target_id int, target_type_id INT)
returns boolean reads sql data 
begin
	declare table_name varchar(255);
	select target_name from target_types where id = target_type_id into table_name ; 
	
	case table_name 
		when 'films' then 
		 return exists(select 1 from films where id = target_id);
		when 'actor' then 
		 return exists(select 1 from actors where id = target_id);
		when 'news' then 
		 return exists(select 1 from news where id = target_id);
		else
		  return false;
	end case;
end //
delimiter ; 

drop trigger if exists likes_validation;
delimiter //
create trigger likes_validation before insert on likes
for each row begin 
	if !is_row_exists(new.target_id, new.target_type_id) then 
	signal sqlstate "45000"
	set message_text = "ERROR. TARGET TABLE DOESN't contain row is provided!";
	end	if;
end //
delimiter ;


drop procedure if exists genre;
delimiter //
create procedure genre (in a varchar(255))
begin 
	
	select films.name_of_film from films 
	join genre_of_film on films.id = genre_of_film.id_of_film 
	join genre on genre.id = genre_of_film.id_of_genre 
	where genre.name_of_genre = a;

end //
delimiter ;

call genre('drama');

drop table if exists logs;
create table logs (
	name_of_table varchar(50),
	updated_at datetime default current_timestamp(),
	updated_id int
);

drop trigger if exists insert_films;
delimiter //
create trigger insert_films after insert on films
for each row 
BEGIN 
	insert into logs (name_of_table, updated_at, updated_id) values ('films',NEW.updated_at,NEW.id);
END //
delimiter ; 
desc films;
select * from films limit 10;
insert into films (name_of_film,category_id,date_of_release) values ('SEVEN',1, "2018-12-01");

select * from logs;


