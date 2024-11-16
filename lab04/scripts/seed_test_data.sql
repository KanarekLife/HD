USE DataWarehouse
GO

INSERT INTO Pytanie (Tresc) VALUES
    ('Test question 1'),
    ('Test question 2'),
    ('Test question 3'),
    ('Test question 4'),
    ('Test question 5'),
    ('Test question 6'),
    ('Test question 7'),
    ('Test question 8'),
    ('Test question 9'),
    ('Test question 10')

INSERT INTO ZajetoscTerminuEgzaminu (ZajetoscTerminu) VALUES
    (N'Pusty'),
    (N'Częściowo Pełny'), 
    (N'Pełny')

INSERT INTO Kandydat (PKK) VALUES
    ('PKK1234567890123456'),
    ('PKK2345678901234567'),
    ('PKK3456789012345678'),
    ('PKK4567890123456789'),
    ('PKK5678901234567890'),
    ('PKK6789012345678901'),
    ('PKK7890123456789012'),
    ('PKK8901234567890123')

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
    (N'Teoretyczny', N'Treść Pytań', N'Istnieją powiązane incydenty', N'Kandydat Nie Zdołał Odpowiedzieć Na Wszystkie Pytania'),
    (N'Teoretyczny', N'Egzaminator', N'Brak powiązanych incydentów', N'Kandydat Odpowiedział Na Wszystkie Pytania'),
    (N'Teoretyczny', N'Inne', N'Istnieją powiązane incydenty', N'Kandydat Nie Zdołał Odpowiedzieć Na Wszystkie Pytania'),
    (N'Teoretyczny', N'Treść Pytań', N'Brak powiązanych incydentów', N'Kandydat Odpowiedział Na Wszystkie Pytania')

GO

INSERT INTO TerminEgzaminu (ID_Daty, ID_Czasu, ID_Egzaminatora, NumerSaliEgzaminacyjnej) VALUES
    (1, 1, 1, '304'),
    (2, 1, 3, '324'),
    (3, 2, 4, '123'),
    (4, 1, 4, '978'),
    (4, 4, 4, '123'),
    (5, 3, 2, '304')
GO

INSERT INTO ZarezerwowanieTerminu (ID_TerminuEgzaminu, ID_Kandydata, CzasOczekiwaniaWDniach) VALUES
    (1, 3, 28),
    (1, 4, 5),
    (2, 1, 13),
    (2, 2, 10),
    (2, 7, 7),
    (3, 5, 1),
    (4, 3, 12),
    (4, 6, 12),
    (4, 8, 11),
    (4, 4, 8),
    (4, 1, 4),
    (5, 2, 3),
    (5, 7, 3),
    (6, 3, 8)

INSERT INTO OdbycieSieEgzaminu (ID_TerminuEgzaminu, ID_ZajetosciTerminuEgzaminu, LiczbaRezerwacjiNaTermin, MaksymalnaLiczbaUczestnikow, LiczbaUczestnikow) VALUES 
    (1, 3, 2, 2, 2),
    (2, 2, 3, 3, 1),
    (3, 3, 1, 1, 1),
    (4, 2, 5, 5, 4),
    (5, 2, 2, 3, 2)

INSERT INTO ZlozenieSkargi (ID_TerminuEgzaminu, ID_Kandydata, ID_Skargi, LiczbaPowiazanychIncydentow) VALUES
    (1, 4, 1, 0),
    (2, 1, 2, 1),
    (4, 1, 4, 2),
    (4, 6, 2, 2),
    (5, 2, 5, 0)

INSERT INTO OdpowiedzenieNaPytaniePodczasEgzaminuZeSkarga (ID_TerminuEgzaminu, ID_Kandydata, ID_Pytania, ID_Skargi) VALUES
    (1, 4, 4, 1),
    (1, 4, 2, 1),
    (1, 4, 1, 1),
    (2, 1, 2, 2),
    (2, 1, 3, 2),
    (2, 1, 8, 2),
    (4, 1, 10, 4),
    (4, 1, 7, 4),
    (4, 1, 3, 4),
    (4, 6, 1, 2),
    (4, 6, 4, 2),
    (4, 6, 9, 2),
    (5, 2, 9, 5),
    (5, 2, 6, 5),
    (5, 2, 5, 5);
GO