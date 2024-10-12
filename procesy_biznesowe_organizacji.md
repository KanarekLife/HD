# Specyfikacja procesów biznesowych: Wojewódzki Ośrodek Ruchu Drogowego w Gdańsku

## Cele biznesowe organizacji

WORD w Gdańsku jest jednostką organizacyjną, która zajmuje się organizacją egzaminów na prawo jazdy. Celem organizacji jest zapewnienie bezpieczeństwa na drogach poprzez przeprowadzanie egzaminów na prawo jazdy, które pozwolą na wyłonienie kandydatów, którzy są w stanie bezpiecznie poruszać się po drogach. Organizacja chciałaby polepszyć jakość swoich usług poprzez lepsze monitorowanie procesów egzaminacyjnych oraz poprawę ich jakości.

Aktualnie organizacja zmaga się z problemem związanym z dużą liczbą kandydatów na egzamin, co powoduje, że czas oczekiwania na egzamin jest bardzo długi. Ponadto, organizacja chciałaby zwiększyć zadowolenie klientów z usług poprzez zmniejszenie liczby składanych skarg. Wg. aktualnych pomiarów na egzamin teoretyczny oczekuje się średnio 14 dni, a na egzamin praktyczny 30 dni. Ponadto aktualnie liczba skarg na organizację wynosi średnio 500 skarg miesięcznie zarówno dla egzaminu teoretycznego jak i praktyczneg.

Aby cele te zostały zrealizowane, zarząd ustanowił następujące mierzalne cele:

- Zmniejszanie czasu oczekiwania na oba rodzaje egzaminów o 50% w ciągu następnych 18 miesięcy (7 dni na egzamin teoretyczny oraz 15 dni na egzamin praktyczny). Aby to osiągnąć, organizacja musi zmniejszać średni czas oczekiwania o 3% miesięcznie.
- Zmniejszenie ilości skarg na każdy z egzaminów o ok. 75% w ciągu następnych 18 miesięcy. Aby to osiągnąć, organizacja musi zmniejszać ilość napływających skarg o 6% miesięcznie.

Najważniejszymi procesami biznesowymi w organizacji są procesy przeprowadzania egzaminów teoretycznych oraz praktycznych. Oba egzaminy są obowiązkowe dla kandydatów na prawo jazdy. W procesie przeprowadzania egzaminów teoretycznych kandydat odpowiada na pytania testowe, które sprawdzają jego wiedzę z zakresu przepisów ruchu drogowego. W procesie przeprowadzania egzaminów praktycznych kandydat wykonuje jazdę próbną, podczas której egzaminator ocenia jego umiejętności jazdy. W obu procesach kluczową rolę odgrywa egzaminator, który jest odpowiedzialny za przeprowadzenie egzaminu oraz ocenę kandydata.

## Procesy biznesowe

### Przeprowadzenie egzaminu teoretycznego

#### Opis procesu

Proces przeprowadzenia egzaminu teoretycznego składa się z następujących kroków:

- Kandydat wybiera dostępny termin egzaminu teoretycznego oraz rejestruje się na egzamin.
- Kandydat przychodzi na egzamin w wyznaczonym terminie.
- Kandydat podchodzi do egzaminu na komputerze stacjonarnym w sali w towarzystwie innych kandydatów pod nadzorem egzaminatora.
- W momencie gdy zostanie zakończony przez wszystkich obecnych na sali kandydatów, system automatycznie ocenia testy, pokazuje kandydatowi wynik oraz egzaminator drukuje zaświadczenia o wyniku egzaminu.
- Kandydat otrzymuje wynik egzaminu oraz zaświadczenie o wyniku egzaminu.
- W przypadku nieprawidłowości w przebiegu egzaminu, kandydat ma prawo złożyć skargę poprzez wypełnienie formularza w okienku recepcji.

#### Pytania analityczne

TODO

#### Źródła danych

Dane dotyczące przebiegu egzaminu teoretycznego są przechowywane w bazie danych systemu przeprowadzania egzaminów teoretycznych. System przechowuje informacje o kandydatach, egzaminatorach, wynikach egzaminów oraz czasie / terminie jego przeprowadzenia. Przechowywane są również informacje o incydentach, które miały miejsce podczas egzaminu.

Skargi dot. procesu egzaminacyjnego są przepisywane z formularzy skargowych do pliku excel przez pracownika recepcji. Plik ten rotowany jest co miesiąc oraz przekazywany do kierownictwa co 2 tygodnie.

### Przeprowadzenie egzaminu praktycznego

#### Opis procesu

Proces przeprowadzenia egzaminu praktycznego składa się z następujących kroków:

- Kandydat wybiera dostępny termin egzaminu praktycznego oraz rejestruje się na egzamin.
- Kandydat przychodzi na egzamin w wyznaczonym terminie.
- Kandydat podchodzi do egzaminu praktycznego w towarzystwie egzaminatora.
- Egzaminator ocenia umiejętności kandydata podczas jazdy próbnej. Samochód jest wyposażony w kamerę i różne inne czujniki, które rejestrują przebieg jazdy.
- Po zakończeniu jazdy próbnej egzaminator podsumowuje ocenę kandydata oraz wydaje decyzję o wyniku egzaminu.
- W przypadku nieprawidłowości w przebiegu egzaminu, kandydat ma prawo złożyć skargę poprzez wypełnienie formularza w okienku recepcji.

#### Pytania analityczne

TODO

#### Źródła danych

Dane dotyczące przebiegu egzaminu praktycznego są przechowywane w bazie danych systemu przeprowadzania egzaminów praktycznych. System przechowuje informacje o kandydatach, egzaminatorach, zaliczonych przez kandydatów częściach egzaminu oraz wyznaczonym do tego celu samochodzie egzaminacyjnym. Reszta danych pobierana jest z kamer i czujników w samochodzie i zapisywana w oddzielnej bazie danych.
