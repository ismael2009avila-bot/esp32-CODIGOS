from umqtt.simple import MQTTClient
import network
import time
from machine import Pin
from dht import DHT11

# ---------------- WIFI ----------------
ssid = 'AVILA'
password = '0104528062'

wifi = network.WLAN(network.STA_IF)
wifi.active(True)
wifi.connect(ssid, password)

while not wifi.isconnected():
    time.sleep(0.5)

print("WiFi conectado")

# --------------- THINGER ---------------
USER = 'Ismaxrt'
DEVICE = 'sensor'
DEVICE_PASSWORD = '1234567'
SERVER = 'backend.thinger.io'
PORT = 1883   # SIN SSL

# --------------- DHT -------------------
dht = DHT11(Pin(23))

def read_dht():
    dht.measure()
    return dht.temperature(), dht.humidity()

# --------------- MQTT ------------------
client = MQTTClient(
    client_id=DEVICE,
    server=SERVER,
    port=PORT,
    user=USER,
    password=DEVICE_PASSWORD,
    keepalive=60
)

client.connect()
print("Conectado a Thinger.io")

# Topic correcto
topic = 'v1/users/{}/devices/{}/data/DHT11'.format(USER, DEVICE)

# --------------- LOOP ------------------
while True:
    temp, hum = read_dht()

    payload = '{{"temperature":{}, "humidity":{}}}'.format(temp, hum)

    client.publish(topic, payload)
    print("Enviado:", payload)

    time.sleep(10) 
