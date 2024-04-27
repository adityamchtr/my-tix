import 'package:get/get.dart';
import 'package:blitix/app/modules/main/event/event_model.dart';

class EventController extends GetxController {

  var isLoading = true.obs;
  late EventItemModel eventItem;

  @override
  void onInit() {
    super.onInit();

    eventItem = Get.arguments;

    fetchData();
  }

  Future<dynamic> fetchData() async {
    isLoading.value = true;
    await 2.delay();
    isLoading.value = false;
  }
}

class EventItemController extends GetxController {
  EventItemController({required bool isLiked}) : _isLiked = isLiked;

  final bool _isLiked;
  var isLike = false.obs;

  @override
  void onInit() {
    super.onInit();

    isLike.value = _isLiked;
  }
}