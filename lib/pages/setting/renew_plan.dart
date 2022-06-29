import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/DAO/plan_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class RenewPlan extends StatefulWidget {
  const RenewPlan(
      {required this.mosqueDAO,
      required this.mosqueID,
      required this.planDAO,
      Key? key})
      : super(key: key);

  final MosqueDAO mosqueDAO;
  final String mosqueID;
  final PlanDAO planDAO;

  @override
  State<RenewPlan> createState() => _RenewPlanState();
}

class _RenewPlanState extends State<RenewPlan> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _remarkController = TextEditingController();
  final FocusNode _remarkFocus = FocusNode();

  XFile? image;

  Map<String, dynamic>? bankDetails;

  getAdminBank() async {
    Map<String, dynamic>? data = await widget.mosqueDAO.getAdminBank();

    if (data != null) {
      setState(() {
        bankDetails = data;
      });
    }
  }

  @override
  void initState() {
    getAdminBank();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: customAppBar(context: context, title: Text('Buat Pembayaran')),
        body: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                bankDetails == null
                    ? const SizedBox.shrink()
                    : Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 2.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp)),
                        child: Column(
                          children: [
                            Text('Bank Name: ' + bankDetails!['bank_name']),
                            SizedBox(height: 1.h),
                            Text('Bank Account Name: ' +
                                bankDetails!['bank_owner_name']),
                            SizedBox(height: 1.h),
                            Text('Bank Account Number: ' +
                                bankDetails!['bank_account_no']),
                            SizedBox(height: 1.h),
                            Text('Yuran: RM' +
                                bankDetails!['monthly_fee']
                                    .toDouble()
                                    .toStringAsFixed(2)),
                            SizedBox(height: 1.h),
                          ],
                        ),
                      ),
                SizedBox(height: 3.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: customTextFormField(
                    hintText: 'Nota',
                    icon: Icons.note,
                    controller: _remarkController,
                    focusNode: _remarkFocus,
                    validator: (val) =>
                        val!.isEmpty ? 'Sila isi nota pembayaran' : null,
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: customTextButton(
                    label: 'Muatnaik Gambar',
                    backgroundColor:
                        image == null ? Colors.grey : AppColor.primary,
                    borderColor: image == null ? Colors.grey : AppColor.primary,
                    onPressed: () async {
                      ImagePicker imagePicker = ImagePicker();

                      await showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          insetPadding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 10.w,
                          ),
                          child: SizedBox(
                            height: 10.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        XFile? file =
                                            await imagePicker.pickImage(
                                                source: ImageSource.camera);
                                        Navigator.pop(context);

                                        if (mounted && file != null) {
                                          setState(() {
                                            image = file;
                                          });
                                        }
                                      },
                                      icon: Icon(Ionicons.camera_outline),
                                    ),
                                    Text('Kamera'),
                                  ],
                                ),
                                SizedBox(width: 2.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        XFile? file =
                                            await imagePicker.pickImage(
                                                source: ImageSource.gallery);
                                        Navigator.pop(context);

                                        if (mounted && file != null) {
                                          setState(() {
                                            image = file;
                                          });
                                        }
                                      },
                                      icon: Icon(Ionicons.image_outline),
                                    ),
                                    Text('Galeri'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 1.h),
                image == null
                    ? const SizedBox.shrink()
                    : Text(
                        image!.name,
                        textAlign: TextAlign.center,
                      ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: customTextButton(
                      label: 'Hantar',
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            image != null) {
                          await widget.planDAO.makePayment({
                            'mosque_id': widget.mosqueID,
                            'remark': _remarkController.text,
                          }, image!);

                          if (mounted) {
                            Navigator.pop(context);
                          }
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
