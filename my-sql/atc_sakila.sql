use sakila;
select * from customer where  first_name like 'p%';

select * from customer where first_name in('Penelope','John', 'Maria', 'Barbara');

select * from film where title like 'c%';

select * from film where rental_duration >3;

select * from rental where rental_date  like '2005-05-27%' ;

select * from rental where rental_date between '2005-05-27' and '2005-05-29' ;

select first_name as Nome from actor order by first_name desc; ## desc = decrecente / asc = ascendente

