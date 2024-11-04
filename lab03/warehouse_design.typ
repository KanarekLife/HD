#set text(
  font: "New Computer Modern",
  size: 11pt
)
#set page(
  paper: "a4",
  margin: 1cm,
  numbering: "1 z 1"
)
#set pad(left: 1cm)
#set heading(numbering: "1.")

#text(size: 16pt, align(center)[*Projekt Hurtowni Danych: Wojewódzki Ośrodek Ruchu Drogowego w Gdańsku*])

#align(center)[Stanisław Nieradko 193044, Bartłomiej Krawisz 193319]

= Proces Biznesowy

Hurtownia Danych zaprojektowana jest dla procesu przeprowadzania egzaminu teoretycznego na prawo jazdy w ośrodku WORD. Przebieg procesu opisany jest w dokumencie `2_wymagania_procesu.pdf`.

= Model Relacyjny

#align(center)[
  #image("diagram.svg")
  /* https://mermaid.live/edit#pako:eNqtVt1u2kgUfhVrrlrJjSBQGrjblt0VYkOshCorhLQ6sU9hMMxEY1vsOMlN1KrPUPUx9hE2vNeOPWPjP5o0Gy4Az_nOOd_59dwQl3tIBgTFkMJCwGbOLPWZgcAYxZZvgVGcothQFjkixngMzJMehGDdaGjy-dMaDf8yqF8XMSS_1m_jCmCvWhSdIgSRQOtDDMGZG6NPE59wOVRf7lLj7vTPmXclXYoXFHMnP01iBisMeeDSHyEzTn9QN76C8zQV4K7oBLRWHXkKfiA3sGagdT6qSIKQUZ9vD5mtQUyUszWPUWX9wgexoC-V5lRkTB4O1eFbCjEw6S5HzJUesrDC7sy7Vhj0UooTcGSYdIjDPVfVLyM10-ThRclrV49HpYjqP8OmLlWH0poTZzwnRUmCLT6fc7_4eEoxUO1YPJpEGxTmvKQ6jCmyqVxwT7GtaSRtXRaaxCb9X2ObHEYNdH_nXkxZ2YBJKoRc1OwUZNBgzsEA1-r8feV8tKE4mkC8pYHPi4IPsfzFDyPV71jioOv75Ol0xg3VOdwcaTYOi0tBlqVp6i9gTTOMK1cMVyXuWevVWO970qkbdcbj8vSa_VIN9eape6jso2JO1eiVEwWhtFUJHr7tvruUb7mq3-6eqTP9-zoroqF0YBbN2JT9TeV1zkT5miIXGEo3Tq0L8PX_1-U2UUrGWKriLhlNUFbywriiuLCtqcDd94evVjLDu892sVdta8QYViyq_holuxFX-UrCbCEl4_vqveJiJZvo4YteVxY14n__2SqTWvnhyx6DOULWnWUlzrcbhfUELoNYBqGv1ptZPcpx3iUTitbM47t72N3vtyJFFeUErFzVMrr2vr8KTpRqE7hawUu5oSDMBsRaJTN6lVIKDNzKSqzM5-3tmze3t3pRDlR0mdtmWLqhHocV91AR_ZQ7hTGRp-qZ-hViRSsNd4j_o3Ro3EvEyy_0x901KzQnpRFqJr4cws-8t5-SkmfYawzhWZZeKsLKZGl7xCZqs2-AeupmnA7bnIRL3OCcJIDtkoaYeL1TQIhCfiGZSwahiNAmgkeLJRl8gnWgnqJrFS2aq3V-eg2MDG7I32TQPTnqtbq9XqvV6bbf9Xt9m0gy6LRbR8edt--6J8f9dqv9tndnk5hzZaB91On1-sftTqt_3G2ftE-6qbVZKtQE0KNq8k71tT693d_9B-DK3dA */
]

#context [
  #set text(size: 10pt)
  #let title(content, n) = [#table.cell(rowspan: n, align(center)[#rotate(90deg, reflow: true)[* #content *]])]
  #let subtitle(content) = [#table.cell(colspan: 3, align(center)[* #content *])]

  #table(
    columns: (auto, auto, auto, auto),
    table.header([*Tabela*], [*Atrybut*], [*Typ*], [*Opis*]),

    title("ZarezerwowanieTerminuPrzezKandydata", 4),
      subtitle("Krotka opisuje fakt zarezerwowania terminu na egzamin teoretyczny przez kandydata."),
      [_ID_TerminuEgzaminu_], [Liczbowa], [FK TerminEgzaminu],
      [_ID_Kandydata_], [Liczbowa], [FK Kandydat],
      [_CzasOczekiwaniaWDniach_], [Liczbowa], [Czas oczekiwania (czas pomiędzy rezerwacją a dniem egzaminu) w dniach],

    title("OdbycieSieEgzaminu", 6),
      subtitle("Krotka opisuje fakt odbycia się egzaminu."),
      [_ID_TerminuEgzaminu_], [Liczbowa], [FK TerminEgzaminu],
      [_ID_ZajetosciTerminuEgzaminu_], [Liczbowa], [FK ZajetoscTerminuEgzaminu],
      [_LiczbaRezerwacjiNaTermin_], [Liczbowa], [Liczba rezerwacji na termin],
      [_MaksymalnaLiczbaUczestnikow_], [Liczbowa], [Maksymalna liczba uczestników na termin (na podstawie pojemności sali)],
      [_LiczbaUczestnikow_], [Liczbowa], [Liczba uczestników, którzy pojawili się w terminie],

    title("ZlozenieSkargi", 5),
      subtitle("Krotka opisuje fakt złożenia skargi na przebieg egzaminu przez kandydata."),
      [_ID_TerminuEgzaminu_], [Liczbowa], [FK TerminEgzaminu],
      [_ID_Kandydata_], [Liczbowa], [FK Kandydat],
      [_ID_Skargi_], [Liczbowa], [FK Skarga],
      [_LiczbaPowiazanychIncydentow_], [Liczbowa], [Liczba incydentów (dot. przebiegu egzaminu) zgłoszonych przez egzaminatorów],

    title("OdpowiedzenieNaPytaniePodczasEgzaminuZeSkarga", 5),
      subtitle("Krotka opisuje odpowiedzenie na pytanie przez kandydata podczas egzaminu na który złożył skargę."),
      [_ID_TerminuEgzaminu_], [Liczbowa], [FK TerminEgzaminu],
      [_ID_Kandydata_], [Liczbowa], [FK Kandydat],
      [_ID_Pytania_], [Liczbowa], [FK Pytanie],
      [_ID_Skargi_], [Liczbowa], [FK Skarga],

    title("Data", 8),
      subtitle("Krotka opisuje datę."),
      [_ID_Daty_], [Liczbowa], [PK],
      [_Data_], [10 znaków], [Data w formacie "RRRR-MM-DD"],
      [_Rok_], [4 znaki], [Rok w formacie "RRRR"],
      [_Miesiac_], [11 znaków], [Nazwa miesiąca ("Styczeń", "Luty", "Marzec", "Kwiecień", "Maj", "Czerwiec", "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień")],
      [_NumerMiesiaca_], [2 znaki], [Numer miesiąca w formacie "MM"],
      [_DzienTygodnia_], [12 znaków], [Nazwa dnia tygodnia ("Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota", "Niedziela")],
      [_NumerDniaTygodnia_], [1 znak], [Numer dnia tygodnia (1 - poniedziałek, 7 - niedziela)],

    title("Czas", 3),
      subtitle("Krotka opisuje czas."),
      [_ID_Czasu_], [Liczbowa], [PK],
      [_Godzina_], [5 znaków], [Godzina w formacie "HH:MM"],

    title("Egzaminator", 5),
      subtitle("Krotka opisuje egzaminatora."),
      [_ID_Egzaminatora_], [Liczbowa], [PK],
      [_PESEL_], [11 znaków], [BK, PESEL egzaminatora],
      [_ImieINazwisko_], [255 znaków], [Imię i nazwisko egzaminatora],
      [_CzyAktualne_], [boolean], [Czy krotka jest najbardziej aktualną (Implementacja SCD 2)],

    title("TerminEgzaminu", 6),
      subtitle("Krotka opisuje termin egzaminu."),
      [_ID_TerminuEgzaminu_], [Liczbowa], [PK],
      [_ID_DataEgzaminu_], [Liczbowa], [FK Data, Data egzaminu],
      [_ID_CzasEgzaminu_], [Liczbowa], [FK Czas, Czas egzaminu],
      [_ID_Egzaminatora_], [Liczbowa], [FK Egzaminator, Egzaminator],
      [_NumerSaliEgzaminacyjnej_], [3 znaki], [Numer sali egzaminacyjnej (liczba całkowita w zakresie 000 - 999 w postaci tekstowej)],

    title("Kandydat", 3),
      subtitle("Krotka opisuje kandydata."),
      [_ID_Kandydata_], [Liczbowa], [PK],
      [_PKK_Kandydata_], [20 znaków], [Numer PKK identyfikujący kandydata],

    title("ZajetoscTerminuEgzaminu", 3),
      subtitle("Krotka opisuje zajętość terminu egzaminu."),
      [_ID_ZajetosciTerminuEgzaminu_], [Liczbowa], [PK],
      [_ZajetoscTerminu_], [15 znaków], [Zajetość terminu egzaminu (Pusty, Częściowo Pełny, Pełny)],
    
    title("Skarga", 6),
      subtitle("Krotka opisuje skargę."),
      [_ID_Skargi_], [Liczbowa], [PK],
      [_TypEgzaminu_], [11 znaków], [Typ egzaminu na który złożono skargę (Teoretyczny, Praktyczny)],
      [_TypSkargi_], [19 znaków], [Typ skargi złożonej przez kandydata (Techniczny Przebieg, Treść Pytań, Egzaminator, Inne)],
      [_CzyIstniejaPowiazaneIncydenty_], [28 znaków], [Czy istnieją powiązane incydenty (Brak powiązanych incydentów, Istnieją powiązane incydenty)],
      [_CzyKandydatOdpowiedzialNaWszystkiePytania_], [53 znaki], [Czy kandydat odpowiedział na wszystkie pytania (Kandydat Nie Zdołał Odpowiedzieć Na Wszystkie Pytania, Kandydat Odpowiedział Na Wszystkie Pytania)],

    title("Pytanie", 3),
      subtitle("Krotka opisuje pytanie."),
      [_ID_Pytania_], [Liczbowa], [PK],
      [_TrescPytania_], [255 znaków], [Treść pytania],
  )
]

= Model Wymiarowy

== Definicje Faktów

1. *ZarezerwowanieTerminuPrzezKandydata*: Fakt zarezerwowania terminu na egzamin teoretyczny przez kandydata. Termin dotyczy egzaminu odbywającego się o konkretnej dacie i godzinie, w konkretnej sali egzaminacyjnej pod okiem konkretnego egzaminatora przez konkretnego kandydata.

Ziarnistość:
- konkretna data egzaminu
- konkretna godzina egzaminu
- konkretna sala egzaminacyjna
- konkretny egzaminator
- konkretny kandydat

Miary i funkcje agregujące:
- Liczba rezerwacji na termin - $"COUNT(*)"$
- Liczba różnych dni wśród terminów rezerwacji - $"COUNT(DISTINCT ID_TerminuEgzaminu)"$
- Liczba różnych kandydatów wśród terminów rezerwacji - $"COUNT(DISTINCT ID_Kandydata)"$
- Średnia liczba rezerwacji - $"Liczba rezerwacji na termin" slash "Liczba różnych dni wśród terminów rezerwacji"$
- Średni czas oczekiwania na egzamin - $"SUM(CzasOczekiwaniaNaEgzamin)" slash "Liczba rezerwacji na termin"$
- Średnia liczba rezerwacji na kandydata - $"Liczba rezerwacji na termin" slash "Liczba różnych kandydatów wśród terminów rezerwacji"$

2. *OdbycieSieEgzaminu*: Fakt odbycia się egzaminu teoretycznego odbywającego się o konkretnej dacie i godzinie, w konkretnej sali egzaminacyjnej pod okiem konkretnego egzaminatora wraz z konkretnym poziomem zajętości terminu.

Ziarnistość:
- konkretna data
- konkretna godzina
- konkretna sala egzaminacyjna
- konkretny egzaminator
- konkretny poziom zajętości terminu

Miary i funkcje agregujące:
- Liczba egzaminów - $"COUNT(*)"$
- Łączna liczba uczestników - $"SUM(LiczbaUczestników)"$
- Łączna liczba rezerwacji - $"SUM(LiczbaRezerwacjiNaTermin)"$
- Łączna liczba kandydatów nieobecnych - $"Łączna liczba rezerwacji" - "Łączna liczba uczestników"$

3. *ZlozenieSkargi*: Fakt złożenia skargi na przebieg egzaminu przez kandydata. Termin dotyczy egzaminu odbywającego się o konkretnej dacie i godzinie, w konkretnej sali egzaminacyjnej pod okiem konkretnego egzaminatora przez konkretnego kandydata. Fakt rozróżniany jest także przez typ egzaminu, typ skargi złożonej przez kandydata, czy podczas egzaminu wystąpiły incydenty, które zostały zgłoszone przez egzaminatorów oraz czy kandydat odpowiedział na wszystkie pytania.

Ziarnistość:
- konkretna data
- konkretna godzina
- konkretna sala egzaminacyjna
- konkretny egzaminator
- konkretny kandydat
- konkretny typ egzaminu
- konkretny typ skargi
- czy podczas egzaminu wystąpiły incydenty
- czy kandydat odpowiedział na wszystkie pytania

Miary i funkcje agregujące:
- Liczba skarg - $"COUNT(*)"$
- Liczba powiązanych incydentów - $"SUM(LiczbaPowiazanychIncydentow)"$
- Liczba kandydatów którzy złożyli skargi - $"COUNT(DISTINCT ID_Kandydata)"$

4. *OdpowiedzenieNaPytaniePodczasEgzaminuZeSkarga*: Fakt odpowiedzenia na pytanie przez kandydata podczas egzaminu na który złożył skargę. Termin dotyczy egzaminu odbywającego się o konkretnej dacie i godzinie, w konkretnej sali egzaminacyjnej pod okiem konkretnego egzaminatora przez konkretnego kandydata. Fakt rozróżniany jest także przez typ egzaminu, typ skargi złożonej przez kandydata, czy podczas egzaminu wystąpiły incydenty, które zostały zgłoszone przez egzaminatorów, czy kandydat odpowiedział na wszystkie pytania oraz treść pytania.

Ziarnistość:
- konkretna data
- konkretna godzina
- konkretna sala egzaminacyjna
- konkretny egzaminator
- konkretny kandydat
- konkretny typ egzaminu
- konkretny typ skargi
- czy podczas egzaminu wystąpiły incydenty
- czy kandydat odpowiedział na wszystkie pytania
- treść pytania

Miary i funkcje agregujące:
- Liczba pytań - $"COUNT(*)"$

== Definicje Wymiarów

#context [
  #let hierarchy(item1, item2, item3) = [
    • #item1 \
    •• #item2 \
    ••• #item3
  ]

  1. *ZarezerwowanieTerminuPrzezKandydata*

  #text(size: 10pt, table(
    columns: (auto, auto, auto),
    table.header([*Atrybut*], [*Tabela / Kolumna*], [*Typ*]),
    [*TerminEgzaminu*], [`TerminEgzaminu`], [Wymiar],
    [*Numer Sali Egzaminacyjnej*], [`TerminEgzaminu.NumerSaliEgzaminacyjnej`], [Atrybut Wymiaru],
    [*DataEgzaminu*], [`Data`], [Wymiar],
    [*Dzień Egzaminu*], [`Data.Data`], [Atrybut Wymiaru],
    [*Rok Egzaminu*], [`Data.Rok`], [Atrybut Wymiaru],
    [*Miesiąc Egzaminu*], [`Data.Miesiac`], [Atrybut Wymiaru],
    [*Dzień Tygodnia Egzaminu*], [`Data.DzienTygodnia`], [Atrybut Wymiaru],
    [*Hierarchia Daty Egzaminu*], [#hierarchy("Data.Rok", "Data.Miesiac", "Data.Data")], [Wymiar Hierachi],
    [*Czas Egzaminu*], [`Czas`], [Wymiar],
    [*Godzina Egzaminu*], [`Czas.Godzina`], [Atrybut Wymiaru],
    [*Egzaminator*], [`Egzaminator`], [Wymiar],
    [*Pesel Egzaminatora*], [`Egzaminator.Pesel`], [Atrybut Wymiaru],
    [*Imię i Nazwisko Egzaminatora*], [`Egzaminator.ImieINazwisko`], [Atrybut Wymiaru],
    [*Kandydat*], [`Kandydat`], [Wymiar],
    [*PKK Kandydata*], [`Kandydat.PKK_Kandydata`], [Atrybut Wymiaru]
  ))

  2. *OdbycieSieEgzaminu*

  #text(size: 10pt, table(
    columns: (auto, auto, auto),
    table.header([*Atrybut*], [*Tabela / Kolumna*], [*Typ*]),
    [*TerminEgzaminu*], [`TerminEgzaminu`], [Wymiar],
    [*Numer Sali Egzaminacyjnej*], [`TerminEgzaminu.NumerSaliEgzaminacyjnej`], [Atrybut Wymiaru],
    [*DataEgzaminu*], [`Data`], [Wymiar],
    [*Dzień Egzaminu*], [`Data.Data`], [Atrybut Wymiaru],
    [*Rok Egzaminu*], [`Data.Rok`], [Atrybut Wymiaru],
    [*Miesiąc Egzaminu*], [`Data.Miesiac`], [Atrybut Wymiaru],
    [*Dzień Tygodnia Egzaminu*], [`Data.DzienTygodnia`], [Atrybut Wymiaru],
    [*Hierarchia Daty Egzaminu*], [#hierarchy("Data.Rok", "Data.Miesiac", "Data.Data")], [Wymiar Hierachi],
    [*Czas Egzaminu*], [`Czas`], [Wymiar],
    [*Godzina Egzaminu*], [`Czas.Godzina`], [Atrybut Wymiaru],
    [*Egzaminator*], [`Egzaminator`], [Wymiar],
    [*Pesel Egzaminatora*], [`Egzaminator.Pesel`], [Atrybut Wymiaru],
    [*Imię i Nazwisko Egzaminatora*], [`Egzaminator.ImieINazwisko`], [Atrybut Wymiaru],
    [*Zajętość Terminu*], [`ZajetoscTerminuEgzaminu`], [Wymiar],
    [*Poziom Zajętości Terminu*], [`ZajetoscTerminuEgzaminu.ZajetoscTerminu`], [Atrybut Wymiaru]
  ))

  3. *ZlozenieSkargi*

    #text(size: 10pt, table(
    columns: (auto, auto, auto),
    table.header([*Atrybut*], [*Tabela / Kolumna*], [*Typ*]),
    [*TerminEgzaminu*], [`TerminEgzaminu`], [Wymiar],
    [*Numer Sali Egzaminacyjnej*], [`TerminEgzaminu.NumerSaliEgzaminacyjnej`], [Atrybut Wymiaru],
    [*DataEgzaminu*], [`Data`], [Wymiar],
    [*Dzień Egzaminu*], [`Data.Data`], [Atrybut Wymiaru],
    [*Rok Egzaminu*], [`Data.Rok`], [Atrybut Wymiaru],
    [*Miesiąc Egzaminu*], [`Data.Miesiac`], [Atrybut Wymiaru],
    [*Dzień Tygodnia Egzaminu*], [`Data.DzienTygodnia`], [Atrybut Wymiaru],
    [*Hierarchia Daty Egzaminu*], [#hierarchy("Data.Rok", "Data.Miesiac", "Data.Data")], [Wymiar Hierachi],
    [*Czas Egzaminu*], [`Czas`], [Wymiar],
    [*Godzina Egzaminu*], [`Czas.Godzina`], [Atrybut Wymiaru],
    [*Egzaminator*], [`Egzaminator`], [Wymiar],
    [*Pesel Egzaminatora*], [`Egzaminator.Pesel`], [Atrybut Wymiaru],
    [*Imię i Nazwisko Egzaminatora*], [`Egzaminator.ImieINazwisko`], [Atrybut Wymiaru],
    [*Kandydat*], [`Kandydat`], [Wymiar],
    [*PKK Kandydata*], [`Kandydat.PKK_Kandydata`], [Atrybut Wymiaru],
    [*Skarga*], [`Skarga`], [Wymiar],
    [*Typ Egzaminu*], [`Skarga.TypEgzaminu`], [Atrybut Wymiaru],
    [*Typ Skargi*], [`Skarga.TypSkargi`], [Atrybut Wymiaru],
    [*Czy Istnieją Powiązane Incydenty*], [`Skarga.CzyIstniejaPowiazaneIncydenty`], [Atrybut Wymiaru],
    [*Czy Kandydat Odpowiedział Na Wszystkie Pytania*], [`Skarga
.CzyKandydatOdpowiedzialNaWszystkiePytania`], [Atrybut Wymiaru],
    [*Hierarchia Skargi*], [#hierarchy("Typ Egzaminu", "Typ Skargi", "Czy Istnieją Powiązane Incydenty")], [Wymiar Hierachi]
  ))

  4. *OdpowiedzenieNaPytaniePodczasEgzaminuZeSkarga*

      #text(size: 10pt, table(
    columns: (auto, auto, auto),
    table.header([*Atrybut*], [*Tabela / Kolumna*], [*Typ*]),
    [*TerminEgzaminu*], [`TerminEgzaminu`], [Wymiar],
    [*Numer Sali Egzaminacyjnej*], [`TerminEgzaminu.NumerSaliEgzaminacyjnej`], [Atrybut Wymiaru],
    [*DataEgzaminu*], [`Data`], [Wymiar],
    [*Dzień Egzaminu*], [`Data.Data`], [Atrybut Wymiaru],
    [*Rok Egzaminu*], [`Data.Rok`], [Atrybut Wymiaru],
    [*Miesiąc Egzaminu*], [`Data.Miesiac`], [Atrybut Wymiaru],
    [*Dzień Tygodnia Egzaminu*], [`Data.DzienTygodnia`], [Atrybut Wymiaru],
    [*Hierarchia Daty Egzaminu*], [#hierarchy("Data.Rok", "Data.Miesiac", "Data.Data")], [Wymiar Hierachi],
    [*Czas Egzaminu*], [`Czas`], [Wymiar],
    [*Godzina Egzaminu*], [`Czas.Godzina`], [Atrybut Wymiaru],
    [*Egzaminator*], [`Egzaminator`], [Wymiar],
    [*Pesel Egzaminatora*], [`Egzaminator.Pesel`], [Atrybut Wymiaru],
    [*Imię i Nazwisko Egzaminatora*], [`Egzaminator.ImieINazwisko`], [Atrybut Wymiaru],
    [*Kandydat*], [`Kandydat`], [Wymiar],
    [*PKK Kandydata*], [`Kandydat.PKK_Kandydata`], [Atrybut Wymiaru],
    [*Skarga*], [`Skarga`], [Wymiar],
    [*Typ Egzaminu*], [`Skarga.TypEgzaminu`], [Atrybut Wymiaru],
    [*Typ Skargi*], [`Skarga.TypSkargi`], [Atrybut Wymiaru],
    [*Czy Istnieją Powiązane Incydenty*], [`Skarga.CzyIstniejaPowiazaneIncydenty`], [Atrybut Wymiaru],
    [*Czy Kandydat Odpowiedział Na Wszystkie Pytania*], [`Skarga
.CzyKandydatOdpowiedzialNaWszystkiePytania`], [Atrybut Wymiaru],
    [*Hierarchia Skargi*], [#hierarchy("Typ Egzaminu", "Typ Skargi", "Czy Istnieją Powiązane Incydenty")], [Wymiar Hierachi],
    [*Pytanie*], [`Pytanie`], [Wymiar],
    [*Treść Pytania*], [`Pytanie.TrescPytania`], [Atrybut Wymiaru]
  ))
]

== Sprawdzenie Możliwości Implementacji Zapytań Analitycznych Na Modelu Wymiarowym

=== Porównaj średni czas oczekiwania na egzamin teoretyczny w tym i poprzednim miesiącu. (KPI 1)

Miara: _Średni czas oczekiwania na egzamin_

Wymiar: _Data Egzaminu_ (atrybuty: Miesiąc Egzaminu)

=== Porównaj liczbę skarg w tym i poprzednim miesiącu. (KPI 2)

Miara: _Liczba skarg_

Wymiar: _Data Egzaminu_ (atrybuty: Miesiąc Egzaminu)

=== Porównaj średnią liczbę zarezerwowanych terminów egzaminów teoretycznych na przestrzeni dni tygodnia.

Miara: _Średnia liczba rezerwacji na termin_

Wymiar: _Data Egzaminu_ (atrybuty: Dzień Tygodnia Egzaminu)

=== Podaj jak dużo kandydatów nie pojawiło się na egzaminie w tym i poprzednim miesiącu.

Miara: _Liczba egzaminów_

Wymiar: _Wynik Egzaminu_

Wymiar: _Data Egzaminu_ (atrybuty: Miesiąc Egzaminu)

=== Jaka jest średnia liczba podejść do egzaminu na jednego kandydata w tym i poprzednim miesiącu?

Miara: _Średnia liczba podejść do egzaminu_

Wymiar: _Wymiar_TerminEgzaminuKandydata_ (atrybuty: PKK_Kandydata)

Wymiar: _Data Egzaminu_ (atrybuty: Miesiąc Egzaminu)

=== Jak dużo terminów egzaminów zostało w pełni zarezerwowanych w tym i poprzednim miesiącu?

Miara: _Liczba rezerwacji_

Wymiar: _CzyTerminJestPelnyPoTejRezerwacji_

=== Porównaj liczbę skarg technicznych w relacji do sal w których odbywają się egzaminy.

Miara: _Liczba skarg_

Wymiar: _Wymiar_Junk_ (atrybuty: Typ Skargi)

Wymiar: _Wymiar_TerminEgzaminuKandydata_ (atrybuty: NumerSaliEgzaminacyjnej)

=== Jakie pytania pojawiały się najczęściej w egzaminach do których złożono skargi związane z treścią pytań?

Miara: _Liczba odpowiedzi na pytania_

Wymiar: _TypSkargi_

=== Jacy egzaminatorzy byli najczęściej związani ze złożeniem skargi?

Miara: _Liczba skarg_

Wymiar: _Wymiar_Egzaminator_ (atrybuty: Pesel)

=== Podaj liczbę skarg złożonych w egzaminach w których nie wystąpiły żadne incydenty zgłoszone przez egzaminatorów.

Miara: _Liczba skarg_

Wymiar: _Wymiar_Junk_ (atrybuty: IncydentyPodczasEgzaminu)

=== Jak dużo kandydatów nie zdołało odpowiedzieć na wszystkie pytania w egzaminie i złożyło skargę z kategorii “związana z treścią pytań” lub “inne”?

Miara: _Liczba skarg_

Wymiar: _Wymiar_Junk_ (atrybuty: KandydatOdpowiedzialNaWszystkiePytania, TypSkargi)

== Sprawdzenie Możliwości Zasilienia Hurtowni Danych Za Pomocą Danych Źródłowych

TODO