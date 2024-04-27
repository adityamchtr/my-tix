import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:blitix/app/modules/my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Instantiate SharedPreferences
  await Get.putAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  }, permanent: true);

  //lock to Portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  runApp(const MyApp());
}