class Payment {
  String? id;
  String? payerID;
  String? payerName;
  String? paymentDate;
  String? startMonth;
  String? endMonth;
  double? amount;
  String? proveURL;

  Payment({
    this.id,
    this.payerID,
    this.payerName,
    this.paymentDate,
    this.startMonth,
    this.endMonth,
    this.amount,
    this.proveURL,
  });

  factory Payment.fromMap(Map<String, dynamic> map) => Payment(
        id: map['id'],
        payerID: map['payer_id'],
        payerName: map['payer_name'],
        paymentDate: map['payment_date'],
        startMonth: map['start_month'],
        endMonth: map['end_month'],
        amount: map['amount'],
        proveURL: map['prove_url'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'payer_id': payerID,
        'payer_name': payerName,
        'payment_date': paymentDate,
        'start_month': startMonth,
        'end_month': endMonth,
        'amount': amount,
        'prove_url': proveURL,
      };
}
