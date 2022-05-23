import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/controllers/auth_controller.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/pages/auth/login.dart';
import 'package:my_khairat_admin/pages/nav.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({required this.mosque, Key? key}) : super(key: key);

  final Mosque mosque;

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneNoFocus = FocusNode();
  final FocusNode _postcodeFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
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
                          child: Center(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                customTextFormField(
                                  hintText: 'Nama Masjid',
                                  icon: Ionicons.home,
                                  controller: _nameController,
                                  focusNode: _nameFocus,
                                  validator: (text) => text!.length >= 6
                                      ? null
                                      : 'Nama masjid mesti melebihi dari 6!',
                                ),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                  hintText: 'No Telefon',
                                  icon: Ionicons.call,
                                  controller: _phoneNoController,
                                  focusNode: _phoneNoFocus,
                                  validator: (text) => text!.length >= 6
                                      ? null
                                      : 'Isi nombor telefon anda!',
                                ),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                  hintText: 'Poskod',
                                  icon: Ionicons.locate,
                                  controller: _postcodeController,
                                  focusNode: _postcodeFocus,
                                  validator: (text) => text!.isNotEmpty
                                      ? null
                                      : 'Sila isi poskod',
                                ),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                  hintText: 'Negeri',
                                  icon: Ionicons.navigate,
                                  controller: _stateController,
                                  focusNode: _stateFocus,
                                  validator: (text) => text!.isNotEmpty
                                      ? null
                                      : 'Sila isi maklumat negeri',
                                ),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                  hintText: 'Alamat',
                                  icon: Ionicons.location,
                                  controller: _addressController,
                                  focusNode: _addressFocus,
                                  validator: (text) => text!.length >= 6
                                      ? null
                                      : 'Alamat hendaklah sekurangnya 6 angka!',
                                ),
                                SizedBox(height: 5.h),
                                customTextButton(
                                  label: 'Selesai',
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      isLoading = true;
                                    });

                                    Mosque mosque = Mosque(
                                      id: widget.mosque.id,
                                      email: widget.mosque.email,
                                      name: _nameController.text,
                                      phone: _phoneNoController.text,
                                      postcode: _postcodeController.text,
                                      state: _stateController.text,
                                      address: _addressController.text,
                                    );
                                    if (_formKey.currentState!.validate()) {
                                      // Complete profile logic
                                      bool res = await AuthController.complete(
                                          mosque: mosque);

                                      if (res) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Nav(mosque: mosque)));
                                      }
                                    }

                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                ),
                                SizedBox(height: 1.h),
                                customTextButton(
                                  label: 'Log Keluar',
                                  backgroundColor: Colors.red,
                                  borderColor: Colors.red,
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    await AuthController.logout();

                                    // Clear token and mosque cache
                                    SecureStorage _secureStorage =
                                        SecureStorage();
                                    _secureStorage.deleteAll();
                                    Box _mosqueBox =
                                        await Hive.openBox('mosque');
                                    await _mosqueBox.clear();
                                    await _mosqueBox.close();

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Login()));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        isLoading
            ? Container(
                color: Colors.white.withOpacity(0.3),
                alignment: Alignment.center,
                child: SpinKitChasingDots(color: AppColor.primary),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
