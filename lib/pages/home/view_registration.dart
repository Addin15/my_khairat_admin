import 'package:flutter/material.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class ViewRegistration extends StatefulWidget {
  const ViewRegistration({Key? key}) : super(key: key);

  @override
  State<ViewRegistration> createState() => _ViewRegistrationState();
}

class _ViewRegistrationState extends State<ViewRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mykhairat",
          style: TextStyle(color: AppColor.primary, fontSize: 14.sp),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Ionicons.chevron_back),
          color: AppColor.primary,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          HeaderPage(),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  //physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: EdgeInsets.all(1.h), child: namecard());
                  })),
        ],
      ),
    );
  }
}

class namecard extends StatelessWidget {
  const namecard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 13.h,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 7.h),
        color: Colors.white,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(2.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(child: Text('Ahmad ibrahim  ')),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                height: 3.h,
                width: 14.h,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Lihat butiran'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColor.primary),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.h)))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderPage extends StatelessWidget {
  const HeaderPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 3.h),
      child: Stack(
        children: [
          Container(
            height: 7.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.primary,
                  AppColor.secondary,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Pendaftaran Baru',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
