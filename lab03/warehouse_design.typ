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
  #image("./mermaid-diagram-2024-11-02-124243.svg")
  #link("https://mermaid.live/edit#pako:eNq1Vttu2kAQ_ZXVPjsRgUCAtza0VZJCUEBKhZCiwZ7CYryLfBFdB17yb_mvjm0MNjZNQlS_WJ6dOXM7M95nbioLeZuj2xEwdcEZS0bPo3YEuE8d8IE9J6Lo-cVuOolwzPt3Y549icTZ7wdlZz-7Aj0BZlbUCxx0t_KcaScUKId6qiwpoGDRIWH-cDOWubCvQ_AKYcfCYtg_lBUKeQTo2zQEh0595RbwsmdF2D56uMhZOAJvehCuhGer7MF1qL_YfgALieVB9LUPUmAhgERe1oqhi55ZDjZEl4Lexh7cgbS0VdbkRC8oKha9bSmRqpaU_chRpoK5Lvfv7p52DgvtH8BCpJamnkuc7zJ9R57r9dnZep3jd5tySjP6kHXMqJOts_xJQXIwt4G0C32JhHtRRzhsqJcDG9ypIAwfzZkUZig1W7ohTgRODeZHbGDLiC0Gw71XgwlJnON5uBtpagulr_vKMjO9I_SvLti7c7ViWw2WqhhsNF0oL1RS7WEKWocO0_rcW0u1EkjTCIsePHqh9nxb4J7lqSLr0TCMLPX6Aq8vbG-GJusB2xmyraWx88CyLkp109h2U_MdbP9pBC6G6KpVNIYHg_HuwcknTUOfKN6i5_dxIancQ5w_RH5WYM6jZlKaS3x9kdqgbRK9s5XrIniBi-wndXsCe7seJLgHcLkReTupPFOP8TnP2hj13ppoU-BA4CcL9KilsDPci3ru-bAS1HJPoBGTILSIAcS66FVWnGhA780QbRFlCb10Rx0rI5Fqon1tzvo0ZcTwol4XbE87tKshsdgqdlRsamZ-SP8qycnlHS1UiNSvZOB70N8O-SeKXbJV8kXZD3w63VGB8suhhF5vRfqxGpyKG-_QUp7uNoFUhJL8Yg-yGiVe4NSqpkvlf6zrzcnJnFj4zzhJbzAJKDc4_cYdEBbdO-PSUiVm6FBukcJqJvw4zQ0pQuCrgZYmb_tugAZ3VTCd8fZvWHj0FSwpVtxeXHfSJUjefuZ_ePusVmucV-vVZq15Ubu8atQbBte8fXF5Xr1qNC8r1Uqr1ai0as2NwUOlCKJ23ryqt2r1-kW1VW9Waq2rGG8UHyYhoCWoG93k2hzfnjd_AXTDw2c")[_Link do diagramu_]
]

#table(
  columns: (auto, auto, auto, auto),
  table.header([*Tabela*], [*Atrybut*], [*Typ*], [*Opis*]),
  table.cell(rowspan: 4)[#align(center)[#rotate(90deg, reflow: true)[*Fakt_ZarezerwowanieTerminuEgzaminu*]]],
    table.cell(colspan: 3)[*Jedna krotka opisuje fakt zarezerwowania terminu egzaminu przez kandydata.*],
    [_ID_TerminuEgzaminuKandydata_], [Liczbowa], [FK Wymiar_TerminEgzaminuKandydata],
    [_CzyTerminJestPelnyPoTejRezerwacji_], [8 znaków], [Czy termin jest pełny po tej rezerwacji ("Niepełny" lub "Pełny")],
    [_LiczbaRezerwacjiNaTerminPoTejRezerwacji_], [Liczbowa], [Liczba rezerwacji na termin po tej rezerwacji],
  table.cell(rowspan: 6)[#align(center)[#rotate(90deg, reflow: true)[*Fakt_OdbycieSieEgzaminu*]]],
    table.cell(colspan: 3)[*Jedna krotka opisuje fakt odbycia się (lub nie) egzaminu kandydata.*],
    [_ID_TerminuEgzaminuKandydata_], [Liczbowa], [FK Wymiar_TerminEgzaminuKandydata],
    [_WynikEgzaminu_], [14 znaków], [Wynik egzaminu ("Nie stawił się", "Nie zdał" lub "Zdał")],
    [_CzasOczekiwaniaNaEgzamin_], [Liczbowa], [Czas oczekiwania na egzamin (czas pomiędzy rezerwacją a odbyciem się egzaminu) w dniach],
    [_LiczbaZdobytychPunktow_], [Liczbowa], [Liczba zdobytych punktów na egzaminie],
    [_MaksymalnaLiczbaPunktow_], [Liczbowa], [Maksymalna liczba punktów do zdobycia na egzaminie],
  table.cell(rowspan: 4)[#align(center)[#rotate(90deg, reflow: true)[*Fakt_OdpowiedzianoNaPytaniePodczasEgzaminuZeSkarga*]]],
    table.cell(colspan: 3)[*Jedna krotka opisuje odpowiedzenie na pytanie przez kandydata podczas egzaminu na który złożył skargę.*],
    [_ID_TerminuEgzaminuKandydata_], [Liczbowa], [FK Wymiar_TerminEgzaminuKandydata],
    [_ID_Pytania_], [Liczbowa], [FK Wymiar_Pytanie],
    [_TypSkargi_], [43 znaki], [Typ skargi złożonej przez kandydata (“związana z technicznym przebiegiem egzaminu”, “związana z treścią pytań”, “związana z egzaminatorem”, “inne”)],
  table.cell(rowspan: 4)[#align(center)[#rotate(90deg, reflow: true)[*Fakt_ZlozenieSkargiNaPrzebiegEgzaminu*]]],
    table.cell(colspan: 3)[*Jedna krotka opuisuje złożenie skargi na przebieg egzaminu przez kandydata*],
    [_ID_TerminuEgzaminuKandydata_], [Liczbowa], [FK Wymiar_TerminEgzaminuKandydata],
    [_ID_Junk_], [Liczbowa], [FK Wymiar_Junk],
    [_LiczbaIncydentowZgloszonychPodczasEgzaminu_], [Liczbowa], [Liczba incydentów zgłoszonych podczas egzaminu przez egzaminatorów],
  table.cell(rowspan: 7)[#align(center)[#rotate(90deg, reflow: true)[*Wymiar_TerminEgzaminuKandydata*]]],
    table.cell(colspan: 3)[*Jedna krotka opisuje termin egzaminu (konkretna sala, egzaminator, data oraz czas) zarezerwowany przez kandydata.*],
    [_ID_TerminuEgzaminuKandydata_], [Liczbowa], [PK],
    [_ID_DataEgzaminu_], [Liczbowa], [FK Wymiar_Data, Data egzaminu],
    [_ID_CzasEgzaminu_], [Liczbowa], [FK Wymiar_Czas, Czas egzaminu],
    [_ID_Egzaminatora_], [Liczbowa], [FK Wymiar_Egzaminator, Egzaminator],
    [_PKK_Kandydata_], [20 znaków], [Numer PKK identyfikujący kandydata (BK)],
    [_NumerSaliEgzaminacyjnej_], [3 znaki], [Numer sali egzaminacyjnej (liczba całkowita w zakresie 000 - 999 w postaci tekstowej)],
  table.cell(rowspan: 3)[#align(center)[#rotate(90deg, reflow: true)[*Wymiar_Pytanie*]]],
    table.cell(colspan: 3)[*Jedna krotka opisuje pytanie z egzaminu teoretycznego.*],
    [_ID_Pytania_], [Liczbowa], [PK],
    [_TrescPytania_], [255 znaków], [Treść pytania],
  table.cell(rowspan: 5)[#align(center)[#rotate(90deg, reflow: true)[*Wymiar_Junk*]]],
    table.cell(colspan: 3)[*Krotki opisują wszystkie możliwe kombinacje typu skargi, indycentów podczas egzaminu oraz odpowiedzenia na wszystkie pytania przez kandydata*],
    [_ID_Junk_], [Liczbowa], [PK],
    [_TypSkargi_], [43 znaki], [Typ skargi złożonej przez kandydata (“związana z technicznym przebiegiem egzaminu”, “związana z treścią pytań”, “związana z egzaminatorem”, “inne”)],
    [_IncydentyPodczasEgzaminu_], [36 znaków], [Czy podczas egzaminu wystąpiły incydenty, które zostały zgłoszone przez egzaminatorów ("Brak Incydentow Podczas Egzaminu", "Zgloszono Incydenty Podczas Egzaminu")],
    [_KandydatOdpowiedzialNaWszystkiePytania_], [53 znaki], [Czy kandydat odpowiedział na wszystkie pytania ("Kandydat Nie Zdołał Odpowiedziec Na Wszystkie Pytania", "Kandydat Odpowiedzial Na Wszystkie Pytania")],
  table.cell(rowspan: 8)[#align(center)[#rotate(90deg, reflow: true)[*Wymiar_Data*]]],
    table.cell(colspan: 3)[*Jedna krotka opisuje datę.*],
    [_ID_Data_], [Liczbowa], [PK],
    [_Data_], [10 znaków], [Data w formacie "RRRR-MM-DD"],
    [_Rok_], [4 znaków], [Rok w formacie "RRRR"],
    [_Miesiac_], [11 znaków], [Nazwa miesiąca ("Styczeń", "Luty", "Marzec", "Kwiecień", "Maj", "Czerwiec", "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień")],
    [_NumerMiesiaca_], [2 znaki], [Numer miesiąca w formacie "MM"],
    [_DzienTygodnia_], [9 znaków], [Nazwa dnia tygodnia ("Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota", "Niedziela")],
    [_NumerDniaTygodnia_], [1 znak], [Numer dnia tygodnia (1 - poniedziałek, 7 - niedziela)],
  table.cell(rowspan: 3)[#align(center)[#rotate(90deg, reflow: true)[*Wymiar_Czas*]]],
    table.cell(colspan: 3)[*Jedna krotka opisuje czas.*],
    [_ID_Czasu_], [Liczbowa], [PK],
    [_Godzina_], [5 znaków], [Czas w formacie "HH:MM"],
  table.cell(rowspan: 5)[#align(center)[#rotate(90deg, reflow: true)[*Wymiar_Egzaminator*]]],
    table.cell(colspan: 3)[*Jedna krotka opisuje egzaminatora.*],
    [_ID_Egzaminatora_], [Liczbowa], [PK],
    [_PESEL_], [11 znaków], [PESEL egzaminatora (BK)],
    [_ImieINazwisko_], [255 znaków], [Imię i nazwisko egzaminatora],
    [_CzyAktualne_], [boolean], [Czy krotka jest najbardziej aktualną (Implementacja SCD 2)]
)

= Model Wymiarowy

== Definicje Faktów

1. *Fakt Egzaminu*: Ukończenie podejścia (lub nie przystąpienie) do egzaminu teoretycznego w określonym terminie przez kandydata w sali egzaminacyjnej pod nadzorem egzaminatora.

Tabela: `Fakt_Egzamin`

Ziarnistość:
- określona data egzaminu
- określony czas egzaminu
- określony egzaminator
- określony kandydat
- określona sala egzaminacyjna
- określony rezultat egzaminu
- określona "zajętość egzaminu" (jak dużo osób przystąpiło do egzaminu w danym terminie)

Miary i funkcje agregujące:


== Definicje Wymiarów

== Sprawdzenie Możliwości Implementacji Zapytań Analitycznych Na Modelu Wymiarowym

== Sprawdzenie Możliwości Zasilienia Hurtowni Danych Za Pomocą Danych Źródłowych