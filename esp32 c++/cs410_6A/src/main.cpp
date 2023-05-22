#include <Arduino.h>
#include <WiFiClientSecure.h>
#include <SPIFFS.h>
#include "at_client.h"
#include "constants.h"

#define LED 2
const int pin = 35;

/**
 * @brief Create instances of AtSign for different devices.
 *
 * Assign a AtKey file to the ESP32 program, the parameter is the name of the AtKey file.
 * It requires the user to have that AtKey file under the ESP32 project folder or %homepage/users/atkey.
 */
const auto *esp32 = new AtSign("@20domestic45");

/**
 * @brief Create an instance of AtSign for the Flutter program.
 *
 * Assign a AtKey file to the Flutter program, the parameter is the name of the AtKey file.
 * No requirement to have the AtKey file under the folder.
 */
const auto *flutter = new AtSign("@grumpy7196");

/**
 * @brief Read keys from the ESP32.
 */
const auto keys = keys_reader::read_keys(*esp32);

/**
 * @brief Create an instance of AtClient.
 */
auto *at_client = new AtClient(*esp32, keys);

/**
 * @brief Setup function called once during program startup.
 */
void setup()
{
    // Authenticate the PKAM with the provided SSID and password
    at_client->pkam_authenticate(SSID, PASSWORD);

    // Initialize serial communication
    // The code to begin the ESP32, it requires the user to put the monitor speed to 115200 under platformio.ini
    Serial.begin(115200);
}

/**
 * @brief Loop function called repeatedly after the setup function.
 */
void loop()
{
    // Read analog values from sensors
    int water = analogRead(32);
    int light = analogRead(33);
    int moist = analogRead(34);
    int steam = analogRead(35);

    // Create AtKey objects for each sensor value
    const auto *at_key_light = new AtKey("light", esp32, flutter);
    const auto *at_key_water = new AtKey("water", esp32, flutter);
    const auto *at_key_moist = new AtKey("moisture", esp32, flutter);
    const auto *at_key_steam = new AtKey("steam", esp32, flutter);

    // Send sensor values to the Flutter app using AtClient
    at_client->put_ak(*at_key_light, std::to_string(light));
    at_client->put_ak(*at_key_water, std::to_string(water));
    at_client->put_ak(*at_key_moist, std::to_string(moist));
    at_client->put_ak(*at_key_steam, std::to_string(steam));

    // Delay for 1 second before sending the next set of values
    delay(1000);
}
