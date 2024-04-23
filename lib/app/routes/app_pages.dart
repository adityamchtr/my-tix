import 'package:get/get.dart';
import 'package:match/app/modules/intro/boarding/boarding_page.dart';
import 'package:match/app/modules/intro/forgot/forgot_password_page.dart';
import 'package:match/app/modules/intro/login/login_page.dart';
import 'package:match/app/modules/intro/register/register_page.dart';
import 'package:match/app/modules/intro/verification/verification_complete_page.dart';
import 'package:match/app/modules/intro/verification/verification_page.dart';
import 'package:match/app/modules/main/main_page.dart';

class AppPages {

  static final routes = [
    GetPage(
      name: BoardingPage.routeName,
      page: () => const BoardingPage(),
    ),
    GetPage(
      name: MainPage.routeName,
      page: () => const MainPage(),
    ),
    GetPage(
      name: LoginPage.routeName,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: RegisterPage.routeName,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: VerificationPage.routeName,
      page: () => const VerificationPage(),
    ),
    GetPage(
      name: VerificationCompletePage.routeName,
      page: () => const VerificationCompletePage(),
    ),
    GetPage(
      name: ForgotPasswordPage.routeName,
      page: () => const ForgotPasswordPage(),
    ),
  ];
}