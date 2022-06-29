import 'package:flutter/material.dart';
import 'package:my_khairat_admin/DAO/dependent_dao.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/dependent.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CheckDependentRegistration extends StatefulWidget {
  const CheckDependentRegistration({
    required this.dependent,
    required this.dependentDAO,
    Key? key,
  }) : super(key: key);

  final Dependent dependent;
  final DependentDAO dependentDAO;

  @override
  State<CheckDependentRegistration> createState() =>
      _CheckDependentRegistrationState();
}

class _CheckDependentRegistrationState
    extends State<CheckDependentRegistration> {
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
                        'Nama Pendaftar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        widget.dependent.dependName!,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Hubungan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        widget.dependent.relation!,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Nama Penuh Tanggungan (Seperti IC)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        widget.dependent.name!,
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
                        widget.dependent.ic!,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'No Telefon',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        widget.dependent.phone ?? '-',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Pekerjaan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        widget.dependent.occupation ?? '-',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Alamat',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        widget.dependent.address ?? '-',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
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
                              MosqueDAO mosqueDAO = Provider.of<MosqueDAO>(
                                  context,
                                  listen: false);
                              widget.dependentDAO.acceptDependent(
                                  mosqueDAO.mosque!.id!, widget.dependent.id!);
                              Navigator.of(context).pop();
                            },
                          ),
                          customTextButton(
                            label: 'Tolak',
                            backgroundColor: Colors.red,
                            borderColor: Colors.red,
                            onPressed: () {
                              MosqueDAO mosqueDAO = Provider.of<MosqueDAO>(
                                  context,
                                  listen: false);
                              widget.dependentDAO.rejectDependent(
                                  mosqueDAO.mosque!.id!, widget.dependent.id!);
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
