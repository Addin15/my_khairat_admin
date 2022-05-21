import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  height: 500,
                  width: 300,
                  decoration: BoxDecoration(color: AppColor.primary),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 300.0,
                        height: 500.0,
                        child: Column(
                          children: [
                            Image.asset('assets/menu/hariraya.jpg'),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                'Selamat Hari Raya',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                    fontFamily: "Reem Kufi"),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
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
              height: 10,
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
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Buang"),
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
