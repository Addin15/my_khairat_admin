import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/pages/auth/register.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

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
                      'LOG MASUK',
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
                            hintText: 'E-mel',
                            icon: Ionicons.mail_outline,
                            controller: _emailController,
                            focusNode: _emailFocus,
                          ),
                          SizedBox(height: 2.h),
                          WidgetConstants.customTextFormField(
                            hintText: 'Kata Laluan',
                            icon: Ionicons.key_outline,
                            controller: _passwordController,
                            focusNode: _passwordFocus,
                            isObscured: true,
                          ),
                          SizedBox(height: 10.h),
                          WidgetConstants.customTextButton(
                            label: 'Log Masuk',
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                            },
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('atau'),
                              SizedBox(width: 1.w),
                              GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const Register()));
                                },
                                child: Text(
                                  'Daftar',
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
