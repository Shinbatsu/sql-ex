SELECT maker, 
CASE count(distinct type) 
WHEN 1 THEN MIN(type) 
WHEN 2 THEN MIN(type) + '/' + MAX(type) 
WHEN 3 THEN 'Laptop/PC/Printer' END 
FROM Product 
GROUP BY maker