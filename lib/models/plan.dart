class Plan {
  String? remark;
  String? proveUrl;
  String? date;
  bool? isDone;

  Plan({
    this.remark,
    this.proveUrl,
    this.date,
    this.isDone,
  });

  factory Plan.fromMap(Map<String, dynamic> map) => Plan(
        remark: map['remark'].toString(),
        proveUrl: map['prove_url'].toString(),
        date: map['created_at'].toString(),
        isDone: map['is_done'] == 1 ? true : false,
      );

  Map<String, dynamic> toMap() => {
        'remark': remark,
        'prove_url': proveUrl,
        'created_at': date,
        'is_done': isDone == true ? 1 : 0,
      };
}
