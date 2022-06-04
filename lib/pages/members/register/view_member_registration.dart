import 'package:flutter/material.dart';
import 'package:my_khairat_admin/models/member.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:sizer/sizer.dart';
import 'package:photo_view/photo_view.dart';

class CheckRegistration extends StatefulWidget {
  const CheckRegistration({required this.member, Key? key}) : super(key: key);

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
                              context: context, builder: (_) => BillDialog());
                        },
                        child: Center(
                          child: Image.network(
                            'https://i.pinimg.com/236x/f7/2c/7e/f72c7e5e75ae1737feff8ef29d34cc73.jpg',
                            height: 30.h,
                            fit: BoxFit.fill,
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
                              context: context, builder: (_) => ResitDialog());
                        },
                        child: Center(
                          child: Image.network(
                            'https://i.pinimg.com/236x/f7/2c/7e/f72c7e5e75ae1737feff8ef29d34cc73.jpg',
                            height: 30.h,
                            fit: BoxFit.fill,
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
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          customTextButton(
                            label: 'Tolak',
                            backgroundColor: Colors.red,
                            borderColor: Colors.red,
                            onPressed: () {
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
}

class BillDialog extends StatelessWidget {
  const BillDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      child: PhotoView(
        imageProvider: NetworkImage(
            'https://i.pinimg.com/236x/f7/2c/7e/f72c7e5e75ae1737feff8ef29d34cc73.jpg'),
      ),
    ));
  }
}

class ResitDialog extends StatelessWidget {
  const ResitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      child: PhotoView(
        imageProvider: NetworkImage(
            'https://i.pinimg.com/236x/f7/2c/7e/f72c7e5e75ae1737feff8ef29d34cc73.jpg'),
      ),
    ));
  }
}
