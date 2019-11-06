select
  sum(coalesce(inc,0))-sum(coalesce(out,0)) as remain
  from income_o i
  full join outcome_o o on i.date=o.date and i.point=o.point
  where coalesce(i.date,o.date) < '2001-04-15'