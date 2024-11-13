USE DataWarehouse
GO

INSERT INTO Pytanie (Tresc) VALUES
    ('Test question 1'),
    ('Test question 2'),
    ('Test question 3'),
    ('Test question 4'),
    ('Test question 5')

INSERT INTO ZajetoscTerminuEgzaminu (ZajetoscTerminu) VALUES
    (N'Pusty'),
    (N'Częściowo Pełny'), 
    (N'Pełny')

INSERT INTO Kandydat (PKK) VALUES
    ('PKK1234567890123456'),
    ('PKK2345678901234567'),
    ('PKK3456789012345678'),
    ('PKK4567890123456789'),
    ('PKK5678901234567890')

INSERT INTO Egzaminator (Pesel, ImieINazwisko, CzyAktualne) VALUES
    ('12345678901', 'Jan Kowalski', 1),
    ('23456789012', 'Anna Nowak', 0),
    ('34567890123', 'Piotr Wiśniewski', 1),
    ('45678901234', 'Katarzyna Zielińska', 1),
    ('56789012345', 'Michał Lewandowski', 0),
    ('56789012345', 'Michalina Lewandowska', 1),
    ('23456789012', 'Anien Nowak', 1)

INSERT INTO Czas (Godzina, Minuty) VALUES
    ('12', '00'),
    ('12', '15'),
    ('12', '30'),
    ('12', '45'),
    ('13', '00')

INSERT INTO Data (Data, Rok, Miesiac, NumerMiesiaca, DzienTygodnia, NumerDniaTygodnia) VALUES
    ('2024-01-01', '2024', N'Styczeń', 1, N'Poniedziałek', 1),
    ('2024-02-14', '2024', N'Luty', 2, N'Środa', 3),
    ('2024-03-25', '2024', N'Marzec', 3, N'Poniedziałek', 1),
    ('2024-04-10', '2024', N'Kwiecień', 4, N'Środa', 3),
    ('2024-05-30', '2024', N'Maj', 5, N'Czwartek', 4)

INSERT INTO Skarga (TypEgzaminu, TypSkargi, CzyIstniejaPowiazaneIncydenty, CzyKandydatOdpowiedzialNaWszystkiePytania) VALUES
    (N'Teoretyczny', N'Techniczny Przebieg', N'Brak powiązanych incydentów', N'Kandydat Odpowiedział Na Wszystkie Pytania'),
    (N'Praktyczny', N'Treść Pytań', N'Istnieją powiązane incydenty', N'Kandydat Nie Zdołał Odpowiedzieć Na Wszystkie Pytania'),
    (N'Teoretyczny', N'Egzaminator', N'Brak powiązanych incydentów', N'Kandydat Odpowiedział Na Wszystkie Pytania'),
    (N'Praktyczny', N'Inne', N'Istnieją powiązane incydenty', N'Kandydat Nie Zdołał Odpowiedzieć Na Wszystkie Pytania'),
    (N'Teoretyczny', N'Treść Pytań', N'Brak powiązanych incydentów', N'Kandydat Odpowiedział Na Wszystkie Pytania')

GO

INSERT INTO TerminEgzaminu (ID_Daty, ID_Czasu, ID_Egzaminatora, NumerSaliEgzaminacyjnej) VALUES
    (1, 1, 1, '304'),
    (2, 1, 3, '324'),
    (3, 2, 4, '123'),
    (4, 1, 4, '978'),
    (4, 4, 4, '123')

GO

INSERT INTO ZarezerwowanieTerminu (ID_TerminuEgzaminu, ID_Kandydata, CzasOczekiwaniaWDniach) VALUES
    (1, 3, 5),
    (1, 4, 28),
    (3, 5, 1),
    (2, 1, 4),
    (4, 1, 12)

INSERT INTO OdbycieSieEgzaminu (ID_TerminuEgzaminu, ID_ZajetosciTerminuEgzaminu, LiczbaRezerwacjiNaTermin, MaksymalnaLiczbaUczestnikow, LiczbaUczestnikow) VALUES 
    (4, 1, 5, 5, 4),
    (2, 1, 3, 2, 1),
    (5, 2, 2, 3, 2),
    (3, 2, 1, 1, 1),
    (1, 3, 2, 1, 1)

INSERT INTO ZlozenieSkargi (ID_TerminuEgzaminu, ID_Kandydata, ID_Skargi, LiczbaPowiazanychIncydentow) VALUES
    (1, 1, 1, 0),
    (2, 2, 2, 1),
    (3, 3, 3, 2),
    (4, 4, 4, 1),
    (5, 5, 5, 0)

INSERT INTO OdpowiedzenieNaPytaniePodczasEgzaminuZeSkarga (ID_TerminuEgzaminu, ID_Kandydata, ID_Pytania, ID_Skargi) VALUES
    (1, 1, 1, 1),
    (2, 2, 2, 2),
    (3, 3, 3, 3),
    (4, 4, 4, 4),
    (5, 5, 5, 5);            

GO