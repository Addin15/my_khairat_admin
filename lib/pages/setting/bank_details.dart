import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/pages/setting/edit_bank_details.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({Key? key}) : super(key: key);

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MosqueDAO>(
      builder: (context, mosqueDAO, child) {
        Mosque? mosque = mosqueDAO.mosque;
        return Scaffold(
          appBar: customAppBar(
            context: context,
            title: Text(
              'Maklumat Bank',
              style: TextStyle(color: AppColor.primary),
            ),
          ),
          body: Container(
            width: 100.w,
            decoration: const BoxDecoration(
              color: Colors.white54,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Maklumat Bank',
                  style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Nama Bank',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                ),
                SizedBox(height: 1.h),
                Text(
                  mosque!.bankName!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Nama Pemilik Akaun',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                ),
                SizedBox(height: 1.h),
                Text(
                  mosque.bankOwnerName!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'No Akaun Bank',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                ),
                SizedBox(height: 1.h),
                Text(
                  mosque.bankAccountNo!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Yuran Bulanan',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                ),
                SizedBox(height: 1.h),
                Text(
                  'RM' + mosque.monthlyFee!.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3.h),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => EditBankDetails(
                            mosqueDAO: mosqueDAO,
                            bankName: mosque.bankName!,
                            bankOwnerName: mosque.bankOwnerName!,
                            bankAccountNo: mosque.bankAccountNo!,
                            monthlyFee: mosque.monthlyFee!,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Sunting',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
