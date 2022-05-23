import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/pages/auth/complete_profile.dart';
import 'package:my_khairat_admin/pages/auth/login.dart';
import 'package:my_khairat_admin/pages/nav.dart';
import 'package:my_khairat_admin/styles/app_color.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  Future<dynamic> getCurrentUser() async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');
      Box _mosqueBox = await Hive.openBox('mosque');

      Mosque mosque = _mosqueBox.get(_token) as Mosque;

      log('ID' + mosque.name!);

      return mosque;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrentUser(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: SpinKitChasingDots(
                color: AppColor.primary,
              ));
        } else {
          dynamic data = snapshot.data;
          if (data == null) {
            return const Login();
          } else if ((data as Mosque).name!.isEmpty) {
            return CompleteProfile(
              mosque: data,
            );
          } else {
            return Nav(mosque: data);
          }
        }
      },
    );
  }
}
