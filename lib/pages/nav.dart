import 'package:flutter/material.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'myKhairat',
          style: TextStyle(
            color: AppColor.primary,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: PageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPage,
        onTap: (val) {
          setState(() {
            selectedPage = val;
          });
        },
        iconSize: 20.sp,
        selectedFontSize: 10.sp,
        unselectedFontSize: 9.sp,
        selectedItemColor: AppColor.primary,
        items: const [
          BottomNavigationBarItem(
            label: 'Halaman Utama',
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: 'Ahli Kariah',
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: 'Profil',
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
