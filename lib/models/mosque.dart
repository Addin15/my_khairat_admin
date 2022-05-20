import 'package:my_khairat_admin/models/village.dart';

class Mosque {
  String? id;
  String? name;
  String? phone;
  String? address;
  List<Village>? villages;

  Mosque({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.villages,
  });

  factory Mosque.fromMap(Map<String, dynamic> map) => Mosque(
        id: map['id'],
        name: map['name'],
        phone: map['phone'] ?? '',
        address: map['address'] ?? '',
        villages: map['villages'] ?? [],
      );
}
