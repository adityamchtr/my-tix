import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mytix/app/core/values/app_colors.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/widgets.dart';
import 'package:mytix/app/modules/main/payment/payment_detail_page.dart';

class PaymentCompletePage extends StatelessWidget {
  const PaymentCompletePage({super.key});

  static const String routeName = "/payment_complete";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    void gotoPaymentDetail() async {
      Get.offNamed(PaymentDetailPage.routeName);
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        gotoPaymentDetail();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Lottie.asset(
                loComplete,
              ),

              const Text("Booking Tiket Berhasil",
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
                child: Text("Silahkan cek pembayaran untuk membayar tiket yang sudah dipesan",
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
                  title: "Lihat Pembayaran",
                  backgroundColor: AppColors.colorGreen,
                  onPressed: () {
                    gotoPaymentDetail();
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
