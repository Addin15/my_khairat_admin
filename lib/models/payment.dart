class Payment {
  String? id;
  String? payerID;
  String? payerName;
  int? payerMonth;
  int? payerYear;
  String? mosqueID;
  String? proveURL;
  String? status;
  String? date;

  Payment({
    this.id,
    this.payerID,
    this.payerMonth,
    this.payerYear,
    this.payerName,
    this.mosqueID,
    this.proveURL,
    this.status,
    this.date,
  });

  factory Payment.fromMap(Map<String, dynamic> map) => Payment(
        id: map['id'].toString(),
        payerID: map['payer_id'].toString(),
        payerMonth: map['person_expire_month'],
        payerYear: map['person_expire_year'],
        payerName: map['person_name'],
        mosqueID: map['mosque_id'].toString(),
        proveURL: map['prove_url'],
        status: map['status'],
        date: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'payer_id': payerID,
        'person_expire_month': payerMonth,
        'person_expire_year': payerYear,
        'person_name': payerName,
        'mosque_id': mosqueID,
        'prove_url': proveURL,
        'status': status,
        'created_at': date,
      };
}
