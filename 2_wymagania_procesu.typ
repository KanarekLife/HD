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

= Specyfikacja wymagań procesu: Przeprowadzenie egzaminu teoretycznego

#pad(top: 10pt, align(center)[Stanisław Nieradko 193044, Bartłomiej Krawisz 193319])

== Generalny opis procesu

=== Opis procesu

Proces przeprowadzenia egzaminu teoretycznego składa się z następujących kroków:

- Kandydat wybiera dostępny termin egzaminu teoretycznego oraz rejestruje się na egzamin.
- Kandydat przychodzi na egzamin w wyznaczonym terminie.
- Kandydat podchodzi do egzaminu na komputerze stacjonarnym w sali w towarzystwie innych kandydatów pod nadzorem egzaminatora.
- W momencie gdy zostanie zakończony przez wszystkich obecnych na sali kandydatów, system automatycznie ocenia testy, pokazuje kandydatowi wynik oraz egzaminator drukuje zaświadczenia o wyniku egzaminu.
- Kandydat otrzymuje wynik egzaminu oraz zaświadczenie o wyniku egzaminu.
- W przypadku nieprawidłowości w przebiegu egzaminu, kandydat ma prawo złożyć skargę poprzez wypełnienie formularza w okienku recepcji.

Cele dot. procesu:

- *Zmniejszenie średniego czasu oczekiwania na termin egzaminu teoretycznego o nie mniej niż 3% miesięcznie w porównaniu do poprzedniego miesiąca przez okres następnych 18 miesięcy*
- *Zmniejszenie liczby skarg dot. przebiegu egzaminu teoretycznego o min 75% w skali najbliższych 18 miesięcy (z 500 do mniej niż, lub równo 125)*

=== Pytania analityczne

- Porównaj średni czas oczekiwania na egzamin teoretyczny w tym i poprzednim miesiącu.
- Porównaj średnią liczbę zarezerwowanych terminów egzaminów teoretycznych na przestrzeni dni tygodnia w tym i poprzednim miesiącu.
- Podaj jak dużo kandydatów nie pojawiło się na egzaminie w tym i poprzednim miesiącu.
- Porównaj liczbę incydentów podczas egzaminów w tym i poprzednim miesiącu.
- Jak dużo terminów egzaminów zostało w pełni zarezerwowanych w tym i poprzednim miesiącu?
- Jaka jest średnia liczba podejść do egzaminu na jednego kandydata w tym i poprzednim miesiącu?

=== Źródła danych

Dane dotyczące przebiegu egzaminu teoretycznego są przechowywane w bazie danych systemu przeprowadzania egzaminów teoretycznych. System przechowuje informacje o kandydatach, egzaminatorach, wynikach egzaminów oraz czasie / terminie jego przeprowadzenia. Przechowywane są również informacje o incydentach, które miały miejsce podczas egzaminu.

Skargi dot. procesu egzaminacyjnego są przepisywane z formularzy skargowych do pliku excel przez pracownika recepcji. Plik ten rotowany jest co miesiąc oraz przekazywany do kierownictwa co 2 tygodnie.

== Struktury w źródłach danych

#pagebreak()

=== Baza danych systemu przeprowadzania egzaminów teoretycznych

#table(
  columns: (auto, auto, auto, auto),
  table.header(
    [*Nazwa Tabeli*], [*Atrybut*], [*Typ Atrybutu*], [*Opis*]
  ),
  table.cell(rowspan: 3)[#align(center)[#rotate(90deg, reflow: true)[*Egzaminatorzy*]]], [Id], [GUID], [PK],
    [Pesel], [nvarchar(11)], [Numer pesel egzaminatora],
    [Nazwa], [nvarchar(max)], [Imię i nazwisko egzaminatora],
  [#align(center)[#rotate(90deg, reflow: true)[*SaleEgzaminacyjne*]]], [NumerSali], [int], [PK, numer sali egzaminacyjnej],
  table.cell(rowspan: 2)[#align(center)[#rotate(90deg, reflow: true)[*StanowiskaEgzaminacyjne*]]], [Id], [GUID], [PK],
    [NumerSali], [int], [FK do SaleEgzaminacyjne, numer sali],
  table.cell(rowspan: 2)[#align(center)[#rotate(90deg, reflow: true)[*Kandydaci*]]], [PKK], [nvarchar(20)], [PK, numer PKK kandydata],
    [Nazwa], [nvarchar(max)], [Imię i nazwisko kandydata],
  table.cell(rowspan: 4)[#align(center)[#rotate(90deg, reflow: true)[*Incydenty*]]], [Id], [GUID], [PK],
    [IdEgzaminu], [GUID], [FK do EgzaminyTeoretyczne, id egzaminu do którego przypisany jest incydent],
    [Tresc], [nvarchar(max)], [Opis incydentu],
    [Powod], [nvarchar(max)], [Dowolna wartość określająca powód incydentu],
  table.cell(rowspan: 4)[#align(center)[#rotate(90deg, reflow: true)[*EgzaminyTeoretyczne*]]], [Id], [GUID], [PK],
    [ZaplanowanyTermin], [datetime2], [Data i godzina zaplanowanego terminu egzaminu],
    [NumerSaliEgzaminacyjnej], [int], [FK do SaleEgzaminacyjne, numer sali egzaminacyjnej],
    [IdEgzaminatora], [GUID], [FK do Egzaminatorzy, id egzaminatora],
  table.cell(rowspan: 2)[#align(center)[#rotate(90deg, reflow: true)[*Pytania*]]], [Id], [GUID], [PK],
    [Dane], [json], text(size: 9pt)[Dane pytania w formacie JSON. Zawiera treść pytania, odpowiedzi oraz poprawną odpowiedź. (Nie będzie używana w hurtowni danych)],
  table.cell(rowspan: 6)[#align(center)[#rotate(90deg, reflow: true)[*ZaplanowanePytania*]]], [Id], [GUID], [PK],
    [IdPrzebieguEgzaminu], [GUID], [FK do PrzebiegiEgzaminow-
    Kandydata, id przebiegu egzaminu],
    [IdPytania], [GUID], [FK do Pytania, id pytania],
    [CzyZostalaUdzielonaPoprawna-
    Odpowiedz], [bit NULL], [Czy kandydat udzielił poprawnej odpowiedzi],
    [CzasUdzieleniaOdpowiedzi], [datetime2 NULL], [Data i godzina udzielenia odpowiedzi],
    [PriorytetPytania], [int], [Priorytet pytania w ramach egzaminu (który w kolejności był/będzie zadany)],
  table.cell(rowspan: 8)[#align(center)[#rotate(90deg, reflow: true)[*PrzebiegiEgzaminowKandydata*]]], [Id], [GUID], [PK],
    [IdEgzaminuTeoretycznego], [GUID], [FK do EgzaminyTeoretyczne, id egzaminu teoretycznego],
    [IdStanowiskaEgzaminacyjnego], [GUID], [FK do StanowiskaEgzaminacyjnego, id stanowiska egzaminacyjnego],
    [PKKKandydata], [nvarchar(20)], [FK do Kandydaci, numer PKK kandydata],
    [CzasRezerwacjiTerminu], [datetime2], [Data i godzina rezerwacji terminu egzaminu],
    [CzasPotwierdzeniaGotowosci
    -PrzezKandydata], [datetime2 NULL], [Data i godzina potwierdzenia gotowości do egzaminu przez kandydata],
    [CzasRozpoczeciaEgzaminu], [datetime2 NULL], [Data i godzina rozpoczęcia egzaminu],
    [CzasZakonczeniaEgzaminu], [datetime2 NULL], [Data i godzina zakończenia egzaminu],
)

=== Plik excel z danymi dot. skarg

_Arkusz 1_ - Skargi dot. procesu egzaminacyjnego.

- Kolumna A - PKK Kantydanta (20 cyfrowy numer identyfikacyjny)
- Kolumna B - Pesel Egzaminatora (11 cyfrowy numer identyfikacyjny)
- Kolumna C - Termin egzaminu (data i godzina w formacie dd-mm-yyyy hh:mm)
- Kolumna D - Typ egzaminu (tekst "teoretyczny" lub "praktyczny")
- Kolumna E - Typ skargi (tekst "związana z technicznym przebiegiem egzaminu", "związana z treścią pytań", "związana z egzaminatorem", "inne")
- Kolumna F - Treść skargi (tekst)
- Kolumna G - Data złożenia skargi (data w formacie dd-mm-yyyy)

Kolejne wiersze zawierają kolejne skargi. Skargi są zapisywane w pliku w kolejności ich złożenia. Nowy plik z danymi skarg jest tworzony co miesiąc, a stary przechowywany jest w archiwum.

_Arkusz 2_ - Lista egzaminatorów

- Kolumna A - Pesel Egzaminatora (11 cyfrowy numer identyfikacyjny)
- Kolumna B - Imię i nazwisko egzaminatora (tekst)

Kolejne wiersze zawierają kolejne wpisy dot. egzaminatorów. Dane aktualizowane są w miarę zmian w zespole egzaminatorów i przekopiowywane co miesiąc.

#pagebreak()

== Scenariusze problemów analitycznych

- *Problem 1*: Dlaczego nastąpił spadek/wzrost średniego czasu oczekiwania na termin egzaminu teoretycznego w porównaniu do poprzedniego miesiąca?
    1. Porównaj średni czas oczekiwania na egzamin teoretyczny w tym i poprzednim miesiącu.
    2. Porównaj średnią liczbę zarezerwowanych terminów egzaminów teoretycznych na przestrzeni dni tygodnia w tym i poprzednim miesiącu.
    3. Podaj jak dużo kandydatów nie pojawiło się na egzaminie w tym i poprzednim miesiącu.
    4. Jaka jest średnia liczba podejść do egzaminu na jednego kandydata w tym i poprzednim miesiącu?
    5. Jak dużo terminów egzaminów zostało w pełni zarezerwowanych w tym i poprzednim miesiącu?
    6. Czy istnieje zapotrzebowanie na dodatkowe terminy egzaminów w okolicy świąt (Boże Narodzenie, Wielkanoc)? (czy stopień zarezerwowanych terminów 2 dni do przodu i do tyłu święta jest powyżej 70%) [DODATKOWE ZEW. DANE]
    7. Porównaj popularność godzin egzaminów w tym i poprzednim miesiącu na podstawie typu kandydata (np. osoby pracujące, uczniowie, studenci) [WYMAGA ZMIANA W PROCESIE BIZNESOWYM - dodanie informacji o typie kandydata]

- *Problem 2*: Jakie są najczęstsze problemy związane z przebiegiem egzaminu teoretycznego, które prowadzą do skarg?
    1. Porównaj liczbę skarg technicznych w relacji do sal w których odbywają się egzaminy.
    2. Jakie pytania pojawiały się najczęściej w egzaminach do których złożono skargi związane z treścią pytań?
    3. Jacy egzaminatorzy byli najczęściej związani ze złożeniem skargi?
    4. Podaj liczbę skarg złożonych w egzaminach w których nie wystąpiły żadne incydenty zgłoszone przez egzaminatorów.
    5. Jak dużo kandydatów nie zdołało odpowiedzieć na wszystkie pytania w egzaminie i złożyło skargę z kategorii "związana z treścią pytań" lub "inne"?

== Dane potrzebne do problemów analitycznych

- *Problem 1*: Dlaczego nastąpił spadek/wzrost średniego czasu oczekiwania na termin egzaminu teoretycznego w porównaniu do poprzedniego miesiąca?

    1. Porównaj średni czas oczekiwania na egzamin teoretyczny w tym i poprzednim miesiącu.
        - *czas rezerwacji terminu* - _Baza Danych_, tabela `PrzebiegEgzaminuKandydata`, atrybut `CzasRezerwacjiTerminu`
        - *czas odbycia się egzaminu* - _Baza Danych_, tabela `PrzebiegEgzaminuKandydata`, atrybut `CzasPotwierdzeniaGotowosciPrzezKandydata`
        - *termin egzaminu* - _Baza Danych_, tabela `EgzaminyTeoretyczne`, atrybut `ZaplanowanyTermin`

    2. Porównaj średnią liczbę zarezerwowanych terminów egzaminów teoretycznych na przestrzeni dni tygodnia w tym i poprzednim miesiącu.
        - *termin egzaminu* - _Baza Danych_, tabela `EgzaminyTeoretyczne`, atrybut `ZaplanowanyTermin`
        - *liczba zarezerwowanych miejsc na egzaminie* - _Baza Danych_, liczba powiązanych z egzaminem `PrzebiegówEgzaminuKandydata`

    3. Podaj jak dużo kandydatów nie pojawiło się na egzaminie w tym i poprzednim miesiącu.
        - *termin egzaminu* - _Baza Danych_, tabela `EgzaminyTeoretyczne`, atrybut `ZaplanowanyTermin`
        - *liczba kandydatów którzy nie pojawili się na egzaminie* - _Baza Danych_, liczba powiązanych z egzaminem `PrzebiegówEgzaminuKandydata` gdzie atrybut `CzasPotwierdzeniaGotowsciPrzezKandydata` jest pusty

    4. Jaka jest średnia liczba podejść do egzaminu na jednego kandydata w tym i poprzednim miesiącu.
        - *termin egzaminu* - _Baza Danych_, tabela `EgzaminyTeoretyczne`, atrybut `ZaplanowanyTermin`
        - *pkk kandydata* - _Baza Danych_, tabela `Kandydaci`, atrybut `PKK`
        - *liczba podejść do egzaminu* - _Baza Danych_, liczba powiązanych z kandydatów `PrzebiegówEgzaminuKandydata` gdzie atrybut `CzasPotwierdzeniaGotowsciPrzezKandydata` nie jest pusty
#pagebreak()
    5. Jak dużo terminów egzaminów zostało w pełni zarezerwowanych w tym i poprzednim miesiącu?
        - *termin egzaminu* - _Baza Danych_, tabela `EgzaminyTeoretyczne`, atrybut `ZaplanowanyTermin`
        - *liczba zarezerwowanych miejsc na egzaminie* - _Baza Danych_, liczba powiązanych z egzaminem `PrzebiegówEgzaminuKandydata`
        - *maksymalna liczba miejsc na egzaminie* - _Baza Danych_, liczba `StanowiskEgzaminacyjnych` w przypisanej do egzaminu `SaliEgzaminacyjnej`

    6. Czy istnieje zapotrzebowanie na dodatkowe terminy egzaminów w okolicy świąt (Boże Narodzenie, Wielkanoc)? (czy stopień zarezerwowanych terminów 2 dni do przodu i do tyłu święta jest powyżej 70%)
        - *termin egzaminu* - _Baza Danych_, tabela `EgzaminyTeoretyczne`, atrybut `ZaplanowanyTermin`
        - *liczba zarezerwowanych miejsc na egzaminie* - _Baza Danych_, liczba powiązanych z egzaminem `PrzebiegówEgzaminuKandydata`
        - *maksymalna liczba miejsc na egzaminie* - _Baza Danych_, liczba `StanowiskEgzaminacyjnych` w przypisanej do egzaminu `SaliEgzaminacyjnej`
        - *święta* - Kalendarz świąt, który musi być dostarczony z zewnątrz np. z Google Calendar'a. Póki co nie mamy dostępu do takich danych i musimy je pozyskać.

    7. Porównaj popularność godzin egzaminów w tym i poprzednim miesiącu na podstawie typu kandydata (np. osoby pracujące, uczniowie, studenci)
        - *termin egzaminu* - _Baza Danych_, tabela `EgzaminyTeoretyczne`, atrybut `ZaplanowanyTermin`
        - *pkk kandydata* - _Baza Danych_, tabela `Kandydaci`, atrybut `PKK`
        - *typ kandydata* - Aktualnie nie mamy takiej informacji w bazie danych, należy zmodyfikować proces biznesowy poprzez wymóg informacji o typie kandydata podczas rezerwacji terminu i zapisywania tej informacji w bazie danych.

- *Problem 2*: Jakie są najczęstsze problemy związane z przebiegiem egzaminu teoretycznego, które prowadzą do skarg?

    1. Porównaj liczbę skarg technicznych w relacji do sal w których odbywają się egzaminy.
        - *salę egzaminacyjną* - _Baza Danych_, tabela `SaleEgzaminacyjne`, atrybut `NumerSali`
        - *termin egzaminu* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `Termin egzaminu`
        - *pesel egzaminatora* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `PeselEgzaminatora`
        - *typ skargi* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `TypSkargi`

    2. Jakie pytania pojawiały się najczęściej w egzaminach do których złożono skargi związane z treścią pytań?
        - *id pytania* - _Baza Danych_, tabela `ZaplanowanePytania`, atrybut `Id`
        - *pkk kandydata* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `PKK Kandydata`
        - *termin egzaminu* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `Termin egzaminu`
        - *pesel egzaminatora* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `PeselEgzaminatora`
        - *typ skargi* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `TypSkargi`

    3. Jacy egzaminatorzy byli najczęściej związani ze złożeniem skargi?
        - *typ skargi* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `TypSkargi`
        - *pesel egzaminatora* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `PeselEgzaminatora`

    4. Podaj liczbę skarg złożonych w egzaminach w których nie wystąpiły żadne incydenty zgłoszone przez egzaminatorów.
        - *liczba incydentów podczas egzaminu* - _Baza Danych_, liczba `IncydentówPodczasEgzaminu` powiązanych z egzaminem
        - *termin egzaminu* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `Termin egzaminu`
        - *pesel egzaminatora* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `PeselEgzaminatora`
#pagebreak()
    5. Jak dużo kandydatów nie zdołało odpowiedzieć na wszystkie pytania w egzaminie i złożyło skargę z kategorii "związana z treścią pytań" lub "inne"?
        - *typ skargi* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `TypSkargi`
        - *pkk kandydata* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `PKK Kandydata`
        - *termin egzaminu* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `ZaplanowanyTermin`
        - *pesel egzaminatora* - _Plik Excel_, arkusz `Arkusz 1`, kolumna `PeselEgzaminatora`
        - *czy kandydat odpowiedział na pytanie* - _Baza Danych_, tabela `ZaplanowanePytania`, atrybut `CzasUdzieleniaOdpowiedzi`
        - *liczba pytań* - _Baza Danych_, liczba rzędów w tabeli `ZaplanowanePytania` powiązanych z `PrzebiegiEgzaminówKandydata`

== Wymagane zmiany w procesie biznesowym

Jedynym wymaganym dodatkiem do procesu biznesowego jest zapisywanie informacji o typie kandydata podczas rezerwacji terminu egzaminu. Informacja ta powinna być zapisywana w bazie danych w tabeli `EgzaminyTeoretyczne` w nowym atrybucie `TypKandydata`. Wartością tego atrybutu powinny być: "pracujący", "uczeń", "student", "brak informacji" oraz "inne". W przypadku starych rekordów, wartość "brak informacji" powinna być domyślną wartością. Dla nowych rekordów, wartość ta powinna być wymagana oraz inna od "brak informacji".
