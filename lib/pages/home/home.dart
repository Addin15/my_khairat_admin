import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/DAO/village_dao.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/models/village.dart';
import 'package:my_khairat_admin/pages/home/announcement/page_announcement.dart';
import 'package:my_khairat_admin/pages/home/claim/page_claim.dart';
import 'package:my_khairat_admin/pages/home/grave/page_grave.dart';
import 'package:my_khairat_admin/pages/home/payment/page_payment.dart';
import 'package:my_khairat_admin/pages/home/village/page_village.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({required this.mosqueDAO, Key? key}) : super(key: key);

  final MosqueDAO mosqueDAO;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    VillageDAO villageDAO = Provider.of<VillageDAO>(context);

    Mosque? mosque = widget.mosqueDAO.mosque;

    List<Village> villages = villageDAO.villages;
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: SingleChildScrollView(
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
                            '${mosque!.name}',
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
                                builder: (context) => PageVillage(
                                  mosque: mosque,
                                ),
                              ),
                            ),
                            child: Text(
                              (villages.isNotEmpty
                                      ? '${villages.length}'
                                      : 'Tiada') +
                                  ' Kariah',
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
                          builder: (context) => PageGrave(
                                mosqueID: mosque.id!,
                              ))),
                ),
                MenuBox(
                  icon: 'assets/menu/announcement.png',
                  label: 'Tambah Pengumuman',
                  onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => PageAnnouncement(
                                mosqueID: mosque.id!,
                              ))),
                ),
                MenuBox(
                  icon: 'assets/menu/record.png',
                  label: 'Rekod Pembayaran',
                  onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              PagePayment(mosqueID: mosque.id!))),
                ),
                MenuBox(
                  icon: 'assets/menu/claim.png',
                  label: 'Semak Tuntutan',
                  onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              PageClaim(mosqueID: mosque.id!))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
