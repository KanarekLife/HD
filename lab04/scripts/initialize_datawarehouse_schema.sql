CREATE DATABASE DataWarehouse
GO

USE DataWarehouse
GO

CREATE TABLE Data
(
    ID_Daty           int IDENTITY (1,1) PRIMARY KEY,
    Data              nvarchar(10) UNIQUE NOT NULL,
    Rok               nvarchar(4)         NOT NULL,
    Miesiac           nvarchar(11)        NOT NULL CHECK (Miesiac IN
                                                          (N'Styczeń', N'Luty', N'Marzec', N'Kwiecień', N'Maj',
                                                           N'Czerwiec', N'Lipiec', N'Sierpień', N'Wrzesień',
                                                           N'Październik', N'Listopad', N'Grudzień')),
    NumerMiesiaca     tinyint             NOT NULL,
    DzienTygodnia     nvarchar(12)        NOT NULL CHECK (DzienTygodnia IN
                                                          (N'Poniedziałek', N'Wtorek', N'Środa', N'Czwartek', N'Piątek',
                                                           'Sobota', 'Niedziela')),
    NumerDniaTygodnia tinyint             NOT NULL,
)
CREATE TABLE Czas
(
    ID_Czasu int IDENTITY (1,1) PRIMARY KEY,
    Godzina  nvarchar(2) NOT NULL,
    Minuty   nvarchar(2) NOT NULL
)
CREATE TABLE Egzaminator
(
    ID_Egzaminatora int IDENTITY (1,1) PRIMARY KEY,
    Pesel           nvarchar(11)  NOT NULL,
    ImieINazwisko   nvarchar(255) NOT NULL,
    CzyAktualne     bit           NOT NULL,
    INDEX idx_Pesel (Pesel)
)
CREATE TABLE Kandydat
(
    ID_Kandydata int IDENTITY (1,1) PRIMARY KEY,
    PKK          nvarchar(20) NOT NULL
)
CREATE TABLE ZajetoscTerminuEgzaminu
(
    ID_ZajetosciTerminuEgzaminu int IDENTITY (1,1) PRIMARY KEY,
    ZajetoscTerminu             nvarchar(15) NOT NULL CHECK (ZajetoscTerminu IN (N'Pusty', N'Częściowo Pełny', N'Pełny'))
)
CREATE TABLE Pytanie
(
    ID_Pytania int IDENTITY (1,1) PRIMARY KEY,
    Tresc      nvarchar(255) NOT NULL
)
CREATE TABLE Skarga
(
    ID_Skargi                                 int IDENTITY (1,1) PRIMARY KEY,
    TypEgzaminu                               nvarchar(11) NOT NULL CHECK (TypEgzaminu IN (N'Teoretyczny', N'Praktyczny')),
    TypSkargi                                 nvarchar(19) NOT NULL CHECK (TypSkargi IN
                                                                           (N'Techniczny Przebieg', N'Treść Pytań',
                                                                            N'Egzaminator', N'Inne')),
    CzyIstniejaPowiazaneIncydenty             nvarchar(28) NOT NULL CHECK (CzyIstniejaPowiazaneIncydenty IN
                                                                           (N'Brak powiązanych incydentów',
                                                                            N'Istnieją powiązane incydenty')),
    CzyKandydatOdpowiedzialNaWszystkiePytania nvarchar(53) NOT NULL CHECK (CzyKandydatOdpowiedzialNaWszystkiePytania IN
                                                                           (N'Kandydat Nie Zdołał Odpowiedzieć Na Wszystkie Pytania',
                                                                            N'Kandydat Odpowiedział Na Wszystkie Pytania'))
)
GO

CREATE TABLE TerminEgzaminu
(
    ID_TerminuEgzaminu      int IDENTITY (1,1) PRIMARY KEY,
    ID_Daty         int         NOT NULL,
    ID_Czasu        int         NOT NULL,
    ID_Egzaminatora         int         NOT NULL,
    NumerSaliEgzaminacyjnej nvarchar(3) NOT NULL,
    FOREIGN KEY (ID_Daty) REFERENCES Data (ID_Daty),
    FOREIGN KEY (ID_Czasu) REFERENCES Czas (ID_Czasu),
    FOREIGN KEY (ID_Egzaminatora) REFERENCES Egzaminator (ID_Egzaminatora)
)
GO

CREATE TABLE ZarezerwowanieTerminu
(
    ID_TerminuEgzaminu     int NOT NULL,
    ID_Kandydata           int NOT NULL,
    CzasOczekiwaniaWDniach int NOT NULL,
    FOREIGN KEY (ID_TerminuEgzaminu) REFERENCES TerminEgzaminu (ID_TerminuEgzaminu),
    FOREIGN KEY (ID_Kandydata) REFERENCES Kandydat (ID_Kandydata)
)
CREATE TABLE OdbycieSieEgzaminu
(
    ID_TerminuEgzaminu          int NOT NULL,
    ID_ZajetosciTerminuEgzaminu int NOT NULL,
    LiczbaRezerwacjiNaTermin    int NOT NULL,
    MaksymalnaLiczbaUczestnikow int NOT NULL,
    LiczbaUczestnikow           int NOT NULL,
    FOREIGN KEY (ID_TerminuEgzaminu) REFERENCES TerminEgzaminu (ID_TerminuEgzaminu),
    FOREIGN KEY (ID_ZajetosciTerminuEgzaminu) REFERENCES ZajetoscTerminuEgzaminu (ID_ZajetosciTerminuEgzaminu)
)
CREATE TABLE ZlozenieSkargi
(
    ID_TerminuEgzaminu          int NOT NULL,
    ID_Kandydata                int NOT NULL,
    ID_Skargi                   int NOT NULL,
    LiczbaPowiazanychIncydentow int NOT NULL,
    FOREIGN KEY (ID_TerminuEgzaminu) REFERENCES TerminEgzaminu (ID_TerminuEgzaminu),
    FOREIGN KEY (ID_Kandydata) REFERENCES Kandydat (ID_Kandydata),
    FOREIGN KEY (ID_Skargi) REFERENCES Skarga (ID_Skargi)
)
CREATE TABLE OdpowiedzenieNaPytaniePodczasEgzaminuZeSkarga
(
    ID_TerminuEgzaminu int NOT NULL,
    ID_Kandydata       int NOT NULL,
    ID_Pytania         int NOT NULL,
    ID_Skargi          int NOT NULL,
    FOREIGN KEY (ID_TerminuEgzaminu) REFERENCES TerminEgzaminu (ID_TerminuEgzaminu),
    FOREIGN KEY (ID_Kandydata) REFERENCES Kandydat (ID_Kandydata),
    FOREIGN KEY (ID_Pytania) REFERENCES Pytanie (ID_Pytania),
    FOREIGN KEY (ID_Skargi) REFERENCES Skarga (ID_Skargi)
)
GO
