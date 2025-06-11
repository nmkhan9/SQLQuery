-- Structure
CREATE VIEW KHANGG AS
SELECT F.FilmID,F.Title,F.BoxOfficeDollars,F.BudgetDollars
FROM [dbo].[Film] AS F
WHERE F.LanguageID='2'

-- Query
SELECT *
FROM [dbo].[KHANGG]

-- UPDATE
UPDATE KHANGG
SET BoxOfficeDollars='12345'
WHERE KHANGG.FilmID='1170'

--DELETE
DROP VIEW [dbo].[KHANGG]