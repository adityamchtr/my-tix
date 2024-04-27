import 'package:get/get.dart';

class MainController extends GetxController {

  static MainController get to => Get.find();
  
  var selectedIndex = 0.obs;
}