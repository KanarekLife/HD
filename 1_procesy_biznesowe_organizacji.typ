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

= Specyfikacja procesów biznesowych: Wojewódzki Ośrodek Ruchu Drogowego w Gdańsku

#pad(top: 10pt, align(center)[Stanisław Nieradko 193044, Bartłomiej Krawisz 193319])

== Cele biznesowe organizacji

WORD w Gdańsku jest instytucją, która zajmuje się organizacją egzaminów na prawo jazdy. Jej celem jest zapewnienie bezpieczeństwa na drogach poprzez przeprowadzanie egzaminów na prawo jazdy, które pozwolą na wyłonienie kandydatów potrafiących bezpiecznie poruszać się po drogach.

Aktualnie organizacja zmaga się z problemem związanym z dużą liczbą kandydatów (spotęgowanych przez okres COVID), co powoduje, że czas oczekiwania na egzamin jest zbyt długi. Wg. aktualnych pomiarów, na egzamin teoretyczny oczekuje się średnio 14 dni, a na egzamin praktyczny 30. Ponadto, chcieliby zwiększyć zadowolenie klientów z ich usług poprzez zmniejszenie liczby składanych skarg na działanie instytucji. Aktualnie liczba skarg na organizację wynosi średnio 500 skarg miesięcznie dla obu form egzaminów.

Aby cele te zostały zrealizowane, zarząd ustanowił następujące mierzalne cele na najbliższe 18 miesięcy:

- Zmniejszanie czasu oczekiwania na oba rodzaje egzaminów o 50% (7 dni na egzamin teoretyczny oraz 15 dni na egzamin praktyczny). Aby to osiągnąć, organizacja musi zmniejszać średni czas oczekiwania o 3% miesięcznie.
- Zmniejszenie liczby skarg dot. przebiegu egzaminu teoretycznego o min 75% (z 500 do mniej niż, lub równo 125)

Najważniejszymi procesami biznesowymi w organizacji są procesy przeprowadzania egzaminów teoretycznych oraz praktycznych. Oba egzaminy są obowiązkowe dla kandydatów na prawo jazdy. W procesie przeprowadzania egzaminów teoretycznych kandydat odpowiada na pytania testowe, które sprawdzają jego wiedzę z zakresu przepisów ruchu drogowego. Egzamin przeprowadzany jest na stanowiskach komputerowych zainstalowanych w organizacji dzięki pomocy zautomatyzowanego systemu. Egzaminator dba o poprawne przyporządkowanie komputerów do kandydatów wg. wskazań systemu oraz odpowiada za poprawne przeprowadzenie egzaminu. Wyniki egzaminu są automatycznie obliczane przez komputer oraz prezentowane uczestnikowi po zakończeniu przez niego procesu egzaminacyjnego. W procesie przeprowadzania egzaminów praktycznych kandydat wykonuje jazdę próbną, podczas której egzaminator ocenia jego umiejętności jazdy. W tym procesie kluczową rolę odgrywa egzaminator, który jest odpowiedzialny za przeprowadzenie egzaminu oraz ocenę kandydata.

== Procesy biznesowe organizacji

=== Proces przeprowadzania egzaminów teoretycznych

==== Opis procesu

Proces przeprowadzenia egzaminu teoretycznego składa się z następujących kroków:

- Kandydat wybiera dostępny termin egzaminu teoretycznego oraz rejestruje się na egzamin.
- Kandydat przychodzi na egzamin w wyznaczonym terminie.
- Kandydat podchodzi do egzaminu na komputerze stacjonarnym w sali w towarzystwie innych kandydatów pod nadzorem egzaminatora.
- W momencie gdy zostanie zakończony przez wszystkich obecnych na sali kandydatów, system automatycznie ocenia testy, pokazuje kandydatowi wynik oraz egzaminator drukuje zaświadczenia o wyniku egzaminu.
- Kandydat otrzymuje wynik egzaminu oraz zaświadczenie o wyniku egzaminu.
- W przypadku nieprawidłowości w przebiegu egzaminu, kandydat ma prawo złożyć skargę poprzez wypełnienie formularza w okienku recepcji.

#pagebreak()

==== Pytania analityczne

- Porównaj średni czas oczekiwania na egzamin teoretyczny w tym i poprzednim miesiącu.
- Porównaj średnią liczbę zarezerwowanych terminów egzaminów teoretycznych na przestrzeni dni tygodnia w tym i poprzednim miesiącu.
- Podaj jak dużo kandydatów nie pojawiło się na egzaminie w tym i poprzednim miesiącu.
- Porównaj liczbę incydentów podczas egzaminów w tym i poprzednim miesiącu.
- Jak dużo terminów egzaminów zostało w pełni zarezerwowanych w tym i poprzednim miesiącu?
- Jaka jest średnia liczba podejść do egzaminu na jednego kandydata w tym i poprzednim miesiącu?

==== Źródła danych

Dane dotyczące przebiegu egzaminu teoretycznego są przechowywane w bazie danych systemu przeprowadzania egzaminów teoretycznych. System przechowuje informacje o kandydatach, egzaminatorach, wynikach egzaminów oraz czasie / terminie jego przeprowadzenia. Przechowywane są również informacje o incydentach, które miały miejsce podczas egzaminu.

Skargi dot. procesu egzaminacyjnego są przepisywane z formularzy skargowych do pliku excel przez pracownika recepcji. Plik ten rotowany jest co miesiąc oraz przekazywany do kierownictwa co 2 tygodnie.

=== Proces przeprowadzania egzaminów praktycznych

==== Opis procesu

Proces przeprowadzenia egzaminu praktycznego składa się z następujących kroków:

- Kandydat wybiera dostępny termin egzaminu praktycznego oraz rejestruje się na egzamin.
- Kandydat przychodzi na egzamin w wyznaczonym terminie.
- Kandydat podchodzi do egzaminu praktycznego w towarzystwie egzaminatora.
- Egzaminator ocenia umiejętności kandydata podczas jazdy próbnej. Samochód jest wyposażony w kamerę i różne inne czujniki, które rejestrują przebieg jazdy.
- Po zakończeniu jazdy próbnej egzaminator podsumowuje ocenę kandydata oraz wydaje decyzję o wyniku egzaminu.
- W przypadku nieprawidłowości w przebiegu egzaminu, kandydat ma prawo złożyć skargę poprzez wypełnienie formularza w okienku recepcji.

==== Pytania analityczne

- Porównaj średnią liczbę zarezerwowanych terminów egzaminów praktycznych na przestrzeni dni tygodnia w tym i poprzednim miesiącu.
- Podaj jak dużo kandydatów opuściło plac manewrowy podczas egzaminu w tym i poprzednim miesiącu.
- Porównaj liczbę wypadków podczas egzaminów w tym i poprzednim miesiącu.
- Jak dużo terminów egzaminów zostało w pełni zarezerwowanych w tym i poprzednim miesiącu?
- Jaka jest najpopularniejsza trasa egzaminacyjna w tym i poprzednim miesiącu?

==== Źródła danych

Dane dotyczące przebiegu egzaminu praktycznego są przechowywane w bazie danych systemu przeprowadzania egzaminów praktycznych. System przechowuje informacje o kandydatach, egzaminatorach, zaliczonych przez kandydatów częściach egzaminu oraz wyznaczonym do tego celu samochodzie egzaminacyjnym. Reszta danych (takich jak trasa przejazdu, czas jej trwania i inne) pobierana jest z kamer i czujników w samochodzie i zapisywana w oddzielnej bazie danych.