import 'package:get/get.dart';

class EventController extends GetxController {

  var isLoading = true.obs;
  bool isEnded = false;

  @override
  void onInit() {
    super.onInit();

    isEnded = Get.arguments ?? false;

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