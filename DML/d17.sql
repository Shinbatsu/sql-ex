DELETE FROM pc
WHERE
  hd in (
    SELECT
      TOP 3 *
    FROM
      (
        SELECT DISTINCT
          hd
        FROM
          pc
      ) p
    ORDER BY
      hd
  );
