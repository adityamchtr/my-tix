import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {

  final TextEditingController searchTextController = TextEditingController();

  @override
  void onClose() {
    super.onClose();

    searchTextController.dispose();
  }

}