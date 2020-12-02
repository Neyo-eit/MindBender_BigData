from kafka import KafkaProducer, SimpleProducer
import requests

TOPIC = "Covid"

url = "https://covid-19-tracking.p.rapidapi.com/v1"

headers = {
    'x-rapidapi-key': "ad02af769fmsh0365720d2962624p1a0e8djsn8d1ee530deaa",
    'x-rapidapi-host': "covid-19-tracking.p.rapidapi.com"
    }

response = requests.request("GET", url, headers=headers)
x = response.text
#print(response.text)

bootstrap_servers = ['localhost:9092', 'localhost:9093', 'localhost:9094']
producer = KafkaProducer(bootstrap_servers = bootstrap_servers)
producer = KafkaProducer()
producer.send(TOPIC, x.encode('utf-8'))
print("Done")