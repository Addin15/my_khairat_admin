import 'package:flutter/cupertino.dart';
import 'package:my_khairat_admin/controllers/payment_controller.dart';
import 'package:my_khairat_admin/models/payment.dart';

class PaymentDAO extends ChangeNotifier {
  List<Payment> payments = [];

  PaymentDAO(String mosqueID) {
    initData(mosqueID);
  }

  initData(String mosqueID) async {
    payments = await PaymentController.getPayments(mosqueID);
    notifyListeners();
  }

  getPayments() {
    return payments;
  }

  changePaymentStatus(String paymentID, String status) async {
    bool res = await PaymentController.actionOnPayment(paymentID, status);
    if (res) {
      payments.where((payment) => payment.id == paymentID).first.status =
          status;
    }

    notifyListeners();
  }

  deletePayments(String paymentID) async {
    bool res = await PaymentController.deletePayment(paymentID);
    if (res) {
      payments.removeWhere((payment) => payment.id == paymentID);
    }

    notifyListeners();
  }
}
