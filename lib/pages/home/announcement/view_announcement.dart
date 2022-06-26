import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:my_khairat_admin/DAO/announcement_dao.dart';
import 'package:my_khairat_admin/config/config.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/announcement.dart';
import 'package:my_khairat_admin/pages/home/announcement/edit_announcement.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class ViewAnnouncement extends StatefulWidget {
  const ViewAnnouncement({
    required this.announcementDAO,
    required this.announcement,
    Key? key,
  }) : super(key: key);

  final AnnouncementDAO announcementDAO;
  final Announcement announcement;

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
        appBar: customAppBar(
          context: context,
          title: Text(
            'Pengumuman',
            style: TextStyle(
              color: AppColor.primary,
            ),
          ),
        ),
        body: SizedBox(
          width: 100.w,
          child: Column(
            children: [
              SizedBox(height: 1.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.sp),
                  color: AppColor.primary,
                ),
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.sp),
                      width: 70.w,
                      height: 70.h,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          widget.announcement.imgURL == null ||
                                  widget.announcement.imgURL!.isEmpty
                              ? const SizedBox.shrink()
                              : Image.network(
                                  Config.host + widget.announcement.imgURL!),
                          SizedBox(height: 2.h),
                          Center(
                            child: Text(
                              widget.announcement.title!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Reem Kufi"),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Center(
                            child: Text(
                              widget.announcement.content!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontFamily: "Reem Kufi"),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customTextButton(
                      label: 'Sunting',
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => EditAnnouncement(
                                      announcementDAO: widget.announcementDAO,
                                      announcement: widget.announcement,
                                    )));
                      }),
                  SizedBox(
                    width: 5.w,
                  ),
                  customTextButton(
                      label: 'Padam',
                      backgroundColor: Colors.red[800],
                      borderColor: Colors.red[800],
                      onPressed: () {
                        showDialog(
                            builder: (BuildContext context) {
                              return Expanded(
                                child: AlertDialog(
                                  title: Text(
                                    'Sahkan Padam',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: "Reem Kufi"),
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Text(
                                    'Anda pasti memadam pengumuman ini?',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.sp,
                                        fontFamily: "Reem Kufi"),
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Kembali",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10.0.sp,
                                            fontFamily: "Reem Kufi"),
                                        textAlign: TextAlign.center,
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.h)),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Padam",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10.0.sp,
                                            fontFamily: "Reem Kufi"),
                                        textAlign: TextAlign.center,
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[900]),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.h)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            context: context);
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
