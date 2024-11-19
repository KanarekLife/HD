-- noinspection SqlWithoutWhereForFile

DELETE FROM ZaplanowanePytania
DELETE FROM PrzebiegiEgzaminowKandydata
DELETE FROM Pytania
DELETE FROM Incydenty
DELETE FROM EgzaminyTeoretyczne
DELETE FROM StanowiskaEgzaminacyjne
DELETE FROM Kandydaci
DELETE FROM SaleEgzaminacyjne
DELETE FROM Egzaminatorzy

BULK INSERT Egzaminatorzy
    FROM 'D:\HD\lab02\data\first_dump\egzaminatorzy.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT SaleEgzaminacyjne
    FROM 'D:\HD\lab02\data\first_dump\sale_egzaminacyjne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT StanowiskaEgzaminacyjne
    FROM 'D:\HD\lab02\data\first_dump\stanowiska_egzaminacyjne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT Kandydaci
    FROM 'D:\HD\lab02\data\first_dump\kandydaci.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT EgzaminyTeoretyczne
    FROM 'D:\HD\lab02\data\first_dump\egzaminy_teoretyczne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT Incydenty
    FROM 'D:\HD\lab02\data\first_dump\incydenty.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT Pytania
    FROM 'D:\HD\lab02\data\first_dump\pytania.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT PrzebiegiEgzaminowKandydata
    FROM 'D:\HD\lab02\data\first_dump\przebiegi_egzaminow_kandydata.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT ZaplanowanePytania
    FROM 'D:\HD\lab02\data\first_dump\zaplanowane_pytania.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )

DELETE FROM ZaplanowanePytania
DELETE FROM PrzebiegiEgzaminowKandydata
DELETE FROM Pytania
DELETE FROM Incydenty
DELETE FROM EgzaminyTeoretyczne
DELETE FROM StanowiskaEgzaminacyjne
DELETE FROM Kandydaci
DELETE FROM SaleEgzaminacyjne
DELETE FROM Egzaminatorzy

BULK INSERT Egzaminatorzy
    FROM 'D:\HD\lab02\data\second_dump\egzaminatorzy.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT SaleEgzaminacyjne
    FROM 'D:\HD\lab02\data\second_dump\sale_egzaminacyjne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT StanowiskaEgzaminacyjne
    FROM 'D:\HD\lab02\data\second_dump\stanowiska_egzaminacyjne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT Kandydaci
    FROM 'D:\HD\lab02\data\second_dump\kandydaci.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT EgzaminyTeoretyczne
    FROM 'D:\HD\lab02\data\second_dump\egzaminy_teoretyczne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT Incydenty
    FROM 'D:\HD\lab02\data\second_dump\incydenty.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT Pytania
    FROM 'D:\HD\lab02\data\second_dump\pytania.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT PrzebiegiEgzaminowKandydata
    FROM 'D:\HD\lab02\data\second_dump\przebiegi_egzaminow_kandydata.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT ZaplanowanePytania
    FROM 'D:\HD\lab02\data\second_dump\zaplanowane_pytania.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )