import 'package:get/get.dart';
import 'package:mytix/app/modules/intro/boarding/boarding_page.dart';
import 'package:mytix/app/modules/intro/forgot/forgot_password_page.dart';
import 'package:mytix/app/modules/intro/login/login_page.dart';
import 'package:mytix/app/modules/intro/register/register_page.dart';
import 'package:mytix/app/modules/intro/verification/verification_complete_page.dart';
import 'package:mytix/app/modules/intro/verification/verification_page.dart';
import 'package:mytix/app/modules/main/event/event_page.dart';
import 'package:mytix/app/modules/main/event/event_review_page.dart';
import 'package:mytix/app/modules/main/main_page.dart';
import 'package:mytix/app/modules/main/notication/notification_page.dart';
import 'package:mytix/app/modules/main/payment/payment_method_page.dart';
import 'package:mytix/app/modules/main/payment/payment_page.dart';
import 'package:mytix/app/modules/main/payment/payment_voucher_page.dart';
import 'package:mytix/app/modules/main/ticket/ticket_checkout_page.dart';

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
    GetPage(
      name: NotificationPage.routeName,
      page: () => const NotificationPage(),
    ),
    GetPage(
      name: EventPage.routeName,
      page: () => const EventPage(),
    ),
    GetPage(
      name: EventReviewPage.routeName,
      page: () => const EventReviewPage(),
    ),
    GetPage(
      name: TicketCheckoutPage.routeName,
      page: () => const TicketCheckoutPage(),
    ),
    GetPage(
      name: PaymentPage.routeName,
      page: () => const PaymentPage(),
    ),
    GetPage(
      name: PaymentMethodPage.routeName,
      page: () => const PaymentMethodPage(),
    ),
    GetPage(
      name: PaymentVoucherPage.routeName,
      page: () => const PaymentVoucherPage(),
    ),
  ];
}