import 'package:hive/hive.dart';
import 'package:my_khairat_admin/models/village.dart';

part 'mosque.g.dart';

@HiveType(typeId: 0)
class Mosque extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? email;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? phone;

  @HiveField(4)
  String? postcode;

  @HiveField(5)
  String? state;

  @HiveField(6)
  String? address;

  String? bankName;

  String? bankOwnerName;

  String? bankAccountNo;

  double? monthlyFee;

  int? expireMonth;

  int? expireYear;

  Mosque({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.postcode,
    this.state,
    this.address,
    this.bankName,
    this.bankOwnerName,
    this.bankAccountNo,
    this.monthlyFee,
    this.expireMonth,
    this.expireYear,
  });

  factory Mosque.fromMap(Map<String, dynamic> map) => Mosque(
        email: map['user']['email'],
        id: map['profile']['mosque_id'].toString(),
        name: map['profile']['mosque_name'] ?? '',
        phone: map['profile']['mosque_phone'] ?? '',
        postcode: map['profile']['mosque_postcode'] ?? '',
        state: map['profile']['mosque_state'] ?? '',
        address: map['profile']['mosque_address'] ?? '',
        bankName: map['profile']['mosque_bank_name'] ?? '',
        bankOwnerName: map['profile']['mosque_bank_owner_name'] ?? '',
        bankAccountNo: map['profile']['mosque_bank_no'] ?? '',
        monthlyFee: map['profile']['mosque_monthly_fee'].toDouble() ?? 0,
        expireMonth: map['profile']['mosque_expire_month'] ?? 0,
        expireYear: map['profile']['mosque_expire_year'] ?? 0,
      );

  Map<String, String> toMap() => {
        'email': email.toString(),
        'mosque_id': id.toString(),
        'mosque_name': name.toString(),
        'mosque_phone': phone.toString(),
        'mosque_postcode': postcode.toString(),
        'mosque_state': state.toString(),
        'mosque_address': address.toString(),
        'mosque_bank_name': bankName.toString(),
        'mosque_bank_owner_name': bankOwnerName.toString(),
        'mosque_bank_no': bankAccountNo.toString(),
        'mosque_expire_month': expireMonth.toString(),
        'mosque_expire_year': expireYear.toString(),
        'mosque_monthly_fee': monthlyFee.toString(),
      };
}
