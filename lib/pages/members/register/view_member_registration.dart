import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_khairat_admin/DAO/member_dao.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/config/config.dart';
import 'package:my_khairat_admin/models/member.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:photo_view/photo_view.dart';

class CheckRegistration extends StatefulWidget {
  const CheckRegistration(
      {required this.memberDAO, required this.member, Key? key})
      : super(key: key);

  final MemberDAO memberDAO;
  final Member member;

  @override
  State<CheckRegistration> createState() => _CheckRegistrationState();
}

class _CheckRegistrationState extends State<CheckRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: Text(
          'Pendaftaran Baru',
          style: TextStyle(
            color: AppColor.primary,
          ),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(1.h),
          width: double.infinity,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Card(
                elevation: 2,
                color: Colors.white,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: EdgeInsets.all(3.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Penuh (Seperti IC)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        widget.member.name!,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'No Kad Pengenalan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        widget.member.ic!,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Kariah',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        widget.member.villageName!,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'No Telefon',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        widget.member.phone!,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Pekerjaan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        widget.member.occupation!,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Alamat',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        widget.member.address!,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Bukti Alamat',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      GestureDetector(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (_) => viewPicture(Config.host +
                                  widget.member.paymentProveImg!));
                        },
                        child: Center(
                          child: Image.network(
                            Config.host + widget.member.detailsProveImg!,
                            height: 30.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Bukti Pembayaran',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      GestureDetector(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (_) => viewPicture(Config.host +
                                  widget.member.paymentProveImg!));
                        },
                        child: Center(
                          child: Image.network(
                            Config.host + widget.member.paymentProveImg!,
                            height: 30.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          customTextButton(
                            label: 'Terima',
                            onPressed: () async {
                              MosqueDAO mosqueDAO = Provider.of<MosqueDAO>(
                                  context,
                                  listen: false);
                              await widget.memberDAO.acceptMember(
                                  mosqueDAO.mosque!.id!, widget.member.id!);
                              Navigator.of(context).pop();
                            },
                          ),
                          customTextButton(
                            label: 'Tolak',
                            backgroundColor: Colors.red,
                            borderColor: Colors.red,
                            onPressed: () async {
                              MosqueDAO mosqueDAO = Provider.of<MosqueDAO>(
                                  context,
                                  listen: false);
                              await widget.memberDAO.rejectMember(
                                  mosqueDAO.mosque!.id!, widget.member.id!);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  viewPicture(String? url) {
    return Dialog(
      child: PhotoView(
        imageProvider: NetworkImage(url!),
      ),
    );
  }
}
