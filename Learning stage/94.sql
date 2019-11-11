SELECT
  DATEADD(day, S.Num, D.date) AS Dt,
  (
    SELECT
      COUNT(DISTINCT P.trip_no)
    FROM
      Pass_in_trip P
      JOIN Trip T ON P.trip_no = T.trip_no
      AND T.town_from = 'Rostov'
      AND P.date = DATEADD(day, S.Num, D.date)
  ) AS Qty
FROM
  (
    SELECT
      (3 * (x - 1) + y - 1) AS Num
    FROM
      (
        SELECT
          1 AS x
        UNION ALL
        SELECT
          2
        UNION ALL
        SELECT
          3
      ) AS N1
      CROSS JOIN (
        SELECT
          1 AS y
        UNION ALL
        SELECT
          2
        UNION ALL
        SELECT
          3
      ) AS N2
    WHERE
      (3 * (x - 1) + y) < 8
  ) AS S,
  (
    SELECT
      MIN(A.date) AS date
    FROM
      (
        SELECT
          P.date,
          COUNT(DISTINCT P.trip_no) AS Qty,
          MAX(COUNT(DISTINCT P.trip_no)) OVER () AS M_Qty
        FROM
          Pass_in_trip AS P
          JOIN Trip AS T ON P.trip_no = T.trip_no
          AND T.town_from = 'Rostov'
        GROUP BY
          P.date
      ) AS A
    WHERE
      A.Qty = A.M_Qty
  ) AS D
  --WITH T AS( SELECT date, 
  --COUNT(DISTINCT trip_no) 
  --x, MAX(COUNT(DISTINCT trip_no)) 
  --over() MAX FROM Pass_in_trip 
  --WHERE trip_no in ( SELECT trip_no 
  --FROM Trip WHERE town_from like 'Rostov%') 
  --GROUP BY date )
  --WITH da AS ( SELECT DATEADD(DAY, t.c, date) date FROM ( SELECT 0 c 
  --UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 
  --UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 ) 
  --t, ( --SELECT top 1 date FROM T WHERE x = MAX ) p ) 
  --SELECT date, ISNULL( ( SELECT x FROM T WHERE date = da.date ), 0 ) FROM da
