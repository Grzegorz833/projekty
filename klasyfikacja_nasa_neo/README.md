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
1. Wczytanie i przegląd danych.  
Na początku wykonano:
- sprawdzenie wymiarów zbioru,
- analizę typów danych,
- wyświetlenie przykładowych obserwacji,
- sprawdzenie brakujących wartości,
- sprawdzenie duplikatów,
- analizę podstawowych statystyk opisowych.

2. Czyszczenie danych.  
W ramach przygotowania danych:
- usunięto duplikaty,
- sprawdzono wartości brakujące,
- usunięto kolumny zawierające ponad 30% braków,
- uzupełniono braki w kolumnach liczbowych medianą,
- uzupełniono braki w kolumnach tekstowych wartością Unknown,
- sprawdzono występowanie niepoprawnych wartości ujemnych,
- uporządkowano nazwy kolumn,
- usunięto kolumnę identyfikatora id,
- usunięto kolumny tekstowe oraz kolumny zawierające tylko jedną unikalną wartość.

3. Eksploracyjna analiza danych.  
W ramach EDA wykonano:
- statystyki opisowe,
- macierz korelacji zmiennych liczbowych,
- histogramy zmiennych liczbowych,
- boxploty dla zmiennych liczbowych,
- analizę wartości odstających,
- analizę rozkładu zmiennej docelowej.

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
1. Logistic Regression.

Regresja logistyczna została wykorzystana jako model bazowy.  
Ze względu na niezbalansowanie klas zastosowano parametr:
*class_weight='balanced'*  
Model był trenowany na zestandaryzowanych danych.

2. XGBoost.

Drugim wykorzystanym modelem był XGBoost, który dobrze radzi sobie z:
- zależnościami nieliniowymi,
- interakcjami pomiędzy cechami,
- niezbalansowanymi klasami,
- dużymi zbiorami danych.

Niezbalansowanie klas uwzględniono za pomocą parametru:
*scale_pos_weight*

## Optymalizacja modelu
Parametry modelu XGBoost zostały dobrane za pomocą:
*RandomizedSearchCV*

Testowane parametry obejmowały między innymi:
- max_depth,
- n_estimators,
- learning_rate,
- subsample,
- colsample_bytree,
- min_child_weight,
- gamma,
- reg_alpha,
- reg_lambda.

Do walidacji zastosowano trzykrotną walidację krzyżową:
*StratifiedKFold*  
Jako główną metrykę optymalizacji przyjęto:
*ROC AUC*

## Ocena modeli
Modele zostały ocenione przy użyciu:
- accuracy,
- precision,
- recall,
- F1-score,
- ROC AUC,
- raportu klasyfikacji,
- macierzy pomyłek,
- krzywej ROC.

Ze względu na niezbalansowanie klas, sama dokładność nie jest wystarczającą metryką. Szczególnie istotne są 'recall' oraz 'ROC AUC', ponieważ pozwalają lepiej ocenić zdolność modelu do wykrywania potencjalnie niebezpiecznych obiektów.

## Wykorzystane technologie
- python,
- pandas,
- numpy,
- matplotlib,
- seaborn,
- scikit-learn,
- xgBoost,
- imbalanced-learn,
- jupyter notebook.

## Instalacja bibliotek
Wymagane biblioteki można zainstalować poleceniem:
- pip install pandas numpy matplotlib seaborn scikit-learn xgboost imbalanced-learn jupyter

## Uruchomienie projektu
Po pobraniu repozytorium należy przejść do jego katalogu:
- cd klasyfikacja_nasa_neo

Następnie uruchomić Jupyter Notebook:
- jupyter notebook

Po otwarciu notatnika należy uruchamiać komórki kolejno od początku.
