class Payment {
  String? id;
  String? payerID;
  String? payerName;
  String? paymentDate;
  int? startMonth;
  int? startYear;
  int? endMonth;
  int? endYear;
  double? amount;
  String? proveURL;

  Payment({
    this.id,
    this.payerID,
    this.payerName,
    this.paymentDate,
    this.startMonth,
    this.startYear,
    this.endMonth,
    this.endYear,
    this.amount,
    this.proveURL,
  });

  factory Payment.fromMap(Map<String, dynamic> map) => Payment(
        id: map['id'],
        payerID: map['payer_id'],
        payerName: map['payer_name'],
        paymentDate: map['payment_date'],
        startMonth: map['start_month'],
        startYear: map['start_year'],
        endMonth: map['end_month'],
        endYear: map['end_year'],
        amount: map['amount'],
        proveURL: map['prove_url'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'payer_id': payerID,
        'payer_name': payerName,
        'payment_date': paymentDate,
        'start_month': startMonth,
        'start_year': startYear,
        'end_month': endMonth,
        'end_year': endYear,
        'amount': amount,
        'prove_url': proveURL,
      };
}
