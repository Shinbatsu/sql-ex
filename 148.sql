WITH cte AS (
	SELECT o.ship, occ_1st_space.sp as frst_occ, occ_lst_space.sp AS lst_occ, LEN(o.ship) as ln FROM Outcomes o
	CROSS APPLY (VALUES
					(CHARINDEX(' ', o.ship, 1))
		) AS occ_1st_space(sp)
	CROSS APPLY (
		VALUES(
			DATALENGTH(o.ship) - CHARINDEX(' ', REVERSE(o.ship), 1 ) + 1
			)
		) AS occ_lst_space(sp)
	WHERE NOT (occ_1st_space.sp = occ_lst_space.sp OR occ_1st_space.sp = 0 OR occ_lst_space.sp = 0)
)
SELECT c.ship, STUFF(c.ship, c.frst_occ + 1, c.lst_occ - 1 - c.frst_occ , REPLICATE('*', c.lst_occ - 1 - c.frst_occ)) FROM cte c
