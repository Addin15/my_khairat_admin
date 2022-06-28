import 'package:flutter/material.dart';
import 'package:my_khairat_admin/config/config.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/controllers/payment_controller.dart';
import 'package:my_khairat_admin/models/payment.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class ViewPayment extends StatelessWidget {
  const ViewPayment({required this.payment, Key? key}) : super(key: key);

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: Text(
          'Pembayaran',
          style: TextStyle(color: AppColor.primary),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            width: 100.w,
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              border: Border.all(
                color: AppColor.primary,
                width: 1.sp,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  payment.payerName!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.h),
                Text('Tamat Tempoh:  ' +
                    payment.payerMonth.toString() +
                    '/' +
                    payment.payerYear.toString()),
                SizedBox(height: 2.h),
                SizedBox(height: 1.h),
                Image.network(Config.host + payment.proveURL!),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customTextButton(
                label: 'Terima',
                onPressed: () async {
                  bool res = await PaymentController.actionOnPayment(
                      payment.id.toString(), 'completed');
                  if (res) {
                    payment.status == 'completed';
                    Navigator.pop(context, true);
                  }
                },
              ),
              SizedBox(width: 2.w),
              customTextButton(
                label: 'Tolak',
                borderColor: Colors.red,
                backgroundColor: Colors.red,
                onPressed: () async {
                  payment.status == 'rejected';
                  Navigator.pop(context, false);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
