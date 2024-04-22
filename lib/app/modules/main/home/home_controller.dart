import 'package:get/get.dart';
import 'package:match/app/data/preference/session_manager.dart';

class HomeController extends GetxController {

  var isGuest = true.obs;

  @override
  void onInit() {
    super.onInit();

    setGuest();
  }

  void setGuest() {
    isGuest.value = SessionManager.getAccessToken() == null;
  }
}