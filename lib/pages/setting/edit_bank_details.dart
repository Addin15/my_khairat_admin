import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:my_khairat_admin/styles/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class EditBankDetails extends StatefulWidget {
  const EditBankDetails({
    required this.mosqueDAO,
    required this.bankName,
    required this.bankOwnerName,
    required this.bankAccountNo,
    required this.monthlyFee,
    Key? key,
  }) : super(key: key);

  final MosqueDAO mosqueDAO;
  final String bankName;
  final String bankOwnerName;
  final String bankAccountNo;
  final double monthlyFee;

  @override
  State<EditBankDetails> createState() => _EditBankDetailsState();
}

class _EditBankDetailsState extends State<EditBankDetails> {
  late TextEditingController _bankNameController;
  late TextEditingController _bankOwnerController;
  late TextEditingController _bankNoController;
  late TextEditingController _monthlyPaymentController;

  final FocusNode _bankNameFocus = FocusNode();
  final FocusNode _bankOwnerFocus = FocusNode();
  final FocusNode _bankNoFocus = FocusNode();
  final FocusNode _monthlyPaymentFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isSaving = false;
  bool isError = false;

  @override
  void initState() {
    _bankNameController = TextEditingController(text: widget.bankName);
    _bankOwnerController = TextEditingController(text: widget.bankOwnerName);
    _bankNoController = TextEditingController(text: widget.bankAccountNo);
    _monthlyPaymentController =
        TextEditingController(text: widget.monthlyFee.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: customAppBar(
              context: context,
              title: Text(
                'Maklumat Bank',
                style: TextStyle(color: AppColor.primary),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                color: Colors.white54,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    !isError
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              Text(
                                'Masalah berlaku. Data tidak disimpan',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(height: 2.h),
                            ],
                          ),
                    Text(
                      'Maklumat Bank',
                      style: TextStyle(
                        color: AppColor.primary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      hintText: 'Nama Bank',
                      focusNode: _bankNameFocus,
                      controller: _bankNameController,
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      hintText: 'Nama Pemilik Bank',
                      focusNode: _bankOwnerFocus,
                      controller: _bankOwnerController,
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      hintText: 'No Bank',
                      focusNode: _bankNoFocus,
                      controller: _bankNoController,
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      hintText: 'Bayaran Bulanan',
                      focusNode: _monthlyPaymentFocus,
                      controller: _monthlyPaymentController,
                    ),
                    SizedBox(height: 3.h),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();

                        setState(() {
                          isSaving = true;
                        });

                        bool res = await widget.mosqueDAO.editBankDetails({
                          'mosque_id': widget.mosqueDAO.mosque!.id,
                          'bank_name': _bankNameController.text,
                          'bank_owner_name': _bankOwnerController.text,
                          'bank_account_no': _bankNoController.text,
                          'monthly_fee': _monthlyPaymentController.text,
                        }) ?? true;

                        if (res) {
                          Navigator.pop(context);
                        } else {
                          setState(() {
                            isSaving = false;
                          });
                        }
                      },
                      child: const Text(
                        'Selesai',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        !isSaving
            ? const SizedBox.shrink()
            : Container(
                color: Colors.white.withAlpha(200),
                alignment: Alignment.center,
                child: SpinKitChasingDots(
                  color: AppColor.primary,
                ),
              ),
      ],
    );
  }
}
