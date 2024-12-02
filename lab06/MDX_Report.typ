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

= Zapytania MDX do zaimplementowanej Hurtowni Danych

#pad(top: 10pt, align(center)[Stanisław Nieradko 193044, Bartłomiej Krawisz 193319])

== KPI

=== 1. Zmniejszenie Średniego Czasu Oczekiwania na Termin Egzaminu

_Zmniejszenie średniego czasu oczekiwania na termin egzaminu teoretycznego o nie mniej niż 3% miesięcznie w porównaniu do poprzedniego miesiąca przez okres następnych 18 miesięcy_

- Value Expression:

    ```
    [Measures].[Średni czas oczekiwania na egzamin]
    ```

- Goal Expression:

    ```
    (KPIVALUE( "Zmniejszenie Średniego Czasu Oczekiwania na Termin Egzaminu" ), PARALLELPERIOD([Data].[Hierarchy].[Miesiac], 1, [Data].[Hierarchy].CurrentMember)) * 0.97
    ```

- Status Expression: 

    ```
    IIF(KPIVALUE("Zmniejszenie Średniego Czasu Oczekiwania na Termin Egzaminu") < KPIGOAL("Zmniejszenie Średniego Czasu Oczekiwania na Termin Egzaminu"), 1, -1)
    ```

- Trend Expression: 

    ```
    IIF ( KPIValue( "Zmniejszenie Średniego Czasu Oczekiwania na Termin Egzaminu" ) < ( KPIValue( "Zmniejszenie Średniego Czasu Oczekiwania na Termin Egzaminu" ), ParallelPeriod (
    [Data].[Hierarchy].[Miesiac], 1,
    [Data].[Hierarchy].CurrentMember ) ), 1, -1)
    ```

=== 2. Zmniejszenie Liczby Skarg

_Zmniejszenie liczby skarg dot. przebiegu egzaminu teoretycznego o min 75% w skali najbliższych 18 miesięcy (z 500 do mniej niż, lub równo 125)_

- Value Expression:

    ```
    [Measures].[Liczba skarg]
    ```

- Goal Expression: 

    ```
    (KPIValue("Zmniejszenie Liczby Skarg"), ParallelPeriod (
    [Data].[Hierarchy].[Miesiac], 1,
    [Data].[Hierarchy].CurrentMember ) ) * 0.926
    ```

- Status Expression: 

    ```
    IIF (KPIVALUE("Zmniejszenie Liczby Skarg") < KPIGoal("Zmniejszenie Liczby Skarg"), 1, -1)
    ```

- Trend Expression: 

    ```
    IIF ( KPIValue("Zmniejszenie Liczby Skarg") > ( KPIValue("Zmniejszenie Liczby Skarg"), ParallelPeriod (
    [Data].[Hierarchy].[Miesiac], 1,
    [Data].[Hierarchy].CurrentMember ) ), 1, -1)
    ```
== Zapytania MDX

=== Porównaj średni czas oczekiwania na egzamin teoretyczny w tym i poprzednim miesiącu.

```mdx
SELECT 
    NON EMPTY { [Measures].[Średni czas oczekiwania na egzamin] } ON COLUMNS,
    NON EMPTY { ([Data].[Hierarchy].[Miesiac].ALLMEMBERS) } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM 
    [Data Warehouse]
```

=== Porównaj liczbę skarg w tym i poprzednim miesiącu.

```mdx
SELECT 
    NON EMPTY { [Measures].[Liczba skarg] } ON COLUMNS,
    NON EMPTY { ([Data].[Hierarchy].[Miesiac].ALLMEMBERS) } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM 
    [Data Warehouse] 
```

=== Porównaj średnią liczbę zarezerwowanych terminów egzaminów teoretycznych na przestrzeni dni tygodnia.

```mdx
SELECT 
    NON EMPTY { [Measures].[Średnia liczba rezerwacji] } ON COLUMNS,
    NON EMPTY { ([Data].[Dzien Tygodnia].[Dzien Tygodnia].ALLMEMBERS) } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM 
    [Data Warehouse] 
```

=== Podaj jak dużo kandydatów nie pojawiło się na egzaminie w tym i poprzednim miesiącu.

```mdx
SELECT 
    NON EMPTY { [Measures].[Łączna liczba kandydatów nieobecnych] } ON COLUMNS,
    NON EMPTY { ([Data].[Hierarchy].[Miesiac].ALLMEMBERS) } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM 
    [Data Warehouse]
```

=== Jaka jest średnia liczba podejść do egzaminu na jednego kandydata w tym i poprzednim miesiącu?

```mdx
WITH 
    MEMBER [Measures].[Temp] AS 
        [Measures].[Liczba rezerwacji na termin] / [Measures].[Liczba różnych kandydatów wśród terminów rezerwacji] 
SELECT 
    NON EMPTY { [Measures].[Temp] } ON COLUMNS,
    NON EMPTY { ([Data].[Hierarchy].[Miesiac].ALLMEMBERS) } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM 
    [Data Warehouse]
```

=== Jak dużo terminów egzaminów zostało w pełni zarezerwowanych w tym i poprzednim miesiącu?

```mdx
SELECT 
    NON EMPTY { [Measures].[Liczba egzaminów] } ON COLUMNS,
    NON EMPTY { ([Data].[Hierarchy].[Miesiac].ALLMEMBERS) } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM 
    (
        SELECT 
            ( { [Zajetosc Terminu Egzaminu].[Zajetosc Terminu].&[Pełny] } ) ON COLUMNS 
        FROM 
            [Data Warehouse]
    ) 
WHERE 
    ( [Zajetosc Terminu Egzaminu].[Zajetosc Terminu].&[Pełny] )
```

=== Porównaj liczbę skarg technicznych w relacji do sal w których odbywają się egzaminy.

```mdx
SELECT 
    NON EMPTY { [Measures].[Liczba skarg] } ON COLUMNS,
    NON EMPTY { ([Termin Egzaminu].[Numer Sali Egzaminacyjnej].[Numer Sali Egzaminacyjnej].ALLMEMBERS) } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM 
    [Data Warehouse]
```

#pagebreak()

=== Jakie pytania pojawiały się najczęściej w egzaminach do których złożono skargi związane z treścią pytań?

```
SELECT 
    NON EMPTY { [Measures].[Liczba pytań] } ON COLUMNS,
    NON EMPTY { 
        TopCount(
            ([Pytanie].[Tresc].[Tresc].ALLMEMBERS), 
            10, 
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

=== Jacy egzaminatorzy byli najczęściej związani ze złożeniem skargi?

```mdx
SELECT 
    NON EMPTY { [Measures].[Liczba skarg] } ON COLUMNS,
    NON EMPTY { ([Egzaminator].[Pesel].[Pesel].ALLMEMBERS) } 
    DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
FROM 
    [Data Warehouse] 
```

=== Podaj liczbę skarg złożonych w egzaminach w których nie wystąpiły żadne incydenty zgłoszone przez egzaminatorów.

```
SELECT 
    NON EMPTY { [Measures].[Liczba skarg] } ON COLUMNS 
FROM 
    (
        SELECT 
            ( { [Skarga].[Czy Istnieja Powiazane Incydenty].&[Brak powiązanych incydentów] } ) ON COLUMNS 
        FROM 
            [Data Warehouse]
    ) 
WHERE 
    ( [Skarga].[Czy Istnieja Powiazane Incydenty].&[Brak powiązanych incydentów] )
```

#pagebreak()

=== Jak dużo kandydatów nie zdołało odpowiedzieć na wszystkie pytania w egzaminie i złożyło skargę z kategorii “związana z treścią pytań” lub “inne”?

```
WITH 
    MEMBER [Measures].[SumLiczbaKandydatów] AS 
        SUM(
            { 
                [Skarga].[Typ Skargi].&[Treść Pytań], 
                [Skarga].[Typ Skargi].&[Inne] 
            }, 
            [Measures].[Liczba kandydatów którzy złożyli skargi]
        ) 
SELECT 
    NON EMPTY { [Measures].[SumLiczbaKandydatów] } ON COLUMNS 
FROM 
    (
        SELECT 
            ( { [Skarga].[Czy Kandydat Odpowiedzial Na Wszystkie Pytania].&[Kandydat Nie Zdołał Odpowiedzieć Na Wszystkie Pytania] } ) ON COLUMNS 
        FROM 
            [Data Warehouse]
    ) 
WHERE 
    ( [Skarga].[Czy Kandydat Odpowiedzial Na Wszystkie Pytania].&[Kandydat Nie Zdołał Odpowiedzieć Na Wszystkie Pytania] )
```