import 'package:flutter/material.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  payment.payerName!,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tempoh Sah:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    SizedBox(
                      width: 40.w,
                      child: Text(
                        payment.startMonth == payment.endMonth &&
                                payment.startYear == payment.endYear
                            ? '${payment.startMonth}/${payment.startYear}'
                            : '${payment.startMonth}/${payment.startYear} hingga ${payment.endMonth}/${payment.endYear}',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumlah:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    SizedBox(
                      width: 40.w,
                      child: Text(
                        'RM${payment.amount!.toStringAsFixed(2)}',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Resit:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    SizedBox(
                      width: 40.w,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey,
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 1.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.sp),
                          ),
                        ),
                        child: Text(
                          'receipt',
                          style:
                              TextStyle(fontSize: 12.sp, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
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
