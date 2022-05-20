import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/pages/home/home.dart';
import 'package:my_khairat_admin/pages/members/members.dart';
import 'package:my_khairat_admin/pages/profile/setting.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int selectedPage = 0;
  final PageController _pageController = PageController();

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
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (val) {
          setState(() {
            selectedPage = val;
          });
        },
        children: const [
          Home(),
          Members(),
          Setting(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPage,
        onTap: (val) {
          setState(() {
            selectedPage = val;
            _pageController.jumpToPage(val);
          });
        },
        iconSize: 20.sp,
        selectedFontSize: 10.sp,
        unselectedFontSize: 9.sp,
        selectedItemColor: AppColor.primary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: 'Halaman Utama',
            icon: Icon(Ionicons.grid_outline),
            activeIcon: Icon(Ionicons.grid),
          ),
          BottomNavigationBarItem(
            label: 'Ahli Khairat',
            icon: Icon(Ionicons.people_outline),
            activeIcon: Icon(Ionicons.people),
          ),
          BottomNavigationBarItem(
            label: 'Tetapan',
            icon: Icon(Ionicons.cog_outline),
            activeIcon: Icon(Ionicons.cog),
          ),
        ],
      ),
    );
  }
}
