select
  code,
  speed,
  ram,
  price,
  screen
from
  laptop
where
  exists (
    select
      1 x
    from
      (
        select
          v,
          rank() over (
            order by
              v
          ) rn
        from
          (
            select
              cast(speed as float) sp,
              cast(ram as float) rm,
              cast(price as float) pr,
              cast(screen as float) sc
          ) l unpivot (v for c in (sp, rm, pr, sc)) u
      ) l pivot (max(v) for rn in ([1], [2], [3], [4])) p
    where
      [1] * 2 <= [2]
      and [2] * 2 <= [3]
      and [3] * 2 <= [4]
  )
  -- :TODO CASTs + OVER BY + RANK + EXISTS
