import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  bool obscurePassword = true;

  @override
  void onClose() {
    super.onClose();

    emailTextController.dispose();
    passwordTextController.dispose();
  }
}