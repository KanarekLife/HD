DECLARE @startDate DATE = '2019-01-01'
DECLARE @endDate DATE = '2026-01-01'

CREATE TABLE #TempDates (Data DATE)

WHILE @startDate <= @endDate
BEGIN
	INSERT INTO #TempDates (Data)
	VALUES (@startDate)

	SET @startDate = DATEADD(DAY, 1, @startDate)
END

INSERT INTO [dbo].[Data] (Data, Rok, Miesiac, NumerMiesiaca, DzienTygodnia, NumerDniaTygodnia)
SELECT
	CONVERT(NVARCHAR(10), Data, 120) AS Data,
	CONVERT(NVARCHAR(4), YEAR(Data)) AS Rok,
	CASE MONTH(Data)
	    WHEN 1 THEN N'Styczeń'
        WHEN 2 THEN N'Luty'
        WHEN 3 THEN N'Marzec'
        WHEN 4 THEN N'Kwiecień'
        WHEN 5 THEN N'Maj'
        WHEN 6 THEN N'Czerwiec'
        WHEN 7 THEN N'Lipiec'
        WHEN 8 THEN N'Sierpień'
        WHEN 9 THEN N'Wrzesień'
        WHEN 10 THEN N'Październik'
        WHEN 11 THEN N'Listopad'
        WHEN 12 THEN N'Grudzień'
	END AS Miesiac,
	MONTH(Data) AS NumerMiesiaca,
	CASE DATEPART(WEEKDAY, Data)
        WHEN 1 THEN N'Niedziela'
        WHEN 2 THEN N'Poniedziałek'
        WHEN 3 THEN N'Wtorek'
        WHEN 4 THEN N'Środa'
        WHEN 5 THEN N'Czwartek'
        WHEN 6 THEN N'Piątek'
        WHEN 7 THEN N'Sobota'
    END AS DzienTygodnia,
    DATEPART(WEEKDAY, Data) AS NumerDniaTygodnia
FROM #TempDates

DROP TABLE #TempDates