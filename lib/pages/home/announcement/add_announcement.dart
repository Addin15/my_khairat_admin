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
  final GlobalKey<FormState> _formKey = GlobalKey();

  String imgURL = '';

  String contentError = '';

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 2.h),
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
                        SizedBox(height: 2.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          width: 90.w,
                          height: 75.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 1,
                                offset: Offset(0.0, 1.0),
                              )
                            ],
                          ),
                          child: ListView(
                            children: [
                              SizedBox(height: 1.h),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  width: 96.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5.sp),
                                  ),
                                  child: TextFormField(
                                    expands: false,
                                    validator: (value) => value!.isEmpty
                                        ? 'Sila isi tajuk pengumuman'
                                        : null,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12.sp),
                                    controller: _titleController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 1.h),
                                        hintText: 'Tajuk',
                                        hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp),
                                        fillColor: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Container(
                                width: 96.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                child: TextField(
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.sp),
                                  controller: _contentController,
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 20,
                                  //expands: true,
                                  decoration: InputDecoration(
                                    fillColor: Colors.red,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(5.sp)),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 1.h),
                                    hintText: 'Isi maklumat pengumuman',
                                    errorText: contentError,
                                    hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              SizedBox(
                                width: double.infinity,
                                height: 10.h,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.sp),
                                    ),
                                  ),
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
                                  customTextButton(
                                      label: 'Tambah',
                                      onPressed: () {
                                        showDialog(
                                            builder: (BuildContext context) {
                                              return AlertDialog(
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
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                actions: [
                                                  customTextButton(
                                                      label: 'Batal',
                                                      backgroundColor:
                                                          Colors.white,
                                                      labelColor:
                                                          AppColor.primary,
                                                      borderColor:
                                                          AppColor.primary,
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context)),
                                                  customTextButton(
                                                      label: 'Tambah',
                                                      onPressed: () {
                                                        if (contentError
                                                            .isNotEmpty) {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            widget
                                                                .announcementDAO
                                                                .addAnnouncement(
                                                                    widget
                                                                        .mosqueID,
                                                                    Announcement(
                                                                      title: _titleController
                                                                          .text,
                                                                      content:
                                                                          _contentController
                                                                              .text,
                                                                      imgURL:
                                                                          imgURL,
                                                                      date: DateFormat(
                                                                              'yyyy-MM-dd')
                                                                          .format(
                                                                              DateTime.now()),
                                                                    ));
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        } else {
                                                          setState(() {
                                                            contentError =
                                                                'Sila isi maklumat pengumuman';
                                                          });
                                                        }

                                                        Navigator.pop(context);
                                                      })
                                                ],
                                              );
                                            },
                                            context: context);
                                      })
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
