import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/village.dart';
import 'package:my_khairat_admin/pages/home/grave/add_grave.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class PageGrave extends StatefulWidget {
  const PageGrave({Key? key}) : super(key: key);

  @override
  State<PageGrave> createState() => _PageGraveState();
}

class _PageGraveState extends State<PageGrave> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: Text(
          'Kemaskini Kubur',
          style: TextStyle(
            color: AppColor.primary,
          ),
        ),
      ),
      body: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () => Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => AddGrave())),
                style: TextButton.styleFrom(
                  backgroundColor: AppColor.primary,
                ),
                icon: Icon(
                  Ionicons.add_outline,
                  color: Colors.white,
                  size: 18.sp,
                ),
                label: Text(
                  'Tambah Kubur',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            TextFormField(
              controller: _searchController,
              focusNode: _searchFocus,
              decoration: InputDecoration(
                hintText: 'Cari kubur',
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
          ],
        ),
      ),
    );
  }
}
