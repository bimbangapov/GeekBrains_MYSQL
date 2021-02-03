alter table actors_in_films 
 add constraint actors_in_film_actor_id_fk
  foreign key (id_of_actor) references actors(id);
  
alter table actors_in_films 
 add constraint actors_in_film_film_id
  foreign key (id_of_film) references films(id); 
  
alter table description_of_film 
 add constraint description_of_film_film_id
  foreign key (id_of_film) references films(id); 
  
alter table films 
 add constraint films_category_id
  foreign key (category_id) references category(id);
  
alter table genre_of_film 
 add constraint genre_of_film_films_id
  foreign key (id_of_film) references films(id);
alter table genre_of_film 
 add constraint genre_of_film_genre_id
  foreign key (id_of_genre) references genre(id); 
  
alter table likes 
 add constraint likes_user_id
  foreign key (user_id) references users(id);
  set foreign_key_checks=0;
  
alter table likes 
 add constraint likes_target_types_id
  foreign key (target_type_id) references target_types(id); 