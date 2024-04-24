import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/modules/main/event/event_model.dart';

class WatchlistController extends GetxController {

  static WatchlistController get to => Get.find();

  var watchlistItems = <EventItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    watchlistItems.addAll(eventDummies);
  }
}