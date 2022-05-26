class Grave {
  String? id;
  String? name;
  String? address;

  Grave({
    this.id,
    this.name,
    this.address,
  });

  factory Grave.fromMap(Map<String, dynamic> map) => Grave(
        id: map['id'].toString(),
        name: map['grave_name'],
        address: map['grave_address'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'grave_name': name,
        'grave_address': address,
      };
}
