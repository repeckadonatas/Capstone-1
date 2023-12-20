create table best_movie_by_year_copy as table best_movie_by_year_2nf;

select * from best_movie_by_year_copy;

select * from media_id limit 10;


alter table best_movie_by_year_copy
add column id varchar(10);

-- alter table best_movie_by_year_copy
-- drop column id;


-- Adding id column from media_id table 
-- to tables that don't have one in order
-- to create a relationship between tables

update best_movie_by_year_copy t1
set id = t2.id
from media_id t2 
where t2.title = t1.title
and t2.release_year = t1.release_year;



select * from best_movie_by_year_copy
where title like '%Taxi Driver%';



-- drop table best_movie_by_year_copy;



