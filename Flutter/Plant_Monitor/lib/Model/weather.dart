class Weather {
  /// Current temperature.
  final double temp;

  /// Feels like temperature.
  final double feelsLike;

  /// Lowest temperature.
  final double low;

  /// Highest temperature.
  final double high;

  /// Description of the weather.
  final String description;

  /// Humidity level.
  final int humidity;

  /// Constructor for class Weather.
  Weather({
    required this.temp,
    required this.feelsLike,
    required this.low,
    required this.high,
    required this.description,
    required this.humidity,
  });

  /// Constructs a Weather object from a JSON map.
  ///
  /// Parameters:
  ///   - json: A JSON map containing weather data.
  ///
  /// Returns: A Weather object with values parsed from the JSON map.
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      low: json['main']['temp_min'].toDouble(),
      high: json['main']['temp_max'].toDouble(),
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'].toInt(),
    );
  }
}
