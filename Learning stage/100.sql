Select distinct
  A.date,
  A.R,
  B.point,
  B.inc,
  C.point,
  C.out
From
  (
    Select distinct
      date,
      ROW_Number() OVER (
        PARTITION BY
          date
        ORDER BY
          code asc
      ) as R
    From
      Income
    Union
    Select distinct
      date,
      ROW_Number() OVER (
        PARTITION BY
          date
        ORDER BY
          code asc
      )
    From
      Outcome
  ) A
  LEFT Join (
    Select
      date,
      point,
      inc,
      ROW_Number() OVER (
        PARTITION BY
          date
        ORDER BY
          code asc
      ) as RI
    FROM
      Income
  ) B on B.date = A.date
  and B.RI = A.R
  LEFT Join (
    Select
      date,
      point,
      out,
      ROW_Number() OVER (
        PARTITION BY
          date
        ORDER BY
          code asc
      ) as RO
    FROM
      Outcome
  ) C on C.date = A.date
  and C.RO = A.R
