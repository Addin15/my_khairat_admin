import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/village.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class PageVillage extends StatefulWidget {
  const PageVillage({required this.villages, Key? key}) : super(key: key);

  final List<Village> villages;

  @override
  State<PageVillage> createState() => _PageVillageState();
}

class _PageVillageState extends State<PageVillage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  List<Village> villages = [];

  @override
  void initState() {
    villages = widget.villages;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(villages.length.toString());
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: Text(
          'Kariah',
          style: TextStyle(
            color: AppColor.primary,
          ),
        ),
      ),
      body: SizedBox(
        width: 100.w,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: TextButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: AppColor.primary,
                ),
                icon: Icon(
                  Ionicons.add_outline,
                  color: Colors.white,
                  size: 18.sp,
                ),
                label: Text(
                  'Tambah Kariah',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              child: TextFormField(
                controller: _searchController,
                focusNode: _searchFocus,
                decoration: InputDecoration(
                  hintText: 'Cari kariah',
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
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: villages.length,
                separatorBuilder: (context, index) => SizedBox(height: 1.h),
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(villages[index].name!),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Ionicons.ellipsis_vertical_outline,
                                size: 12.sp,
                              ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
