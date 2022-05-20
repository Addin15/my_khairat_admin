import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/pages/register/view_registration.dart';
import 'package:my_khairat_admin/pages/home/home.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';


class Members extends StatefulWidget {
  const Members({Key? key}) : super(key: key);

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  final TextEditingController _searchController = TextEditingController();

  final FocusNode _searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _searchFocus.unfocus();
      },
      child: Scaffold(
        body: Container(
          width: 100.w,
          height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            children: [
              GridView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: [
                  MenuBox(
                    icon: 'assets/members/consent.png',
                    label: 'Semak Pendaftaran Ahli Baharu',
                    onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const ViewRegistration())),
                  ),
                  MenuBox(
                    icon: 'assets/members/consent.png',
                    label: 'Semak Pendaftaran Tanggungan',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              TextFormField(
                controller: _searchController,
                focusNode: _searchFocus,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Ionicons.search_outline,
                    color: AppColor.primary,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                    borderSide: BorderSide(color: AppColor.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                    borderSide: BorderSide(color: AppColor.primary),
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Expanded(
                child: Center(
                  child: Text('Tiada pencarian'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

