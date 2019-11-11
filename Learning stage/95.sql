SELECT
  name,
  COUNT(
    DISTINCT CONVERT(CHAR(24), date) + CONVERT(CHAR(4), Trip.trip_no)
  ),
  COUNT(DISTINCT plane),
  COUNT(DISTINCT ID_psg),
  COUNT(*)
FROM
  Company,
  Pass_in_trip,
  Trip
WHERE
  Company.ID_comp = Trip.ID_comp
  and Trip.trip_no = Pass_in_trip.trip_no
GROUP BY
  Company.ID_comp,
  name
