import 'package:flutter/material.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/pages/home/claim/check_claim.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_khairat_admin/models/claim.dart';

class PageClaim extends StatefulWidget {
  const PageClaim({Key? key}) : super(key: key);

  @override
  State<PageClaim> createState() => _PageClaimState();
}

class _PageClaimState extends State<PageClaim> {
  List<Claim> claims = [];
  List<Claim> filteredclaims = [];

  filterclaims() {
    filteredclaims.clear();
    for (var claim in claims) {
      if (claim.status == 'pending') {
        filteredclaims.add(claim);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    claims.addAll([
      Claim(
          id: '0',
          claimerID: '0',
          claimerIC: '001114236780',
          claimerName: 'Ahmad Najim Bin Abu Somad',
          claimerVillage: 'kampung telok mas',
          proveURL:
              'https://i.pinimg.com/236x/f7/2c/7e/f72c7e5e75ae1737feff8ef29d34cc73.jpg',
          status: 'pending')
    ]);
    filterclaims();
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
      body: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Expanded(
              child: claims.isEmpty
                  ? const Center(child: Text('tiada rekod'))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: claims.length,
                      //physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            padding: EdgeInsets.all(1.h),
                            child: SizedBox(
                              height: 13.h,
                              child: Card(
                                elevation: 5,
                                margin: EdgeInsets.symmetric(horizontal: 7.h),
                                color: Colors.white,
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  padding: EdgeInsets.all(2.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Center(
                                          child: Text(filteredclaims[index]
                                              .claimerName!)),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                        width: 14.h,
                                        child: ElevatedButton(
                                          onPressed: () => Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      const CheckClaim())),
                                          child: Text('Lihat butiran'),
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
                      })),
        ],
      ),
    );
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
              boxShadow: [
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
