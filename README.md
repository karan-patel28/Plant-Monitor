# Plant Monitor App

I developed an Android application aimed at monitoring environmental conditions to determine the optimal timing for planting specific plants.

## Project Overview

The Plant Monitor app is designed to help gardeners and farmers make informed decisions about the best time to plant various crops. By integrating real-time sensor data and weather forecasts, the app provides users with precise recommendations on planting conditions.

## Key Features

- **Sensor Integration**: Integrated various sensors, including temperature, steam, water, moisture, and ambient light, connected via ESP32. These sensors provided real-time data on soil humidity, temperature, and water level.
- **Weather Data Integration**: Collected weather forecasts from the OpenWeather API to complement sensor data, including information on temperature, humidity, precipitation, and sunlight duration.
- **Ideal Plant Data Comparison**: Referenced a database of ideal environmental conditions for different plant species, such as optimal temperature ranges, soil moisture levels, and light exposure requirements.
- **Decision-Making Algorithm**: Analyzed sensor data, weather forecasts, and ideal plant conditions using a sophisticated algorithm to determine whether current environmental conditions aligned with ideal planting conditions.
- **User Interface**: Provided clear recommendations to users based on analysis results, indicating whether current conditions were suitable for planting specific plants or if adjustments were necessary.

## Usage

The Plant Monitor app is designed for use in various agricultural and gardening scenarios:

- **Home Gardening**: Ideal for home gardeners who want to optimize their planting schedule based on real-time environmental data.
- **Urban Farming**: Useful for urban farmers who need to monitor conditions in controlled environments like greenhouses.
- **Agricultural Research**: Beneficial for researchers studying the impact of environmental conditions on plant growth.

## How It Works

1. **Sensor Data Collection**: The ESP32 microcontroller collects data from connected sensors measuring soil humidity, temperature, water level, and ambient light.
2. **Data Transmission**: The collected data is transmitted to the Flutter app using secure communication protocols.
3. **Weather Data Integration**: The app retrieves current and forecasted weather data from the OpenWeather API.
4. **Data Analysis**: The app compares the collected sensor data and weather forecasts against a database of ideal plant conditions.
5. **Recommendations**: Based on the analysis, the app provides users with recommendations on whether the current conditions are suitable for planting specific plants.

## Technologies Used

- **Flutter**: For developing the Android application.
- **C++**: For backend development and sensor data processing with ESP32.
- **ESP32**: For connecting and integrating various sensors.
- **OpenWeather API**: For retrieving weather data.
- **PlatformIO**: For managing the ESP32 development environment.
- **atSign's atKeys**: For encrypting sensitive data.
- **Visual Studio Code**: For coding and debugging.

## Installation Steps

To establish a connection between the ESP32 and sensors and your laptop, you will need a USB-A to Micro USB cable.

### ESP32 Setup

1. Install PlatformIO in your project.
2. Connect the ESP32 to your laptop using the USB cable.
3. Set the ESP32 to build mode, then switch it to upload and monitor mode.
4. Press the power button and reset button simultaneously until you see output on your console.

### Flutter App Setup

1. Install Dart and Flutter packages on your system.
2. Use the `flutter run` command to launch the app on your local device.

### Prerequisites

- Visual Studio Code and WiFi connection are required for the installation and setup process.
- To enable encryption, you need to download two Atkeys from Atsigns for encryption on both the Flutter app and ESP32 side.

## AtKeys (Data Encryption)

When sensitive data such as sensor readings, plant analysis, or user information needs to be transmitted or stored, the data is encrypted using the generated AtKeys. The encryption process converts the plaintext data into an unreadable format using a strong encryption algorithm.

## Conclusion

Overall, the Plant Monitor app allows users to become better plant caregivers by providing them with the tools and knowledge they need to create an optimal environment for their plants to thrive.

## Contact

If you have any questions or feedback, please contact me at hello@thekaranpatel.com.

