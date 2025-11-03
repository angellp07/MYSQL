-- ==============================================
-- SECCIÓN A) 30 CONSULTAS CON JOIN DE 2 TABLAS
-- ==============================================
-- 1:  Para cada actor, muestra el número total de películas en las que aparece; es decir, cuenta cuántas filas de film_actor corresponden a cada actor.

select a.actor_id,a.first_name,a.last_name,count(f.film_id) as 'total_films'
from film_actor fa
join 
actor a on a.actor_id = fa.actor_id
join 
film f on f.film_id = fa.film_id
group by a.actor_id,a.first_name,a.last_name
order by a.actor_id,a.first_name,a.last_name asc;
# Utilizamos la función "count" ya que nos dice que contemos y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 2:  Lista solo los actores que participan en 20 o más películas (umbral alto) con su conteo.

select a.actor_id,a.first_name,a.last_name,count(f.film_id) as 'films_20plus'
from film_actor fa
join 
actor a on a.actor_id = fa.actor_id
join 
film f on f.film_id = fa.film_id
group by a.actor_id,a.first_name,a.last_name
having films_20plus >= 20
order by a.actor_id,a.first_name,a.last_name asc;
# Utilizamos la función "count" ya que nos dice que contemos, lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.
# Utilizamos having ya que aplicamos un filtro al resultado del count ya que deseamos aquellas peliculas que sea mayor o igual a 20.

-- 3:  Para cada idioma, indica cuántas películas están catalogadas en ese idioma.

select l.language_id,l.name,count(f.film_id) as 'films_in_language' from language l
join 
film f on f.language_id = l.language_id
group by l.language_id,l.name
order by l.language_id,l.name asc;
# Utilizamos la función "count" ya que nos dice que contemos y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 4:  Muestra el promedio de duración (length) de las películas por idioma y filtra aquellos idiomas con duración media estrictamente mayor a 110 minutos.

select l.language_id, l.name, avg(f.length) as 'avg_length' from film f
join 
language l on f.language_id = l.language_id
group by l.language_id, l.name
having avg_length > 110
order by l.language_id, l.name asc;
# Utilizamos la función "avg" ya que nos dice que saquemos el promedio y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.
# Utilizamos having ya que aplicamos un filtro al resultado del avg o promedio ya que deseamos aquellas cuya duración sea mayor a 110min.

-- 5:  Para cada película, muestra cuántas copias hay en el inventario.

select f.film_id,f.title, count(inv.inventory_id) as 'copies' from film f
join
inventory inv on inv.film_id = f.film_id
group by f.film_id,f.title
order by f.film_id asc;
# Utilizamos la función "count" ya que nos dice que cuantas hay y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 6:  Lista solo las películas que tienen al menos 5 copias en inventario.

select f.film_id,f.title, count(inv.inventory_id) as 'copies_5plus' from film f
join
inventory inv on inv.film_id = f.film_id
group by f.film_id,f.title
having copies_5plus >= 5
order by f.film_id asc;
# Utilizamos la función "count" ya que nos dice que contemos las copias y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.
# Utilizamos having ya que aplicamos un filtro al resultado del count ya que deseamos aquellas peliculas sean mayor o igual a 5.

-- 7:  Para cada artículo de inventario, cuenta cuántos alquileres se han realizado.

select inv.inventory_id,count(re.rental_id) as 'rentals' from inventory inv
join
rental re on re.inventory_id = inv.inventory_id
group by inventory_id
order by inv.inventory_id asc; 
# Utilizamos la función "count" ya que nos dice que contemos los alquileres y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 8:  Para cada cliente, muestra cuántos alquileres ha realizado en total.

select c.customer_id,c.first_name,c.last_name,count(re.rental_id) as 'total_rentals' from customer c
join
rental re on re.customer_id = c.customer_id
group by c.customer_id,c.first_name,c.last_name
order by c.customer_id,c.first_name,c.last_name asc;
# Utilizamos la función "count" ya que nos dice que contemos los alquileres y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 9:  Lista los clientes con 30 o más alquileres acumulados.

select c.customer_id,c.first_name,c.last_name,count(re.rental_id) as 'rentals_30plus' from customer c
join
rental re on re.customer_id = c.customer_id
group by c.customer_id,c.first_name,c.last_name
having rentals_30plus >= 30
order by c.customer_id,c.first_name,c.last_name asc;
# Utilizamos la función "count" ya que nos dice que contemos los alquileres y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.
# Utilizamos having ya que aplicamos un filtro al resultado del count ya que deseamos aquellas peliculas sean mayor o igual a 30.

-- 10:  Para cada cliente, muestra el total de pagos (suma en euros/dólares) que ha realizado.

select c.customer_id,c.first_name,c.last_name,sum(pa.amount) as 'total_amount' from customer c
join
payment pa on pa.customer_id = c.customer_id
group by c.customer_id,c.first_name,c.last_name
order by c.customer_id,c.first_name,c.last_name asc;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 11:  Muestra los clientes cuyo importe total pagado es al menos 200.

select c.customer_id,c.first_name,c.last_name,sum(pa.amount) as 'total_amount' from customer c
join
payment pa on pa.customer_id = c.customer_id
group by c.customer_id,c.first_name,c.last_name
having total_amount >= 200
order by c.customer_id,c.first_name,c.last_name asc;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.
# Utilizamos having ya que aplicamos un filtro al resultado del sum ya que deseamos aquellos pagos sean mayor o igual a 200.

-- 12:  Para cada empleado (staff), muestra el número de pagos que ha procesado.

select st.staff_id,st.first_name,st.last_name,count(pa.payment_id) as 'payments_processed' from staff st
join
payment pa on pa.staff_id = st.staff_id
group by st.staff_id,st.first_name,st.last_name
order by st.staff_id,st.first_name,st.last_name asc;
# Utilizamos la función "count" ya que nos dice que contemos los pagos y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 13:  Para cada empleado, muestra el importe total procesado.

select st.staff_id,st.first_name,st.last_name,sum(pa.amount) as 'total_processed' from staff st
join
payment pa on pa.staff_id = st.staff_id
group by st.staff_id,st.first_name,st.last_name
order by st.staff_id,st.first_name,st.last_name asc;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos para obtener el total y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 14:  Para cada tienda, cuenta cuántos artículos de inventario tiene.

select str.store_id,count(inv.inventory_id) as 'total_inventory_items' from store str
join
inventory inv on inv.store_id = str.store_id
group by str.store_id
order by str.store_id asc;
# Utilizamos la función "count" ya que nos dice que contemos los articulos y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 15:  Para cada tienda, cuenta cuántos clientes tiene asignados.

select str.store_id,count(c.customer_id) as 'customer_in_store' from store str
join
customer c on c.store_id = str.store_id
group by str.store_id
order by str.store_id asc;
# Utilizamos la función "count" ya que nos dice que contemos los clientes y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 16:  Para cada tienda, cuenta cuántos empleados (staff) tiene asignados.

select str.store_id,count(st.staff_id) as 'staff_in_store' from store str
join
staff st on st.store_id = str.store_id
group by str.store_id
order by str.store_id asc;
# Utilizamos la función "count" ya que nos dice que contemos los empleados y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 17:  Para cada dirección (address), cuenta cuántas tiendas hay ubicadas ahí (debería ser 0/1 en datos estándar).

select ad.address_id,ad.address,count(str.store_id) as 'store_here' from address ad
join
store str on str.address_id = ad.address_id
group by ad.address_id,ad.address
order by ad.address_id,ad.address asc;
# Utilizamos la función "count" ya que nos dice que contemos las tiendas y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 18:  Para cada dirección, cuenta cuántos empleados residen en esa dirección.

select ad.address_id,ad.address,count(st.staff_id) as 'staff_here' from address ad
join
staff st on st.address_id = ad.address_id
group by ad.address_id,ad.address
order by ad.address_id,ad.address asc;
# Utilizamos la función "count" ya que nos dice que contemos los empleados y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 19:  Para cada dirección, cuenta cuántos clientes residen ahí.

select ad.address_id,ad.address,count(c.customer_id) as 'customers_here' from address ad
join
customer c on c.address_id = ad.address_id
group by ad.address_id,ad.address
order by ad.address_id,ad.address asc;
# Utilizamos la función "count" ya que nos dice que contemos los clientes y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 20:  Para cada ciudad, cuenta cuántas direcciones hay registradas.

select ci.city_id,ci.city,count(ad.address) as 'addresses_in_city' from city ci
join
address ad on  ad.city_id = ci.city_id
group by ci.city_id,ci.city
order by ci.city_id,ci.city asc;
# Utilizamos la función "count" ya que nos dice que contemos las direcciones y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 21:  Para cada país, cuenta cuántas ciudades existen.

select co.country_id,co.country,count(ci.city_id) 'cities_in_country' from country co
join
city ci on ci.country_id = co.country_id
group by  co.country_id,co.country
order by  co.country_id,co.country asc;
# Utilizamos la función "count" ya que nos dice que contemos las ciudades y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 22:  Para cada idioma, calcula la duración media de películas y muestra solo los idiomas con media entre 90 y 120 inclusive.

select la.language_id,la.name,avg(f.length) 'avg_length' from language la
join 
film f on f.language_id = la.language_id
group by  la.language_id,la.name
having avg_length between 90 and 120
order by la.language_id,la.name asc; 
# Utilizamos la función "avg" ya que nos dice que saquemos el promedio la duración y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.
# Utilizamon having porque aplicamos un filtro sobre el resultado del avg ya que queremos aquella duración este entre 90 y 120.

-- 23:  Para cada película, cuenta el número de alquileres que se han hecho de cualquiera de sus copias (usando inventario).

select f.film_id,f.title,count(re.rental_id) as 'total_rentals'from film f
join
inventory inv on inv.film_id = f.film_id
join
rental re on re.inventory_id = inv.inventory_id
group by f.film_id,f.title
order by f.film_id,f.title asc;
# Utilizamos la función "count" ya que nos dice que contemos los los alquileres y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 24:  Para cada cliente, cuenta cuántos pagos ha realizado en 2005 (usando el año de payment_date).

select c.customer_id,c.first_name,c.last_name,count(pa.payment_id) as 'payments_2005' from customer c
join
payment pa on pa.customer_id = c.customer_id
where year(pa.payment_date) = 2005
group by c.customer_id,c.first_name,c.last_name
order by c.customer_id,c.first_name,c.last_name asc;
# Utilizamos la función "count" ya que nos dice que contemos los pagos y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.
# Utilizamos where porque queremos filtra antes de que nos agrupe para que el resultado sea los pagos de 2005.

-- 25:  Para cada película, muestra el promedio de tarifa de alquiler (rental_rate) de las copias existentes (es un promedio redundante pero válido).

select f.film_id,f.title,avg(f.rental_rate) as 'avg_rate' from film f
group by f.film_id,f.title
order by f.film_id,f.title asc;
# Utilizamos la función "avg" ya que nos dice que saquemos el promedio de las tarifas y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 26:  Para cada actor, muestra la duración media (length) de sus películas.

select a.actor_id,a.first_name,a.last_name,avg(length) as 'avg_length_by_actor' from actor a
join
film_actor fa on fa.actor_id = a.actor_id
join
film f on f.film_id = fa.film_id
group by a.actor_id,a.first_name,a.last_name
order by a.actor_id,a.first_name,a.last_name asc;
# Utilizamos la función "avg" ya que nos dice que saquemos el promedio de la duración y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 27:  Para cada ciudad, cuenta cuántos clientes hay (usando la relación cliente->address->city requiere 3 tablas; aquí contamos direcciones por ciudad).

select ci.city_id,ci.city,count(c.customer_id) as 'total_addresses' from city ci
join
address ad on ad.city_id = ci.city_id
join
customer c on c.address_id = ad.address_id
group by ci.city_id,ci.city
order by ci.city_id,ci.city asc;
# Utilizamos la función "count" ya que nos dice que contemos los clientes y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 28:  Para cada película, cuenta cuántos actores tiene asociados.

select f.film_id,title,count(a.actor_id) as 'actors_in_film' from film f
join 
film_actor fa on fa.film_id = f.film_id
join
actor a on a.actor_id = fa.actor_id
group by f.film_id,title
order by f.film_id,title asc;
# Utilizamos la función "count" ya que nos dice que contemos los actores y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 29:  Para cada categoría (por id), cuenta cuántas películas pertenecen a ella (sin nombre de categoría para mantener 2 tablas).

select ca.category_id,count(f.film_id) as 'films_in_category' from category ca
join
film_category fc on fc.category_id = ca.category_id
join 
film f on f.film_id = fc.film_id
group by ca.category_id
order by ca.category_id asc;
# Utilizamos la función "count" ya que nos dice que contemos las peliculas y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.

-- 30:  Para cada tienda, cuenta cuántos alquileres totales se originan en su inventario.

select str.store_id,count(re.inventory_id) as 'rentals_by_store_inventory' from store str 
join
inventory inv on inv.store_id = str.store_id
join
rental re on re.inventory_id = inv.inventory_id
group by str.store_id
order by str.store_id asc;
# Utilizamos la función "count" ya que nos dice que contemos los alquileres y lo demas es ir uniendo tablas con join sin pasarse de usar solo 2.
-- ==============================================
-- SECCIÓN B) 30 CONSULTAS CON JOIN DE 3 TABLAS
-- ==============================================
-- 31:  Para cada actor, cuenta cuántas películas tiene y muestra solo los que superan 15 películas.

select a.actor_id,a.first_name,a.last_name,count(f.film_id) as 'films_by_actor' from actor a
join
film_actor fa on fa.actor_id = a.actor_id
join
film f on f.film_id = fa.film_id
group by a.actor_id,a.first_name,a.last_name
having films_by_actor > 15
order by a.actor_id,a.first_name,a.last_name asc;
# Utilizamos la función "count" ya que nos dice que contemos las peliculas y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.
# Utilizamos having porque queremos filtra el resultado del count para que nos saque aquellas peliculas que superen las 15.

-- 32:  Para cada categoría (por nombre), cuenta cuántas películas hay en esa categoría.

select ca.category_id,ca.name,count(f.film_id) as 'flims_in_category' from category ca
join
film_category fc on fc.category_id = ca.category_id
join 
film f on f.film_id = fc.film_id
group by ca.category_id,ca.name
order by ca.category_id,ca.name asc;
# Utilizamos la función "count" ya que nos dice que contemos las peliculas y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.

-- 33:  Para cada película, cuenta cuántos alquileres se han hecho de sus copias.

select f.film_id,f.title,count(re.rental_id) 'rentals_of_film' from film f
join
inventory inv on inv.film_id = f.film_id
join
rental re on re.inventory_id = inv.inventory_id
group by f.film_id,f.title
order by f.film_id,f.title asc;
# Utilizamos la función "count" ya que nos dice que contemos los alquileres y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.

-- 34:  Para cada cliente, suma el importe pagado en 2005 y filtra clientes con total >= 150.

select c.customer_id,c.first_name,c.last_name,sum(pa.amount) as 'total_2005' from customer c
join
payment pa on pa.customer_id = c.customer_id
where year(pa.payment_date) = 2005
group by c.customer_id,c.first_name,c.last_name
having total_2005 >= 150
order by c.customer_id,c.first_name,c.last_name asc;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.
# Utilizamos having porque queremos filtra el resultado del sum para que nos saque aquellos pagos que sean mayor o igual a 150.

-- 35:  Para cada tienda, suma el importe cobrado por todos sus empleados.

select str.store_id,sum(pa.amount) as 'revenue_by_store_staff' from store str
join
staff st on st.store_id = str.store_id
join
payment pa on pa.staff_id = st.staff_id
group by str.store_id
order by str.store_id asc;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.

-- 36:  Para cada ciudad, cuenta cuántos empleados residen ahí (staff -> address -> city).

select ci.city_id,ci.city,count(st.staff_id) as 'staff_in_city' from city ci
join
address ad on ad.city_id = ci.city_id
join
staff st on st.address_id = ad.address_id
group by ci.city_id,ci.city
order by ci.city_id,ci.city asc;
# Utilizamos la función "count" ya que nos dice que contemos los empleados y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.

-- 37:  Para cada ciudad, cuenta cuántas tiendas existen (store -> address -> city).

select ci.city_id,ci.city,count(str.store_id) as 'stores_in_city' from city ci
join
address ad on ad.city_id = ci.city_id
join
store str on str.address_id = ad.address_id
group by ci.city_id,ci.city
order by ci.city_id,ci.city asc;
# Utilizamos la función "count" ya que nos dice que contemos las tiendas y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.

-- 38:  Para cada actor, calcula la duración media de sus películas del año 2006.

select a.actor_id,a.first_name,a.last_name,avg(f.length) as 'avg_len_2006' from actor a 
join
film_actor fa on fa.actor_id = a.actor_id
join
film f on f.film_id = fa.film_id
where f.release_year = 2006
group by a.actor_id,a.first_name,a.last_name;
# Utilizamos la función "avg" ya que nos dice saquemos el promedio de la duración y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.
# Utilizamos where porque queremos filtrar antes de agrupar para que nos saque los resultados de 2006.

-- 39:  Para cada categoría, calcula la duración media y muestra solo las que superan 120.

select ca.category_id,ca.name,avg(f.length) as 'avg_len' from category ca 
join
film_category fc on fc.category_id = ca.category_id
join
film f on f.film_id = fc.film_id
group by ca.category_id,ca.name
having avg_len > 120
order by ca.category_id,ca.name asc;
# Utilizamos la función "avg" ya que nos dice saquemos el promedio de la duración y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.
# Utilizamos having porque queremos filtra el resultado del avg para que nos saque aquellos pagos que sean mayor a 120.

-- 40:  Para cada idioma, suma las tarifas de alquiler (rental_rate) de todas sus películas.

select la.language_id,la.name,sum(f.rental_rate) as 'sum_rates' from language la
join
film f on f.language_id = la.language_id
join
inventory inv on inv.film_id = f.film_id
group by la.language_id,la.name;
# Utilizamos la función "sum" ya que nos dice saquemos la suma de las tarifas y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.

-- 41:  Para cada cliente, cuenta cuántos alquileres realizó en fines de semana (SÁB-DO) usando DAYOFWEEK (1=Domingo).

select c.customer_id,c.first_name,c.last_name,count(re.rental_id) as 'weekend_rentals' from customer c
join
rental re on re.customer_id = c.customer_id
where dayofweek(re.rental_date) in (1,7)
group by c.customer_id,c.first_name,c.last_name
order by c.customer_id,c.first_name,c.last_name asc;
# Utilizamos la función "count" ya que nos dice que contemos los alquileres y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.
# Utilizamos where porque queremos filtrar antes de agrupar para que nos saque los resultados que estan entre el sabado y domingo.

-- 42:  Para cada actor, muestra el total de títulos distintos en los que participa (equivale a COUNT DISTINCT, sin subconsulta).

select a.actor_id,a.first_name,a.last_name,count(distinct f.film_id) as 'distinct_films' from actor a
join
film_actor fa on fa.actor_id = a.actor_id                                                                    
join
film f on f.film_id = fa.film_id
group by a.actor_id,a.first_name,a.last_name
order by a.actor_id,a.first_name,a.last_name asc;
# Utilizamos la función "count" ya que nos dice que contemos las peliculas distintas y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.

-- 43:  Para cada ciudad, cuenta cuántos clientes residen ahí (customer -> address -> city).

select ci.city_id,ci.city,count(c.customer_id) as 'customers_in_city' from city ci
join
address ad on ad.city_id = ci.city_id
join
customer c on c.address_id = ad.address_id
group by ci.city_id,ci.city;
# Utilizamos la función "count" ya que nos dice que contemos los clientes y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.

-- 44:  Para cada categoría, muestra cuántos actores distintos participan en películas de esa categoría.

select ca.category_id,ca.name, count(distinct a.actor_id) as 'actors_in_category' from category ca
join
film_category fc on fc.category_id = ca.category_id
join
film_actor fa on fa.film_id = fc.film_id
join
actor a on a.actor_id = fa.actor_id
group by ca.category_id,ca.name
order by ca.category_id,ca.name asc;
# Utilizamos la función "count" ya que nos dice que contemos los actores distintos y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.

-- 45:  Para cada tienda, cuenta cuántas copias totales (inventario) tiene de películas en 2006.

select str.store_id,count(inv.inventory_id) as 'copies_2006' from store str
join
inventory inv on inv.store_id = str.store_id
join
film f on f.film_id = inv.film_id
where release_year = 2006
group by str.store_id 
order by str.store_id desc;
# Utilizamos la función "count" ya que nos dice que contemos las copias y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.
# Utilizamos where porque queremos filtrar antes de agrupar para que nos saque las copias de 2006.

-- 46:  Para cada cliente, suma el total pagado por alquileres cuyo empleado pertenece a la tienda 1.

select c.customer_id,c.first_name,c.last_name,sum(pa.amount) as 'total_amount' from customer c
join
payment pa on pa.customer_id = c.customer_id
join
staff st on st.staff_id = pa.staff_id
join 
store str on str.store_id = st.store_id
where str.store_id = 1
group by c.customer_id,c.first_name,c.last_name
order by c.customer_id,c.first_name,c.last_name asc;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.
# Utilizamos where porque queremos filtrar antes de agrupar para que nos saque el total de la tienda 1.

-- 47:  Para cada película, cuenta cuántos actores tienen el apellido de longitud >= 5.

select f.film_id,f.title,count(a.actor_id) as 'actors_lastname_len5plus' from film f
join
film_actor fa on fa.film_id = f.film_id
join
actor a on a.actor_id = fa.actor_id
where length(a.last_name) >= 5
group by  f.film_id,f.title;
# Utilizamos la función "count" ya que nos dice que contemos los actores y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.
# Utilizamos where porque queremos filtrar antes de agrupar para que nos saque los apellidos que tengan mas o igual a 5 letras.

-- 48:  Para cada categoría, suma la duración total (length) de sus películas.

select ca.category_id,ca.name,sum(f.length) as 'total_length' from category ca
join
film_category fc on fc.category_id = ca.category_id
join
film f on f.film_id = fc.film_id
group by ca.category_id,ca.name
order by ca.category_id,ca.name asc;
# Utilizamos la función "sum" ya que nos dice que sumemos la duracón y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.

-- 49:  Para cada ciudad, suma los importes pagados por clientes que residen en esa ciudad.

select ci.city_id,ci.city,sum(pa.amount) as 'total_paid' from city ci
join
address ad on ad.city_id = ci.city_id
join
customer c on c.address_id = ad.address_id
join
payment pa on pa.customer_id = c.customer_id
group by ci.city_id,ci.city;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.

-- 50:  Para cada idioma, cuenta cuántos actores distintos participan en películas de ese idioma.

select la.language_id,la.name,count(distinct a.actor_id) as 'actors_in_language' from language la
join
film f on f.language_id = la.language_id
join
film_actor fa on fa.film_id = f.film_id
join
actor a on a.actor_id = fa.actor_id
group by la.language_id,la.name
order by la.language_id,la.name asc;
# Utilizamos la función "count" ya que nos dice que contemos los actores distintos y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.

-- 51:  Para cada tienda, cuenta cuántos clientes activos (active=1) tiene.

select str.store_id, count(c.customer_id) as 'active_customers' from store str
join 
customer c on c.store_id = str.store_id
where (active=1)
group by str.store_id
order by str.store_id asc;
# Utilizamos la función "count" ya que nos dice que contemos los clientes y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.

-- 52:  Para cada cliente, cuenta en cuántas categorías distintas ha alquilado (aprox. vía film_category; requiere 4 tablas, aquí contamos películas 2006 por inventario).

select c.customer_id,c.first_name,c.last_name,count(distinct fc.category_id) as 'rentals_2006' from customer c
join
rental re on re.customer_id = c.customer_id
join
inventory inv on inv.inventory_id = re.inventory_id
join
film_category fc on fc.film_id = inv.film_id
where year(re.rental_date) = 2006
group by c.customer_id,c.first_name,c.last_name;
#aqui me di cuenta que tanto film como category se pueden saltar en el join ya que inventory y fil_category tienen las claves foraneas de las tablas que he dicho antes.
#cumpliendo con que usaramos 4 tablas.

-- 53:  Para cada empleado, cuenta cuántos clientes diferentes le han pagado.

select st.staff_id,st.first_name,st.last_name,count(distinct c.customer_id) as 'distinct_customers_paid' from staff st
join
payment pa on pa.staff_id = st.staff_id
join
customer c on c.customer_id = pa.customer_id
group by st.staff_id,st.first_name,st.last_name;
# Utilizamos la función "count" ya que nos dice que contemos los clientes distintos y lo demas es ir uniendo tablas con join sin pasarse de usar solo 3.

-- 54:  Para cada ciudad, cuenta cuántas películas del año 2006 han sido alquiladas por residentes en esa ciudad.

select ci.city_id,ci.city,count(inv.film_id) as 'rentals_2006_by_city' from city ci
join
address ad on ad.city_id = ci.city_id
join
customer c on c.address_id = ad.address_id
join
rental re on re.customer_id = c.customer_id
join
inventory inv on inv.inventory_id = re.inventory_id
where year(rental_date) = 2006
group by ci.city_id,ci.city;
# Utilizamos la función "count" ya que nos dice que contemos las peliculas y no logre hacerlo utilizando como mucho 3 tablas.

-- 55:  Para cada categoría, calcula el promedio de replacement_cost de sus películas.

select ca.category_id,ca.name,avg(f.replacement_cost) as 'avg_replacement_cost' from category ca
join
film_category fc on fc.category_id = ca.category_id
join
film f on f.film_id = fc.film_id
group by ca.category_id,ca.name
order by ca.category_id,ca.name asc;
# Utilizamos la función "avg" ya que nos dice que saquemos el promedio y lo demas es usando las 3 o menos tablas.

-- 56:  Para cada tienda, suma los importes cobrados en 2006 (vía empleados de esa tienda).

select str.store_id,sum(pa.amount) as 'revenue_2006' from store str
join
staff st on st.store_id = str.store_id
join
payment pa on pa.staff_id = st.staff_id
where year(payment_date) = 2006
group by str.store_id,st.staff_id
order by str.store_id,st.staff_id asc;
# Utilizamos la función "sum" ya que nos dice que sumemos y lo demas es usando las 3 o menos tablas.
# Utilizamos where porque queremos filtrar antes de agrupar para que nos saquemos los pagos de 2006.

-- 57:  Para cada actor, cuenta cuántas películas tienen título de más de 12 caracteres.

select a.actor_id,a.first_name,a.last_name,count(f.film_id) as 'films_title_len_gt12' from actor a
join
film_actor fa on fa.actor_id = a.actor_id
join
film f on f.film_id = fa.film_id
where length(f.title) > 12
group by a.actor_id,a.first_name,a.last_name
order by a.actor_id,a.first_name,a.last_name asc;
# Utilizamos la función "count" ya que nos dice que contemos las peliculas y lo demas es usando las 3 o menos tablas.
# Utilizamos where porque queremos filtrar antes de agrupar para que nos saque los resultados de aquellos titulos que tienen mas de 12 letras.

-- 58:  Para cada ciudad, calcula la suma de pagos de 2005 y filtra las ciudades con total >= 300.

select ci.city_id,ci.city,sum(pa.amount) as 'amount_2005' from city ci
join
address ad on ad.city_id = ci.city_id 
join
customer c on c.address_id = ad.address_id
join
payment pa on pa.customer_id = c.customer_id
where year(pa.payment_date) = 2005
group by ci.city_id,ci.city
having amount_2005 >= 300
order by ci.city_id,ci.city asc;
# Utilizamos la función "sum" ya que nos dice que sumemos y lo demas es usando las 3 o menos tablas.
# Utilizamos where porque queremos filtrar antes de agrupar para que nos saque los resultados de 2005.
# Utilizamos having porque filtramos el resultado para que nos de aquellos que son mayor o igual a 300.

-- 59:  Para cada categoría, cuenta cuántas películas tienen rating 'PG' o 'PG-13'.

select ca.category_id,ca.name,count(f.film_id) as 'films_pg_pg13' from category ca
join
film_category fc on fc.category_id = ca.category_id
join
film f on f.film_id = fc.film_id
where f.rating in ('PG','PG-13')
group by ca.category_id,ca.name;
# Utilizamos la función "count" ya que nos dice que contemos las peliculas y lo demas es usando las 3 o menos tablas.
# Utilizamos where porque queremos filtrar antes de agrupar para que nos saque los resultados donde aparezcan esa palabra.

-- 60:  Para cada cliente, calcula el total pagado en pagos procesados por el empleado 2.

select c.customer_id,c.first_name,c.last_name,sum(pa.amount) as 'total_paid_by_staff2' from customer c
join
payment pa on pa.customer_id = c.customer_id
join
staff st on st.staff_id = pa.staff_id
where st.staff_id = 2
group by c.customer_id,c.first_name,c.last_name
order by c.customer_id,c.first_name,c.last_name asc;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es usando las 3 o menos tablas.
# Utilizamos where porque queremos filtrar antes de agrupar para que nos saque los resultados hechos por el empleado 2.

-- ==============================================
-- SECCIÓN C) 20 CONSULTAS CON JOIN DE 4 TABLAS
-- ==============================================
-- 61:  Para cada ciudad, cuenta cuántos clientes hay y muestra solo ciudades con 10 o más clientes.

select ci.city_id,ci.city,count(c.customer_id) as 'customers_in_here' from city ci
join
address ad on ad.city_id = ci.city_id
join
customer c on c.address_id =ad.address_id
group by ci.city_id,ci.city
having customers_in_here >=10;
# Utilizamos la función "count" ya que nos dice que contemos los clientes y lo demas es usando las 4 o menos tablas.
# Utilizamos having porque filtramos el resultado para que nos de aquellos que son mayor o igual a 10.

-- 62:  Para cada actor, cuenta cuántos alquileres totales suman todas sus películas.

select a.actor_id,a.first_name,a.last_name,count(re.rental_id) as 'rental_for_actor' from actor a
join
film_actor fa on fa.actor_id = a.actor_id
join
film f on f.film_id = fa.film_id
join
inventory inv on inv.film_id = f.film_id
join
rental re on re.inventory_id = inv.inventory_id
group by a.actor_id,a.first_name,a.last_name;
# Utilizamos la función "count" ya que nos dice que contemos los clientes y lo demas es usando las 4 o menos tablas.

-- 63:  Para cada categoría, suma los importes pagados derivados de películas de esa categoría.

select ca.category_id,ca.name,sum(pa.amount) as 'revenue_by_category' from category ca
join
film_category fc on fc.category_id = ca.category_id
join
inventory inv on inv.film_id = fc.film_id
join
rental re on re.inventory_id = inv.inventory_id
join
payment pa on pa.rental_id = re.rental_id
group by ca.category_id,ca.name
order by ca.category_id,ca.name;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es usando las 4 o menos tablas.

-- 64:  Para cada ciudad, suma los importes pagados por clientes residentes en esa ciudad en 2005.

select ci.city_id,ci.city,sum(pa.amount) as 'total_paid_2005' from city ci
join
address ad on ad.city_id = ci.city_id
join
customer c on c.address_id = ad.address_id
join
payment pa on pa.customer_id = c.customer_id
where year(pa.payment_date) = 2005
group by ci.city_id,ci.city;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es usando las 4 o menos tablas.
# Utilizamos where para filtrar antes de agrupar y que nos saque los resultados del 2005.

-- 65:  Para cada tienda, cuenta cuántos actores distintos aparecen en las películas de su inventario.

select str.store_id,count(distinct fa.actor_id) as 'distinct_actors_in_store_inventory' from store str
join
inventory inv on inv.store_id = str.store_id
join
payment pa on pa.rental_id = inv.inventory_id
join
film_actor fa on fa.film_id = inv.film_id
group by str.store_id;
# Utilizamos la función "count" ya que nos dice que contemos los actores y lo demas es usando las 4 o menos tablas.

-- 66:  Para cada idioma, cuenta cuántos alquileres totales se han hecho de películas en ese idioma.

select la.language_id,la.name,count(re.rental_id) as 'rental_in_language' from language la 
join
film f on f.language_id = la.language_id
join
inventory inv on inv.film_id = f.film_id
join
rental re on re.inventory_id = inv.inventory_id
group by la.language_id,la.name
order by  la.language_id,la.name asc;
# Utilizamos la función "count" ya que nos dice que contemos los alquileres y lo demas es usando las 4 o menos tablas.

-- 67:  Para cada cliente, cuenta en cuántos meses distintos de 2005 realizó pagos (meses distintos).

select c.customer_id,c.first_name,c.last_name,count(distinct month(pa.payment_date)) as 'active_months_2005' from customer c
join
payment pa on pa.customer_id = c.customer_id
where year(pa.payment_date) = 2005
group by c.customer_id,c.first_name,c.last_name;
# Utilizamos la función "count" ya que nos dice que contemos los meses distintos y lo demas es usando las 4 o menos tablas.
# Utilizamos where para filtrar antes de agrupar y que nos saque los resultados del 2005.

-- 68:  Para cada categoría, calcula la duración media de las películas alquiladas (considerando solo películas alquiladas).

select ca.category_id,ca.name,avg(f.length) as 'avg_length_rented' from category ca
join
film_category fc on fc.category_id = ca.category_id
join
film f on f.film_id = fc.film_id
join
inventory inv on inv.film_id = f.film_id
join
rental re on re.inventory_id = inv.inventory_id
group by ca.category_id,ca.name
order by ca.category_id,ca.name asc;
# Utilizamos la función "avg" ya que nos dice que saquemos el promedio de la duración y lo demas es usando las 4 o menos tablas.

-- 69:  Para cada país, cuenta cuántos clientes hay (country -> city -> address -> customer).

select co.country_id,co.country,count(c.customer_id) as 'customers_in_country' from country co
join
city ci on ci.country_id = co.country_id
join
address ad on ad.city_id = ci.city_id
join
customer c on c.address_id = ad.address_id
group by co.country_id,co.country
order by co.country_id,co.country asc;
# Utilizamos la función "count" ya que nos dice que contemos los clientes y lo demas es usando las 4 o menos tablas.

-- 70:  Para cada país, suma los importes pagados por sus clientes.

select co.country_id,co.country,sum(pa.amount) as 'total_paid_by_country' from country co
join
city ci on ci.country_id = co.country_id
join
address ad on ad.city_id = ci.city_id
join
customer c on c.address_id = ad.address_id
join
payment pa on pa.customer_id = c.customer_id
group by co.country_id,co.country;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es usando las 4 o menos tablas.

-- 71:  Para cada tienda, cuenta cuántas categorías distintas existen en su inventario.

select str.store_id,count(distinct ca.category_id) as 'distinct_categories_in_store' from store str
join
inventory inv on inv.store_id = str.store_id
join
film f on f.film_id = inv.film_id
join
film_category fc on fc.film_id = f.film_id
join
category ca on ca.category_id = fc.category_id
group by str.store_id
order by str.store_id asc;
# Utilizamos la función "count" ya que nos dice que contemos las categorias distintas y lo demas es usando las 4 o menos tablas.

-- 72:  Para cada tienda, suma la recaudación por categoría (resultado agregado por tienda y categoría).

select st.store_id,ca.category_id,ca.name,sum(pa.amount) as 'renueve' from category ca
join
film_category fc on fc.category_id = ca.category_id
join
inventory inv on inv.film_id = fc.film_id
join
rental re on re.inventory_id = inv.inventory_id
join
payment pa on pa.rental_id = re.rental_id
join
staff st on st.staff_id = pa.staff_id
group by st.store_id,ca.category_id,ca.name
order by ca.name asc, st.store_id desc;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos distintos y lo demas no logre usar las 4 o menos tablas. 

-- 73:  Para cada actor, cuenta en cuántas tiendas distintas se han alquilado sus películas.

select a.actor_id,a.first_name,a.last_name,count(distinct str.store_id) as 'stores_with_actor_films_rented' from actor a
join
film_actor fa on fa.actor_id = a.actor_id
join
inventory inv on inv.film_id = fa.film_id
join
rental re on re.inventory_id = inv.inventory_id
join
store str on str.store_id = inv.store_id
group by a.actor_id,a.first_name,a.last_name;
# Utilizamos la función "count" ya que nos dice que contemos las tiendas distintas y lo demas es usando las 4 o menos tablas. 

-- 74:  Para cada categoría, cuenta cuántos clientes distintos han alquilado películas de esa categoría.

select ca.category_id,ca.name,count(distinct c.customer_id) as 'distinct_customers' from category ca
join
film_category fc on fc.category_id = ca.category_id
join
inventory inv on inv.film_id = fc.film_id
join
rental re on re.inventory_id = inv.inventory_id
join
customer c on c.customer_id = re.customer_id
group by ca.category_id,ca.name;
# Utilizamos la función "count" ya que nos dice que contemos los clientes distintos y lo demas es usando las 4 o menos tablas. 

-- 75:  Para cada idioma, cuenta cuántos actores distintos participan en películas alquiladas en ese idioma.

select la.language_id,la.name,count(distinct fa.actor_id) as 'actors_in_rented_language_films' from language la 
join
film f on f.language_id = la.language_id
join
film_actor fa on fa.film_id = f.film_id
join
inventory inv on inv.film_id = fa.film_id
join
rental re on re.inventory_id = inv.inventory_id
group by la.language_id,la.name;
# Utilizamos la función "count" ya que nos dice que contemos los actores distintos y lo demas es usando las 4 o menos tablas. 

-- 76:  Para cada país, cuenta cuántas tiendas hay (país->ciudad->address->store).

select co.country_id,co.country,count(str.store_id) as 'stores_in_country' from country co
join
city ci on ci.country_id = co.country_id
join
address ad on ad.city_id = ci.city_id
join
store str on str.address_id = ad.address_id
group by co.country_id,co.country;
# Utilizamos la función "count" ya que nos dice que contemos las tiendas y lo demas es usando las 4 o menos tablas. 

-- 77:  Para cada cliente, cuenta los alquileres en los que la devolución (return_date) fue el mismo día del alquiler.

select c.customer_id,c.first_name,c.last_name,count(re.rental_id) as 'same_day_returns' from customer c
join
rental re on re.customer_id = c.customer_id
join
inventory inv on inv.inventory_id = re.inventory_id
join
film f on f.film_id = inv.film_id
where date(re.rental_date) = date(re.return_date)
group by c.customer_id,c.first_name,c.last_name;
# Utilizamos la función "count" ya que nos dice que contemos los alquileres y lo demas es usando las 4 o menos tablas. 
# Utilizamos where para filtrar antes de agrupar para decir que la fecha de alquiler de la pelicula es lo mismo que la fecha que se devuelve la pelicula.

-- 78:  Para cada tienda, cuenta cuántos clientes distintos realizaron pagos en 2005.

select str.store_id,count(distinct pa.customer_id) as 'distinct_customers_2005' from payment pa
join
staff st on st.staff_id = pa.staff_id
join
store str on str.store_id = st.store_id
where year(payment_date) = 2005
group by str.store_id;
# Utilizamos la función "count" ya que nos dice que contemos los clientes distintos y lo demas es usando las 4 o menos tablas. 
# Utilizamos where para filtrar antes de agrupar para que nos saque los resultados de 2005.

-- 79:  Para cada categoría, cuenta cuántas películas con título de longitud > 15 han sido alquiladas.

select ca.category_id,ca.name,count(f.film_id) as 'rentals_long_title' from category ca
join
film_category fc on fc.category_id = ca.category_id
join
film f on f.film_id = fc.film_id
join
inventory inv on inv.film_id = f.film_id
join
rental re on re.inventory_id = inv.inventory_id
where length(f.title) > 15
group by ca.category_id,ca.name;
# Utilizamos la función "count" ya que nos dice que contemos las peliculas y lo demas es usando las 4 o menos tablas. 
# Utilizamos where para filtrar antes de agrupar para decir que nos saque los resultados de aquellos titulos que tengan mas de 15 letras o caracteres.

-- 80:  Para cada país, suma los pagos procesados por los empleados de las tiendas ubicadas en ese país.

select co.country_id,co.country,sum(pa.amount) as 'revenue_by_country_staff' from country co
join
city ci on ci.country_id = co.country_id
join
address ad on ad.city_id = ci.city_id
join
staff st on st.address_id = ad.address_id
join
payment pa on pa.staff_id = st.staff_id
group by co.country_id,co.country;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es usando las 4 o menos tablas. 

-- ==============================================
-- SECCIÓN D) 20 CONSULTAS EXTRA (DIFICULTAD +), <=4 JOINS
-- ==============================================
-- 81:  Para cada cliente, muestra el total pagado con IVA teórico del 21% aplicado (total*1.21), redondeado a 2 decimales.

select c.customer_id,c.first_name,c.last_name,round(sum(pa.amount*1.21),2) as 'total_with_vat_21' from customer c
join
payment pa on pa.customer_id = c.customer_id
group by c.customer_id,c.first_name,c.last_name;
# Utilizamos la función "sum" y "round" ya que nos dice que sumemos los pagos y que solo salgan con 2 decimales y lo demas es usando las 4 o menos tablas. 

-- 82:  Para cada hora del día (0-23), cuenta cuántos alquileres se iniciaron en esa hora.

select hour(rental_date) as 'rental_hour', count(rental_id) as 'rentals_in_hour' from rental
where hour(rental_date) between 0 and 23
group by rental_hour
order by rental_hour asc;
# Utilizamos la función "count" ya que nos dice que contemos los alquileres y lo demas es usando las 4 o menos tablas. 
# Utilizamos where para que nos filtre antes de agrupar y nos de el resultado de las horas 0 y 23.

-- 83:  Para cada tienda, muestra la media de length de las películas alquiladas en 2005 y filtra las tiendas con media >= 100.

select str.store_id,avg(f.length) as 'avg_length_2005' from store str
join 
inventory inv on inv.store_id = str.store_id
join
film f on f.film_id = inv.film_id
join
rental re on re.inventory_id = inv.inventory_id
where year(rental_date) = 2005 
group by str.store_id
having avg_length_2005 >= 100;
# Utilizamos la función "avg" ya que nos dice que el promedio de la duración y lo demas es usando las 4 o menos tablas. 
# Utilizamos where para que nos filtre antes de agrupar y nos de los resultados de 2005.
# Utilizamos having ya que queremos darle un filtro al avg para que nos de aquellos que sean mayor o igual a 100.

-- 84:  Para cada categoría, muestra la media de replacement_cost de las películas alquiladas un domingo.

select ca.category_id,ca.name,avg(f.replacement_cost) as 'avg_replacement_sundays' from rental re
join
inventory inv on inv.inventory_id = re.inventory_id
join
film f on f.film_id = inv.film_id
join
film_category fc on fc.film_id = f.film_id
join
category ca on ca.category_id = fc.category_id
where dayofweek(re.rental_date) = 1
group by ca.category_id,ca.name;
# Utilizamos la función "avg" ya que nos dice que el promedio del coste y lo demas es usando las 4 o menos tablas. 
# Utilizamos where para que nos filtre antes de agrupar y nos de los resultados de las peliculas alquilada los domingos.

-- 85:  Para cada empleado, muestra el importe total por pagos realizados entre las 00:00 y 06:00 (inclusive 00:00, exclusivo 06:00).

select st.staff_id,st.first_name,st.last_name,sum(pa.amount) as 'night_shift_amount' from staff st
join
payment pa on pa.staff_id = st.staff_id
where hour(pa.payment_date) between 00 and 05
group by st.staff_id,st.first_name,st.last_name;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es usando las 4 o menos tablas. 
# Utilizamos where para que nos filtre antes de agrupar y nos de los resultados entre las horas 00 y 05 porque 06 no esta incluido.


-- 86:  Para cada actor, cuenta cuántas de sus películas tienen un título que contiene la palabra 'LOVE' (mayúsculas).

select a.actor_id,a.first_name,a.last_name,count(f.film_id) as 'films_with_love' from actor a
join
film_actor fa on fa.actor_id = a.actor_id
join
film f on f.film_id = fa.film_id
where f.title like '%LOVE%'
group by a.actor_id,a.first_name,a.last_name
order by a.actor_id,a.first_name,a.last_name;
# Utilizamos la función "count" ya que nos dice que contemos las peliculas y lo demas es usando las 4 o menos tablas. 
# Utilizamos where para que nos filtre antes de agrupar y nos de los resultados contengas la palabra LOVE.

-- 87:  Para cada idioma, muestra el total de pagos de alquileres de películas en ese idioma.

select la.language_id,la.name,sum(pa.amount) as 'total_amount_in_language' from language la
join
film f on f.language_id = la.language_id
join
inventory inv on inv.film_id = f.film_id
join
rental re on re.inventory_id = inv.inventory_id
join
payment pa on pa.rental_id = re.rental_id
group by la.language_id,la.name;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es usando las 4 o menos tablas. 

-- 88:  Para cada cliente, cuenta en cuántos días distintos de 2005 realizó algún alquiler.

select c.customer_id,c.first_name,c.last_name,count(distinct date(re.rental_date)) as 'active_days_2005' from customer c
join
rental re on re.customer_id = c.customer_id
where year(re.rental_date) = 2005
group by c.customer_id,c.first_name,c.last_name
order by c.customer_id,c.first_name,c.last_name asc;
# Utilizamos la función "count" ya que nos dice que contemos las peliculas y lo demas es usando las 4 o menos tablas. 
# Utilizamos where para que nos filtre antes de agrupar y nos de los resultados de 2005.

-- 89:  Para cada categoría, calcula la longitud media de títulos (número de caracteres) de sus películas alquiladas.

select ca.category_id,ca.name,avg(length(f.title)) as 'avg_title_len_rented' from category ca
join
film_category fc on fc.category_id = ca.category_id
join
film f on f.film_id = fc.film_id
join
inventory inv on inv.film_id = f.film_id
join
rental re on re.inventory_id = inv.inventory_id
group by ca.category_id,ca.name
order by ca.category_id,ca.name asc;
# Utilizamos la función "avg" ya que nos dice que saquemos el promedio de la duración y lo demas es usando las 4 o menos tablas. 

-- 90:  Para cada tienda, cuenta cuántos clientes distintos alquilaron en el primer trimestre de 2006 (enero-marzo).

select str.store_id,count(distinct re.customer_id) as 'distinct_customers_q1_2006' from store str
join
inventory inv on inv.store_id = str.store_id
join
rental re on re.inventory_id = inv.inventory_id
where year(re.rental_date) = 2006 and quarter(re.rental_date) = 1
group by str.store_id
order by str.store_id asc;
# Utilizamos la función "count" ya que nos dice que contemos los clientes distintos y lo demas es usando las 4 o menos tablas. 
# Utilizamos where para que nos filtre antes de agrupar y nos de los resultados de 2006 y dentro de este solo los del primer trimestre.

-- 91:  Para cada país, cuenta cuántas categorías diferentes han sido alquiladas por clientes residentes en ese país.

select co.country_id,co.country,count(distinct fc.category_id) as 'distinct_categories_rented_by_country' from country co
join
city ci on ci.country_id = co.country_id
join
address ad on ad.city_id = ci.city_id
join
customer c on c.address_id = ad.address_id
join
rental re on re.customer_id = c.customer_id
join
inventory inv on inv.inventory_id = re.inventory_id
join 
film_category fc on fc.film_id = inv.film_id
group by co.country_id,co.country
order by  co.country_id,co.country asc;
# Utilizamos la función "count" ya que nos dice que contemos las categorias distintas y lo demas no lo logre usar las 4 o menos tablas. 

-- 92:  Para cada cliente, muestra el importe medio de sus pagos redondeado a 2 decimales, solo si ha hecho al menos 10 pagos.

select c.customer_id,c.first_name,c.last_name,round(avg(pa.amount),2) as 'avg_payment' from customer c
join
payment pa on pa.customer_id = c.customer_id
group by c.customer_id,c.first_name,c.last_name
having count(pa.payment_id) >= 10
order by c.customer_id asc;
# Utilizamos la función "avg" y "round" ya que nos dice que saquemos el promedio de los pagos con 2 decimales y lo demas es usando las 4 o menos tablas. 
# Utilizamos having para filtrar los pagos que se hicieron aunque no aparezcan en el select ni el agrupado.

-- 93:  Para cada categoría, muestra el número de películas con replacement_cost > 20 que hayan sido alquiladas al menos una vez.

select ca.category_id,ca.name,count(distinct f.film_id) as 'pricey_rented_films' from category ca
join
film_category fc on fc.category_id = ca.category_id
join
film f on f.film_id = fc.film_id
join
inventory inv on inv.film_id = f.film_id
join
rental re on re.inventory_id = inv.inventory_id
where f.replacement_cost > 20
group by ca.category_id,ca.name
order by ca.category_id,ca.name asc;
# Utilizamos la función "count" ya que nos dice que contemos las peliculas distintas y lo demas es usando las 4 o menos tablas. 
# Utilizamos where para filtrar antes de agrupar para que nos saque el resultado cuando el coste se mayor a 20.

-- 94:  Para cada tienda, suma los importes pagados en fines de semana.

select str.store_id,sum(pa.amount) as 'weekend_revenue' from store str
join
staff st on st.store_id = str.store_id
join
payment pa on pa.staff_id = st.staff_id
where dayofweek(pa.payment_date) in (1,7)
group by str.store_id
order by str.store_id;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es usando las 4 o menos tablas. 
# Utilizamos where para filtrar antes de agrupar para que nos saque el resultado del fin de semana.

-- 95:  Para cada actor, cuenta cuántas películas suyas fueron alquiladas por al menos 5 clientes distintos (se cuenta alquileres y luego se filtra por HAVING).

select a.actor_id,a.first_name,a.last_name,count(distinct re.customer_id) as 'distinct_customers' from rental re
join
inventory inv on inv.inventory_id = re.inventory_id
join
film_actor fa on fa.film_id = inv.film_id
join
actor a on a.actor_id = fa.actor_id
group by a.actor_id,a.first_name,a.last_name
having count(distinct re.customer_id) >= 5; 
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es usando las 4 o menos tablas. 
# Utilizamos having para que aparezcan los resultados que fueron alquilados por lo menos 5 clientes.
#REVISAR ESTA CONSULTA NO SALE IGUAL

-- 96:  Para cada idioma, muestra el número de películas cuyo título empieza por la letra 'A' y que han sido alquiladas.

select la.language_id,la.name,count(distinct f.film_id) as 'films_starting_A_rented' from language la
join
film f on f.language_id = la.language_id
join
inventory inv on inv.film_id = f.film_id
join
rental re on re.inventory_id = inv.inventory_id
where f.title like 'A%'
group by la.language_id,la.name;
# Utilizamos la función "count" ya que nos dice que contemos las peliculas distintas y lo demas es usando las 4 o menos tablas. 
# Utilizamos where para filtrar antes de agrupar para que nos de los resultados que empiece por A.

-- 97:  Para cada país, suma el importe total de pagos realizados por clientes residentes y filtra países con total >= 1000.

select co.country_id,co.country,sum(pa.amount) as 'total_amount' from country co
join
city ci on ci.country_id = co.country_id
join
address ad on ad.city_id = ci.city_id
join
customer c on c.address_id = ad.address_id
join 
payment pa on pa.customer_id = c.customer_id
group by co.country_id,co.country
having total_amount >= 1000;
# Utilizamos la función "sum" ya que nos dice que sumemos los pagos y lo demas es usando las 4 o menos tablas. 
# Utilizamos having para filtrar el resultado del sum para que nos de los resultados mayor o igual a 1000.

-- 98:  Para cada cliente, cuenta cuántos días han pasado entre su primer y su último alquiler en 2005 (diferencia de fechas), mostrando solo clientes con >= 5 alquileres en 2005.

select c.customer_id,c.first_name,c.last_name,datediff(max(re.rental_date),min(re.rental_date)) as 'days_between_first_last_2005' from customer c
join
rental re on re.customer_id = c.customer_id
where year(re.rental_date) = 2005
group by c.customer_id,c.first_name,c.last_name
having count(c.customer_id) >=5
order by c.customer_id,c.first_name,c.last_name asc;
# Utilizamos la función "datediff" ya que nos dice que contemos los dias que han pasado desde el primer y ultimo alquiler y lo demas es usando las 4 o menos tablas. 
# Utilizamos where ya que queremos filtrar antes de agrupar para que nos de el resultado del 2005.
# Utilizamos having para que aparezcan los resultados que fueron alquilados por lo menos 5 clientes.

--     (Se evita subconsulta calculando sobre el conjunto agrupado por cliente y usando MIN/MAX de rental_date en 2005).
-- 99:  Para cada tienda, muestra la media de importes cobrados por transacción en el año 2006, con dos decimales.

select str.store_id,round(avg(pa.amount),2) as 'avg_payment_2006' from store str
join
staff st on st.store_id = str.store_id
join
payment pa on pa.staff_id = st.staff_id
where year(pa.payment_date) = 2006
group by str.store_id
order by str.store_id asc;
# Utilizamos la función "avg" y "round" ya que nos dice que saquemos el promedio de los pagos y que aparezcan con 2 decimales y lo demas es usando las 4 o menos tablas. 
# Utilizamos where ya que queremos filtrar antes de agrupar para que nos de el resultado del 2006.

-- 100:  Para cada categoría, calcula la media de duración (length) de películas alquiladas en 2006 y ordénalas descendentemente por dicha media.

select ca.category_id,ca.name,avg(f.length) as 'avg_length_rented_2006' from category ca
join
film_category fc on fc.category_id = ca.category_id
join
film f on f.film_id = fc.film_id
join
inventory inv on inv.film_id = f.film_id
join
rental re on re.inventory_id = inv.inventory_id
where year(rental_date) = 2006
group by ca.category_id,ca.name
order by avg_length_rented_2006 desc;
# Utilizamos la función "avg" ya que nos dice que saquemos el promedio de los pagos y lo demas es usando las 4 o menos tablas. 
# Utilizamos where ya que queremos filtrar antes de agrupar para que nos de el resultado del 2006.