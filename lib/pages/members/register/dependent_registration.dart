import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_khairat_admin/DAO/dependent_dao.dart';
import 'package:my_khairat_admin/DAO/member_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/dependent.dart';
import 'package:my_khairat_admin/models/member.dart';
import 'package:my_khairat_admin/pages/members/register/add_dependent.dart';
import 'package:my_khairat_admin/pages/members/register/view_dependent_registration.dart';
import 'package:my_khairat_admin/pages/members/register/view_member_registration.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DependentRegistration extends StatefulWidget {
  const DependentRegistration({Key? key}) : super(key: key);

  @override
  State<DependentRegistration> createState() => _DependentRegistrationState();
}

class _DependentRegistrationState extends State<DependentRegistration> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemberDAO>(builder: (context, memberDAO, child) {
      List<Member> members = memberDAO.pendingMembers;
      return Consumer<DependentDAO>(builder: (context, dependentDAO, child) {
        List<Dependent> dependents = dependentDAO.pendingDependents;
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Pendaftaran Tanggungan Ahli',
                    style: TextStyle(
                        color: AppColor.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => AddDependent(
                          memberDAO: memberDAO,
                          dependentDAO: dependentDAO,
                        ),
                      ),
                    );
                  },
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.add_outlined,
                    size: 22.sp,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Expanded(
              child: dependents.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      child: const Text('Tiada pendaftaran'),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: dependents.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        Dependent dependent = dependents[index];
                        return Container(
                          padding: EdgeInsets.all(1.h),
                          child: dependentCard(
                            dependent: dependent,
                            dependentDAO: dependentDAO,
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      });
    });
  }

  Widget dependentCard({
    required Dependent dependent,
    required DependentDAO dependentDAO,
  }) {
    return SizedBox(
      child: Card(
        elevation: 5,
        color: Colors.white,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dependent.dependName!,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 0.8.h),
              Text(
                'Hubungan: ' + dependent.relation!,
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                'Nama: ' + dependent.name!,
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                alignment: Alignment.centerRight,
                child: customTextButton(
                  label: 'Lihat Butiran',
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => CheckDependentRegistration(
                          dependent: dependent,
                          dependentDAO: dependentDAO,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
