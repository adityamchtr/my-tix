import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterController extends GetxController {

  var step = 0.obs;
  bool isNext = false;

  final GlobalKey<FormState> formOneKey = GlobalKey<FormState>();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController birthPlaceTextController = TextEditingController();
  final TextEditingController birthDateTextController = TextEditingController();
  final TextEditingController waTextController = TextEditingController();
  DateTime? birthDate;
  int gender = 0;

  final GlobalKey<FormState> formTwoKey = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void onClose() {
    super.onClose();

    nameTextController.dispose();
    birthPlaceTextController.dispose();
    birthDateTextController.dispose();
    waTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
  }

  void setBirthDate(DateTime dateTime) {
    birthDate = dateTime;
    birthDateTextController.text = DateFormat("dd MMMM yyyy", "id_ID").format(dateTime);
  }

  void actionStep(bool isNext) {
    isNext ? step.value++ : step.value--;
    this.isNext = isNext;
  }
}