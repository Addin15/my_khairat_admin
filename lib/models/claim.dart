class Claim {
  String? id;
  String? claimerID;
  String? claimerName;
  String? claimerIC;
  String? claimerVillage;
  String? proveURL;

  Claim(
      {this.id,
      this.claimerID,
      this.claimerName,
      this.claimerIC,
      this.claimerVillage,
      this.proveURL});

  factory Claim.fromMap(Map<String, dynamic> map) => Claim(
        id: map['id'],
        claimerID: map['claimer_id'],
        claimerName: map['claimer_name'],
        claimerIC: map['claimer_ic'],
        claimerVillage: map['claimer_village'],
        proveURL: map['prove_url'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'claimer_id': claimerID,
        'claimer_name': claimerName,
        'claimer_ic': claimerIC,
        'claimer_village': claimerVillage,
        'prove_url': proveURL,
      };
}
