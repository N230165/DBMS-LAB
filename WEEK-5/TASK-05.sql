 USE TAXATION_P;
 -- PART A
show tables;
INSERT INTO income_record 
(income_id,taxpayer_id,income_source,amount, received_date,remarks,category_id,year_id)
VALUES
(1007,101,"villa",850000.00,"2025-03-31","",3,5),
(1008,102,"small house",1200000.00,"2025-03-31","",3,5),
(1009,103,"Poorna builders",1800000.00,"2024-03-31","",4,4),
(1010,104,"Sarada school",620000.00,"2024-03-31","",4,4),
(1011,105,"Web Design Projects",750000.00,"2023-03-31","",5,3),
(1012,106,"Professional Consultation",1500000.00,"2023-03-31","",5,3);

-- PART-B 
-- LEVEL-1
-- TASK-1
SELECT COUNT(taxpayer_id) FROM income_record;
SELECT COUNT(*) FROM taxpayer;
-- TASK-2
SELECT SUM(amount) FROM income_record;
-- TASK-3
SELECT AVG(amount) FROM income_record;
-- TASK-4
SELECT MAX(amount) FROM income_record;
-- TASK-5
SELECT MIN(amount) FROM income_record;

-- LEVEL-02
-- TASK-1
SELECT category_id, COUNT(category_id) FROM income_record GROUP BY category_id;
-- TASK-2
SELECT category_id, SUM(amount)FROM income_record GROUP BY category_id;
-- TASK-3
SELECT category_id, AVG(amount)FROM income_record GROUP BY category_id;
-- TASK-4
SELECT category_id, MAX(amount)FROM income_record GROUP BY category_id;
-- TASK-5
SELECT category_id, MIN(amount)FROM income_record GROUP BY category_id;
-- TASK-6
SELECT year_id, SUM(amount) as total_income FROM income_record GROUP BY year_id;
-- TASK-7
SELECT year_id, COUNT(income_id) as no_of_income FROM income_record GROUP BY year_id;
-- TASK-8
SELECT year_id,category_id, SUM(amount) as total_income FROM income_record GROUP BY year_id,category_id;

-- LEVEL-03
-- TASK-1
SELECT category_id, SUM(amount) as total_income FROM income_record 
GROUP BY category_id HAVING  SUM(amount)>'1000000.00';
-- TASK-2
SELECT category_id, AVG(amount) as total_income FROM income_record
GROUP BY category_id HAVING  AVG(amount)>'500000.00';
-- TASK-3
SELECT year_id, COUNT(income_id) as records_greaterthan3 FROM income_record
GROUP BY year_id HAVING  COUNT(amount)>3;
-- TASK-4
SELECT category_id, SUM(amount) AS total_income
FROM income_record GROUP BY category_id ORDER BY total_income DESC;
-- TASK-5
SELECT category_id, SUM(amount) AS total_income FROM income_record
GROUP BY category_id HAVING SUM(amount) > 1000000 ORDER BY total_income DESC;
-- TASK-6
SELECT category_id,
SUM(amount) AS total_income, 
AVG(amount) AS average_income FROM income_record GROUP BY category_id;
-- TASK-7
SELECT category_id, year_id, SUM(amount) AS total_income FROM income_record
GROUP BY category_id, year_id ORDER BY total_income DESC LIMIT 1;
-- TASK-8
SELECT ir.year_id, COUNT(DISTINCT t.taxpayer_id) AS no_of_taxpayers FROM taxpayer t
JOIN income_record ir ON t.taxpayer_id = ir.taxpayer_id GROUP BY ir.year_id;

-- REAL WORLD ANALYSIS
-- Task 1
SELECT c.category_name,SUM(i.amount) AS total_income
FROM income_record AS i JOIN income_category AS c
ON i.category_id = c.category_id GROUP BY i.category_id
ORDER BY total_income DESC LIMIT 1;
-- Task 2
SELECT f.year_labe,SUM(i.amount) AS total_income FROM income_record AS i
JOIN financial_year AS f ON i.year_id = f.year_id
GROUP BY i.year_id ORDER BY total_income DESC
LIMIT 1;
-- Task 3
SELECT c.category_name,(AVG(i.amount)) AS highest_avg_income FROM income_record AS i
JOIN income_category AS c ON i.category_id = c.category_id
GROUP BY i.category_id ORDER BY highest_avg_income DESC
LIMIT 1;
-- Task 4
SELECT c.category_name, COUNT(i.category_id) AS records_count FROM income_record AS i
JOIN income_category AS c ON i.category_id = c.category_id
GROUP BY i.category_id HAVING records_count > 2;
-- Task 5
SELECT f.year_labe, SUM(i.amount) AS total_income FROM income_record AS i
JOIN financial_year AS f ON i.year_id = f.year_id
GROUP BY i.year_id HAVING total_income > 1000000;
-- Task 6
SELECT category_id,
       COUNT(income_id) AS number_of_records,
       SUM(amount) AS total_income,
       AVG(amount) AS average_income,
       MAX(amount) AS highest_income,
       MIN(amount) AS lowest_income FROM income_record GROUP BY category_id;


