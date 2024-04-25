import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/modules/main/payment/payment_model.dart';
import 'package:mytix/app/modules/main/ticket/ticket_model.dart';

class PaymentController extends GetxController {

  final List<TicketChildItemModel> ticket = [];
  double totalPrice = 0.0;

  var childSelected = Rxn<PaymentChildItemModel>();

  @override
  void onInit() {
    super.onInit();

    ticket.addAll(Get.arguments[0]);
    totalPrice = Get.arguments[1];
  }
}

class PaymentMethodController extends GetxController {

  static PaymentMethodController get to => Get.find();

  List<PaymentParentItemModel> paymentMethods = [];
  var parentSelected = Rxn<String>();
  var childSelected = Rxn<PaymentChildItemModel>();

  @override
  void onInit() {
    super.onInit();

    childSelected.value = Get.arguments;
    parentSelected.value = childSelected.value?.headerId;

    fetchPaymentMethod();
  }

  void fetchPaymentMethod() {
    List<PaymentParentItemModel> data = List<PaymentParentItemModel>.from(
        paymentMethodDummies["data"]!.map((item) {
        return PaymentParentItemModel.fromMap(item);
      })
    );

    paymentMethods.addAll(data);
  }
}