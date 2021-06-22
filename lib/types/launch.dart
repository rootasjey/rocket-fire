import 'package:rocketfire/types/links.dart';
import 'package:rocketfire/types/rocket.dart';
import 'package:rocketfire/types/ship.dart';

class Launch {
  final String missionName;
  final String id;
  final DateTime launchDateLocal;
  final Links links;
  final Rocket rocket;
  final List<Ship> ships;

  Launch({
    required this.missionName,
    required this.id,
    required this.launchDateLocal,
    required this.links,
    required this.rocket,
    required this.ships,
  });

  factory Launch.empty() {
    return Launch(
      missionName: '',
      id: '',
      launchDateLocal: DateTime.now(),
      links: Links.empty(),
      rocket: Rocket.empty(),
      ships: const [],
    );
  }

  factory Launch.fromJSON(Map<String, dynamic>? data) {
    if (data == null) {
      return Launch.empty();
    }

    return Launch(
      missionName: data['mission_name'] ?? '',
      launchDateLocal: DateTime.parse(data['launch_date_local']),
      id: data['id'] ?? '',
      links: Links.fromJSON(data['links']),
      rocket: Rocket.fromJSON(data['rocket']),
      ships: parseShips(data['ships']),
    );
  }

  static List<Ship> parseShips(List<dynamic> shipsList) {
    final ships = <Ship>[];

    for (var rawShip in shipsList) {
      final ship = Ship.fromJSON(rawShip);
      ships.add(ship);
    }

    return ships;
  }
}
