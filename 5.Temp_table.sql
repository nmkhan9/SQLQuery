-- Check temp_table
SELECT *
FROM tempdb.sys.tables
WHERE name LIKE '#%';

-- Structure
CREATE TABLE #temp_table (
	col_1 int,
	col_2 float,
	col_3 nvarchar(10)
);

INSERT INTO #temp_table (col_1, col_2, col_3)
VALUES (1, 3.14, N'Hello');

SELECT * 
FROM #temp_table;

-- Other
SELECT F.FilmID,F.Title
INTO #temp_film
FROM [dbo].[Film] as F;

SELECT *
FROM #temp_film;

-- Update
UPDATE #temp_table
SET col_2 = 9.99,
    col_3 = N'Updated'
WHERE col_1 = 1;

-- DELETE

-- Conditional
DELETE FROM #temp_table
WHERE col_1 = 2;

-- Full data
DELETE FROM #temp_table;

-- Delete table
DROP TABLE #temp_table;



