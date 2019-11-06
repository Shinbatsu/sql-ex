WITH nums AS
(
	SELECT 1 AS num
	UNION ALL
	SELECT num * 2 FROM nums
	where num * 2 < 65535
), resultset AS
(
	SELECT t.trip_no, n.num, CAST(t.trip_no & n.num AS bit) as val FROM nums n CROSS JOIN Trip t
)
, resultsetX2 AS
(
	SELECT r.trip_no, STRING_AGG(CAST(r.val AS char(1)), '') WITHIN GROUP(ORDER BY r.num DESC) AS num FROM resultset r
	GROUP BY r.trip_no
) SELECT r.trip_no, SUBSTRING(r.num, CHARINDEX('1', r.num, 1), LEN(r.num) - CHARINDEX('1', r.num, 1) + 1) FROM resultsetX2 r
