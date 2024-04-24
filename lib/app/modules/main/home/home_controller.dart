import 'package:get/get.dart';

class HomeController extends GetxController {

  var isLoading = true.obs;
  var bannerSelected = 0.obs;
  var categorySelected = 0.obs;

  @override
  void onInit() {
    super.onInit();

    fetchData();
  }

  Future<dynamic> fetchData() async {
    isLoading.value = true;
    await 2.delay();
    isLoading.value = false;
  }
}