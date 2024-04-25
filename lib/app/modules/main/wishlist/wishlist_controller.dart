import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/modules/main/event/event_model.dart';

class WishlistController extends GetxController {

  static WishlistController get to => Get.find();

  var wishlistItems = <EventItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    wishlistItems.addAll(eventDummies);
  }
}