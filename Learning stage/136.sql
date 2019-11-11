SELECT
  s.name,
  d.pat,
  SUBSTRING(s.name, d.pat, 1) t
FROM
  Ships s
  CROSS APPLY (
    VALUES
      (
        PATINDEX(
          '%[" "-,.*!@#$^&()''""|\/_`~<>;:}{+=1234567890]%',
          s.name
        )
      )
  ) AS d (pat)
WHERE
  d.pat <> 0
