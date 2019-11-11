WITH
  cte AS (
    SELECT
      TOP (1) CAST(pc.cd AS VARCHAR(50)) cd,
      CAST(pc.hd AS VARCHAR(50)) hd,
      CAST(pc.model AS VARCHAR(50)) model,
      CAST(pc.price AS VARCHAR(50)) price,
      CAST(pc.ram AS VARCHAR(50)) ram,
      CAST(pc.speed AS VARCHAR(50)) speed
    FROM
      PC pc
    ORDER BY
      code DESC
  )
SELECT
  chr,
  value
FROM
  cte c
  CROSS APPLY (
    VALUES
      ('cd', [cd]),
      ('hd', [hd]),
      ('model', [model]),
      ('price', [price]),
      ('ram', [ram]),
      ('speed', [speed])
  ) AS X (chr, value)
