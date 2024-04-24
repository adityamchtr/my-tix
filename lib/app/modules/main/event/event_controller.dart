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