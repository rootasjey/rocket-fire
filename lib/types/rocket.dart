class Rocket {
  final String name;

  Rocket({
    required this.name,
  });

  factory Rocket.empty() {
    return Rocket(
      name: '',
    );
  }

  factory Rocket.fromJSON(Map<String, dynamic>? data) {
    if (data == null) {
      return Rocket.empty();
    }

    return Rocket(
      name: data['rocket_name'] ?? '',
    );
  }
}
