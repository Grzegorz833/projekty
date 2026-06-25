import streamlit as st
import pandas as pd
import joblib

st.set_page_config(page_title='Spam Detector', page_icon='📧')

# Wczytanie modelu Metadata + Text
# Plik spam_metadata_text_model.pkl musi znajdować się w tym samym folderze co app.py/app3.py
model = joblib.load('spam_metadata_text_model.pkl')


# Funkcja testująca email na modelu Metadata + Text
def predict_email_full(
    subject,
    body,
    language='en',
    num_phone_numbers=0,
    num_received_headers=1,
    has_attachments=0,
    has_reply_to=0,
    has_cc=0,
    has_html_body=1,
    contains_tracking_token=0,
    spf_pass=1,
    dkim_pass=1,
    dmarc_pass=1,
    spam_threshold=0.75,
):
    subject = subject if subject is not None else ''
    body = body if body is not None else ''

    text = subject + ' ' + body

    new_email = pd.DataFrame([{
        'num_phone_numbers': int(num_phone_numbers),
        'num_received_headers': int(num_received_headers),
        'has_attachments': int(has_attachments),
        'has_reply_to': int(has_reply_to),
        'has_cc': int(has_cc),
        'has_html_body': int(has_html_body),
        'contains_tracking_token': int(contains_tracking_token),
        'spf_pass': int(spf_pass),
        'dkim_pass': int(dkim_pass),
        'dmarc_pass': int(dmarc_pass),
        'language': language,
        'text': text,
    }])

    probabilities = model.predict_proba(new_email)[0]

    spam_index = list(model.classes_).index(1)
    legit_index = list(model.classes_).index(0)

    spam_probability = float(probabilities[spam_index])
    legit_probability = float(probabilities[legit_index])

    if spam_probability >= spam_threshold:
        label = 'SPAM / PHISHING'
    else:
        label = 'LEGIT'

    return {
        'prediction': label,
        'spam_probability': spam_probability,
        'legit_probability': legit_probability,
        'threshold': spam_threshold,
    }


st.title("📧 Spam / Phishing Email Detector")
st.write(
    "Wpisz temat i treść wiadomości oraz ustaw metadane. "
    "Model oceni, czy email wygląda podejrzanie."
)

subject = st.text_input("Subject")
body = st.text_area("Email body", height=250)

st.sidebar.header("Metadata")

language = st.sidebar.selectbox("Language", ['en'], index=0)

num_phone_numbers = st.sidebar.number_input(
    "Number of phone numbers",
    min_value=0,
    value=0,
    step=1,
)

num_received_headers = st.sidebar.number_input(
    "Number of Received headers",
    min_value=0,
    value=1,
    step=1,
)

has_attachments = st.sidebar.checkbox("Has attachments", value=False)
has_reply_to = st.sidebar.checkbox("Has Reply-To", value=False)
has_cc = st.sidebar.checkbox("Has CC", value=False)
has_html_body = st.sidebar.checkbox("Has HTML body", value=True)
contains_tracking_token = st.sidebar.checkbox("Contains tracking token", value=False)

spf_pass = st.sidebar.checkbox("SPF pass", value=True)
dkim_pass = st.sidebar.checkbox("DKIM pass", value=True)
dmarc_pass = st.sidebar.checkbox("DMARC pass", value=True)

spam_threshold = st.sidebar.slider(
    "Spam threshold",
    min_value=0.0,
    max_value=1.0,
    value=0.75,
    step=0.01,
)

if st.button("Sprawdź email"):
    if not subject.strip() and not body.strip():
        st.warning("Wpisz temat lub treść wiadomości.")
    else:
        result = predict_email_full(
            subject=subject,
            body=body,
            language=language,
            num_phone_numbers=num_phone_numbers,
            num_received_headers=num_received_headers,
            has_attachments=has_attachments,
            has_reply_to=has_reply_to,
            has_cc=has_cc,
            has_html_body=has_html_body,
            contains_tracking_token=contains_tracking_token,
            spf_pass=spf_pass,
            dkim_pass=dkim_pass,
            dmarc_pass=dmarc_pass,
            spam_threshold=spam_threshold,
        )

        st.subheader("Wynik")

        if result['prediction'] == 'SPAM / PHISHING':
            st.error(result['prediction'])
        else:
            st.success(result['prediction'])

        st.write(f"Prawdopodobieństwo spamu: **{result['spam_probability']:.2%}**")
        st.write(f"Prawdopodobieństwo LEGIT: **{result['legit_probability']:.2%}**")
        st.write(f"Próg SPAM: **{result['threshold']:.2f}**")

        with st.expander("Podgląd użytych metadanych"):
            st.write({
                'language': language,
                'num_phone_numbers': int(num_phone_numbers),
                'num_received_headers': int(num_received_headers),
                'has_attachments': int(has_attachments),
                'has_reply_to': int(has_reply_to),
                'has_cc': int(has_cc),
                'has_html_body': int(has_html_body),
                'contains_tracking_token': int(contains_tracking_token),
                'spf_pass': int(spf_pass),
                'dkim_pass': int(dkim_pass),
                'dmarc_pass': int(dmarc_pass),
            })
