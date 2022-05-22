import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/pages/home/announcement/edit_announcement.dart';
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
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: Center(
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(color: AppColor.primary),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.sp),
                        width: 70.w,
                        height: 70.h,
                        child: Column(
                          children: [
                            Image.network(
                                'https://static.vecteezy.com/system/resources/previews/000/524/905/original/hari-raya-vector.jpg'),
                            SizedBox(
                              height: 2.h,
                            ),
                            Center(
                              child: Text(
                                'Selamat Hari Raya',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Reem Kufi"),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Center(
                              child: Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
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
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => EditAnnouncement()));
                  },
                  child: Text("Ubah"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColor.primary),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.h)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                ElevatedButton(
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
                                        MaterialStateProperty.all(Colors.white),
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
                                    backgroundColor: MaterialStateProperty.all(
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
                  },
                  child: Text("Padam"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red[800]),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.h)),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
