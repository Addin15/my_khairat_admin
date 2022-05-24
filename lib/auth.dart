import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/pages/auth/complete_profile.dart';
import 'package:my_khairat_admin/pages/auth/login.dart';
import 'package:my_khairat_admin/pages/nav.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MosqueDAO>(
      create: (context) => MosqueDAO(),
      child: Consumer<MosqueDAO>(
        builder: (context, mosqueDAO, child) {
          Mosque? mosque = mosqueDAO.mosque;
          if (mosque == null) {
            return Login(mosqueDAO: mosqueDAO);
          } else if (mosque.name!.isEmpty) {
            return CompleteProfile(
              mosqueDAO: mosqueDAO,
            );
          } else {
            return Nav(mosqueDAO: mosqueDAO);
          }
        },
      ),
    );
  }
}
