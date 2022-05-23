import 'package:hive/hive.dart';

part 'village.g.dart';

@HiveType(typeId: 1)
class Village extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? mosque;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? address;

  Village({this.id, this.mosque, this.name, this.address});

  factory Village.fromMap(Map<String, dynamic> map) => Village(
        id: map['village_id'],
        mosque: map['mosque_id'],
        name: map['mosque_name'],
        address: map['mosque_address'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'village_id': id,
        'mosque_id': mosque,
        'mosque_name': name,
        'mosque_address': address,
      };
}
