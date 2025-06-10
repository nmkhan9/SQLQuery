--FIBONACI
WITH Fibo(prev_n,n) AS (
	-- khoi tao
	SELECT
		0 AS prev_n,
		1 AS n
	UNION ALL
	-- de quy
	SELECT
		n as prev_n,
		prev_n+n as n
	FROM fibo
)
SELECT *
from Fibo
OPTION (MAXRECURSION 5);


--GIAI THUA
WITH Giaithua(n,gt) AS (
	SELECT
		1 AS n,
		1 AS gt
	UNION ALL
	SELECT
		n+1 as n,
		gt*(n+1) as gt
	FROM Giaithua
)
SELECT *
from Giaithua
OPTION (MAXRECURSION 5);

-- Example: Find all films related to a specific actor,
-- including films where co-actors from those films also participated
-- (up to a certain depth).

-- Example: Find all films related to actor 'Neill Sam' and his co-actors,
-- as well as films of those co-actors, etc., up to a certain depth.

WITH ctes AS (
    SELECT
        F.FilmID,
        F.Title,
        A.ActorID,
        CONCAT(A.FamilyName, ' ', A.FirstName) AS FULLNAME,
        1 AS dept
    FROM
        [dbo].[Film] AS F
    JOIN
        [dbo].[Role] AS R ON F.FilmID = R.FilmID
    JOIN
        [dbo].[Actor] AS A ON A.ActorID = R.ActorID
    WHERE
        CONCAT(A.FamilyName, ' ', A.FirstName) = 'Neill Sam'

    UNION ALL

    -- Recursive Member: Find films of actors connected through shared films
    SELECT
        F_next.FilmID,
        F_next.Title,
        A_next.ActorID,
        CONCAT(A_next.FamilyName, ' ', A_next.FirstName) AS FULLNAME,
        ctes.dept + 1
    FROM
        ctes
    JOIN
        [dbo].[Role] AS R_connected ON ctes.FilmID = R_connected.FilmID
    JOIN
        [dbo].[Actor] AS A_next ON R_connected.ActorID = A_next.ActorID
    JOIN
        [dbo].[Film] AS F_next ON R_connected.FilmID = F_next.FilmID
    WHERE
        ctes.dept < 3

)
SELECT
    FilmID,
    Title,
    FULLNAME,
    dept
FROM
    ctes

