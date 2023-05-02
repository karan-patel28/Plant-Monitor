class Plant {
  late final String name;
  late final String image;
  late final String desc;
  late final String temp;
  late final String humidity;
  late final String moisture;
  late final String waterLevel;

  Plant(
      {required this.name,
      required this.image,
      required this.desc,
      required this.temp,
      required this.humidity,
      required this.moisture,
      required this.waterLevel});

  List<Plant> _plants = [
    Plant(
        name: 'Corn',
        image: 'https://example.com/corn.jpg',
        desc:
            'Corn is a cereal crop that is widely grown around the world for food and animal feed.',
        temp: '60-85°F',
        humidity: '60-70%',
        moisture: '20-22%',
        waterLevel: 'Keep soil moist, but not waterlogged'),
    Plant(
        name: 'Tomato',
        image: 'https://example.com/tomato.jpg',
        desc:
            'Tomato is a juicy, nutrient-dense fruit that is delicious in salads, sandwiches, and sauces.',
        temp: '65-85°F',
        humidity: '40-70%',
        moisture: '20-25%',
        waterLevel:
            'Water deeply once a week, or more often in hot, dry weather.'),
    Plant(
        name: 'Lettuce',
        image: 'https://example.com/lettuce.jpg',
        desc:
            'Lettuce is a leafy green vegetable that is commonly used in salads and sandwiches.',
        temp: '45-65°F',
        humidity: '70-90%',
        moisture: '20-25%',
        waterLevel: 'Water frequently to keep soil moist, but not waterlogged.')
  ];
}
