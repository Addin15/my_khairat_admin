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
        id: map['village_id'].toString(),
        mosque: map['mosque_id'].toString(),
        name: map['village_name'],
        address: map['village_address'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'village_id': id,
        'mosque_id': mosque,
        'village_name': name,
        'village_address': address,
      };
}
