-- Structure
CREATE PROCEDURE GetFilmsByYear
    @Year INT
AS
BEGIN
    SELECT *
	FROM Film 
	WHERE YEAR(ReleaseDate) = @Year;
END;

-- Calling procedure
EXEC GetFilmsByYear @Year = 2005;
EXEC GetFilmsByYear @Year = 2015;
EXEC GetFilmsByYear @Year = 2007;


CREATE PROCEDURE GetDoB
	@Year INT,
	@Month INT

AS
BEGIN
	SELECT *
	FROM [dbo].[Actor]
	WHERE (YEAR(DoB)=@Year) and (MONTH(DoB)=@Month)
END;

EXEC GetDob @Year=1967, @Month=1;
EXEC GetDob @Year=1972, @Month=4;