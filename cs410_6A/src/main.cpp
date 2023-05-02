#include<Arduino.h>
#include <WiFiClientSecure.h>
#include <SPIFFS.h>
#include "at_client.h"
#include "constants.h"


#define LED 2
const int pin = 35;
 
const auto *esp32 = new AtSign("@20domestic45"); 
const auto *flutter=new AtSign("@grumpy7196");
const auto keys = keys_reader::read_keys(*esp32); 
auto *at_client = new AtClient(*esp32, keys); 
void setup()
{
    // // reads the keys on the ESP32
     at_client->pkam_authenticate(SSID, PASSWORD); 

    //for receiving data from java app
    // const auto *at_key = new AtKey("led", java, esp32);
    // std::string value;
    //  for (int i = 0; i < 500; i++)
    //  {
    //     value = at_client->get_ak(*at_key);
    //     std::cout<<"Value:"<<value<<std::endl;
    //     if(value=="0"){
    //         digitalWrite(LED,LOW);
    //     }else{
    //         digitalWrite(LED,HIGH);
    //     }
    //  }
     
     

    
    //For sending data from esp32 to java app
    
    Serial.begin(115200);
}

void loop() {

     int water = analogRead(32);
     int light = analogRead(33);
     int moist = analogRead(34);
     int steam = analogRead(35);
     
    //moist highest 2000
    //water highest 2300
    //light highest 4100
    //steam highest 3300
    
    // // create AtKey object for the "test" key and send value to Java app
     const auto *at_key_light = new AtKey("light", esp32, flutter);
     const auto *at_key_water = new AtKey("water", esp32, flutter);
     const auto *at_key_moist = new AtKey("moisture", esp32, flutter);
     const auto *at_key_steam = new AtKey("steam", esp32, flutter);
    //  light=(100*light)/4100;
    //  water=(100*water)/2300;
    //  moist=(100*moist)/2000;
    //  steam=(100*steam)/3300;
     at_client->put_ak(*at_key_light, std::to_string(light));
     at_client->put_ak(*at_key_water, std::to_string(water));
     at_client->put_ak(*at_key_moist, std::to_string(moist));
     at_client->put_ak(*at_key_steam, std::to_string(steam));
     Serial.print("light value is ");   
     Serial.println(light); 
     Serial.print("water value is ");    
     Serial.println(water);
     Serial.print("steam value is ");
     Serial.println(steam);
     Serial.print("moist value is ");
     Serial.println(moist);
     
     delay(1000); // wait for 1 second before sending the next value

}