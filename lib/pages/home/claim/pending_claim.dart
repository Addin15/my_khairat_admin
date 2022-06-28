import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_khairat_admin/DAO/claim_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/claim.dart';
import 'package:my_khairat_admin/pages/home/claim/check_claim.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class PendingClaim extends StatefulWidget {
  const PendingClaim({Key? key, required this.dao, required this.pendingClaims})
      : super(key: key);

  final List<Claim> pendingClaims;
  final ClaimDAO dao;

  @override
  State<PendingClaim> createState() => _PendingClaimState();
}

class _PendingClaimState extends State<PendingClaim> {
  List<Claim> pendingClaims = [];

  refresh() {
    List<Claim> temp = pendingClaims;
    pendingClaims.clear();
    for (var claim in temp) {
      log(claim.status!);
      if (claim.status == 'pending') {
        pendingClaims.add(claim);
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    pendingClaims = widget.pendingClaims;
    super.initState();
  }

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
      body: SizedBox(
        width: 100.w,
        child: Column(
          children: [
            Expanded(
              child: pendingClaims.isEmpty
                  ? const Center(child: Text('tiada rekod'))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: pendingClaims.length,
                      //physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        Claim claim = pendingClaims[index];
                        return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 2.w),
                            child: SizedBox(
                              child: Card(
                                elevation: 5,
                                margin: EdgeInsets.symmetric(horizontal: 6.h),
                                color: Colors.white,
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.h, horizontal: 2.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Pemohon : " + claim.claimername!),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text("Arwah : " + claim.deadname!),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text("Status : " + claim.status!),
                                      Container(
                                        height: 4.h,
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                          onPressed: () => Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      CheckClaim(
                                                        claim: claim,
                                                      ))).then((value) {
                                            if (value) {
                                              String changingID =
                                                  pendingClaims[index].id!;
                                              pendingClaims[index].status ==
                                                  'success';
                                              widget.dao.changeClaimStatus(
                                                  changingID, 'success');
                                              refresh();
                                            } else {
                                              // if payment is rejected
                                              String changingID =
                                                  pendingClaims[index].id!;
                                              pendingClaims[index].status ==
                                                  'rejected';
                                              widget.dao.changeClaimStatus(
                                                  changingID, 'rejected');
                                              refresh();
                                            }
                                          }),
                                          child: const Text('Lihat butiran'),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      AppColor.primary),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.h)))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
