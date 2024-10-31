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
  #image("./mermaid-diagram-2024-10-31-202753.svg")
  #link("https://mermaid.live/edit#pako:eNq1Vttu2kAQ_RVrn0kEAcrlrQlNldJSFCKlQkjRxJ7CxvYuWtui3oAURc1HtE3-pI_hR_IlXTt2ssaG0CrliZ05c_bM7Fnbl8TkFpI2QdGhMBbgjpihfqehS0GcdcAH4_IxFP2-GEedx-CI9LsjomeisL4-5ra-_ETRo2DqoV7gokjimdKOpMhOwjG3GIVcRUcFi5Kfbe5QUzIczCj6XEnc58vfyEBwSyKjaMyNU4qODYyb6v--APu5aMyN5c8Zvf-hukj6WmRmcSDBy80iDuZn8V7tSBkU0bwbS3BVzucix6bn8qR99NDJVLgUj3ogZ9SzuZ44kOFb2w_AYVgk4USgZ_ZDH9QAcxrSeH7_uGxDS4VGSXKB4jvs6rbKciejLERHiRxaGxVk0FpiZXzd7lkXmBVaK0btiQE4tKixDwGzc10NbBBjiFMFMwqncZ6q3MPVrTqa-xsJDAxp-GhOWGS10DWmQuI5xTFF18Ck54eru5KxWiNw-ctUa2OqjmX5vQiDzw2jmwIoY5j8v-sp51vcD00ZqlVW7zHKwPHB1wavqtMxGdGlUVpDz7-_mdLlteLR9N7GWz2BpQXL65KRKY5jCXKjkMSvMIQLdXc9MyvoQLGE6c6GBIESxYzPgIWpDEVuvohaIyE59UOw_eR4113NoMhrOXNG_h46PHrowJMdtrD_hprCS5CY8BkVBbKoj8px57EYzkJzcsTM0ELm81m-88ebj31umdpVHOJrTGQLpQqVeTDpaD1RdGjH8UmDefE_ZeobrnvkvfZQomP_bEq06QyeXndKSN6wC76zM5-vbNlW9CnhenDkxwi5-zI00rMlNGom3X97l23Xxl-R6EL-jUG3X0FLmvu2k7-2YM3MUrdtx16MzlOvvL3nhZ5ImTeCU1dsBdZe0HoNKRH1becCtdTXaHytRsSfoIsjEsEsEPHVWCgcBD4fhMwkbV8EWCKCB-MJaX8Fx1OrYKpePph8zaaQKTDSviTfSLtSq-w2W-VWq7JXKbeqjXqJhKRdrVd3m7Vaq1FulKuVvfqiRCTnqryswM1qtVatNxrNVuVNrRqTDeNkxL34A1kWuk8")[_Link do diagramu_]
]

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