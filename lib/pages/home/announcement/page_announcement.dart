import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
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
                height: 20,
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
                        padding: EdgeInsets.all(8),
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(horizontal: 1.h),
                          color: Colors.white,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding: EdgeInsets.all(3.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Pengubahan Tarikh Bayaran',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontFamily: "Reem Kufi"),
                                ),
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
          onPressed: () {},
          backgroundColor: AppColor.primary,
          child: (Icon(Icons.add)),
        ),
      ),
    );
  }
}
