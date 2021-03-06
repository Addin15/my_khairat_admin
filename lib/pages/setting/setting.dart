import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/auth.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/controllers/auth_controller.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/pages/auth/login.dart';
import 'package:my_khairat_admin/pages/setting/bank_details.dart';
import 'package:my_khairat_admin/pages/setting/edit_bank_details.dart';
import 'package:my_khairat_admin/pages/setting/view_plan.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Setting extends StatefulWidget {
  const Setting({required this.mosqueDAO, Key? key}) : super(key: key);

  final MosqueDAO mosqueDAO;

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    Mosque? mosque = widget.mosqueDAO.mosque;

    if (mosque!.id == null) {
      return Container(
          color: Colors.white,
          child: SpinKitChasingDots(
            color: AppColor.primary,
          ));
    } else {
      return Scaffold(
        body: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Column(
            children: [
              Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: 1.h,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColor.primary,
                      AppColor.secondary,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 35.sp,
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${mosque.name}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        const Icon(
                          Ionicons.shield_checkmark_outline,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Text(
                      'M${mosque.id}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              // Setting buttons
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.h,
                      ),
                      color: Colors.white,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Click on plan
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => ViewPlan(
                                    mosqueID: mosque.id,
                                    expireMonth: mosque.expireMonth,
                                    expireYear: mosque.expireYear,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.w),
                                    color: Colors.teal,
                                  ),
                                  padding: EdgeInsets.all(2.w),
                                  child: Icon(
                                    Ionicons.clipboard_outline,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Text(
                                    'Pelan',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${mosque.expireMonth}/${mosque.expireYear}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 1.w),
                                Icon(
                                  Ionicons.chevron_forward,
                                  size: 14.sp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 1.h,
                        ),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.w),
                                    color: Colors.blue,
                                  ),
                                  padding: EdgeInsets.all(2.w),
                                  child: Icon(
                                    Ionicons.help_outline,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Text(
                                    'Bantuan',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Ionicons.chevron_forward,
                                  size: 14.sp,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const BankDetails(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.w),
                                      color: Colors.red[400],
                                    ),
                                    padding: EdgeInsets.all(2.w),
                                    child: Icon(
                                      Ionicons.card_outline,
                                      color: Colors.white,
                                      size: 14.sp,
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Text(
                                      'Maklumat Bank',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Ionicons.chevron_forward,
                                    size: 14.sp,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.w),
                                    color: Colors.pink,
                                  ),
                                  padding: EdgeInsets.all(2.w),
                                  child: Icon(
                                    Ionicons.information_outline,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Text(
                                    'Soalan Lazim',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Ionicons.chevron_forward,
                                  size: 14.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.h,
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          // LOGOUT
                          await widget.mosqueDAO.logout();
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.w),
                                color: Colors.red,
                              ),
                              padding: EdgeInsets.all(2.w),
                              child: Icon(
                                Ionicons.log_out_outline,
                                color: Colors.white,
                                size: 14.sp,
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Text(
                                'Log Keluar',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Icon(
                              Ionicons.chevron_forward,
                              size: 14.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
