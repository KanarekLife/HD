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
  /* https://mermaid.live/edit#pako:eNqtVutu2kgUfhVrfrWSE4VLDOVfW7YVYkOshqoVQqpO7LMwGGYiX8SOk_yJWvUZqj7GPsKG9-rYMza-sUmz4QfgOd855ztXzzVxuItkQNAfUlj4sJkzQ35m4GOM_pZvgVGcor-hLLL9GOMxMFe4EIJxraDJ57MxGn7RqD8WMSS_xrtxBbBXLYrOEILIR-NtDMG5E6NHE5_waSi_nKXC3aqfc_dSOBQvKOZOfpvEDFYY8sCh_4XMOP1JnfgSPqSpAGdFJ6C06sgz8AKxgTUDpfNRRhKEjHp8e8hsDaKjnK15jDLrFx74C_pcaU5F2uThUG2-pRADE85yxBzhIgsr7M7dK4lBN6U4AVuESYfY3HVk_TJSM0UenpW8cvVwVJKo-jNs6lJ5KIw5scdzUpQk2OLzB-4VH88oBrIdi0eTaIO-Pi-pDmOKbCoW3JVsaxpJW5eFOrFJ_9fYJodRA9333I0pKxvQSYWQ-zU7BRk0mLMxwLU8f1M5H20ojiYQb2ng8aLgbSxee2Ek-x1LHFR9Hz2d9rihOoebI83GYXEpyLI0Tf0FrGmGccSK4arEPWu9Gut9T9p1o_Z4XJ5evV-qoV4_dg-VfVTMyRq9sKMgFKYswf2P3U-H8i2X9dvdMXmmfl9mRdSUDsyiHpuyv6m4yplIX1PkPobCiVPrPnjq_8tym0glbSxVcZaMJigjeWFcUlyYxtTH3c_770Yyw7uvZrFXTWPEGFYsyv4aJbsRV_lKwmwhJeP74o3kYiSb6P6bWlcG1eJ__9lKk0r5_tsegzlC1J1lJc63G4X1BD4FsQhCT643vXqk47xLJhSNmct3d7C7229FijLKCRi5qqF1zX1_FZxI1SZwtYJ6y9ZKmPGq1NDHwKnswspg3twcHd3cqA05kGFl_pph6Wp6GFZcQEX0Yy4T2kSeoyfqV4gVrTRcHv6P0qE5LxEvv8kfdtes0JyURqge9XIIv_PCfkxKnmCvMYQnWXquCLORUoaISeQu3wB15V04nbI5CZe4wTlJANslDTFxdyuBEIX8QjCHDEI_QpP4PFosyeAvWAfyKbqSYaK-TOenV8DI4Jr8TQZHLavTO7ZOuu1u_6Rr9XunJhFk0Om0j3ttq2_1rN5pr99qn96aJOZcmmgfW51Oq_vqlXXS6nX7nZaV2pulQkUBXSqH7kxd5dMb_e0vzaTYnA */
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
      [_ID_Data Egzaminu_], [Liczbowa], [FK Data, Data egzaminu],
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
    [*Termin Egzaminu*], [`TerminEgzaminu`], [Wymiar],
    [*Numer Sali Egzaminacyjnej*], [`TerminEgzaminu.NumerSaliEgzaminacyjnej`], [Atrybut Wymiaru],
    [*Data Egzaminu*], [`Data`], [Wymiar],
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
    [*Termin Egzaminu*], [`TerminEgzaminu`], [Wymiar],
    [*Numer Sali Egzaminacyjnej*], [`TerminEgzaminu.NumerSaliEgzaminacyjnej`], [Atrybut Wymiaru],
    [*Data Egzaminu*], [`Data`], [Wymiar],
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
    [*Termin Egzaminu*], [`TerminEgzaminu`], [Wymiar],
    [*Numer Sali Egzaminacyjnej*], [`TerminEgzaminu.NumerSaliEgzaminacyjnej`], [Atrybut Wymiaru],
    [*Data Egzaminu*], [`Data`], [Wymiar],
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
    [*Termin Egzaminu*], [`TerminEgzaminu`], [Wymiar],
    [*Numer Sali Egzaminacyjnej*], [`TerminEgzaminu.NumerSaliEgzaminacyjnej`], [Atrybut Wymiaru],
    [*Data Egzaminu*], [`Data`], [Wymiar],
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

Miara: _Średnia liczba rezerwacji_

Wymiar: _Data Egzaminu_ (atrybuty: Dzień Tygodnia Egzaminu)

=== Podaj jak dużo kandydatów nie pojawiło się na egzaminie w tym i poprzednim miesiącu.

Miara: _Liczba kandydatów nieobecnych_

Wymiar: _Data Egzaminu_ (atrybuty: Miesiąc Egzaminu)

=== Jaka jest średnia liczba podejść do egzaminu na jednego kandydata w tym i poprzednim miesiącu?

Miara: _Średnia liczba rezerwacji na kandydata_

Wymiar: _Data Egzaminu_ (atrybuty: Miesiąc Egzaminu)

=== Jak dużo terminów egzaminów zostało w pełni zarezerwowanych w tym i poprzednim miesiącu?

Miara: _Liczba egzaminów_

Wymiar: _Data Egzaminu_ (atrybuty: Miesiąc Egzaminu)

Wymiar: _Zajętość Terminu_ (atrybuty: Poziom Zajętości Terminu)

=== Porównaj liczbę skarg technicznych w relacji do sal w których odbywają się egzaminy.

Miara: _Liczba skarg_

Wymiar: _Termin Egzaminu_ (atrybuty: Numer Sali Egzaminacyjnej)

=== Jakie pytania pojawiały się najczęściej w egzaminach do których złożono skargi związane z treścią pytań?

Miara: _Liczba pytań_

Wymiar: _Skarga_ (atrybuty: Typ Skargi)

=== Jacy egzaminatorzy byli najczęściej związani ze złożeniem skargi?

Miara: _Liczba pytań_

Wymiar: _Egzaminator_ (atrybuty: Pesel Egzaminatora, ImieINazwisko Egzaminatora)

=== Podaj liczbę skarg złożonych w egzaminach w których nie wystąpiły żadne incydenty zgłoszone przez egzaminatorów.

Miara: _Liczba skarg_

Wymiar: _Skarga_ (atrybuty: Czy Istnieją Powiązane Incydenty)

=== Jak dużo kandydatów nie zdołało odpowiedzieć na wszystkie pytania w egzaminie i złożyło skargę z kategorii “związana z treścią pytań” lub “inne”?

Miara: _Liczba kandydatów którzy złożyli skargi_

Wymiar: _Skarga_ (atrybuty: Typ Skargi, Czy Kandydat Odpowiedział Na Wszystkie Pytania)

== Sprawdzenie Możliwości Zasilienia Hurtowni Danych Za Pomocą Danych Źródłowych

#context [
  #set text(size: 10pt)
  #let title(content, n) = [#table.cell(rowspan: n, align(center)[#rotate(90deg, reflow: true)[* #content *]])]
  #let subtitle(content) = [#table.cell(colspan: 2, align(center)[* #content *])]
  
  #table(
    columns: (auto, auto, auto),
    table.header([*Tabela*], [*Kolumna*], [*Source*]),

    title("ZarezerwowanieTerminuPrzezKandydata", 4),
      subtitle("Krotka opisuje fakt zarezerwowania terminu na egzamin teoretyczny przez kandydata."),
      [_ID_TerminuEgzaminu_], [Klucz obcy do tabeli `TerminEgzaminu`. Oparty na wartościach (dacie, czasie, sali egzaminacyjnej oraz egzaminatorze) z tabeli `EgzaminyTeoretyczne` powiązanej z tabelą `PrzebiegiEgzaminowKandydata`.],
      [_ID_Kandydata_], [Klucz obcy do tabeli `Kandydat`. Oparty na wartościach z tabeli `PKKKandydata` z tabeli `PrzebiegiEgzaminowKandydata`.],
      [_CzasOczekiwaniaWDniach_], [Różnica między datą rezerwacji a datą egzaminu. Obliczane na podstawie `CzasRezerwacjiTerminu` z `PrzebiegiEgzaminowKandydata` oraz `ZaplanowanyTermin` z `EgzaminyTeoretyczne`.],

    title("OdbycieSieEgzaminu", 6),
      subtitle("Krotka opisuje fakt odbycia się egzaminu."),
      [_ID_TerminuEgzaminu_], [Klucz obcy do tabeli `TerminEgzaminu`. Oparty na wartościach (dacie, czasie, sali egzaminacyjnej oraz egzaminatorze) z tabeli `EgzaminyTeoretyczne` powiązanej z tabelą `PrzebiegiEgzaminowKandydata`.],
      [_ID_ZajetosciTerminuEgzaminu_], [Klucz obcy do tabeli `ZajetoscTerminuEgzaminu`. Oparty na ilości rezerwacji na termin (liczba `PrzebiegówEgzaminowKandydata` na dany z `EgzaminyTeoretyczne`) oraz na maksymalnej liczbie uczestników przypadającej na termin (pojemność sali egzaminacyjnej) wynikającą z ilości połączeń danej sali z tabeli `SaleEgzaminacyjne` ze stanowiskami z tabeli `StanowiskaEgzaminacyjne`.],
      [_LiczbaRezerwacjiNaTermin_], [Liczba `PrzebiegówEgzaminowKandydata` przyporządkowanych do danego terminu z `EgzaminyTeoretyczne`.],
      [_MaksymalnaLiczbaUczestnikow_], [Pojemność sali egzaminacyjnej, wynikająca z ilości połączeń danej sali z tabeli `SaleEgzaminacyjne` ze stanowiskami z tabeli `StanowiskaEgzaminacyjne`.],
      [_LiczbaUczestnikow_], [Liczba `PrzebiegówEgzaminowKandydata` przyporządkowanych do danego terminu z `EgzaminyTeoretyczne` z wartością `CzasRozpoczeciaEgzaminu` będącą różną od NULL.],

    title("ZlozenieSkargi", 5),
      subtitle("Krotka opisuje fakt złożenia skargi na przebieg egzaminu przez kandydata."),
      [_ID_TerminuEgzaminu_], [Klucz obcy do tabeli `TerminEgzaminu`. Oparty na wartościach (dacie, czasie (`Termin egzaminu`) oraz egzaminatorze (`Pesel Egzaminatora`)) z excela dot. skarg (_Arkusz 1_)],
      [_ID_Kandydata_], [Klucz obcy do tabeli `Kandydat`. Oparty na wartości `PKK Kandydata` z excela dot. skarg (_Arkusz 1_).],
      [_ID_Skargi_], [Klucz obcy do tabeli `Skarga`. Oparty na wartościach z kolumn `Typ Egzaminu`, `Typ Skargi` z excela dot. skarg (_Arkusz 1_). Z powiązanego ze skargą egzaminu pozyskujemy wartości `Czy Istnieją Powiązane Incydenty` (liczba wierszy z tabeli `Incydenty` powiązanej z egzaminem) oraz `Czy Kandydat Odpowiedział Na Wszystkie Pytania` (powiązanie skargi po `PKK Kandydata` i `Terminie Egzaminu` z excela do `PrzebiegiEgzaminowKandydata` oraz `ZaplanowanePytania` i wyciągnięcie listy pytań z `CzyZostalaUdzielonaPoprawnaOdpowiedz` równym NULL).],
      [_LiczbaPowiazanychIncydentow_], [Liczba wierszy z tabeli `Incydenty` powiązanej z egzaminem z tabeli `EgzaminTeoretyczny`.],

    title("OdpowiedzenieNaPytaniePodczasEgzaminuZeSkarga", 5),
      subtitle("Krotka opisuje odpowiedzenie na pytanie przez kandydata podczas egzaminu, na który złożył skargę."),
      [_ID_TerminuEgzaminu_], [Klucz obcy do tabeli `TerminEgzaminu`. Oparty na wartościach (dacie, czasie (`Termin egzaminu`) oraz egzaminatorze (`Pesel Egzaminatora`)) z excela dot. skarg (_Arkusz 1_)],
      [_ID_Kandydata_], [Klucz obcy do tabeli `Kandydat`. Oparty na wartości `PKK Kandydata` z excela dot. skarg (_Arkusz 1_).],
      [_ID_Pytania_], [Klucz obcy do tabeli `Pytania`. Oparty na wartości `Dane` z tabeli `Pytania`, powiązanej z tabelą `ZaplanowanePytania` (powiązanej na podstawie `PKK Kandydata` i `Terminu Egzaminu` z excela dot. skarg (_Arkusz 1_).)],
      [_ID_Skargi_], [Klucz obcy do tabeli `Skargi`. Oparty na wartościach z kolumn `Typ Egzaminu`, `Typ Skargi` z excela dot. skarg (_Arkusz 1_).],

    title("Data", 1),
      subtitle("Krotka opisuje datę. Dane generowane są na podstawie dowolnego kalendarza przed procesem ETL."),

    title("Czas", 1),
      subtitle("Krotka opisuje czas (niezależnie od daty). Dane generowane przed procesem ETL."),

    title("Egzaminator", 5),
      subtitle("Krotka opisuje egzaminatora."),
      [_ID_Egzaminatora_], [PK - generowane przez bazę danych],
      [_PESEL_], [Wartość `Pesel` z tabeli `Egzaminatorzy`],
      [_ImieINazwisko_], [Wartość `Nazwa` z tabeli `Egzaminatorzy`],
      [_CzyAktualne_], ["1" jeżeli informacja jest aktualna, "0" jeżeli nieaktualna (implementacja SCD2)],

    title("TerminEgzaminu", 6),
      subtitle("Krotka opisuje termin egzaminu."),
      [_ID_TerminuEgzaminu_], [PK - generowane przez bazę danych],
      [_ID_Data Egzaminu_], [Klucz obcy do tabeli `Data`. Oparty na datach z tabeli `EgzaminyTeoretyczne`],
      [_ID_CzasEgzaminu_], [Klucz obcy do tabeli `Czas`. Oparty na datach z tabeli `EgzaminyTeoretyczne`],
      [_ID_Egzaminatora_], [Klucz obcy do tabeli `Egzaminator`. Oparty na powiązaniach wierszy tabeli `EgzaminyTeoretyczne` z tabelą `Egzaminatorzy`],
      [_NumerSaliEgzaminacyjnej_], [Wartość `NumerSali` z tabeli `SaleEgzaminacyjne`],

    title("Kandydat", 3),
      subtitle("Krotka opisuje kandydata."),
      [_ID_Kandydata_], [PK - generowane przez bazę danych],
      [_PKK_Kandydata_], [Wartość `PKK` z tabeli `Kandydaci`],

    title("ZajetoscTerminuEgzaminu", 3),
      subtitle("Krotka opisuje zajętość terminu egzaminu."),
      [_ID_ZajetosciTerminuEgzaminu_], [PK - generowane przez bazę danych],
      [_ZajetoscTerminu_], [Wartości `Pusty`, `Częściowo Pełny`, `Pełny`],

    title("Skarga", 6),
      subtitle("Krotka opisuje skargę."),
      [_ID_Skargi_], [PK - generowane przez bazę danych],
      [_TypEgzaminu_], [Generowany na podstawie kolumny `Typ Egzaminu` z excela],
      [_TypSkargi_], [Generowany na podstawie kolumny `Typ Skargi` z excela],
      [_CzyIstniejaPowiazaneIncydenty_], [Wartości `Brak powiązanych incydentów`, `Istnieją powiązane incydenty`],
      [_CzyKandydatOdpowiedzialNaWszystkiePytania_], [Wartości `Kandydat Nie Zdołał Odpowiedzieć Na Wszystkie Pytania`, `Kandydat Odpowiedział Na Wszystkie Pytania`],

    title("Pytanie", 3),
      subtitle("Krotka opisuje pytanie."),
      [_ID_Pytania_], [PK - generowane przez bazę danych],
      [_TrescPytania_], [Generowana na podstawie wartości `Dane` z tabeli `Pytania`]
  )
]