CREATE DATABASE DB
GO

USE DB
GO

BEGIN TRANSACTION

CREATE TABLE Egzaminatorzy(Id uniqueidentifier PRIMARY KEY, Pesel nvarchar(11) NOT NULL, Nazwa nvarchar(max) NOT NULL)
CREATE TABLE SaleEgzaminacyjne(NumerSali int PRIMARY KEY)
CREATE TABLE StanowiskaEgzaminacyjne(Id uniqueidentifier PRIMARY KEY, NumerSali int NOT NULL, CONSTRAINT FK_NumerSali FOREIGN KEY (NumerSali) REFERENCES SaleEgzaminacyjne(NumerSali))
CREATE TABLE Kandydaci(PKK nvarchar(20) PRIMARY KEY, Nazwa nvarchar(max) NOT NULL)
CREATE TABLE EgzaminyTeoretyczne(Id uniqueidentifier PRIMARY KEY, ZaplanowanyTermin datetime2 NOT NULL, NumerSaliEgzaminacyjnej int NOT NULL, IdEgzaminatora uniqueidentifier NOT NULL, CONSTRAINT FK_SalaEgzaminacyjna FOREIGN KEY (NumerSaliEgzaminacyjnej) REFERENCES SaleEgzaminacyjne(NumerSali), CONSTRAINT FK_Egzaminator FOREIGN KEY (IdEgzaminatora) REFERENCES Egzaminatorzy(Id))
CREATE TABLE Incydenty(Id uniqueidentifier PRIMARY KEY, IdEgzaminu uniqueidentifier NOT NULL, Tresc nvarchar(max) NOT NULL, Powod nvarchar(max) NOT NULL, CONSTRAINT FK_Egzamin FOREIGN KEY (IdEgzaminu) REFERENCES EgzaminyTeoretyczne(Id))
CREATE TABLE Pytania(Id uniqueidentifier PRIMARY KEY, Dane nvarchar(max) NOT NULL)
CREATE TABLE PrzebiegiEgzaminowKandydata(Id uniqueidentifier PRIMARY KEY, IdEgzaminuTeoretycznego uniqueidentifier NOT NULL, IdStanowiskaEgzaminacyjnego uniqueidentifier NOT NULL, PKKKandydata nvarchar(20) NOT NULL, CzasRezerwacjiTerminu datetime2 NOT NULL, CzasPotwierdzeniaGotowosciPrzezKandydata datetime2 NULL, CzasRozpoczeciaEgzaminu datetime2 NULL, CzasZakonczeniaEgzaminu datetime2 NULL, CONSTRAINT FK_EgzaminTeoretyczny FOREIGN KEY (IdEgzaminuTeoretycznego) REFERENCES EgzaminyTeoretyczne(Id), CONSTRAINT FK_StanowiskoEgzaminacyjne FOREIGN KEY (IdStanowiskaEgzaminacyjnego) REFERENCES StanowiskaEgzaminacyjne(Id), CONSTRAINT FK_Kandydat FOREIGN KEY (PKKKandydata) REFERENCES Kandydaci(PKK))
CREATE TABLE ZaplanowanePytania(Id uniqueidentifier PRIMARY KEY, IdPrzebieguEgzaminu uniqueidentifier NOT NULL, IdPytania uniqueidentifier NOT NULL, CzyZostalaUdzielonaPoprawnaOdpowiedz bit NULL, CzasUdzieleniaOdpowiedzi datetime2 NULL, PriorytetPytania int NOT NULL, CONSTRAINT FK_PrzebiegEgzaminu FOREIGN KEY (IdPrzebieguEgzaminu) REFERENCES PrzebiegiEgzaminowKandydata(Id), CONSTRAINT FK_Pytanie FOREIGN KEY (IdPytania) REFERENCES Pytania (Id))

COMMIT
GO