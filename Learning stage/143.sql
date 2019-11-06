WITH nums AS
(
	SELECT 0 AS n
	UNION ALL
	SELECT n + 1 AS n FROM nums
	WHERE n < 6
)
SELECT b.name, CAST(b.date AS date), DATEADD(day, -n , EOMONTH(b.date)) FROM Battles b JOIN Nums n
ON DATEPART(dw, DATEADD(day, -n , EOMONTH(b.date))) = DATEPART(dw, '20210326')