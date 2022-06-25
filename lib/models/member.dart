class Member {
  String? id;
  String? ic;
  String? name;
  String? villageName;
  String? phone;
  String? address;
  String? occupation;
  String? status;
  int? expireMonth;
  int? expireYear;
  int? memberNo;
  String? detailsProveImg;
  String? paymentProveImg;
  String? email;

  Member({
    this.id,
    this.ic,
    this.name,
    this.villageName,
    this.phone,
    this.address,
    this.occupation,
    this.status,
    this.expireMonth,
    this.expireYear,
    this.memberNo,
    this.detailsProveImg,
    this.paymentProveImg,
    this.email,
  });

  factory Member.fromMap(Map<String, dynamic> map) => Member(
        id: map['id'].toString(),
        ic: map['person_ic'],
        name: map['person_name'],
        villageName: map['village_name'],
        phone: map['person_phone'],
        address: map['person_address'],
        occupation: map['person_occupation'],
        status: map['person_status'],
        expireMonth: map['person_expire_month'],
        expireYear: map['person_expire_year'],
        memberNo: map['person_member_no'],
        detailsProveImg: map['person_details_prove'],
        paymentProveImg: map['person_payment_prove'],
        email: map['email'],
      );

  toMap() => {
        'id': id,
        'person_ic': ic,
        'person_name': name,
        'village_name': villageName,
        'person_phone': phone,
        'person_address': address,
        'person_occupation': occupation,
        'person_status': status,
        'person_expire_month': expireMonth,
        'person_expre_year': expireYear,
        'person_member_no': memberNo,
        'person_details_prove': detailsProveImg,
        'person_payment_prove': paymentProveImg,
        'email': email,
      };
}
