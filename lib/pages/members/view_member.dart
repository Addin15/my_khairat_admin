import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/member.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewMember extends StatefulWidget {
  const ViewMember({required this.member, Key? key}) : super(key: key);

  final Member member;

  @override
  State<ViewMember> createState() => _ViewMemberState();
}

class _ViewMemberState extends State<ViewMember> {
  late Member member;

  @override
  void initState() {
    member = widget.member;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: Text(
          'Profil Ahli',
          style: TextStyle(
            color: AppColor.primary,
          ),
        ),
      ),
      body: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        alignment: Alignment.center,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              member.memberNo.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.primary,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              member.name.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    // Uri uri = Uri.parse('mailto:${member.email}');

                    // launchUrl(uri);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: Container(
                      height: 50.sp,
                      width: 50.sp,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      child: Icon(
                        Ionicons.mail_outline,
                        size: 25.sp,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Uri uri = Uri.parse('tel:${member.phone}');

                    launchUrl(uri);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: Container(
                      height: 50.sp,
                      width: 50.sp,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      child: Icon(
                        Ionicons.call_outline,
                        size: 25.sp,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Uri uri = Uri.parse('https://wa.me/${member.phone}');

                    bool res = await canLaunchUrl(uri);
                    if (res) {
                      launchUrl(uri);
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: Container(
                      height: 50.sp,
                      width: 50.sp,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      child: Icon(
                        Ionicons.logo_whatsapp,
                        size: 25.sp,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Text(
              'No Kad Pengenalan',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              member.ic.toString(),
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Pekerjaan',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              member.occupation.toString(),
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Alamat',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              member.address.toString(),
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
