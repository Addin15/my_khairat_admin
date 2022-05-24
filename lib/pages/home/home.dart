import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/pages/home/announcement/page_announcement.dart';
import 'package:my_khairat_admin/pages/home/claim/page_claim.dart';
import 'package:my_khairat_admin/pages/home/grave/page_grave.dart';
import 'package:my_khairat_admin/pages/home/payment/page_payment.dart';
import 'package:my_khairat_admin/pages/home/village/page_village.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Mosque mosque = Provider.of<Mosque>(context);

    if (mosque.id == null) {
      return Container(
          color: Colors.white,
          child: SpinKitChasingDots(
            color: AppColor.primary,
          ));
    } else {
      return Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Container(
              height: 20.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.primary,
                    AppColor.secondary,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${mosque.name}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            PageVillage(mosque: mosque)))
                                .whenComplete(() {
                              setState(() {});
                            }),
                            child: Text(
                              (mosque.villages != null
                                      ? '${mosque.villages!.length}'
                                      : 'Tiada') +
                                  ' kariah',
                              style: TextStyle(
                                color: AppColor.primary,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 2,
                    height: 2,
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            GridView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 2.w),
              children: [
                MenuBox(
                  icon: 'assets/menu/edit.png',
                  label: 'Kemaskini Kubur',
                  onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const PageGrave())),
                ),
                MenuBox(
                  icon: 'assets/menu/announcement.png',
                  label: 'Tambah Pengunguman',
                  onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const PageAnnouncement())),
                ),
                MenuBox(
                  icon: 'assets/menu/record.png',
                  label: 'Rekod Pembayaran',
                  onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              PagePayment(mosqueID: mosque.id.toString()))),
                ),
                MenuBox(
                  icon: 'assets/menu/claim.png',
                  label: 'Semak Tuntutan',
                  onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const PageClaim())),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}

class MenuBox extends StatelessWidget {
  const MenuBox({
    required this.icon,
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String icon;
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  icon,
                  color: AppColor.primary,
                  width: 10.w,
                  height: 10.w,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 3.5.w,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
