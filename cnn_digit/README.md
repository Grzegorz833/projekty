# Rozpoznawanie cyfr ze zdjęć przy użyciu CNN (Convolutional Neural Network)
## Opis projektu
Projekt przedstawia model uczenia głębokiego przeznaczony do rozpoznawania pojedynczych cyfr od 0 do 9.

Model został zbudowany przy użyciu bibliotek TensorFlow i Keras oraz wytrenowany na zbiorze danych MNIST, zawierającym obrazy ręcznie napisanych cyfr.  

Po zakończeniu treningu model jest zapisywany do pliku i może zostać wykorzystany do rozpoznawania cyfr narysowanych przez użytkownika, na przykład w programie Paint.

# Co wykonano w projekcie
W projekcie wykonano następujące kroki:  
1\. Wczytano zbiór danych MNIST.
2\. Podzielono dane na:
- zbiór treningowy,
- zbiór testowy.
3\. Przygotowano obrazy do treningu:  
- zmieniono ich kształt do formatu wymaganego przez sieć CNN,
- dodano wymiar kanału obrazu,
- znormalizowano wartości pikseli z zakresu 0–255 do zakresu 0–1.
4\. Przygotowano etykiety cyfr za pomocą one-hot encoding.
5\. Zbudowano konwolucyjną sieć neuronową CNN składającą się z:  
- warstw konwolucyjnych,
- warstw Max Pooling,
- warstwy Flatten,
- warstw Dense,
- warstwy wyjściowej rozpoznającej cyfry od 0 do 9.
6\. Skompilowano model z wykorzystaniem:  
- optymalizatora Adam,
- funkcji straty categorical crossentropy,
- metryki accuracy.
7\. Wytrenowano model przez pięć epok.
8\. Sprawdzono skuteczność modelu na zbiorze testowym.
9\. Zapisano wytrenowany model do pliku:  
*mnist_cnn.keras*
10\. Przygotowano funkcję do przetwarzania własnych obrazów:  
*prepare_image_for_mnist*
11\. Dodano możliwość rozpoznawania cyfry znajdującej się na obrazie utworzonym przez użytkownika.

# Wykorzystane technologie
- tensorflow,
- keras,
- numpy,
- pillow.

# Instalacja bibliotek
Przed uruchomieniem projektu należy zainstalować wymagane biblioteki:  
*python -m pip install tensorflow numpy pillow*

# Uruchomienie projektu
1\. Uruchomić Jupyter Notebook. Po otwarciu notatnika należy uruchamiać komórki kolejno od początku.

Po zakończeniu treningu w katalogu projektu powinien pojawić się plik:  
*mnist_cnn.keras*
Jest to zapisany model, który można później wczytać bez ponownego treningu.

2\. Przygotowanie własnej cyfry w Paint.
Aby sprawdzić działanie modelu:  
1. Otwórzyć program Paint.
2. Utwórzyć nowy obraz z białym tłem.
3. Narysować jedną cyfrę od 0 do 9.
4. Najlepiej użyć:
- czarnego koloru,
- grubszego pędzla,
- dużej cyfry,
- prostego, czytelnego kształtu.
5. Umieścić cyfrę możliwie blisko środka obrazu.
6. Zapisać obraz w formacie JPG lub PNG, na przykład jako:  
   *img_digit.jpg*
7. Umieścić zapisany obraz w tym samym katalogu co notebook lub skrypt projektu.

# Ograniczenia projektu
WAŻNA WSKAZÓWKA: Model rozpoznaje tylko jedną cyfrę na jednym obrazie.  
Nie rozpoznaje liczb wielocyfrowych, takich jak:  
- 12
- 123
- 2026
