import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController otpTextController = TextEditingController();

  Timer? _timer;
  var counterResend = 0.obs;

  late String email;

  @override
  void onInit() {
    super.onInit();

    email = Get.arguments;

    timerResend();
  }

  @override
  void onClose() {
    super.onClose();

    timerCancel();
    otpTextController.dispose();
  }

  void timerResend() {
    counterResend.value = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      counterResend.value--;
      if (counterResend.value == 0) {
        timer.cancel();
      }
    });
  }

  void timerCancel() {
    if(_timer != null) _timer!.cancel();
  }
}