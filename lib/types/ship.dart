class Ship {
  final String name;
  final String homePort;
  final String image;

  Ship({
    required this.name,
    required this.homePort,
    required this.image,
  });

  factory Ship.empty() {
    return Ship(
      name: '',
      homePort: '',
      image: '',
    );
  }

  factory Ship.fromJSON(Map<String, dynamic>? data) {
    if (data == null) {
      return Ship.empty();
    }

    return Ship(
      name: data['name'],
      homePort: data['home_port'],
      image: data['image'],
    );
  }
}
