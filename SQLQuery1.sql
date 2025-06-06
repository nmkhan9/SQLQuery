--1 Retrieve all films:
SELECT *
FROM Film;

--2 Get the names of all actors:
SELECT a.FirstName,a.FamilyName
FROM [dbo].[Actor] as a;

--3 Get the names of all directors:
SELECT a.FirstName,a.FamilyName
FROM [dbo].[Director] as a;

--4 Get the ID and name of all genres:
SELECT *
FROM [dbo].[Genre];

--5 Get the first 5 films (ordered by FilmID):
SELECT TOP 5 f.FilmID,f.Title
FROM [dbo].[Film] as f
ORDER BY f.FilmID ASC;

--6 Get the film name and director name for all films:
SELECT f.FilmID,f.Title,d.DirectorID,d.FamilyName,d.FirstName
FROM [dbo].[Film] as f
JOIN [dbo].[Director] as d
ON f.DirectorID=d.DirectorID;

--7 Get the film name and genre name for all films:
SELECT f.Title,g.Genre
FROM [dbo].[Film] as f
JOIN [dbo].[Genre] as g
ON f.GenreID=g.GenreID;

--8 Count the number of films in each genre:
SELECT g.Genre,COUNT(f.FilmID) as NumberofFilms
FROM [dbo].[Film] as f
JOIN [dbo].[Genre] as g
ON f.GenreID=g.GenreID
GROUP BY g.Genre;

--9 Find all films released by Studio with StudioID = 1 :
SELECT f.FilmID,f.Title
FROM [dbo].[Film] as f
JOIN [dbo].[Studio] as s
ON f.StudioID=s.StudioID
WHERE s.StudioID=1 ;

--10 List actor names and the film names they participated in:
SELECT a.FirstName,f.Title
FROM [dbo].[Actor] as a
JOIN [dbo].[Role] as r
ON a.ActorID=r.ActorID
JOIN [dbo].[Film] as f
ON f.FilmID=r.FilmID;

--11 Find directors who have directed more than 5 films:
SELECT d.FirstName, COUNT(f.FilmID) as NumberofFilms
FROM [dbo].[Film] as f
JOIN [dbo].[Director] as d
ON f.DirectorID=d.DirectorID
GROUP BY d.FirstName
HAVING COUNT(f.FilmID)>5;

--12 Get the film name, director name, and country name of the film:
SELECT F.Title,D.FirstName,C.Country
FROM [dbo].[Film] AS F
JOIN [dbo].[Director] AS D
ON F.DirectorID=D.DirectorID
JOIN [dbo].[Country] AS C
ON C.CountryID=F.CountryID

--13 Find actors who have not participated in any film:
SELECT A.FirstName
FROM [dbo].[Role] AS R
JOIN [dbo].[Actor] AS A
ON A.ActorID=R.ActorID
WHERE R.RoleID IS NULL;

--14 List films and the number of actors involved in each film:
SELECT f.Title, COUNT(R.ActorID) AS NumberOfActors
FROM Film AS F
LEFT JOIN Role AS R ON F.FilmID = R.FilmID
GROUP BY f.Title;

--15 Find film names with 'English' language and '12' certificate:
SELECT F.Title
FROM Film AS F
JOIN Language AS L 
ON F.LanguageID = L.LanguageID
JOIN Certificate AS C 
ON F.CertificateID = C.CertificateID
WHERE L.Language = 'English' AND C.Certificate = '12';

--16 Get the names of all films directed by 'Steven Spielberg':
SELECT F.Title
FROM Film AS F
JOIN Director AS D 
ON F.DirectorID = D.DirectorID
WHERE CONCAT(D.FirstName,D.FamilyName) = 'StevenSpielberg';

--17 Find Studio names that have produced at least 3 films:
SELECT S.Studio, COUNT(F.FilmID) AS NumberOfFilms
FROM Studio AS S
JOIN Film AS F 
ON S.StudioID = F.StudioID
GROUP BY S.Studio
HAVING COUNT(F.FilmID) >= 3;

--18 List film names and actor names if the film has more than 2 actors involved:
SELECT F.Title, A.FirstName
FROM Film AS F
JOIN Role AS R 
ON F.FilmID = R.FilmID
JOIN Actor AS A 
ON R.ActorID = A.ActorID
WHERE F.FilmID IN (
    SELECT FilmID
    FROM Role
    GROUP BY FilmID
    HAVING COUNT(ActorID) > 2
);

--19 Find names of films where the genre name starts with 'D' :
SELECT F.Title, G.Genre
FROM Film AS F
JOIN Genre AS G 
ON F.GenreID = G.GenreID
WHERE G.Genre LIKE 'D%';

--20 List director names and the number of films they directed, but only show directors from 'Japan' who have directed at least 5 films:
SELECT D.FirstName, COUNT(F.FilmID) AS NumberOfFilms
FROM Director AS D
JOIN Film AS F 
ON D.DirectorID = F.DirectorID
JOIN Country AS C 
ON F.CountryID = C.CountryID 
WHERE C.Country = 'Japan' 
GROUP BY D.FirstName
HAVING COUNT(F.FilmID) >= 5;
