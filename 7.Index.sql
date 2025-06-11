-- CREATE
CREATE INDEX idx_film
ON [dbo].[Film] ([FilmID]);

-- DELETE
DROP INDEX idx_film ON [dbo].[Film];

SELECT *
FROM [dbo].[Role]
WHERE Role ='Marius';

CREATE INDEX idx_role
ON [dbo].[Role] (Role);

-- Bat hien thi thong ke ve tai nguyen
SET STATISTICS IO ON;

-- Tat hien thi thong ke ve tai nguyen
SET STATISTICS IO OFF;