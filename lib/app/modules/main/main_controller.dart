import 'package:get/get.dart';
import 'package:match/app/data/preference/session_manager.dart';

class MainController extends GetxController {

  static MainController get to => Get.find();

  var isGuest = true.obs;

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    setGuest();
  }

  void setGuest() {
    isGuest.value = SessionManager.getAccessToken() == null;
  }
}