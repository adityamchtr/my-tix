import 'package:blitix/app/core/values/app_constants.dart';
import 'package:blitix/app/modules/main/event/event_model.dart';
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

class SearchListController extends GetxController {
  SearchListController({required this.isEnded});

  final bool isEnded;

  List<EventItemModel> eventItems = [];

  @override
  void onInit() {
    super.onInit();

    fetchEvent();
  }

  Future<dynamic> fetchEvent() async {
    List<EventItemModel> data;

    if (isEnded) {
      data = List<EventItemModel>.from(
        eventEndedSample["data"]!.map((item) {
          return EventItemModel.fromMap(item);
        })
      );
    } else {
      data = List<EventItemModel>.from(
        eventSample["data"]!.map((item) {
          return EventItemModel.fromMap(item);
        })
      );
    }

    eventItems.addAll(data);
  }
}