import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_khairat_admin/models/claim.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:sizer/sizer.dart';
import 'package:photo_view/photo_view.dart';

class CheckClaim extends StatefulWidget {
  const CheckClaim({Key? key, required this.claim}) : super(key: key);

  final Claim claim;
  @override
  State<CheckClaim> createState() => _CheckClaimState();
}

class _CheckClaimState extends State<CheckClaim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: Text(
          'Semak Tuntutan',
          style: TextStyle(
            color: AppColor.primary,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(1.h),
        width: double.infinity,
        child: Card(
          elevation: 2,
          color: Colors.white,
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                    const Text(
                      "Nama seperti IC",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      '${widget.claim.claimerName}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      "NO IC",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      '${widget.claim.claimerIC}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      "Kariah",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      '${widget.claim.mosqueID}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      "Surat Kematian",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) => ImageDialog(
                                  imagePath: widget.claim.claimerurl!,
                                ));
                      },
                      child: Image.file(
                        File(widget.claim.claimerurl!),
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
                            backgroundColor:
                                MaterialStateProperty.all(AppColor.primary),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.h)),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("Tolak"),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red[800]),
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
            ],
          ),
        ),
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  const ImageDialog({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      child: PhotoView(
        imageProvider: FileImage(File(imagePath)),
      ),
    ));
  }
}
