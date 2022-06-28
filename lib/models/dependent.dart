class Dependent {
  String? id;
  String? dependID;
  String? name;
  String? ic;
  String? phone;
  String? occupation;
  String? address;
  String? relation;

  Dependent({
    this.id,
    this.dependID,
    this.name,
    this.ic,
    this.phone,
    this.occupation,
    this.address,
    this.relation,
  });

  factory Dependent.fromMap(Map<String, dynamic> map) => Dependent(
        id: map['id'].toString(),
        dependID: map['user_id'].toString(),
        name: map['dependent_name'],
        ic: map['dependent_ic'],
        phone: map['dependent_phone'],
        occupation: map['dependent_occupation'],
        relation: map['dependent_relation'],
      );

  toMap() => {
        'id': id,
        'user_id': dependID,
        'dependent_name': name,
        'dependent_ic': ic,
        'dependent_phone': phone,
        'dependent_occupation': occupation,
        'dependent_relation': relation,
      };
}
