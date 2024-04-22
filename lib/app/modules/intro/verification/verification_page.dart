import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:match/app/core/values/app_colors.dart';
import 'package:match/app/core/values/app_styles.dart';
import 'package:match/app/core/values/app_values.dart';
import 'package:match/app/core/widgets/widgets.dart';
import 'package:match/app/modules/intro/verification/verfication_controller.dart';
import 'package:match/app/modules/intro/verification/verification_complete_page.dart';
import 'package:pinput/pinput.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  static const String routeName = "/verification";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final VerificationController verificationController = Get.put(VerificationController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        titleSpacing: 0.0,
        title: const Text("Kode Verifikasi"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppValues.padding),
        children: [

          //Title
          const Padding(
            padding: EdgeInsets.only(
              bottom: AppValues.halfPadding
            ),
            child: Text("Masukan Kode Verifikasi",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600
              ),
            ),
          ),

          //Subtitle
          Text("Kami telah mengirimkan kode verifikasi ke email ${verificationController.email}",
            style: TextStyle(
              fontSize: 18.0,
              color: theme.disabledColor
            ),
          ),

          //OTP
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppValues.padding
            ),
            child: Form(
              key: verificationController.formKey,
              child: Pinput(
                length: 4,
                controller: verificationController.otpTextController,
                autofocus: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                defaultPinTheme: pinTheme(theme),
                pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                focusedPinTheme: pinTheme(theme).copyWith(
                  decoration: pinTheme(theme).decoration!.copyWith(
                    border: Border.all(color: theme.colorScheme.primary),
                  ),
                ),
                errorPinTheme: pinTheme(theme).copyBorderWith(
                  border: Border.all(color: AppColors.colorRed),
                ),
                validator: (value) {
                  if (value == "1111") return "Kode Verifikasi salah";
                  return null;
                },
                onSubmitted: (value) {
                  verificationController.formKey.currentState!.validate();
                },
                onCompleted: (value) {
                  verificationController.formKey.currentState!.validate();
                },
              ),
            ),
          ),

          ButtonPrimaryWidget(
            title: "Lanjutkan",
            onPressed: () {
              if (verificationController.formKey.currentState!.validate()) {
                Get.toNamed(VerificationCompletePage.routeName);
              }
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppValues.padding
            ),
            child: Center(
              child: Obx(() {
                return Visibility(
                  visible: verificationController.counterResend.value > 0,
                  replacement: InkWell(
                    onTap: () {
                      verificationController.timerResend();
                    },
                    child: Ink(
                      child: const Text(
                        "Kirim Ulang",
                        style: TextStyle(
                          color: AppColors.colorBlue,
                          fontSize: 18.0,
                          decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ),
                  child: Text("Kirim Kode Ulang Dalam 0:${verificationController.counterResend.value}",
                    style: TextStyle(
                      color: theme.disabledColor,
                      fontSize: 18.0,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
