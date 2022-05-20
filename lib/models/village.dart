class Village {
  String? id;
  String? name;
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
