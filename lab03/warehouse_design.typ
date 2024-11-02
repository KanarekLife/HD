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
  #image("./mermaid-diagram-2024-11-02-122107.svg")
  #link("https://mermaid.live/edit#pako:eNq1VttO20AQ_ZXVPhsUzMVp3lrSVkAJEUSiipDQYE_D4ng38kXpmuSFf-O_OmvHjh07pQTVL5bnvmfOjPeZu8pD3uMY9gVMQgjuJKPnVgcCwvs-xMCec5F5frKzfi6848OLO17VGHH1-1r51c9LgZEAtyoaJAGGK3nNtZ8KlCM9UZ4U0PDok7CuXN7JWtmnKUSNsjNhs-zvykuF3BLo6ySFgLSxChvxqrpm2CFGOK15BALPBpDOReSrquI01Z_9OIGpxPYihjoGKbBRQC5va8UoxMhtDzbCkIpe1Z5cgPS0t63JhVULkFtUFUxqfRteXNyXuRoNvYGpKDxd_STxqaz9HypfLPb2FosaY3uESYHIu7wzjuzsXWVEEaQW5jyRfgNpI1yL-iJgIz278SGcCIoRo_sohZtKzWZhig8CJxaLTX_ZzPTfYrjOajEhiUW8Hu5MutpDGeuh8txK7yj6lxD8Uq_mbGXBChOLjSdTFaVKqnWYhtVmwgKfK2-m5gJpvmA6gNso1VHsC1zztjBkA6L32FOvL_D6wtZu6LIBsNKRrTytMgOrpmi1LWor5-Ab-PH9GEJMMVRzM1h5c5MSls0GbehbeGwOTWOcG55jFA9xKgnuET5dmzxzcJ9MM-mYM3x9kdqi_WDeVeQuEaIkRPaDuv0Aa78B5HE3wtVG5O1D1Zm6jc911mZRr7wH7Qq8EfhBgG61FH6Fe6bnUQxzQS2PBFoZCVKPGECsM682cMyAXrkp-sKcEgbFjtoGI5HqQcfafRzSlBHDm3aX4Ec6oO0LucfKsK8yV7fyi_kbJDvDO56qFKlf-cAPYLga8g-A3bJV6qCsB76YbgNQfTm00OutSt-Hwa5xsx3aytNyE0hFUfKf5sapxnkW2BXVYqn8j3W93PkwOwL_kSTFnSQPyi1Ov_EAhEc3yQxaQuIRAzqbMfAg9E3mJdlBEqsbLV3ei8MELR6qZPLIe79gGtFXMqNScXUTLaUzkLz3zH_z3oFt7x87zrFt247TPbQ7hxbXvHfYPSLxkX30yT5xjp3uwdLiqVIUobN_0u3azonTcTp2xz7udLNw40yZV4CeoF5c5tfg7Da8_APZDbQJ")[_Link do diagramu_]
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