import 'package:blitix/app/core/values/app_constants.dart';
import 'package:blitix/app/modules/main/event/event_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  var isLoading = true.obs;
  var bannerSelected = 0.obs;
  var categorySelected = 0.obs;

  List<EventItemModel> eventItems = [];
  List<EventItemModel> eventEndedItems = [];

  @override
  void onInit() {
    super.onInit();

    fetchEvent();
  }

  Future<dynamic> fetchEvent() async {
    isLoading.value = true;

    List<EventItemModel> data = List<EventItemModel>.from(
      eventSample["data"]!.map((item) {
        return EventItemModel.fromMap(item);
      })
    );
    eventItems.addAll(data);

    List<EventItemModel> dataEnded = List<EventItemModel>.from(
      eventSample["data"]!.map((item) {
        return EventItemModel.fromMap(item);
      })
    );
    eventEndedItems.addAll(dataEnded);

    await 2.delay();
    isLoading.value = false;
  }
}