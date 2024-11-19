DECLARE @TypEgzaminuValues TABLE (Value nvarchar(11))
DECLARE @TypSkargiValues TABLE (Value nvarchar(19))
DECLARE @CzyIstniejaPowiazaneIncydenty TABLE (Value nvarchar(28))
DECLARE @CzyKandydatOdpowiedzialNaWszystkiePytania TABLE (Value nvarchar(53))

INSERT INTO @TypEgzaminuValues(Value) VALUES (N'Teoretyczny'),  (N'Praktyczny')
INSERT INTO @TypSkargiValues(Value) VALUES (N'Techniczny Przebieg'), (N'Treść Pytań'), (N'Egzaminator'), (N'Inne')
INSERT INTO @CzyIstniejaPowiazaneIncydenty(Value) VALUES (N'Brak powiązanych incydentów'), (N'Istnieją powiązane incydenty')
INSERT INTO @CzyKandydatOdpowiedzialNaWszystkiePytania(Value) VALUES (N'Kandydat Nie Zdołał Odpowiedzieć Na Wszystkie Pytania'), (N'Kandydat Odpowiedział Na Wszystkie Pytania')

INSERT INTO Skarga(TypEgzaminu, TypSkargi, CzyIstniejaPowiazaneIncydenty, CzyKandydatOdpowiedzialNaWszystkiePytania)
SELECT	typEgzaminu.Value AS TypEgzaminu,
		typSkargi.Value AS TypSkargi,
		czyIstniejaPowiazaneIncydenty.Value AS CzyIstniejaPowiazaneIncydenty,
		czyKandydatOdpowiedzialNaWszystkiePytania.Value AS CzyKandydatOdpowiedzialNaWszystkiePytania
FROM @TypEgzaminuValues typEgzaminu
CROSS JOIN @TypSkargiValues typSkargi
CROSS JOIN @CzyIstniejaPowiazaneIncydenty czyIstniejaPowiazaneIncydenty
CROSS JOIN @CzyKandydatOdpowiedzialNaWszystkiePytania czyKandydatOdpowiedzialNaWszystkiePytania