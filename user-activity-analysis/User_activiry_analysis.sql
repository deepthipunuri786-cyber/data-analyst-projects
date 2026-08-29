SELECT login_date,COUNT(DISTINCT user_id) AS users FROM activity 
GROUP BY login_date;

SELECT user_id , COUNT(*) AS logins FROM activity 
GROUP BY user_id 
ORDER BY logins DESC;

WITH cte AS (SELECT *,LAG(login_date)OVER(PARTITION BY user_id ORDER BY login_date) AS previous FROM activity)
SELECT  DISTINCT user_id FROM  cte 
WHERE login_date = DATE(previous, '+1 day');

-- exec only demo SQLite 
CREATE VIRTUAL TABLE IF NOT EXISTS link_name USING ext_api(
  'hist;Demo.Memory SQLite;8;0',
  'user_id'
);
