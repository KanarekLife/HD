-- noinspection SqlWithoutWhereForFile

DELETE FROM Egzaminatorzy
DELETE FROM SaleEgzaminacyjne
DELETE FROM StanowiskaEgzaminacyjne
DELETE FROM Kandydaci
DELETE FROM EgzaminyTeoretyczne
DELETE FROM Incydenty
DELETE FROM Pytania
DELETE FROM PrzebiegiEgzaminowKandydata
DELETE FROM ZaplanowanePytania


BULK INSERT Egzaminatorzy
    FROM '/mnt/egzaminatorzy.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',' )

BULK INSERT SaleEgzaminacyjne
    FROM '/mnt/sale_egzaminacyjne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',' )

BULK INSERT StanowiskaEgzaminacyjne
    FROM '/mnt/stanowiska_egzaminacyjne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',' )

BULK INSERT Kandydaci
    FROM '/mnt/kandydaci.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',' )

BULK INSERT EgzaminyTeoretyczne
    FROM '/mnt/egzaminy_teoretyczne.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',' )

BULK INSERT Incydenty
    FROM '/mnt/incydenty.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',' )

BULK INSERT Pytania
    FROM '/mnt/pytania.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',' )

BULK INSERT PrzebiegiEgzaminowKandydata
    FROM '/mnt/przebiegi_egzaminow_kandydata.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',' )

BULK INSERT ZaplanowanePytania
    FROM '/mnt/zaplanowane_pytania.csv'
    WITH ( ROWTERMINATOR = '\n', FIELDTERMINATOR = ',' )
