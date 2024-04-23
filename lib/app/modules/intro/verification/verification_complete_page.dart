import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:match/app/core/values/app_constants.dart';
import 'package:match/app/core/values/app_values.dart';
import 'package:match/app/core/widgets/widgets.dart';
import 'package:match/app/data/preference/session_manager.dart';
import 'package:match/app/modules/main/main_controller.dart';
import 'package:match/app/modules/main/main_page.dart';

class VerificationCompletePage extends StatelessWidget {
  const VerificationCompletePage({super.key});

  static const String routeName = "/verification_complete";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    void gotoMain() async {
      await SessionManager.setAccessToken("oke");
      await Get.delete<MainController>();
      Get.offAllNamed(
        MainPage.routeName,
      );
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        gotoMain();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Lottie.asset(
                loComplete
              ),

              const Text("Pendaftaran Berhasil, Yayy!",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  top: AppValues.largePadding,
                  left: AppValues.extraLargePadding,
                  right: AppValues.extraLargePadding,
                  bottom: AppValues.padding
                ),
                child: Text("Selamat! pendaftaran kamu berhasil silahkan nikmati pengalaman baru dengan mytix\nuntuk mencari acara kesukaanmu!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: theme.disabledColor
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(AppValues.padding),
                child: ButtonPrimaryWidget(
                  title: "Lihat Halaman",
                  onPressed: () {
                    gotoMain();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}