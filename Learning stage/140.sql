WITH nums1 AS (select 1 as n from (values(1),(1),(1),(1),(1),(1)) as d(n))
, nums2 AS (SELECT 1 as n FROM nums1 n1 CROSS JOIN nums1 n2)
, rns AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as rn FROM nums2)
, max_yrs AS (
	SELECT MIN(DATEPART(year, date)/10)*10 as min_yr, MAX(DATEPART(year, date)/10)*10 as max_yr FROM Battles
), gen_decades AS 
(
	SELECT min_yr + (rn - 1) * 10  AS yr  FROM max_yrs JOIN rns ON min_yr + (rn - 1) * 10 <= max_yr
)
SELECT CAST(gd.yr AS varchar(4)) + 's', COUNT(b.name) FROM gen_decades gd LEFT JOIN Battles b ON gd.yr = (DATEPART(year, b.date)/10)*10
GROUP BY gd.yr