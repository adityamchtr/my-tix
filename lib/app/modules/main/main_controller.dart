import 'package:get/get.dart';

class MainController extends GetxController {

  static MainController get to => Get.find();
  
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    update();
  }
}