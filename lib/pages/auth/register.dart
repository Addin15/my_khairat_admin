import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/auth.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/controllers/auth_controller.dart';
import 'package:my_khairat_admin/pages/auth/login.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class Register extends StatefulWidget {
  const Register({required this.mosqueDAO, Key? key}) : super(key: key);

  final MosqueDAO mosqueDAO;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  String? error;
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
                resizeToAvoidBottomInset: false,
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
                          'DAFTAR',
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
                              error == null
                                  ? const SizedBox.shrink()
                                  : Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.sp),
                                        border: Border.all(color: Colors.red),
                                        color: Colors.red.withOpacity(0.4),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 2.h),
                                      child: Text(
                                        error!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                              SizedBox(height: 1.h),
                              customTextFormField(
                                hintText: 'E-mel',
                                icon: Ionicons.mail_outline,
                                controller: _emailController,
                                focusNode: _emailFocus,
                                validator: (text) =>
                                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(text!)
                                        ? null
                                        : 'Emel tidak sah!',
                              ),
                              SizedBox(height: 2.h),
                              customTextFormField(
                                hintText: 'Kata Laluan',
                                icon: Ionicons.key_outline,
                                controller: _passwordController,
                                focusNode: _passwordFocus,
                                isObscured: true,
                                validator: (text) => text!.length >= 6
                                    ? null
                                    : 'Kata laluan hendaklah sekurangnya 6 angka!',
                              ),
                              SizedBox(height: 2.h),
                              customTextFormField(
                                hintText: 'Pengesahan Kata Laluan',
                                icon: Ionicons.key_outline,
                                controller: _confirmPasswordController,
                                focusNode: _confirmPasswordFocus,
                                isObscured: true,
                                validator: (text) => text!.length >= 6
                                    ? null
                                    : 'Kata laluan hendaklah sekurangnya 6 angka!',
                              ),
                              SizedBox(height: 10.h),
                              customTextButton(
                                label: 'Daftar',
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    // Register logic

                                    bool res = await widget.mosqueDAO.register(
                                        _emailController.text,
                                        _passwordController.text);

                                    if (!res) {
                                      error =
                                          'Akaun telah wujud! Sila log masuk ';
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  }

                                  setState(() {
                                    isLoading = false;
                                  });
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
                                      Navigator.of(context).pop();
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
