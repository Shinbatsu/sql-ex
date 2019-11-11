SELECT
  Q_NAME
FROM
  utQ
WHERE
  Q_ID IN (
    SELECT DISTINCT
      B.B_Q_ID
    FROM
      (
        SELECT
          B_Q_ID
        FROM
          utB
        GROUP BY
          B_Q_ID
        HAVING
          SUM(B_VOL) = 765
      ) AS B
    WHERE
      B.B_Q_ID NOT IN (
        SELECT
          B_Q_ID
        FROM
          utB
        WHERE
          B_V_ID IN (
            SELECT
              B_V_ID
            FROM
              utB
            GROUP BY
              B_V_ID
            HAVING
              SUM(B_VOL) < 255
          )
      )
  )
