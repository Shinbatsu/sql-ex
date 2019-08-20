SELECT MAX(b_datetime) FROM utB
GROUP BY CAST(CONVERT(varchar, b_datetime, 112) + ' '+LEFT(CONVERT(varchar, B_DATETIME, 114), 2) + ':00' AS datetime2)
SELECT MAX(b_datetime) FROM utB
GROUP BY CAST(B_DATETIME AS date), DATEPART(HOUR, B_DATETIME)
