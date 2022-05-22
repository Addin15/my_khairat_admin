import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/pages/auth/login.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneNoFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'my',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.normal,
                          fontSize: 24.sp,
                        ),
                      ),
                      Text(
                        'Khairat',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.sp,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 1.h),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Mengesahkan Pendaftaran',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.sp),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WidgetConstants.customTextFormField(
                            hintText: 'Nama Masjid',
                            icon: Ionicons.home,
                            controller: _nameController,
                            focusNode: _nameFocus,
                            validator: (text) => text!.length >= 6
                                ? null
                                : 'Nama masjid mesti melebihi dari 6!',
                          ),
                          SizedBox(height: 2.h),
                          WidgetConstants.customTextFormField(
                            hintText: 'Alamat',
                            icon: Ionicons.location,
                            controller: _addressController,
                            focusNode: _addressFocus,
                            isObscured: true,
                            validator: (text) => text!.length >= 6
                                ? null
                                : 'Alamat hendaklah sekurangnya 6 angka!',
                          ),
                          SizedBox(height: 2.h),
                          WidgetConstants.customTextFormField(
                            hintText: 'No Telefon',
                            icon: Ionicons.call,
                            controller: _phoneNoController,
                            focusNode: _phoneNoFocus,
                            isObscured: true,
                            validator: (text) => text!.length >= 6
                                ? null
                                : 'Isi nombor telefon anda!',
                          ),
                          SizedBox(height: 5.h),
                          WidgetConstants.customTextButton(
                            label: 'Daftar',
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()) {
                                // Register logic

                              }
                            },
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Telah ada akaun?'),
                              SizedBox(width: 1.w),
                              GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => const Login()));
                                },
                                child: Text(
                                  'Log Masuk',
                                  style: TextStyle(
                                      color: AppColor.primary,
                                      fontWeight: FontWeight.w800),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
