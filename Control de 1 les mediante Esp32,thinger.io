#include "WiFi.h"
#include <ThingerESP32.h>

// Datos de Thinger.io
#define usuario "Ismaxrt"
#define device_Id "Led"
#define device_credentials "12345678"

ThingerESP32 thing(usuario, device_Id, device_credentials);

// WiFi
const char WiFi_ssid[] = "AVILA";
const char WiFi_password[] = "123456789";

// LED
int led = 5;

void setup()
{
  pinMode(led, OUTPUT);

  // Conexión WiFi
  thing.add_wifi(WiFi_ssid, WiFi_password);

  // Recurso en Thinger.io para controlar el LED
  thing["Led"] << digitalPin(led);
}

void loop()
{
  thing.handle();
}
