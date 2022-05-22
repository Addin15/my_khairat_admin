import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/pages/home/announcement/add_announcement.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

import 'package:my_khairat_admin/pages/home/announcement/view_announcement.dart';

class PageAnnouncement extends StatefulWidget {
  const PageAnnouncement({Key? key}) : super(key: key);

  @override
  State<PageAnnouncement> createState() => _PageAnnouncementState();
}

class _PageAnnouncementState extends State<PageAnnouncement> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: WidgetConstants.customAppBar(
          context,
          Text(
            'Pengumuman',
            style: TextStyle(
              color: AppColor.primary,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          child: Column(
            children: [
              TextFormField(
                controller: _searchController,
                focusNode: _searchFocus,
                decoration: InputDecoration(
                  hintText: 'Cari Pengumuman',
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
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAnnouncement()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.sp),
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          color: Colors.white,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.sp)),
                          child: Container(
                            padding: EdgeInsets.all(3.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.campaign,
                                      color: AppColor.primary,
                                      size: 24.sp,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                      child: Text(
                                        'Selamat Hari Raya',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0.sp,
                                            fontFamily: "Reem Kufi"),
                                      ),
                                    ),
                                    Icon(Icons.keyboard_arrow_right,
                                        color: AppColor.primary, size: 26.0.sp),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => AddAnnouncement()));
          },
          backgroundColor: AppColor.primary,
          child: (Icon(
            Icons.add,
            size: 24.sp,
          )),
        ),
      ),
    );
  }
}
