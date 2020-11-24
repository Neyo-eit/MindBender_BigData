from kafka import SimpleProducer, KafkaClient
import requests

TOPIC = "Logistics"


url = "https://order-tracking.p.rapidapi.com/carriers"

headers = {
    'content-type': "application/json",
    'x-rapidapi-key': "ad02af769fmsh0365720d2962624p1a0e8djsn8d1ee530deaa",
    'x-rapidapi-host': "order-tracking.p.rapidapi.com"
    }

response = requests.request("GET", url, headers=headers)

x =response.text
# print(response.text)

kafka = KafkaClient("localhost:9092")
producer = SimpleProducer(kafka)
producer.send_messages(TOPIC, x.encode('utf-8'))
# producer.flush()
print("Done")
