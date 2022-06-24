class Claim {
  String? id;
  String? claimerID;
  String? mosqueID;
  String? claimerName;
  String? claimerIC;
  String? claimerurl;
  String? status;

  Claim(
      {this.id,
      this.claimerID,
      this.mosqueID,
      this.claimerName,
      this.claimerIC,
      this.claimerurl,
      this.status});

  factory Claim.fromMap(Map<String, dynamic> map) => Claim(
      id: map['id'].toString(),
      claimerID: map['claimer_id'].toString(),
      mosqueID: map['mosque_id'].toString(),
      claimerName: map['claimer_name'],
      claimerIC: map['claimer_ic'],
      claimerurl: map['claimer_url'],
      status: map['status']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'claimer_id': claimerID,
        'claimer_name': claimerName,
        'claimer_ic': claimerIC,
        'claimer_url': claimerurl,
        'status': status
      };
}
