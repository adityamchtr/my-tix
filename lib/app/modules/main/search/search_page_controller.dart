import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController with GetSingleTickerProviderStateMixin {

  static SearchPageController get to => Get.find();

  late TabController tabController;

  var showEmpty = false.obs;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);
  }
}