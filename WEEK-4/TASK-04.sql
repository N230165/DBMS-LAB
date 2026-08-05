USE TAXATION_P;
show tables;

-- PART-A
describe taxpayer;
SHOW COLUMNS FROM taxpayer;
select * from taxpayer;
describe income_record;
SHOW COLUMNS FROM income_record;
select * from income_record;
describe financial_year;
SHOW COLUMNS FROM financial_year;
select * from financial_year;
describe income_category;
SHOW COLUMNS FROM income_category;
select * from income_category;

 -- PART-B 
 -- LEVEL-1
 -- task-1
 SELECT t.full_name, ir.income_source FROM taxpayer t INNER JOIN income_record ir ON t.taxpayer_id=ir.taxpayer_id;
 -- task-2
 SELECT t.full_name, ic.category_name FROM taxpayer t INNER JOIN income_record ir ON t.taxpayer_id=ir.taxpayer_id INNER JOIN income_category ic ON ir.category_id=ic.category_id;
 -- task-3
 SELECT ir.income_source, ir.amount, fy.year_label FROM income_record ir INNER JOIN financial_year fy ON ir.year_id=fy.year_id;
 -- task-4
SELECT t.full_name, ir.amount, t.annual_income FROM taxpayer t INNER JOIN income_record ir ON t.taxpayer_id=ir.taxpayer_id;
-- task-5
SELECT t.full_name,ir.income_source,ic.category_name,fy.year_label
FROM Taxpayer t INNER JOIN Income_Record ir ON t.taxpayer_id = ir.taxpayer_id INNER JOIN Income_Category ic
ON ir.category_id = ic.category_id INNER JOIN Financial_Year fy ON ir.year_id = fy.year_id;

-- level-2
-- task-1
SELECT t.full_name, ir.income_source FROM Taxpayer t INNER JOIN Income_Record ir ON t.taxpayer_id = ir.taxpayer_id
INNER JOIN Income_Category ic ON ir.category_id = ic.category_id WHERE ic.category_name = 'Salary';
-- task-2
SELECT t.full_name, t.occupation, ir.income_source FROM Taxpayer t
INNER JOIN Income_Record ir ON t.taxpayer_id = ir.taxpayer_id
INNER JOIN Income_Category ic ON ir.category_id = ic.category_id WHERE ic.category_name = 'Business';
-- task-3
SELECT t.full_name,t.pan_number,fy.start_date,fy.end_date
FROM Taxpayer t
INNER JOIN Income_Record ir
ON t.taxpayer_id = ir.taxpayer_id
INNER JOIN Financial_Year fy
ON ir.year_id = fy.year_id;
-- task-4
SELECT t.full_name,
       t.pan_number,
       ic.description
FROM Taxpayer t
INNER JOIN Income_Record ir
ON t.taxpayer_id = ir.taxpayer_id
INNER JOIN Income_Category ic
ON ir.category_id = ic.category_id;
-- task-5
SELECT t.full_name,t.pan_number,t.occupation,ir.income_source,ic.category_name,ir.amount,fy.year_label,fy.start_date,fy.end_date
FROM Taxpayer t
INNER JOIN Income_Record ir
ON t.taxpayer_id = ir.taxpayer_id
INNER JOIN Income_Category ic
ON ir.category_id = ic.category_id
INNER JOIN Financial_Year fy
ON ir.year_id = fy.year_id;

-- LEVEL-3
-- Task-1
  SELECT t.full_name, ir.income_source
FROM Taxpayer t
LEFT JOIN Income_Record ir
ON t.taxpayer_id = ir.taxpayer_id;
-- task-2
SELECT ic.category_name, ir.income_source
FROM Income_Record ir
RIGHT JOIN Income_Category ic
ON ir.category_id = ic.category_id;
-- task-3
SELECT t.full_name, ir.income_source
FROM Taxpayer t
LEFT JOIN Income_Record ir
ON t.taxpayer_id = ir.taxpayer_id
UNION
SELECT t.full_name, ir.income_source
FROM Taxpayer t
RIGHT JOIN Income_Record ir
ON t.taxpayer_id = ir.taxpayer_id;
-- task-4
SELECT t.full_name, fy.year_label
FROM Taxpayer t
CROSS JOIN Financial_Year fy;
-- task-5
SELECT A.full_name AS Taxpayer1,
       B.full_name AS Taxpayer2,
       A.occupation
FROM Taxpayer A
JOIN Taxpayer B
ON A.occupation = B.occupation
AND A.taxpayer_id < B.taxpayer_id;

