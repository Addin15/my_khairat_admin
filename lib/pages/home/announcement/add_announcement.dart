import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_khairat_admin/DAO/announcement_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/announcement.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class AddAnnouncement extends StatefulWidget {
  const AddAnnouncement(
      {required this.announcementDAO, required this.mosqueID, Key? key})
      : super(key: key);

  final AnnouncementDAO announcementDAO;
  final String mosqueID;

  @override
  _AddAnnouncementState createState() => _AddAnnouncementState();
}

class _AddAnnouncementState extends State<AddAnnouncement> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  String imgURL = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: Text(
          'Tambah Pengumuman',
          style: TextStyle(
            color: AppColor.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                width: double.infinity,
                height: 50.h,
                color: AppColor.primary,
              ),
            ),
            Center(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Tambah Pengumuman',
                      style: TextStyle(
                        fontFamily: "Reem Kufi",
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(1.h),
                      width: 80.w,
                      height: 65.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 15,
                            offset: Offset(0.0, 15.0),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              width: 80.w,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10.0..sp),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 15.sp, right: 15.sp, top: 5.sp),
                                child: TextFormField(
                                  controller: _titleController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Tajuk',
                                      labelStyle: TextStyle(
                                          color: Colors.white, fontSize: 12.sp),
                                      fillColor: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            padding: EdgeInsets.all(8.sp),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: TextField(
                              controller: _contentController,
                              textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              maxLines: 10,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Isi maklumat pengumuman',
                                  hintStyle: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          SizedBox(
                            width: 80.w,
                            height: 10.h,
                            child: ElevatedButton.icon(
                              icon: Icon(
                                Icons.add_a_photo_outlined,
                                size: 24.sp,
                              ),
                              onPressed: () {},
                              label: Text(
                                'Tambah Gambar',
                                style: TextStyle(fontSize: 12.sp),
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
                                  showDialog(
                                      builder: (BuildContext context) {
                                        return Expanded(
                                          child: AlertDialog(
                                            title: Text(
                                              'Tambah Pengumuman',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontFamily: "Reem Kufi"),
                                              textAlign: TextAlign.center,
                                            ),
                                            content: Text(
                                              'Anda pasti menambah pengumuman ini?',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10.0.sp,
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
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2.h)),
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  widget.announcementDAO
                                                      .addAnnouncement(
                                                          widget.mosqueID,
                                                          Announcement(
                                                            title:
                                                                _titleController
                                                                    .text,
                                                            content:
                                                                _contentController
                                                                    .text,
                                                            imgURL: imgURL,
                                                            date: DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(DateTime
                                                                    .now()),
                                                          ));
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Tambah",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.0,
                                                      fontFamily: "Reem Kufi"),
                                                  textAlign: TextAlign.center,
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          AppColor.primary),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2.h)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      context: context);
                                },
                                child: const Text("Tambah"),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColor.primary),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.h),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 150);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 170);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
