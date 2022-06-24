import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_khairat_admin/DAO/claim_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/controllers/claim_controller.dart';
import 'package:my_khairat_admin/pages/home/claim/check_claim.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_khairat_admin/models/claim.dart';

class PageClaim extends StatefulWidget {
  const PageClaim({Key? key, required this.mosqueID}) : super(key: key);

  final String mosqueID;
  @override
  State<PageClaim> createState() => _PageClaimState();
}

class _PageClaimState extends State<PageClaim> {
  List<Claim> claims = [];
  List<Claim> pendingClaims = [];
  List<Claim> successClaims = [];
  bool loading = true;

  getClaims() async {
    List<Claim> claims = await ClaimController.getClaims(widget.mosqueID);
    if (mounted) {
      setState(() {
        this.claims = claims;
        loading = false;
      });
    }
  }

  filterPendingClaims() {
    pendingClaims.clear();
    for (var claim in claims) {
      if (claim.status == 'pending') {
        pendingClaims.add(claim);
      }
    }
  }

  filterCompleteClaims() {
    successClaims.clear();
    for (var claim in claims) {
      if (claim.status == 'success') {
        successClaims.add(claim);
      }
    }
  }

  @override
  void initState() {
    getClaims();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Container(
        color: Colors.white,
        child: SpinKitChasingDots(
          color: AppColor.primary,
        ),
      );
    } else {
      return ChangeNotifierProvider(
        create: (context) => ClaimDAO(widget.mosqueID),
        child: Consumer<ClaimDAO>(builder: (context, claimdao, child) {
          claims = claimdao.claims;
          filterPendingClaims();
          filterCompleteClaims();
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
            body: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
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
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 6.h),
                                      color: Colors.white,
                                      shadowColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.h, horizontal: 2.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(claim.claimerName!),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(claim.claimerIC!),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(claim.status!),
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
                                                            ))),
                                                child:
                                                    const Text('Lihat butiran'),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppColor
                                                                .primary),
                                                    shape: MaterialStateProperty
                                                        .all(RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2.h)))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                            })),
              ],
            ),
          );
        }),
      );
    }
  }
}

class HeaderPage extends StatelessWidget {
  const HeaderPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 3.h),
      child: Stack(
        children: [
          Container(
            height: 7.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.primary,
                  AppColor.secondary,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Pendaftaran Baru',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
