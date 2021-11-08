use sakila;
select * from view_filmes;

CREATE VIEW view_filmes
AS 
SELECT 
	f.film_id,
    f.title as titulo
FROM
	film as f
		LEFT JOIN
	inventory as i
		ON f.film_id = i.film_id
	GROUP BY 
		f.film_id;