USE TAXATION_P;
ALTER TABLE Income_record
DROP COLUMN category_name,
DROP COLUMN financial_year;
SELECT * FROM income_record;
ALTER TABLE Income_record
	ADD category_id INT,
    ADD year_id INT;
ALTER TABLE Income_record
ADD CONSTRAINT foreignkey_Taxpayer
foreign key (taxpayer_id)
REFERENCES taxpayer(taxpayer_id);

ALTER TABLE Income_record
ADD CONSTRAINT foreignkey_category
foreign key (category_id)
REFERENCES income_category(category_id);

ALTER TABLE Income_record
	ADD CONSTRAINT foreignkey_year
	foreign key (year_id)
	REFERENCES financial_year(year_id);
    
UPDATE income_record
	SET category_id = 1
    WHERE income_id = 1001;
UPDATE income_record
	SET category_id = 2
    WHERE income_id = 1002;
UPDATE income_record
	SET category_id = 3
    WHERE income_id = 1003;
UPDATE income_record
	SET category_id = 4
    WHERE income_id = 1004;
UPDATE income_record
	SET category_id = 5
    WHERE income_id = 1005;
UPDATE income_record
	SET category_id = 6
    WHERE income_id = 1006;
 
 UPDATE income_record
	SET year_id = 1
    WHERE income_id = 1001;
 UPDATE income_record
	SET year_id = 2
    WHERE income_id = 1002;
 UPDATE income_record
	SET year_id = 3
    WHERE income_id = 1003;
 UPDATE income_record
	SET year_id = 4
    WHERE income_id = 1004;
 UPDATE income_record
	SET year_id = 5
    WHERE income_id = 1005;
 UPDATE income_record
	SET year_id = 6
    WHERE income_id = 1006;
SELECT * FROM income_record;

INSERT INTO Income_record(income_id, taxpayer_id, income_source, amount, received_date ,category_id,year_id) VALUES
 (1007,999,'teacher','500000.00','2026-03-12',7,8);
 -- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`taxation_p`.`income_record`, CONSTRAINT `foreignkey_Taxpayer` FOREIGN KEY (`taxpayer_id`) REFERENCES `taxpayer` (`taxpayer_id`))
INSERT INTO Income_record(income_id, taxpayer_id, income_source, amount, received_date ,category_id,year_id) VALUES
 (1007,101,'teacher','500000.00','2026-03-12',20,8);
 -- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`taxation_p`.`income_record`, CONSTRAINT `foreignkey_category` FOREIGN KEY (`category_id`) REFERENCES `income_category` (`category_id`))

INSERT INTO Income_record(income_id, taxpayer_id, income_source, amount, received_date ,category_id,year_id) VALUES
 (1007,101,'teacher','500000.00','2026-03-12',2,15);
 -- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`taxation_p`.`income_record`, CONSTRAINT `foreignkey_year` FOREIGN KEY (`year_id`) REFERENCES `financial_year` (`year_id`))
INSERT INTO Income_record(income_id, taxpayer_id, income_source, amount, received_date ,category_id,year_id) VALUES
 (1007,101,'teacher','500000.00','2026-03-12',20,3);
 -- Error Code: 1062. Duplicate entry '1007' for key 'income_record.PRIMARY'

DELETE FROM income_category WHERE category_id = 1;
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`taxation_p`.`income_record`, CONSTRAINT `foreignkey_category` FOREIGN KEY (`category_id`) REFERENCES `income_category` (`category_id`))

SELECT distinct occupation FROM taxpayer;
SELECT distinct * FROM income_category;
SELECT distinct * FROM financial_year;
SELECT distinct income_source FROM income_record;

-- PART c 
-- TASK-01
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 1
)
UNION
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 2
);
-- task-02
SELECT income_source
FROM Income_Record
WHERE year_id = 5
UNION
SELECT income_source
FROM Income_Record
WHERE year_id = 6;
-- task-03
SELECT full_name
FROM Taxpayer
WHERE occupation = 'Teacher'
UNION
SELECT full_name
FROM Taxpayer
WHERE occupation = 'Software Engineer';

-- PART-E
-- TASK-01
SELECT taxpayer_id
FROM Income_Record
WHERE category_id = 1
INTERSECT
SELECT taxpayer_id
FROM Income_Record
WHERE category_id = 2;

-- TASK-02
SELECT income_source
FROM Income_Record
WHERE year_id = 1
INTERSECT
SELECT income_source
FROM Income_Record
WHERE year_id = 2;

-- PART-F
-- TASK-01
SELECT taxpayer_id
FROM Income_Record
WHERE category_id = 1
EXCEPT
SELECT taxpayer_id
FROM Income_Record
WHERE category_id = 2;
-- TASK-2
SELECT taxpayer_id
FROM Income_Record
WHERE year_id = 2
EXCEPT
SELECT taxpayer_id
FROM Income_Record
WHERE year_id = 1;


-- PART-G 
-- TASK-01
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
);
-- TASK-02
SELECT full_name
FROM Taxpayer
WHERE occupation IN (
    SELECT occupation
    FROM Taxpayer
    WHERE taxpayer_id IN (
        SELECT taxpayer_id
        FROM Income_Record
        WHERE category_id = 2
    )
);
-- PART-h 
-- TASK-01
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM Income_Record
);
-- TASK-2
SELECT DISTINCT occupation
FROM Taxpayer
WHERE taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM Income_Record
);
SELECT taxpayer_id
FROM Taxpayer;
SELECT DISTINCT taxpayer_id
FROM Income_Record;

-- PART-I 
-- TASK-01
SELECT full_name
FROM Taxpayer
WHERE EXISTS (
    SELECT *
    FROM Income_Record
    WHERE Taxpayer.taxpayer_id = Income_Record.taxpayer_id
);
-- TASK-02
SELECT year_label
FROM Financial_Year
WHERE EXISTS (
    SELECT *
    FROM Income_Record
    WHERE Financial_Year.year_id = Income_Record.year_id
);

-- PART-J
-- TASK-01
SELECT full_name
FROM Taxpayer
WHERE NOT EXISTS (
    SELECT *
    FROM Income_Record
    WHERE Taxpayer.taxpayer_id = Income_Record.taxpayer_id
);
-- TASK-02
SELECT category_name
FROM Income_Category
WHERE NOT EXISTS (
    SELECT *
    FROM Income_Record
    WHERE Income_Category.category_id = Income_Record.category_id
);
-- PART-k 
-- TASK-1
SELECT full_name
FROM Taxpayer
WHERE annual_income > ANY (
    SELECT annual_income
    FROM Taxpayer
    WHERE occupation = 'Teacher'
);
-- TASK-2
SELECT full_name
FROM Taxpayer
WHERE annual_income > ANY (
    SELECT amount
    FROM Income_Record
    WHERE category_id = 2
);
-- PART-L 
-- TASK-01
SELECT full_name
FROM Taxpayer
WHERE annual_income > ALL (
    SELECT annual_income
    FROM Taxpayer
    WHERE occupation = 'Teacher'
);
-- TASK-02
SELECT full_name
FROM Taxpayer
WHERE annual_income > ALL (
    SELECT amount
    FROM Income_Record
    WHERE category_id = 2
);
-- PART-M
-- TASK-01
SELECT full_name, LENGTH(full_name)
FROM Taxpayer
ORDER BY full_name;
SELECT CONCAT('[', full_name, ']')
FROM Taxpayer
ORDER BY full_name;
UPDATE Taxpayer
SET full_name = TRIM(full_name)
WHERE taxpayer_id > 0;
SELECT *
FROM Taxpayer
ORDER BY full_name ASC;
-- TASK-2
SELECT *
FROM Taxpayer
WHERE annual_income > 800000;
-- TASK-3
SELECT *
FROM Taxpayer
WHERE occupation = 'Software Engineer';
-- TASK-4
SELECT *
FROM Income_Record
WHERE category_id = 2;
-- TASK-5
SELECT *
FROM Income_Record
WHERE amount BETWEEN 500000 AND 1000000;
-- TASK-6
SELECT *
FROM Taxpayer
WHERE full_name LIKE 'A%';
-- TASK-7
ALTER TABLE taxpayer ADD city varchar(20);
UPDATE taxpayer SET city='Vizag' WHERE taxpayer_id=101;
UPDATE Taxpayer SET city = 'Rajamundry' WHERE taxpayer_id IN (102,105);
UPDATE Taxpayer SET city = 'Tuni'WHERE taxpayer_id IN (103, 104,106);
SELECT *
FROM Taxpayer
WHERE city = 'Your_City';
-- TASK-08
SELECT *
FROM Taxpayer
WHERE is_active = 1;
-- TASK-9
SELECT COUNT(*) AS total_taxpayers
FROM Taxpayer;
-- TASK-10
SELECT MAX(annual_income) AS highest_income
FROM Taxpayer;

-- PART-N 
-- TASK-1
SELECT full_name
FROM Taxpayer
WHERE annual_income = (
    SELECT MAX(annual_income)
    FROM Taxpayer
);
-- TASK-2
SELECT category_id, COUNT(*) AS total_records
FROM Income_Record
GROUP BY category_id
ORDER BY total_records DESC
LIMIT 1;
-- TASK-03
SELECT occupation, COUNT(*) AS total_taxpayers
FROM Taxpayer
GROUP BY occupation;
-- TASK-4
SELECT COUNT(*) AS active_taxpayers
FROM Taxpayer
WHERE is_active = 1;
-- TASK-5
SELECT year_id, COUNT(*) AS total_records
FROM Income_Record
GROUP BY year_id
ORDER BY total_records DESC
LIMIT 1;

