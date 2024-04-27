import 'package:get/get.dart';
import 'package:blitix/app/core/values/app_constants.dart';
import 'package:blitix/app/modules/main/event/event_model.dart';

class WishlistController extends GetxController {

  static WishlistController get to => Get.find();

  var wishlistItems = <EventItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    //wishlistItems.addAll(eventDummies);
    fetchWishlist();
  }

  void fetchWishlist() {
    List<EventItemModel> data = List<EventItemModel>.from(
      eventSample["data"]!.map((item) {
        return EventItemModel.fromMap(item);
      })
    );

    wishlistItems.addAll(data);
  }
}