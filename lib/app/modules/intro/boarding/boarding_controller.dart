import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardingController extends GetxController {

  final PageController pageController = PageController();
  var page = 0.obs;

  @override
  void onClose() {
    super.onClose();

    pageController.dispose();
  }
}