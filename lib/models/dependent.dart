class Dependent {
  String? id;
  String? dependID;
  String? name;
  String? ic;
  String? phone;
  String? occupation;
  String? address;
  String? relation;
  String? dependName;
  String? status;

  Dependent({
    this.id,
    this.dependID,
    this.dependName,
    this.name,
    this.ic,
    this.phone,
    this.occupation,
    this.address,
    this.relation,
    this.status,
  });

  factory Dependent.fromMap(Map<String, dynamic> map) => Dependent(
        id: map['id'].toString(),
        dependID: map['user_id'].toString(),
        dependName: map['person_name'],
        name: map['dependent_name'],
        ic: map['dependent_ic'],
        phone: map['dependent_phone'],
        occupation: map['dependent_occupation'],
        relation: map['dependent_relation'],
        status: map['verify'] == 1 ? 'completed' : 'pending',
      );

  toMap() => {
        'id': id,
        'user_id': dependID,
        'person_name': dependName,
        'dependent_name': name,
        'dependent_ic': ic,
        'dependent_phone': phone,
        'dependent_occupation': occupation,
        'dependent_relation': relation,
        'verify': status == 'completed' ? 1 : 0,
      };
}
