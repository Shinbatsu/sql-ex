with
  CTE AS (
    select
      1 n,
      cast(0 as varchar(16)) bit_or,
      code,
      speed,
      ram
    FROM
      PC
    UNION ALL
    select
      n * 2,
      cast(convert(bit, (speed | ram) & n) as varchar(1)) + cast(bit_or as varchar(15)),
      code,
      speed,
      ram
    from
      CTE
    where
      n < 65536
  )
select
  code,
  speed,
  ram
from
  CTE
where
  n = 65536
  and CHARINDEX('1111', bit_or) > 0
  -- : TODO Something with CHARINDEX
