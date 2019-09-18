WITH paint_per_country AS (
    SELECT
        q.Q_ID,
        q.Q_NAME,
        v.V_COLOR,
        SUM(b.B_VOL) AS TOTAL_VOL
    FROM utB b
    JOIN utQ q ON b.B_Q_ID = q.Q_ID
    JOIN utV v ON b.B_V_ID = v.V_ID
    GROUP BY q.Q_ID, q.Q_NAME, v.V_COLOR
),
country_rgb AS (
    SELECT
        Q_ID,
        Q_NAME,
        MAX(CASE WHEN V_COLOR = 'R' THEN TOTAL_VOL ELSE 0 END) AS R,
        MAX(CASE WHEN V_COLOR = 'G' THEN TOTAL_VOL ELSE 0 END) AS G,
        MAX(CASE WHEN V_COLOR = 'B' THEN TOTAL_VOL ELSE 0 END) AS B
    FROM paint_per_country
    GROUP BY Q_ID, Q_NAME
),
country_coords AS (
    SELECT
        Q_ID,
        Q_NAME,
        CAST(SUBSTRING(Q_NAME, 2, 1) AS INT) AS row,
        CAST(SUBSTRING(Q_NAME, 3, 1) AS INT) AS col
    FROM utQ
),
colored_coords AS (
    SELECT
        c.Q_ID,
        c.Q_NAME,
        c.row,
        c.col,
        COALESCE(r.R, 0) AS R,
        COALESCE(r.G, 0) AS G,
        COALESCE(r.B, 0) AS B
    FROM country_coords c
    LEFT JOIN country_rgb r ON c.Q_ID = r.Q_ID
),
neighbors AS (
    SELECT
        a.Q_NAME AS from_q,
        b.Q_NAME AS to_q,
        a.R / 8 AS send_R,
        a.G / 8 AS send_G,
        a.B / 8 AS send_B
    FROM colored_coords a
    CROSS JOIN colored_coords b
    WHERE (
        MOD(a.row - b.row + 6, 6) BETWEEN 5 AND 1 OR MOD(a.row - b.row + 6, 6) = 0
    ) AND (
        MOD(a.col - b.col + 4, 4) BETWEEN 3 AND 1 OR MOD(a.col - b.col + 4, 4) = 0
    ) AND NOT (a.row = b.row AND a.col = b.col)
),
received AS (
    SELECT
        to_q AS Q_NAME,
        SUM(send_R) AS received_R,
        SUM(send_G) AS received_G,
        SUM(send_B) AS received_B
    FROM neighbors
    GROUP BY to_q
),
final_result AS (
    SELECT
        c.Q_NAME,
        LPAD(CAST((c.R % 8 + COALESCE(r.received_R, 0)) AS CHAR), 3, '0') || 'R' AS cR,
        LPAD(CAST((c.G % 8 + COALESCE(r.received_G, 0)) AS CHAR), 3, '0') || 'G' AS cG,
        LPAD(CAST((c.B % 8 + COALESCE(r.received_B, 0)) AS CHAR), 3, '0') || 'B' AS cB
    FROM colored_coords c
    LEFT JOIN received r ON c.Q_NAME = r.Q_NAME
)
SELECT Q_NAME || ' - ' || cR || ' ' || cG || ' ' || cB AS result
FROM final_result
ORDER BY Q_NAME;