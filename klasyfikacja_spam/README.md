# Klasyfikacja wiadomości e-mail
## Opis projektu
Celem projektu jest stworzenie modelu uczenia maszynowego, który klasyfikuje wiadomości e-mail jako:  
- SPAM / PHISHING
- LEGIT

Model analizuje zarówno treść wiadomości, jak i wybrane metadane techniczne e-maila.

Finalny model wykorzystuje połączenie:  
- tekstu wiadomości,
- tematu wiadomości,
- cech technicznych,
- informacji o zabezpieczeniach SPF, DKIM i DMARC.

## Zbiór danych
W projekcie wykorzystano plik:  
- email_dataset_100k.csv

Zbiór zawiera około 100 000 wiadomości e-mail wraz z ich treścią, metadanymi oraz etykietą klasy.

Kolumna docelowa:  
- label

Znaczenie wartości:  
- 0 – LEGIT
- 1 – SPAM / PHISHING

## Etapy projektu
- wczytanie zbioru danych,
- podstawowa analiza struktury danych,
- sprawdzenie brakujących wartości,
- przygotowanie nowych cech,
- połączenie tematu i treści wiadomości,
- usunięcie duplikatów,
- analiza rozkładu klas,
- analiza zależności pomiędzy metadanymi a klasą wiadomości,
- usunięcie cech powodujących wyciek informacji,
- wizualizacja wybranych cech,
- analiza korelacji,
- przygotowanie preprocessingu,
- trenowanie kilku modeli klasyfikacyjnych,
- porównanie modeli opartych na metadanych, tekście oraz połączeniu obu typów danych,
- cross-validation,
- analiza ważności cech,
- analiza wpływu cech,
- analiza najważniejszych słów dla klas SPAM i LEGIT,
- utworzenie finalnego modelu,
- zapis modelu do pliku,
- przygotowanie aplikacji Streamlit.

## Feature Engineering  
W projekcie utworzono między innymi następujące cechy:  
- has_reply_to,
- has_cc,
- has_unsubscribe,
- has_html_body,
- is_thread,
- spf_pass,
- dkim_pass,
- dmarc_pass,
- text.

Kolumna 'text' powstała przez połączenie tematu i treści wiadomości:  
df['text'] = (  
    df['subject'].fillna('') + ' ' +  
    df['body_plain'].fillna('')  
)

Wartości SPF, DKIM i DMARC zostały przekształcone do formatu binarnego:  
- 1 – test przeszedł poprawnie,
- 0 – test nie przeszedł poprawnie.

## Wykorzystane cechy  
Finalny model korzysta z tekstu wiadomości oraz metadanych.

Cechy liczbowe:  
- num_phone_numbers,
- num_received_headers,
- has_attachments,
- has_reply_to,
- has_cc,
- has_html_body,
- contains_tracking_token,
- spf_pass,
- dkim_pass,
- dmarc_pass.

Cechy kategoryczne:  
- language

Cecha tekstowa:  
- text

## Przygotowanie danych  
Dane liczbowe zostały przygotowane za pomocą:  
- SimpleImputer,
- StandardScaler.

Dane kategoryczne zostały przygotowane za pomocą:  
- SimpleImputer,
- OneHotEncoder.

Tekst został przekształcony do postaci liczbowej za pomocą:  
- TfidfVectorizer,
- unigramów i bigramów,
- angielskich stop words.

Wszystkie etapy zostały połączone za pomocą ColumnTransformer oraz Pipeline.

## Porównywane warianty
W projekcie porównano trzy główne zestawy cech:  
- Metadata only,
- Text only,
- Metadata + Text.

Dodatkowo wykonano eksperymenty, w których usuwano wybrane cechy i sprawdzano ich wpływ na jakość klasyfikacji.

## Wykorzystane modele
W projekcie przetestowano:  
- Logistic Regression,
- Random Forest,
- XGBoost.

Modele oceniano za pomocą:  
- accuracy,
- precision,
- recall,
- F1-score,
- confusion matrix,
- cross-validation.

## Analiza NLP
Dla modelu tekstowego przeanalizowano współczynniki regresji logistycznej.

Pozwoliło to wskazać słowa i frazy, które najmocniej wpływały na klasyfikację wiadomości jako:  
- SPAM / PHISHING,
- LEGIT.

Wiadomości spamowe częściej zawierały słownictwo związane między innymi z:  
- logowaniem,
- weryfikacją konta,
- płatnościami,
- nagrodami,
- pilnymi działaniami,
- zamknięciem konta,
- przesyłkami.

Wiadomości legit częściej zawierały słownictwo charakterystyczne dla zwykłej komunikacji biznesowej.

## Finalny model
Finalny model wykorzystuje:  
- Metadata + Text

Model składa się z:  
- preprocessingu metadanych,
- kodowania języka,
- TF-IDF dla tekstu,
- Logistic Regression.

Tekst może otrzymać większą wagę za pomocą parametru:  
transformer_weights={
    'num': 1.0,
    'cat': 1.0,
    'txt': 5.0
}

Finalny model został zapisany do pliku:  
*spam_metadata_text_model.pkl*

## Aplikacja Streamlit
Projekt zawiera aplikację Streamlit umożliwiającą:  
- wpisanie tematu wiadomości,
- wpisanie treści wiadomości,
- ustawienie metadanych,
- ustawienie progu klasyfikacji,
- wyświetlenie wyniku,
- wyświetlenie prawdopodobieństwa spamu.

## Wykorzystane technologie
- pandas,
- numpy,
- matplotlib,
- seaborn,
- scikit-learn,
- xgboost,
- TF-IDF,
- logistic regression,
- random forest,
- streamlit,
- joblib.

## Instalacja bibliotek
Instalacja wymaganych bibliotek:  
*pip install pandas numpy matplotlib seaborn scikit-learn xgboost joblib streamlit*

## Uruchomienie projektu
Uruchomić Jupyter Notebook. Po otwarciu notatnika należy uruchamiać komórki kolejno od początku.

Nastepnie uruchomić aplikację w Streamlit, z pliku 'app.py':
- przejść w terminalu, do katalogu docelowego np.:
  *cd klasyfikacja_spam*
- zainstalować wymagane biblioteki:  
  *pip install -r requirements.txt*
- wpisać poniższą komendę uruchamiajacą Streamlit:  
  *streamlit run app.py*

## Pliki projektu
klasyfikacja_spam/  
- email_dataset_100k.csv
- requirements.txt
- spam.ipynb
- app.py
- spam_metadata_text_model.pkl
- README.md