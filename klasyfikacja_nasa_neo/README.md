# Klasyfikacja potencjalnie niebezpiecznych asteroid – NASA NEO
## Opis projektu
Celem projektu jest stworzenie modelu uczenia maszynowego, który klasyfikuje obiekty bliskie Ziemi jako potencjalnie niebezpieczne lub bezpieczne.
Projekt został wykonany na zbiorze danych NASA Near-Earth Objects, zawierającym informacje o asteroidach i innych obiektach przelatujących w pobliżu Ziemi.

Problem został potraktowany jako zadanie klasyfikacji binarnej:  
- 0 – obiekt nie jest potencjalnie niebezpieczny,
- 1 – obiekt jest potencjalnie niebezpieczny.

## Zbiór danych
Zbiór zawiera ponad 90 tyś. obserwacji oraz informacje dotyczące między innymi:  
- minimalnej i maksymalnej szacowanej średnicy obiektu,
- prędkości względnej,
- minimalnej odległości od Ziemi,
- jasności absolutnej,
- ciała, wokół którego porusza się obiekt,
- klasyfikacji obiektu jako potencjalnie niebezpiecznego.

Zmienną docelową jest kolumna:  
*hazardous*

Zbiór jest niezbalansowany – obiekty potencjalnie niebezpieczne stanowią około 10% wszystkich obserwacji.

# Etapy projektu
1\. Wczytanie i przegląd danych.  
- sprawdzenie wymiarów zbioru,
- analiza typów danych,
- wyświetlenie przykładowych obserwacji,
- sprawdzenie brakujących wartości,
- sprawdzenie duplikatów,
- analiza podstawowych statystyk opisowych.

2\. Czyszczenie danych.  
- usuwanie duplikatów,
- sprawdzenie wartości brakujące,
- usunięcie kolumn zawierających ponad 30% braków,
- uzupełnienie braków w kolumnach liczbowych medianą,
- uzupełnienie braków w kolumnach tekstowych wartością 'Unknown',
- sprawdzenie występowania niepoprawnych wartości ujemnych,
- uporządkowanie nazw kolumn,
- usunięcie kolumny id,
- usunięcie kolumn tekstowych oraz kolumn zawierających tylko jedną unikalną wartość.

3\. Eksploracyjna analiza danych.  
- statystyki opisowe,
- macierz korelacji zmiennych liczbowych,
- histogramy zmiennych liczbowych,
- boxploty dla zmiennych liczbowych,
- analiza wartości odstających,
- analiza rozkładu zmiennej docelowej.

Dla zmiennych posiadających silnie skośne rozkłady utworzono również wersje po transformacji logarytmicznej:  
*log10(x + 1)*  

Transformację zastosowano między innymi do średnicy, prędkości względnej i odległości obiektu.

## Przygotowanie danych do modelowania
Dane zostały podzielone na:
- 80% – zbiór treningowy,
- 20% – zbiór testowy.

Podział wykonano z wykorzystaniem stratyfikacji, dzięki czemu zachowano podobne proporcje klas w obu zbiorach.  
Dla modelu regresji logistycznej zastosowano standaryzację zmiennych przy użyciu:  
*StandardScaler*

## Zastosowane modele
1\. Logistic Regression.  
Regresja logistyczna została wykorzystana jako model bazowy.  

Ze względu na niezbalansowanie klas zastosowano parametr:  
*class_weight='balanced'*  

Model był trenowany na zestandaryzowanych danych.

2\. XGBoost.  
Drugim wykorzystanym modelem był XGBoost.

Niezbalansowanie klas uwzględniono za pomocą parametru:  
*scale_pos_weight*

## Walidacja krzyżowa
Dla modelu XGBoost wykonano walidację krzyżową z użyciem:  
*StratifiedKFold*

Celem walidacji było sprawdzenie stabilności modelu na różnych podziałach danych.

## Optymalizacja modelu
Parametry modelu XGBoost zostały dobrane za pomocą:  
*RandomizedSearchCV*

Do walidacji w ramach RandomizedSearchCV zastosowano:  
*StratifiedKFold*  

Jako główną metrykę optymalizacji przyjęto:  
*PR-AUC*

## Ocena modeli
Modele zostały ocenione przy użyciu:  
- accuracy,
- precision,
- recall,
- F1-score,
- ROC-AUC,
- PR-AUC,
- raportu klasyfikacji,
- macierzy pomyłek,
- krzywej ROC,
- krzywej PR.

## Analiza progów klasyfikacji
Dla modeli analizowano również różne progi klasyfikacji.

Domyślny próg wynosi: 
*0.5*

Oznacza to, że model klasyfikuje obiekt jako 'hazardous' = 1, jeśli prawdopodobieństwo klasy pozytywnej jest większe lub równe 0.5.

Sprawdzono również inne progi, między innymi:
- 0.3,
- 0.4,
- 0.6,
- 0.7,
- 0.8.

## Wykorzystane technologie
- pandas,
- numpy,
- matplotlib,
- seaborn,
- scikit-learn,
- xgBoost,
- imbalanced-learn.

## Instalacja bibliotek
Wymagane biblioteki można zainstalować poleceniem:  
*pip install pandas numpy matplotlib seaborn scikit-learn xgboost imbalanced-learn*

## Uruchomienie projektu
Uruchomić Jupyter Notebook. Po otwarciu notatnika należy uruchamiać komórki kolejno od początku.

## Pliki projektu
klasyfikacja-nasa-neo/
- neo_v2.csv
- NASA_NEO_ML.ipynb
- README.md


Dataset pochodzi z serwisu kaggle.com: https://www.kaggle.com/datasets/sameepvani/nasa-nearest-earth-objects