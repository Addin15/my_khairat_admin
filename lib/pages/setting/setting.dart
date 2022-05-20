import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/pages/setting/view_plan.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
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
                        'Masjid A',
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
                    'M0001',
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
                                    builder: (context) => const ViewPlan()));
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
                                '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
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
                  Container(
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
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.h,
                    ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
