class Vehicle {
  final String name;
  final String tagline;
  final String subtitle;
  final String brandIcon;
  final double price;
  final List<int> gradientColors;
  final String imagePath;

  const Vehicle({
    required this.name,
    required this.tagline,
    required this.subtitle,
    required this.brandIcon,
    required this.price,
    required this.gradientColors,
    required this.imagePath,
  });
}

final List<Vehicle> demoVehicles = [
  const Vehicle(
    name: 'Ford Mustang GT',
    tagline: 'Drive Redefined',
    subtitle: 'The Intelligent Way',
    brandIcon: 'Ford',
    price: 12.5,
    gradientColors: [0xFFDCEBFF, 0xFFF0F6FF],
    imagePath: 'assets/images/cars/car_mustang.png',
  ),
  const Vehicle(
    name: 'Toyota Supra',
    tagline: 'Power in Engine',
    subtitle: 'Ride The Smart Way',
    brandIcon: 'Toyota',
    price: 15.0,
    gradientColors: [0xFFFFE0F0, 0xFFFFF0F7],
    imagePath: 'assets/images/cars/car_supra.png',
  ),
  const Vehicle(
    name: 'BMW G60 Series',
    tagline: 'Beyond the Wheel',
    subtitle: 'Travel The Smart Way',
    brandIcon: 'BMW',
    price: 18.0,
    gradientColors: [0xFFE0E8FF, 0xFFF0F3FF],
    imagePath: 'assets/images/cars/car_bmw.png',
  ),
];