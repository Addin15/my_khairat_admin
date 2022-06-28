class Claim {
  String? id;
  String? claimid;
  String? mosqueid;
  String? claimername;
  String? claimeraddress;
  String? claimerrelation;
  String? deaddate;
  String? deadname;
  String? deadreason;
  String? claimeric;
  String? claimerurl;
  String? status;

  Claim(
      {this.id,
      this.claimid,
      this.mosqueid,
      this.claimeric,
      this.claimername,
      this.claimeraddress,
      this.claimerrelation,
      this.deaddate,
      this.deadname,
      this.deadreason,
      this.claimerurl,
      this.status});

  factory Claim.fromMap(Map<String, dynamic> map) => Claim(
        id: map['id'].toString(),
        claimid: map['claim_id'].toString(),
        mosqueid: map['mosque_id'].toString(),
        claimeric: map['claimer_ic'],
        claimername: map['claimer_name'],
        claimeraddress: map['claimer_address'],
        claimerrelation: map['claimer_relation'],
        deaddate: map['dead_date'],
        deadname: map['dead_name'],
        deadreason: map['dead_reason'],
        claimerurl: map['claimer_url'],
        status: map['status'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'claim_id': claimid,
        'mosque_id': mosqueid,
        'claimer_name': claimername,
        'claimer_ic': claimeric,
        'claimer_address': claimeraddress,
        'claimer_relation': claimerrelation,
        'dead_date': deaddate,
        'dead_name': deadname,
        'dead_reason': deadreason,
        'claimer_url': claimerurl,
        'status': status,
      };
}
