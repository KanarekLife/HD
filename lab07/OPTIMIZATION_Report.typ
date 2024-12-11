#set text(
  font: "New Computer Modern",
  size: 11pt
)

#set page(
  paper: "a4",
  margin: 1cm,
  numbering: "1/1"
)

#set pad(left: 1cm)

#show raw: it => box(
  fill: rgb("ddd"),
  outset: 4pt,
  it
)

= Optymalizacja Hurtowni Danych - Raport

#pad(top: 10pt, align(center)[Stanisław Nieradko 193044, Bartłomiej Krawisz 193319])

== 1. Cel raportu

Celem raportu jest analiza i optymalizacja hurtowni danych. W tym celu zostaną przeprowadzone testy wydajnościowe, a następnie zaproponowane zostaną optymalizacje.

== 2. Założenia

=== Wielkość Hurtowni

Wielkość hurtowni danych: 1360.00 MB

Liczba rekordów w zależności od tabeli faktów:

#table(
  columns: (2fr, 1fr),
  [OdbycieSieEgzaminu], [410400],
  [OdpowiedzenieNaPytaniePodczasEgzaminuZeSkarga], [2015],
  [ZarezerwowanieTerminu], [1342661],
  [ZlozenieSkargi], [1095]
)

=== Środowisko testowe

```
/////////////////  /////////////////    KanarekLife@Laptop
/////////////////  /////////////////    ------------------
/////////////////  /////////////////    OS: Windows 11 (Home) x86_64
/////////////////  /////////////////    Host: ROG Zephyrus G14 GA402RJ_GA402RJ (1.0)
/////////////////  /////////////////    Kernel: WIN32_NT 10.0.22631.4460 (23H2)
/////////////////  /////////////////    Uptime: 17 days, 22 hours, 57 mins
/////////////////  /////////////////    Shell: PowerShell 7.4.6
/////////////////  /////////////////    Display (TL140VDXP10): 1920x1200 @ 144 Hz
                                        DE: Fluent
/////////////////  /////////////////    WM: Desktop Window Manager
/////////////////  /////////////////    WM Theme: Dark - Blue (System: Dark, Apps: Dark)
/////////////////  /////////////////    Icons: Recycle Bin
/////////////////  /////////////////    Font: Segoe UI (12pt) [Caption / Menu / Message / Status]
/////////////////  /////////////////    Cursor: Windows Default (32px)
/////////////////  /////////////////    Terminal: Windows Terminal 1.21.3231.0
/////////////////  /////////////////    Terminal Font: Cascadia Mono (12pt)
/////////////////  /////////////////    CPU: AMD Ryzen 7 6800HS (16) @ 4.75 GHz
                                        GPU 1: AMD Radeon(TM) Graphics (485.80 MiB) [Integrated]
                                        GPU 2: AMD Radeon RX 6700S (7.96 GiB) [Discrete]
                                        Memory: 13.98 GiB / 15.23 GiB (92%)
                                        Swap: 1.10 GiB / 9.50 GiB (12%)
                                        Disk (C:\): 311.79 GiB / 476.07 GiB (65%) - NTFS
                                        Disk (D:\): 6.38 GiB / 63.94 GiB (10%) - ReFS
                                        Local IP (WiFi): 10.0.0.16/24
                                        Battery: 79% [AC Connected]
                                        Locale: en-GB

```

#pagebreak()

== 3. Założenia teoretyczne

#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  [], [*MOLAP*], [*HOLAP*], [*ROLAP*],
  [*Czas zapytania*], [Najkrótszy], [Średni (w przypadku dobrze zaprojektowanych agregacji może być krótki)], [Najdłuższy],
  [*Czas przetwarzania*], [Najdłuższy], [Średni (w przypadku dobrze zaprojektowanych agregacji może być krótki)], [Krótki],
  [*Wielkość hurtowni*], [Największa (wielkość miary jest zdecydowanie mniejsza jeżeli nie ma żadnych powiązanych z nią agregacji)], [Średnia], [Najmniejsza]
)

== 4. Testowanie

Testowanie czasów wykonywania zapytań dla różnych modeli, z i bez zdefiniowanych
agregacjami. 

Testowanie czasów przetwarzania kostek w tych samych ustawieniach testowych

=== Krótki opis zapytań

==== Zapytanie 1: Agregacja po dacie

```sql
SELECT 
	NON EMPTY { [Data].[Hierarchy].[Rok] } ON ROWS,
	NON EMPTY { [Measures].[Liczba rezerwacji], [Measures].[Średni czas oczekiwania na egzamin] } ON COLUMNS
FROM
	[Data Warehouse]
```

==== Zapytanie 2: Agregacja po wymiarze

```sql
SELECT
	NON EMPTY { [Kandydat].[PKK].MEMBERS } ON ROWS,
	NON EMPTY { [Measures].[Średni czas oczekiwania na egzamin] } ON COLUMNS
FROM
	[Data Warehouse]
```

==== Zapytanie 3: Zapytanie ogólne

```sql
SELECT 
    NON EMPTY { [Measures].[Liczba pytań] } ON COLUMNS,
    NON EMPTY { 
        TopCount(
            ([Pytanie].[Tresc].[Tresc].ALLMEMBERS), 
            50, 
            [Measures].[Liczba pytań]
        ) 
    } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM 
    (
        SELECT 
            ( { [Skarga].[Typ Skargi].&[Treść Pytań] } ) ON COLUMNS 
        FROM 
            [Data Warehouse]
    ) 
WHERE 
    ( [Skarga].[Typ Skargi].&[Treść Pytań] )
```

=== Cache i Ustawienia Agregacji

- Podczas testów cache usuwany był przed każdym zapytaniem z wykorzystaniem poniższego polecania:

```xml
<ClearCache xmlns="http://schemas.microsoft.com/analysisservices/2003/engine">  
  <Object>  
    <DatabaseID>DataWarehouse</DatabaseID>  
  </Object>  
</ClearCache>
```

- Testy czasu przetwarzania przeprowadzane były natomiast z wykorzystaniem kolejnego polecenia:

```xml
<Batch xmlns="http://schemas.microsoft.com/analysisservices/2003/engine">
  <Parallel>
    <Process xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ddl2="http://schemas.microsoft.com/analysisservices/2003/engine/2" xmlns:ddl2_2="http://schemas.microsoft.com/analysisservices/2003/engine/2/2" xmlns:ddl100_100="http://schemas.microsoft.com/analysisservices/2008/engine/100/100" xmlns:ddl200="http://schemas.microsoft.com/analysisservices/2010/engine/200" xmlns:ddl200_200="http://schemas.microsoft.com/analysisservices/2010/engine/200/200" xmlns:ddl300="http://schemas.microsoft.com/analysisservices/2011/engine/300" xmlns:ddl300_300="http://schemas.microsoft.com/analysisservices/2011/engine/300/300" xmlns:ddl400="http://schemas.microsoft.com/analysisservices/2012/engine/400" xmlns:ddl400_400="http://schemas.microsoft.com/analysisservices/2012/engine/400/400" xmlns:ddl500="http://schemas.microsoft.com/analysisservices/2013/engine/500" xmlns:ddl500_500="http://schemas.microsoft.com/analysisservices/2013/engine/500/500">
      <Object>
        <DatabaseID>DataWarehouse</DatabaseID>
      </Object>
      <Type>ProcessFull</Type>
      <WriteBackTableCreation>UseExisting</WriteBackTableCreation>
    </Process>
  </Parallel>
</Batch>
```

- Utworzone strategie agregacji zostały zdefiniowane na podstawie domyślnych ustawień dla każdego wymiaru.
- Pomiary czasowe zostały przeprowadzone z wykorzystaniem narzędzia `Microsoft SQL Server Management Studio`.

#pagebreak()

=== Wyniki

#text(size: 8pt, smallcaps[
  Wyniki w milisekundach (ms), w nawiasach wartości odchylenia standardowego.

  Agregacje utworzone z domyślnymi parametrami.
])

#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  align: center+horizon,
  table.cell(rowspan: 2)[_średnia (odch. std.)_], table.cell(colspan: 2)[*ROLAP*], table.cell(colspan: 2)[*HOLAP*], table.cell(colspan: 2)[*MOLAP*],
  [_Bez Agregacji_], [_Agregacja_], [_Bez Agregacji_], [_Agregacja_], [_Bez Agregacji_], [_Agregacja_],
  [Czas zapytania dot. Daty \[ms\]], [103,2 (24,21)], [97,2 (4,71)], [99,3 (9,73)], [8,2 (10,49)], [16,7 (5,17)], [8,2 (10,16)],
  [Czas zapytania dot. wymiaru \[ms\]], [131,5 (29,51)], [128,9 (3,31)], [128,2 (3,39)], [48,4 (10,09)], [60,4 (5,58)], [46,3 (4,06)],
  [Czas zapytania ogólnego \[ms\]], [41,1 (4,18)], [42,3 (2,87)], [41,9 (3,48)], [42 (2,91)], [7,8 (4,83)], [8 (4,97)],
  [Czas przetwarzania \[ms\]], [1773], [1744], [2524], [6245], [4595], [6947],
  [Rozmiar hurtowni \[MB\]], [9,95], [9,95], [9,95], [11,2], [24,6], [25,92]
)

==== Pełna lista pomiarów

#let results = csv("data.tsv", delimiter: "\t")
#table(
  columns: 4,
  [*Typ Hurtowni*],	[*Zapytanie*],	[*Agregacje*],	[*Czas Przetwarzania \[ms\]*],
  ..results.flatten()
)