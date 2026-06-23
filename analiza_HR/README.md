# Analiza danych HR
## Opis projektu
Projekt przedstawia analizę danych pracowników firmy.
Celem było sprawdzenie struktury zbioru, przygotowanie danych oraz przeanalizowanie informacji związanych z zatrudnieniem i odejściami pracowników.

Wyniki analizy, tabele oraz wnioski znajdują się bezpośrednio w projekcie.

## Wykonane etapy
Podczas pracy z datasetem, wykonano poszczególne etapy:
- wczytano zbiór danych z pliku CSV,
- sprawdzono liczbę wierszy i kolumn,
- wyświetlono podstawowe informacje o danych i typach kolumn,
- sprawdzono występowanie brakujących wartości oraz pustych pól,
- usunięto wiersze zawierające brakujące dane,
- ujednolicono wartości tekstowe w kolumnach,
- obliczono podstawowe statystyki dotyczące pracowników,
- porównano pracowników, którzy odeszli, z osobami, które zostały,
- przeanalizowano m.in. wynagrodzenia, staż pracy, satysfakcję, nadgodziny, podróże służbowe, stanowiska i działy,
- utworzono tabele grupujące oraz tabele przestawne,
- wskazano przykładowych kandydatów do awansu,
- obliczono korelacje pomiędzy cechami liczbowymi a odejściami pracowników,
- przygotowano wykresy przedstawiające najważniejsze zależności,
- zapisano oczyszczony zbiór danych do nowego pliku CSV.

## Przykładowe analizy
W projekcie przeanalizowano:
- liczbę pracowników, którzy zostali i odeszli,
- średni wiek i wynagrodzenie,
- staż pracy w firmie,
- czas od ostatniego awansu,
- poziom satysfakcji z pracy,
- równowagę między pracą a życiem prywatnym,
- nadgodziny,
- podróże służbowe,
- poziomy stanowisk,
- działy i role pracowników,
- poziomy dochodów,
- korelacje z odejściami pracowników.

## Wykresy
W projekcie przygotowano między innymi:
- macierz korelacji cech dla flagi Attrition,
- wykres udziału kobiet i mężczyzn,
- wykres zależności dochodu od stażu pracy,
- wykres lat bez awansu,
- wykres satysfakcji z pracy,
- wykres odejść według poziomu stanowiska,
- wykres ryzyka odejścia według czasu od awansu,
- mapę nastrojów w działach,
- histogram odejść według stażu pracy,
- porównanie wynagrodzeń i podróży służbowych.

## Wykorzystane biblioteki
- pandas – wczytywanie, przetwarzanie i analiza danych,
- numpy – operacje na danych i tworzenie dodatkowych kolumn,
- matplotlib – tworzenie wykresów,
- seaborn – tworzenie wykresów statystycznych i map korelacji.

## Uruchomienie projektu
Należy zainstalować wymagane biblioteki:
- pip install pandas numpy matplotlib seaborn

Następnie uruchomić plik projektu w Jupyter Notebook albo w środowisku obsługującym język Python.