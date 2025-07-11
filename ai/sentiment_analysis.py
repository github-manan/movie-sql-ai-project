from textblob import TextBlob
import mysql.connector
import pandas as pd

# 🔌 Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",          # Change if needed
    password="v8097214647V",          # Add your password if required
    database="bollywood_db"
)

cursor = conn.cursor(dictionary=True)
cursor.execute("SELECT review_id, movie_id, review_text FROM reviews")
reviews = cursor.fetchall()

print("🧪 Fetched reviews:", len(reviews))

results = []

for review in reviews:
    review_id = review["review_id"]
    movie_id = review["movie_id"]
    text = review["review_text"]

    blob = TextBlob(text)
    polarity = round(blob.sentiment.polarity, 2)
    subjectivity = round(blob.sentiment.subjectivity, 2)

    if polarity > 0.1:
        sentiment = "Positive"
    elif polarity < -0.1:
        sentiment = "Negative"
    else:
        sentiment = "Neutral"

    results.append({
        "review_id": review_id,
        "movie_id": movie_id,
        "review_text": text,
        "polarity": polarity,
        "subjectivity": subjectivity,
        "sentiment": sentiment
    })

# Save to CSV
df = pd.DataFrame(results)
df.to_csv("sentiment_output_textblob.csv", index=False)
print("📁 Saved to 'sentiment_output_textblob.csv'")

cursor.close()
conn.close()