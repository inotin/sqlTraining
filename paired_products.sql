--https-//www.interviewquery.com/questions/paired-products
SELECT
(CASE WHEN p1.name<p2.name THEN p1.name ELSE p2.name END) AS P1, -- these cases are needed to make P1 and P2 in alphabetical order as required by the task
(CASE WHEN p1.name<p2.name THEN p2.name ELSE p1.name END) AS P2,
s.qty AS 'count(*)'  -- the requirement of the task to alias it so
FROM
(SELECT t1.product_id AS p1,
t2.product_id AS p2, count(*) AS qty
FROM transactions AS t1
CROSS JOIN transactions AS t2
where t1.created_at=t2.created_at
AND t1.user_id=t2.user_id
AND t1.product_id!=t2.product_id
GROUP BY t1.product_id, t2.product_id
ORDER BY qty DESC
LIMIT 5) AS s
LEFT JOIN products AS p1
ON s.p1=p1.id
LEFT JOIN products AS p2
ON s.p2=p2.id;
