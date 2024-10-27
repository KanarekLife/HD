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
    FROM '/mnt/first_dump/egzaminatorzy.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT SaleEgzaminacyjne
    FROM '/mnt/first_dump/sale_egzaminacyjne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT StanowiskaEgzaminacyjne
    FROM '/mnt/first_dump/stanowiska_egzaminacyjne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT Kandydaci
    FROM '/mnt/first_dump/kandydaci.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT EgzaminyTeoretyczne
    FROM '/mnt/first_dump/egzaminy_teoretyczne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT Incydenty
    FROM '/mnt/first_dump/incydenty.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT Pytania
    FROM '/mnt/first_dump/pytania.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT PrzebiegiEgzaminowKandydata
    FROM '/mnt/first_dump/przebiegi_egzaminow_kandydata.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT ZaplanowanePytania
    FROM '/mnt/first_dump/zaplanowane_pytania.csv'
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
    FROM '/mnt/second_dump/egzaminatorzy.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT SaleEgzaminacyjne
    FROM '/mnt/second_dump/sale_egzaminacyjne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT StanowiskaEgzaminacyjne
    FROM '/mnt/second_dump/stanowiska_egzaminacyjne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT Kandydaci
    FROM '/mnt/second_dump/kandydaci.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT EgzaminyTeoretyczne
    FROM '/mnt/second_dump/egzaminy_teoretyczne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT Incydenty
    FROM '/mnt/second_dump/incydenty.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT Pytania
    FROM '/mnt/second_dump/pytania.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT PrzebiegiEgzaminowKandydata
    FROM '/mnt/second_dump/przebiegi_egzaminow_kandydata.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )
BULK INSERT ZaplanowanePytania
    FROM '/mnt/second_dump/zaplanowane_pytania.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',', FIRSTROW = 2 )