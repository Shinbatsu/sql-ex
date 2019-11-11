WITH
  cte AS (
    SELECT
      p.ID_psg,
      p.name,
      place,
      LEAD(pit.place, 1, '') OVER (
        PARTITION BY
          pit.id_psg
        ORDER BY
          pit.[date],
          t.time_out
      ) AS nxt_place
    FROM
      Pass_in_trip pit
      JOIN Trip t ON pit.trip_no = t.trip_no
      JOIN Passenger p ON p.ID_psg = pit.ID_psg
  )
SELECT
  c.name
FROM
  cte c
WHERE
  c.place = c.nxt_place
GROUP BY
  c.id_psg,
  c.name
