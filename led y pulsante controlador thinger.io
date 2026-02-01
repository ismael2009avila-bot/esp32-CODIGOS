#include "WiFi.h"
#include <ThingerESP32.h>    //Librería de la plataforma thinger.io
// Parámetros del conexión con thinger.io
#define usuario "Ismaxrt"
#define device_Id "Control_Leds"
#define device_credentials "123456789"

ThingerESP32 thing(usuario, device_Id, device_credentials);


// Parámetros de conexión WiFi
const char WiFi_ssid[] = "AVILA";          //Nombre de red
const char WiFi_password[] = "12345678"; //Clave de red

// Configurar LEDS
int led1 = 23;

void setup()
{
  pinMode(led1, OUTPUT);
 
  // Inicialización de la WiFi para comunicarse con la API
  thing.add_wifi(WiFi_ssid, WiFi_password);
 
  thing["Led1"] << digitalPin(led1);
  
  

}

void loop()
{
  thing.handle();
}
