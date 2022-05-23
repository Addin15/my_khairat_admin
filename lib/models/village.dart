import 'package:hive/hive.dart';

part 'village.g.dart';

@HiveType(typeId: 1)
class Village extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? address;

  Village({this.id, this.name, this.address});

  factory Village.fromMap(Map<String, dynamic> map) => Village(
        id: map['id'],
        name: map['name'],
        address: map['address'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
      };
}
