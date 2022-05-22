import 'package:flutter/material.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:sizer/sizer.dart';
import 'package:photo_view/photo_view.dart';

class CheckRegistration extends StatefulWidget {
  const CheckRegistration({Key? key}) : super(key: key);

  @override
  State<CheckRegistration> createState() => _CheckRegistrationState();
}

class _CheckRegistrationState extends State<CheckRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetConstants.customAppBar(
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
            children: [
              Card(
                elevation: 2,
                color: Colors.white,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nama seperti IC",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "Ahmad Najmi Bin Abdul Halim",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "NO IC",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "001123-12-1211",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Kariah",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "Masjid Muda Musa",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Bill berserta alamat",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => BillDialog());
                            },
                            child: Image.network(
                              'https://i.pinimg.com/236x/f7/2c/7e/f72c7e5e75ae1737feff8ef29d34cc73.jpg',
                              height: 30.h,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Resit Pembayaran",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => ResitDialog());
                            },
                            child: Image.network(
                              'https://i.pinimg.com/236x/f7/2c/7e/f72c7e5e75ae1737feff8ef29d34cc73.jpg',
                              height: 30.h,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text("Terima"),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColor.primary),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2.h)),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text("Tolak"),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.red[800]),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2.h)),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
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
