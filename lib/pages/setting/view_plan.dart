import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_khairat_admin/DAO/plan_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/plan.dart';
import 'package:my_khairat_admin/pages/setting/renew_plan.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ViewPlan extends StatefulWidget {
  const ViewPlan({
    this.mosqueID,
    this.expireMonth,
    this.expireYear,
    Key? key,
  }) : super(key: key);

  final String? mosqueID;
  final int? expireMonth;
  final int? expireYear;

  @override
  State<ViewPlan> createState() => _ViewPlanState();
}

class _ViewPlanState extends State<ViewPlan> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlanDAO(widget.mosqueID!),
      child: Consumer<PlanDAO>(
        builder: (context, planDAO, child) {
          List<Plan> plans = planDAO.plans;
          log(plans.length.toString());
          return Scaffold(
            appBar: customAppBar(
              context: context,
              title: Text(
                'Pelan',
                style: TextStyle(color: AppColor.primary),
              ),
            ),
            body: Center(
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Text(
                    'Tarikh Luput:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${widget.expireMonth}/${widget.expireYear}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: customTextButton(
                        label: 'Pembaharuan Pelan',
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => RenewPlan(
                                mosqueID: widget.mosqueID!,
                                planDAO: planDAO,
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 3.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(
                      'Sejarah Pembayaran',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...plans.map((plan) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.sp)),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.sp)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          plan.remark!,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Text(
                                          DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(plan.date!)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    plan.isDone == true
                                        ? plan.isRejected == true
                                            ? 'Rejected'
                                            : 'Accepted'
                                        : 'Pending',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: plan.isDone == true
                                          ? plan.isRejected == true
                                              ? Colors.red
                                              : Colors.green
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
