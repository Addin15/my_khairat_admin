import 'package:flutter/material.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class ViewAnnouncement extends StatefulWidget {
  @override
  _ViewAnnouncementState createState() => _ViewAnnouncementState();
}

class _ViewAnnouncementState extends State<ViewAnnouncement> {
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
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColor.primary),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
