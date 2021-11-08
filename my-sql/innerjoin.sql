use sakila;

select city.city as cidade, pais.country
from city inner join country  as pais  on city.country_id = pais.country_id 
where pais.country = 'Brazil'; 

select * 
from rental
inner join inventory
on rental.inventory_id = inventory.inventory_id;

select rental_id, rental.inventory_id, film_id
from rental
inner join inventory
on rental.inventory_id = inventory.inventory_id;


#########################################################################################
select city, country
from city
inner join country
on city.country_id = country.country_id;

select city, country
from city
inner join country
on city.country_id = country.country_id
where country.country in ('Brazil', 'Argentina');


SELECT
ator.first_name, ator.last_name, filme.film_id AS nomeFilme
FROM
actor AS ator INNER JOIN film_actor AS filme
ON
ator.actor_id = filme.actor_id;



