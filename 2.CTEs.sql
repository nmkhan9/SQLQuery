-- 1. Find all films starring a specific actor (e.g., ActorID = 455)
-- and display the film name along with the actor's name:

WITH FILM_ACTOR AS (
	SELECT F.FilmID,F.Title,R.RoleID,R.Role,A.ActorID,A.FamilyName,A.FirstName
	FROM [dbo].[Film] AS F
	JOIN [dbo].[Role] AS R
	ON R.FilmID = F.FilmID
	JOIN [dbo].[Actor] AS A
	ON A.ActorID=R.ActorID
	WHERE A.ActorID='455'
	)
SELECT FA.ActorID,FA.FilmID,FA.Title
FROM FILM_ACTOR AS FA ;

-- 2. Find films directed by directors who have directed at least 5 films
-- and starring at least 2 actors:

WITH DirectorsWithManyFilms AS (
	SELECT D.DirectorID,D.FamilyName,D.FirstName,D.FullName,COUNT(F.FilmID) AS NUMBEROFFILMS
	FROM [dbo].[Film] AS F
	JOIN [dbo].[Director] AS D
	ON D.DirectorID=F.DirectorID
	GROUP BY D.DirectorID,D.FamilyName,D.FirstName,D.FullName
	HAVING COUNT(F.FilmID) >= 5
	),
FilmsWithEnoughActors AS (
	SELECT F.FilmID,F.Title,COUNT(A.ActorID) AS NUMBEROFACTORS
	FROM [dbo].[Film] AS F
	JOIN [dbo].[Role] AS R
	ON R.FilmID=F.FilmID
	JOIN [dbo].[Actor] AS A
	ON A.ActorID=R.ActorID
	GROUP BY F.FilmID,F.Title
	HAVING COUNT(A.ActorID) >= 2
	)
SELECT F.FilmID,F.Title
FROM [dbo].[Film] AS F
JOIN DirectorsWithManyFilms AS D
ON D.DirectorID=F.DirectorID
JOIN FilmsWithEnoughActors AS FA
ON FA.FilmID=F.FilmID;

-- 3. List Studios that have films with '12A' certification
-- and starring a specific actor (e.g., ActorID = 448):

WITH FILMS12A AS (
	SELECT F.FilmID,F.Title,F.StudioID
	FROM [dbo].[Film] AS F
	JOIN [dbo].[Certificate] AS C
	ON C.CertificateID=F.CertificateID
	WHERE C.Certificate='12A'
	),
FilmsWithActor AS (
	SELECT F.FilmID,F.Title,F.StudioID
	FROM [dbo].[Film] AS F
	JOIN [dbo].[Role] AS R
	ON R.FilmID=F.FilmID
	WHERE R.ActorID='448'
	)
SELECT DISTINCT S.StudioID,S.Studio
FROM [dbo].[Studio] AS S
JOIN FILMS12A AS F12
ON F12.StudioID = S.StudioID
JOIN FilmsWithActor AS FA
ON FA.StudioID = S.StudioID
