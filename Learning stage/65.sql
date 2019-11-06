with z as (SELECT DISTINCT 
maker, type, CASE
WHEN type='PC' THEN 1
WHEN type='Laptop' THEN 2
ELSE 3 END ord FROM product),
x AS (
SELECT row_number() over(PARTITION BY maker
ORDER BY maker, ord) v,maker , TYPE
FROM z)
SELECT row_number() over(ORDER BY maker) num ,
CASE WHEN v=1 THEN maker
ELSE ''END AS maker , TYPE
FROM x
