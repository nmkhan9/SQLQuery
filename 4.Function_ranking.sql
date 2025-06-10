--Create a list of movies, displaying their ID, title, and budget, 
--and rank them based on their budget, excluding movies without budget information.
SELECT F.FilmID,
F.Title,
F.BudgetDollars,
RANK() OVER (ORDER BY F.BudgetDollars DESC) as RANKING
FROM [dbo].[Film] AS F
WHERE F.BudgetDollars IS NOT NULL;

-- Danh so hang cac phim co ngan sach tu cao xuong thap
-- Dua theo tung ngon ngu
SELECT F.FilmID,
F.Title,
L.Language,
F.BudgetDollars,
RANK() OVER (PARTITION BY L.Language ORDER BY F.BudgetDollars DESC) as RANKING
FROM [dbo].[Film] AS F
JOIN [dbo].[Language] AS L
ON F.LanguageID=L.LanguageID
WHERE F.BudgetDollars IS NOT NULL;

-- Danh so thu tu
-- RANK (1,2,2,4,4,4,7)
-- DENSE_RANK (1,2,2,3,3,3,4)

