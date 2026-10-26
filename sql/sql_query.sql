-- Zadanie 1: Podstawowa eksploracja zamówień
-- (A) Zlicz liczbę wszystkich zamówień w tabeli olist_orders_dataset.
select * from olist_orders_dataset;
select count(*) from olist_orders_dataset;

-- (B) Wyświetl 10 pierwszych zamówień (order_id) wraz z datą zakupu (order_purchase_timestamp).
select order_id, order_purchase_timestamp from olist_orders_dataset limit 10;
select order_id, order_purchase_timestamp from olist_orders_dataset order by order_purchase_timestamp desc limit 10;



-- Zadanie 2: Unikalni klienci i liczność zamówień
-- (A) Sprawdź, ilu unikalnych klientów znajduje się w tabeli olist_customers_dataset (kolumna customer_unique_id).
select * from olist_customers_dataset;
select count(customer_unique_id) from olist_customers_dataset;
select count(distinct customer_unique_id) as unique_customers from olist_customers_dataset;

-- (B) Wyświetl 5 przykładowych klientów (customer_unique_id), którzy występują w bazie, wraz z ich stanem (customer_state).
select customer_unique_id, customer_state from olist_customers_dataset order by random() limit 5;



-- Zadanie 3: Filtrowanie zamówień według statusu
-- (A) Policz liczbę zamówień o statusie delivered w tabeli olist_orders_dataset.

select count(*) from olist_orders_dataset;
select distinct order_status from olist_orders_dataset order by order_status asc;

select count(*) from olist_orders_dataset where order_status = 'approved';
select count(*) from olist_orders_dataset where order_status = 'canceled';
select count(*) from olist_orders_dataset where order_status = 'created';
select count(*) from olist_orders_dataset where order_status = 'delivered';
select count(*) from olist_orders_dataset where order_status = 'invoiced';
select count(*) from olist_orders_dataset where order_status = 'processing';
select count(*) from olist_orders_dataset where order_status = 'shipped';
select count(*) from olist_orders_dataset where order_status = 'unavailable';

-- (B) Wyświetl po 3 przykładowe zamówienia dla każdego statusu: delivered, canceled i unavailable. Użyj klauzuli WHERE z operatorem IN.
(select * from olist_orders_dataset where order_status in ('delivered') order by order_status limit 3)
union all
(select * from olist_orders_dataset where order_status in ('canceled') order by order_status limit 3)
union all
(select * from olist_orders_dataset where order_status in ('unavailable') order by order_status limit 3);

--select * from olist_orders_dataset
--select * from olist_orders_dataset order by order_purchase_timestamp desc;
--select * from olist_orders_dataset where order_purchase_timestamp like '2018-09%' and order_status = 'shipped'



-- Zadanie 4: Sortowanie wyników
-- (A) Znajdź 5 najstarszych zamówień (według order_purchase_timestamp) i wyświetl order_id, order_status, order_purchase_timestamp.
select order_id, order_status, order_purchase_timestamp from olist_orders_dataset order by order_purchase_timestamp limit 5;

-- (B) Znajdź 5 najnowszych zamówień i wyświetl to samo, ale posortuj malejąco względem daty zakupu.
select order_id, order_status, order_purchase_timestamp from olist_orders_dataset order by order_purchase_timestamp desc limit 5;



-- Zadanie 5: Łączenie zamówień z klientami (INNER JOIN)
-- (A) Zrób wewnętrzne złączenie (INNER JOIN) tabel olist_orders_dataset i olist_customers_dataset, 
--aby uzyskać informacje o customer_unique_id dla każdego order_id. Wyświetl 10 pierwszych rekordów.
select * from olist_orders_dataset;
select count(*) from olist_orders_dataset;

select * from olist_customers_dataset;
select count(*) from olist_customers_dataset;

select count(*)
from olist_orders_dataset o
	inner join olist_customers_dataset c
		on o.customer_id = c.customer_id

select order_id, customer_unique_id 
from olist_orders_dataset o
	inner join olist_customers_dataset c
		on o.customer_id = c.customer_id
limit 10;

-- (B) Policz łączną liczbę zamówień przypisanych do klientów (czyli wynik wewnętrznego złączenia).
select count(*) as total_joined
from olist_orders_dataset o
	inner join olist_customers_dataset c
		on o.customer_id = c.customer_id;

--select c.customer_id, count(order_id) as order_count
--from olist_orders_dataset o
--	inner join olist_customers_dataset c
--		on o.customer_id = c.customer_id
--group by c.customer_id
--order by c.customer_id, order_count desc;



-- Zadanie 6: Łączenie zamówień z klientami (LEFT JOIN)
-- (A) Wyświetl wszystkie order_id i odpowiadające im customer_unique_id za pomocą LEFT JOIN, 
-- nawet jeśli dany klient nie istnieje w tabeli olist_customers_dataset (sprawdź, czy takie przypadki są).
select o.order_id, c.customer_unique_id 
from olist_orders_dataset o
	left join olist_customers_dataset c
		on o.customer_id = c.customer_id
--where c.customer_id is null --(sprawdź, czy takie przypadki są)
order by o.order_id
limit 10;

-- (B) Policz, ile rekordów znajdzie się w wyniku zapytania z LEFT JOIN w porównaniu do INNER JOIN z Zadania 5.
select count(*) 
from olist_orders_dataset o
	left join olist_customers_dataset c
		on o.customer_id = c.customer_id
		
		
		
-- Zadanie 7: Analiza płatności
-- (A) Policz, ile zamówień zostało opłaconych każdą metodą płatności (payment_type) w tabeli olist_order_payments_dataset.
select * from olist_order_payments_dataset;
select payment_type, count(*) as order_count from olist_order_payments_dataset group by payment_type;

select count(*) from olist_order_payments_dataset where payment_type = 'boleto';
select count(*) from olist_order_payments_dataset where payment_type = 'debit_card';
select count(*) from olist_order_payments_dataset where payment_type = 'not_defined';
select count(*) from olist_order_payments_dataset where payment_type = 'voucher';
select count(*) from olist_order_payments_dataset where payment_type = 'credit_card';
		
-- (B) Wyświetl sumaryczną wartość płatności (payment_value) dla każdego typu płatności (payment_type).
select payment_type, sum(payment_value) from olist_order_payments_dataset group by payment_type;



-- Zadanie 8: Wielkość zamówień (JOIN z olist_order_items_dataset)
-- (A) Dołącz do tabeli olist_order_items_dataset informacje o statusie zamówienia z olist_orders_dataset (INNER JOIN po order_id).
-- Wyświetl 5 przykładowych wierszy.
select ooid.*, o.order_status from olist_order_items_dataset ooid
	inner join olist_orders_dataset o 
		on ooid.order_id = o.order_id
order by random() limit 5;

-- (B) Policz łączną liczbę produktów (order_item_id) dla zamówień o statusie delivered.
select * from olist_orders_dataset;
select * from olist_order_items_dataset;

select count(ooid.order_item_id) as total_items_delivered from olist_order_items_dataset ooid
	inner join olist_orders_dataset o 
		on ooid.order_id = o.order_id
where o.order_status = 'delivered';
--group by ooid.order_id;



-- Zadanie 9: Agregacja wartości zamówień
-- (A) Wykorzystując olist_order_items_dataset, oblicz łączną kwotę (SUM(price)) wszystkich produktów w dostarczonych zamówieniach.
select sum(ooid.price) as total_price_delivered
from olist_order_items_dataset ooid
	inner join olist_orders_dataset o
		on o.order_id = ooid.order_id
where o.order_status = 'delivered'

-- (B) Policz łączną kwotę opłat za przesyłkę (SUM(freight_value)) dla tych samych zamówień.
select sum(ooid.freight_value) as total_freight_delivered
from olist_order_items_dataset ooid
	inner join olist_orders_dataset o
		on o.order_id = ooid.order_id
where o.order_status = 'delivered'



-- Zadanie 10: Grupowanie zamówień według stanu klienta
-- (A) Połącz olist_orders_dataset z olist_customers_dataset i zgrupuj zamówienia według customer_state. 
-- Policz liczbę zamówień w każdym stanie.
select * from olist_orders_dataset;
select * from olist_customers_dataset; 

select c.customer_state, count(o.order_id) as count_order
from olist_orders_dataset o
	full join olist_customers_dataset c
		on o.customer_id = c.customer_id
group by c.customer_state;

-- (B) Posortuj wyniki malejąco według liczby zamówień, wyświetl top 5 stanów z największą liczbą zamówień.
select c.customer_state, count(o.order_id) as count_order
from olist_orders_dataset o
	full join olist_customers_dataset c
		on o.customer_id = c.customer_id
group by c.customer_state
order by count_order desc limit 5;



-- Zadanie 11: Sprawdzenie wymiarów i wagi produktów
-- (A) Policz średnią wagę (product_weight_g) produktu w tabeli olist_products_dataset.
select round(avg(product_weight_g), 2) as avg_weight from olist_products_dataset;

-- (B) Policz średnią wysokość (product_height_cm) i szerokość (product_width_cm) produktu.
select round(avg(product_height_cm), 2) as avg_height, round(avg(product_width_cm), 2) as avg_weight from olist_products_dataset;



-- Zadanie 12: Produkty a kategorie
-- (A) Z tabeli olist_products_dataset wyświetl 10 różnych kategorii produktowych (product_category_name) wraz z przykładowym product_id.
select product_category_name, min(product_id) as product_id
from olist_products_dataset
where product_category_name <> ''
group by product_category_name
offset 15 limit 10;
--order by product_category_name limit 10;

select distinct on(product_category_name) product_category_name, product_id
from olist_products_dataset
where product_category_name is not null
offset 15 limit 10;

-- (B) Połącz ją z tabelą product_category_name_translation, aby dodać tłumaczenie kategorii na język angielski. 
-- Wyświetl 10 wierszy.
--select * from olist_products_dataset;
--select * from product_category_name_translation;
select opd.product_category_name, pcnt.product_category_name_english, min(product_id) as product_id
from olist_products_dataset opd
	inner join product_category_name_translation pcnt 
		on opd.product_category_name = pcnt.product_category_name
where opd.product_category_name <> ''
group by opd.product_category_name, pcnt.product_category_name_english
limit 10;

select opd.product_category_name, pcnt.product_category_name_english
from olist_products_dataset opd
	left join product_category_name_translation pcnt
       on opd.product_category_name = pcnt.product_category_name
limit 10;



-- Zadanie 13: Łączenie informacji o sprzedawcach
-- (A) Zrób INNER JOIN między olist_sellers_dataset a olist_order_items_dataset po kolumnie seller_id. Wyświetl 5 przykładowych rekordów.
--select * from olist_sellers_dataset;
--select * from olist_order_items_dataset;
select * from olist_sellers_dataset osd
	inner join olist_order_items_dataset ooid
		on osd.seller_id = ooid.seller_id
limit 5;

-- (B) Policz, ilu unikalnych sprzedawców (seller_id) brało udział w zamówieniach występujących w olist_order_items_dataset.
select 
	count(distinct osd.seller_id) as dis_seller,
	count(osd.seller_id) as seller
from olist_sellers_dataset osd
	inner join olist_order_items_dataset ooid
		on osd.seller_id = ooid.seller_id;



-- Zadanie 14: Obliczanie średniego kosztu dostawy
-- (A) W tabeli olist_order_items_dataset oblicz średnią wartość freight_value.
select round(avg(freight_value)::numeric, 2) as avg_freight from olist_order_items_dataset;

-- (B) Wyświetl top 5 rekordów o najwyższej wartości freight_value razem z price.
select product_id, freight_value, price from olist_order_items_dataset order by freight_value desc limit 5;



-- Zadanie 15: Zagnieżdżone zapytania (subqueries)
-- (A) Policz, ile jest zamówień w stanie delivered, korzystając z podzapytania do tabeli olist_orders_dataset, i wyświetl tę liczbę.
--select * from olist_orders_dataset;
--select * from olist_order_items_dataset;
select count(*) from (
	select order_id
	from olist_orders_dataset
	where order_status = 'delivered'
) as delivered_count;

select count(*) from olist_orders_dataset where order_status = 'delivered';

-- (B) Wyświetl wszystkie wiersze z tabeli olist_orders_dataset, których order_id pojawia się w podzapytaniu pobierającym order_id
-- z tabeli olist_order_reviews_dataset o review_score = 5.
select count(*) from olist_order_reviews_dataset where review_score = 5;

select count(*) from (
	select order_id
	from olist_order_reviews_dataset
	where review_score = 5
);

select * from (
	select order_id, review_score
	from olist_order_reviews_dataset
	where review_score = 5
);

select * from olist_orders_dataset
where order_id in (
  select order_id
  from olist_order_reviews_dataset
  where review_score = 5
);



-- Zadanie 16: Użycie CTE (Common Table Expressions)
-- (A) Utwórz CTE, które policzy liczbę zamówień w poszczególnych stanach (customer_state).
-- Następnie wyświetl z tego CTE tylko stany, które mają ponad 2000 zamówień.
select count(*) from olist_customers_dataset;
select count(*) from olist_orders_dataset;

with orders_by_state as (
	select c.customer_state, count(*) as order_count
	from olist_orders_dataset o
		left join olist_customers_dataset c
			on o.customer_id = c.customer_id
	group by c.customer_state
)
select * from orders_by_state where order_count > 2000 order by order_count desc;

-- (B) Utwórz CTE, które zwróci zamówienia dostarczone (delivered) w 2017 roku (na podstawie order_purchase_timestamp),
-- a następnie oblicz na nim liczbę tych zamówień.
with orders_delivered_2017 as (
	select * from olist_orders_dataset 
	where order_status = 'delivered' and extract(year from order_purchase_timestamp) = 2017 order by order_purchase_timestamp 
)
select count(*) from orders_delivered_2017;



-- Zadanie 17: Analiza recenzji
-- (A) Policz średni review_score (ocenę) w tabeli olist_order_reviews_dataset.
--select * from olist_order_reviews_dataset;
select round(avg(review_score), 2) as avg_review_score from olist_order_reviews_dataset;

-- (B) Wyświetl 5 zamówień o najniższej ocenie i sprawdź, czy mają uzupełnione komentarze (review_comment_message).
select order_id, review_score, review_comment_message from olist_order_reviews_dataset order by review_score, review_creation_date limit 5;



-- Zadanie 18: Grupowanie recenzji i obliczanie średniej
-- (A) Zgrupuj recenzje według review_score i oblicz liczbę recenzji dla każdej oceny.
select review_score, count(review_id) as review_count 
from olist_order_reviews_dataset 
group by review_score
order by review_score;

-- (B) Policz średnią długość komentarza (LENGTH(review_comment_message)) dla każdej oceny review_score.
select review_score, round(avg(length(review_comment_message)), 2) as avg_comment_lenght 
from olist_order_reviews_dataset
group by review_score
order by review_score;



-- Zadanie 19: Relacja między recenzjami a czasem dostawy
-- (A) Przyłącz tabelę olist_order_reviews_dataset do olist_orders_dataset (JOIN po order_id) i oblicz średnią ocenę dla zamówień, 
-- w których order_delivered_customer_date < order_estimated_delivery_date.
select * from olist_order_reviews_dataset; --99 224
select * from olist_orders_dataset;		   --99 441	

select round(avg(r.review_score), 2) as avg_score_early_delivery from olist_orders_dataset o
	join olist_order_reviews_dataset r
		on o.order_id = r.order_id
where o.order_delivered_customer_date < o.order_estimated_delivery_date;

-- (B) Sprawdź różnicę w średniej ocenie pomiędzy zamówieniami dostarczonymi przed terminem a po terminie.
with early as (
  select avg(r.review_score) as avg_early
  from olist_order_reviews_dataset r
  	join olist_orders_dataset o
    	on r.order_id = o.order_id
  where o.order_delivered_customer_date < o.order_estimated_delivery_date
),
late as (
  select avg(r.review_score) as avg_late
  from olist_order_reviews_dataset r
  	join olist_orders_dataset o
    	on r.order_id = o.order_id
  where o.order_delivered_customer_date > o.order_estimated_delivery_date
)

select 
	round(early.avg_early, 3) as avg_early,
	round(late.avg_late, 3) as avg_late,
	round(early.avg_early - late.avg_late, 3) as difference
from early, late;



-- Zadanie 20: Analiza geograficzna
-- (A) Sprawdź, w ilu unikalnych miastach (geolocation_city) występują klienci (JOIN tabel olist_customers_dataset i olist_geolocation_dataset po prefiksie kodu pocztowego).
select count(distinct geolocation_city) as unique_geolocation_city
from olist_customers_dataset c
	join olist_geolocation_dataset g
		on c.customer_zip_code_prefix = g.geolocation_zip_code_prefix;

-- (B) Wyświetl 5 miast o najwyższej liczbie klientów, posortuj malejąco po liczbie klientów.
select g.geolocation_city, count(*) as customer_count
from olist_customers_dataset c
	join olist_geolocation_dataset g
		on c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
group by g.geolocation_city
order by customer_count desc
limit 5;



-- Zadanie 21: Indeksy – tworzenie indeksu na order_id
-- (A) Utwórz indeks na kolumnie order_id w tabeli olist_orders_dataset, aby przyspieszyć wyszukiwanie zamówień.
create index idx_orders_order_id
	on olist_orders_dataset (order_id);

drop index if exists idx_orders_order_id;

-- (B) Uruchom zapytanie EXPLAIN dla prostej selekcji z olist_orders_dataset, aby zobaczyć, czy indeks jest używany.
explain analyze
select * from olist_orders_dataset
where customer_id = 'some_customer_id' and order_status = 'delivered';



-- Zadanie 22: Indeksy – tworzenie indeksu złożonego
-- (A) Utwórz indeks złożony na kolumnach customer_id i order_status w tabeli olist_orders_dataset.
create index idx_orders_customer_status
	on olist_orders_dataset (customer_id, order_status);
commit;
drop index if exists idx_orders_customer_status;

-- (B) Porównaj czas wykonania zapytania filtrującego po customer_id i order_status przed i po utworzeniu indeksu (używając EXPLAIN ANALYZE).
explain analyze
select * from olist_orders_dataset
where customer_id = 'some_customer_id' and order_status = 'delivered';
-- Execution Time: 8.344 ms przed indeksem
-- Execution Time: 0.058 ms po indeksie



-- Zadanie 23: Złączenie wielu tabel naraz
-- (A) Za pomocą pojedynczego zapytania, połącz (JOIN) tabele:
-- olist_orders_dataset (alias o)
-- olist_customers_dataset (alias c)
-- olist_order_payments_dataset (alias p)
-- w celu uzyskania informacji: order_id, order_status, payment_type, customer_state. Wyświetl 10 pierwszych wyników.
select * from olist_orders_dataset;			-- 99 441	
select * from olist_customers_dataset;		-- 99 441
select * from olist_order_payments_dataset; --103 886


select o.order_id, o.order_status, p.payment_type, c.customer_state
from olist_order_payments_dataset p
	join olist_orders_dataset o
		on p.order_id = o.order_id
			join olist_customers_dataset c
				on o.customer_id = c.customer_id
limit 10;

-- (B) Policz łączną liczbę rekordów zwróconych przez to złączenie.
select count(*)
from olist_order_payments_dataset p
	join olist_orders_dataset o
		on p.order_id = o.order_id
			join olist_customers_dataset c
				on o.customer_id = c.customer_id;


				
-- Zadanie 24: Przykład klauzuli HAVING
-- (A) Pogrupuj zamówienia w olist_orders_dataset według order_status i zlicz je.
select order_status, count(*) as num_orders
from olist_orders_dataset
group by order_status
order by order_status;

-- (B) Odfiltruj grupy, które mają mniej niż 1000 zamówień, używając klauzuli HAVING.	
select order_status, count(*) as num_orders
from olist_orders_dataset
group by order_status
having count(*) >= 1000
--having num_orders >= 1000  --to nie zadziala
order by num_orders;



-- Zadanie 25: Analiza liczby rat w płatnościach
-- (A) W tabeli olist_order_payments_dataset sprawdź maksymalną liczbę rat (payment_installments) i zlicz, ile zamówień ma właśnie taką najwyższą liczbę rat.
with max_installments as (
	select max(payment_installments) as max_inst
	from olist_order_payments_dataset
)
select 
	max_inst as max_installments,
	(
		select count(*)
		from olist_order_payments_dataset
		where payment_installments = max_inst
	) as count_with_max
from max_installments;

-- (B) Oblicz średnią liczbę rat dla wszystkich zamówień.
select round(avg(payment_installments), 2) as avg_inst
from olist_order_payments_dataset;



-- Zadanie 26: Funkcje tekstowe
-- (A) Wyświetl 10 przykładów komentarzy (review_comment_message) z tabeli olist_order_reviews_dataset w postaci dużymi literami (funkcja UPPER).
select upper(review_comment_message) as comment_upper, review_comment_message
from olist_order_reviews_dataset
where review_comment_message is not null
limit 10;

-- (B) Policz liczbę komentarzy, które zawierają słowo late (możesz użyć LIKE).
select count(*) as comments_with_late
from olist_order_reviews_dataset
where review_comment_message like '%late%';



-- Zadanie 27: Funkcje daty i czasu
-- (A) Wyświetl rok i miesiąc (EXTRACT(YEAR FROM ...), EXTRACT(MONTH FROM ...)) z kolumny order_purchase_timestamp dla 10 przykładowych zamówień.
select
extract(year from order_purchase_timestamp) as year,
extract(month from order_purchase_timestamp) as month
from olist_orders_dataset
limit 10;

-- (B) Policz, ile zamówień złożono w 2017 roku, a ile w 2018 roku (kolumna order_purchase_timestamp).
select
sum(
	case
		when extract(year from order_purchase_timestamp) = 2017
		then 1 
		else 0
	end
) as orders_2017,
sum(
	case
		when extract(year from order_purchase_timestamp) = 2018 
		then 1 
		else 0 
	end
) as orders_2018
from olist_orders_dataset;



-- Zadanie 28: Analiza sprzedawców
-- (A) Z tabeli olist_sellers_dataset wyświetl 5 sprzedawców z miasta o najdłuższej nazwie (mierzonej funkcją LENGTH(seller_city)).
select * from olist_sellers_dataset;

select seller_id, seller_city from olist_sellers_dataset
order by length(seller_city) desc
limit 5;

-- (B) Policz, w ilu różnych stanach (seller_state) działają sprzedawcy.
select count(distinct(seller_state)) as count_seller_state from olist_sellers_dataset;



-- Zadanie 29: Najpopularniejsze kategorie produktów
-- (A) Połącz tabele olist_products_dataset i olist_order_items_dataset, aby ustalić, 
-- która kategoria (product_category_name) pojawia się najczęściej w zamówieniach. Wyświetl top 5.
select * from olist_products_dataset;	 		 -- 32 951
select * from olist_order_items_dataset; 		 --112 650
select * from product_category_name_translation; --     71

select p.product_category_name, count(*) as count_items from olist_order_items_dataset i
	join olist_products_dataset p
		on i.product_id = p.product_id
group by p.product_category_name
order by count_items desc
limit 5;

-- (B) Dołącz (JOIN) do tego zapytania również product_category_name_translation i wyświetl kategorię w języku angielskim.
select p.product_category_name, t.product_category_name_english, count(*) as count_items from olist_order_items_dataset i
	join olist_products_dataset p
		on i.product_id = p.product_id
			join product_category_name_translation t
				on p.product_category_name = t.product_category_name 
group by p.product_category_name, t.product_category_name_english 
order by count_items desc
limit 5;



-- Zadanie 30: Porównanie danych z kolumną tłumaczeń
-- (A) Zlicz, ile kategorii w olist_products_dataset nie ma odpowiednika w product_category_name_translation
-- (użyj LEFT JOIN i klauzuli WHERE ... IS NULL).
select count(*) as count_items
--p.product_category_name
from olist_products_dataset p
	left join product_category_name_translation t
		on p.product_category_name = t.product_category_name
where t.product_category_name_english is null;

-- (B) Wyświetl te brakujące kategorie (jeśli istnieją).
select distinct p.product_category_name, t.product_category_name_english
from olist_products_dataset p
	left join product_category_name_translation t
		on p.product_category_name = t.product_category_name
where t.product_category_name_english is null
group by p.product_category_name, t.product_category_name_english;



-- Zadanie 31: Rekordy duplikujące się w bazie
-- (A) Sprawdź, czy w tabeli olist_customers_dataset istnieją duplikaty wartości w kolumnie customer_unique_id.
-- Wyświetl ewentualne duplikujące się identyfikatory i ich liczność.
select customer_unique_id, count(*) as duplicate_count from olist_customers_dataset
group by customer_unique_id
having count(*) > 1
order by duplicate_count desc;

-- (B) Sprawdź, czy w tabeli olist_orders_dataset istnieją powtarzające się order_id (nie powinno ich być) – wyświetl liczbę takich potencjalnych duplikatów.
select order_id, count(*) as duplicate_count from olist_orders_dataset
group by order_id 
having count(*) > 1
order by duplicate_count desc;



-- Zadanie 32: Użycie funkcji okna (window functions) – ranking
-- (A) Za pomocą funkcji okna ROW_NUMBER(), nadaj kolejny numer zamówieniom posortowanym malejąco po dacie zakupu (order_purchase_timestamp). 
-- Wyświetl 10 pierwszych.
select order_id, order_purchase_timestamp, row_number() over (order by order_purchase_timestamp desc) as rank_num
from olist_orders_dataset
limit 10;

-- (B) Za pomocą RANK() lub DENSE_RANK(), posortuj zamówienia rosnąco po order_purchase_timestamp i wyświetl 10 pierwszych rekordów z przypisanym rankingiem.
select order_id, order_purchase_timestamp, 
	rank() over (order by order_purchase_timestamp asc) as rank_num
from olist_orders_dataset
limit 10;



-- Zadanie 33: Użycie funkcji okna – obliczanie sumy częściowej
-- (A) Przyłącz (JOIN) tabelę olist_order_payments_dataset do olist_orders_dataset, a następnie użyj SUM(payment_value) OVER (ORDER BY order_purchase_timestamp)
-- do obliczenia narastającej sumy płatności w porządku czasowym. Wyświetl 10 pierwszych wyników.
--select * from olist_order_payments_dataset;	--103 886
--select * from olist_orders_dataset;			-- 99 441
select o.order_id, o.order_purchase_timestamp, 
	round(sum(p.payment_value) over (order by o.order_purchase_timestamp)::numeric, 2) as running_total
from olist_order_payments_dataset p
	join olist_orders_dataset o
		on p.order_id = o.order_id
order by o.order_purchase_timestamp
limit 10;

-- (B) Policz maksymalną płatność narastającą do danego momentu (użyj MAX(...) OVER (...)).
select o.order_id, o.order_purchase_timestamp,
	max(p.payment_value) over (order by o.order_purchase_timestamp) as running_total
from olist_order_payments_dataset p
	join olist_orders_dataset o
		on p.order_id = o.order_id
order by o.order_purchase_timestamp
limit 1000;



-- Zadanie 34: Tworzenie tabeli tymczasowej
-- (A) Utwórz tabelę tymczasową temp_delivered_orders zawierającą wyłącznie zamówienia o statusie delivered z olist_orders_dataset.
create temp table temp_delivered_orders as
select * from olist_orders_dataset
where order_status = 'delivered';

select * from temp_delivered_orders;

-- (B) Z tabeli tymczasowej wyświetl liczbę rekordów. Upewnij się, że tabela znika po zakończeniu sesji (cecha TEMPORARY).
-- po zakonczeniu sesji spróbujcie wykonać tę querkę
select * from temp_delivered_orders;



-- Zadanie 35: Tworzenie widoku (VIEW)
-- (A) Stwórz widok view_top_states wyświetlający stan (customer_state) oraz liczbę zamówień, posortowaną malejąco.
-- Ogranicz wynik do tych stanów, w których jest co najmniej 1000 zamówień.
--select * from olist_orders_dataset;	--99 441
--select * from olist_customers_dataset;--99 441
create view view_top_states as
	select c.customer_state, count(o.order_id) as state_order_count
	from olist_orders_dataset o
		join olist_customers_dataset c
			on o.customer_id = c.customer_id
	group by c.customer_state
	having count(o.order_id) >= 1000
	order by state_order_count desc;

-- (B) Wyświetl zawartość widoku i policz, ile stanów się w nim znajduje.
select *, (select count(*) from view_top_states) as total_states from view_top_states;



-- Zadanie 36: Poszukiwanie potencjalnych zależności między wielkością produktu a kosztem dostawy
-- (A) Przyłącz olist_products_dataset i olist_order_items_dataset (po product_id), oblicz korelację (CORR(product_weight_g, freight_value)) lub 
-- chociaż współczynnik product_weight_g i średniego freight_value.
--select * from olist_products_dataset;		-- 32 951
--select * from olist_order_items_dataset; 	--112 650
select 
	round(corr(p.product_weight_g, i.freight_value)::numeric, 2) as corr_weight_freight
from olist_order_items_dataset i
	join olist_products_dataset p
  		on i.product_id = p.product_id;

-- (B) Policz również korelację między product_volume_cm = product_length_cm * product_height_cm * product_width_cm a freight_value (możesz obliczyć tę kolumnę w zapytaniu).
select 
	round(corr((p.product_length_cm * p.product_height_cm * p.product_width_cm), i.freight_value)::numeric, 2) as corr_volume_freight
from olist_order_items_dataset i
	join olist_products_dataset p
 		on i.product_id = p.product_id;



-- Zadanie 37: Sprawdzanie różnicy czasu między akceptacją a wysyłką
-- (A) Z tabeli olist_orders_dataset oblicz różnicę w dniach pomiędzy order_purchase_timestamp a order_approved_at (funkcja AGE lub odejmowanie). Wyświetl 10 przykładów.
-- Być może będziecie musieli zmienić typ kolumny order_approved_at, bo nie zrobiliśmy tego wcześniej.
select order_id,
	age(order_approved_at, order_purchase_timestamp) as approval_delay
from olist_orders_dataset
limit 10;

-- (B) Policz średnią wartość tej różnicy w dniach.
select
	avg(age(order_approved_at, order_purchase_timestamp)) as avg_approval_delay
from olist_orders_dataset;

select
    round(
        extract(epoch from avg(
            AGE(order_approved_at, order_purchase_timestamp)
        ))
    ) * interval '1 second' as avg_approval_delay
from olist_orders_dataset;



-- Zadanie 38: Wykorzystanie CASE WHEN
-- (A) W tabeli olist_order_reviews_dataset, wyświetl nową kolumnę, w której:
-- jeśli review_score = 5, wpisz 'Bardzo zadowolony',
-- jeśli review_score pomiędzy 3 a 4, wpisz 'Średnio',
-- w pozostałych przypadkach wpisz 'Niezadowolony'.
select review_id, review_score,
	case
		when review_score = 5 then 'Bardzo zadowolony'
		when review_score between 3 and 4 then 'Średnio'
		else 'Niezadowolony'
	end
from olist_order_reviews_dataset
limit 100;

-- (B) Policz, ilu klientów ma status 'Bardzo zadowolony', 'Średnio' i 'Niezadowolony' (wygenerowany z CASE WHEN).
select
	case
		when review_score = 5 then 'Bardzo zadowolony'
		when review_score between 3 and 4 then 'Średnio'
		else 'Niezadowolony'
	end as satisfaction_level,
	count(*) as count_reviews 
from olist_order_reviews_dataset
group by 1



-- Zadanie 39: Dodawanie i usuwanie kolumny w tabeli
-- (A) Dodaj kolumnę processed_timestamp TIMESTAMP do tabeli olist_orders_dataset (ALTER TABLE).
alter table olist_orders_dataset
add column processed_timestamp timestamp;

-- (B) Usuń ją (kolumnę processed_timestamp) z tabeli olist_orders_dataset.
alter table olist_orders_dataset
drop column processed_timestamp;
