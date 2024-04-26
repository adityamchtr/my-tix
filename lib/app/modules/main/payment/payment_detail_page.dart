import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_colors.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/dash_line_widget.dart';
import 'package:mytix/app/core/widgets/widgets.dart';
import 'package:mytix/app/modules/main/payment/payment_complete_page.dart';
import 'package:mytix/app/modules/main/payment/payment_controller.dart';
import 'package:mytix/app/modules/main/payment/payment_widget.dart';
import 'package:mytix/app/modules/main/transaction/transaction_page.dart';

class PaymentDetailPage extends StatelessWidget {
  const PaymentDetailPage({super.key});

  static const String routeName = "/payment_detail";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PaymentDetailController paymentDetailController = Get.put(PaymentDetailController());

    bool isSuccess = false;
    String desc;
    if (paymentDetailController.statusPayment == "waiting") {
      desc = "Selesaikan pembayaran sebelum Minggu,\n25 Februari 2024 pukul 03.12";
    } else if (paymentDetailController.statusPayment == "success") {
      isSuccess = true;
      desc = "Selamat! Kamu berhasil melalukan pembelian, silahkan cek melalui tiket kamu ya";
    } else {
      desc = "Pembelian Gagal karena belum membayar, silahkan lakukan pembelian ulang";
    }

    bool fromList = Get.previousRoute != PaymentCompletePage.routeName;

    void goto() async {
      if (fromList) {
        Get.back();
      } else {
        Get.offAllNamed(TransactionPage.routeName,
          arguments: "oke"
        );
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        goto();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 0.0,
          backgroundColor: theme.scaffoldBackgroundColor,
          foregroundColor: theme.iconTheme.color,
          titleSpacing: 0.0,
          systemOverlayStyle: systemUiOverlayStyle(theme),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppValues.padding),
          child: Ink(
            padding: const EdgeInsets.all(AppValues.padding),
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
              borderRadius: BorderRadius.circular(AppValues.smallRadius)
            ),
            child: Stack(
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //Title
                    Align(
                      alignment: Alignment.center,
                      child: Text(isSuccess ? "Pembelian Berhasil!" : "Menunggu Pembayaran",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600
                        )
                      ),
                    ),

                    //Desc
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppValues.padding),
                      margin: const EdgeInsets.symmetric(
                        vertical: AppValues.padding
                      ),
                      decoration: BoxDecoration(
                        color: isSuccess ? const Color(0xFFFBFEFA) : const Color(0xFFFBDFDF),
                        borderRadius: BorderRadius.circular(AppValues.smallRadius),
                        border: Border.all(
                          color: isSuccess ? AppColors.colorGreen : AppColors.colorRed
                        )
                      ),
                      child: Text(desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSuccess ? AppColors.colorGreen : AppColors.colorRed,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ),

                    //Logo
                    Image.asset(imLogo,
                      height: 40.0,
                      width: 100.0,
                    ),

                    //Label Detail Pembayaran
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppValues.padding
                      ),
                      child: Text("Detail Pemesanan",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),

                    //No Pesanan
                    const PaymentLabelWidget(
                      title: "No Pesanan",
                      value: "240104YOIVTYDV",
                    ),

                    //No Invoice
                    const PaymentLabelWidget(
                      title: "No Invoice",
                      value: "T2189913013458FKPGS",
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppValues.padding
                      ),
                      child: DashLineWidget(),
                    ),

                    //Metode Pembayaran
                    const Text("Metode Pembayaran",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500
                      )
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppValues.halfPadding,
                      ),
                      child: Image.asset(imPaymentMandiri,
                        width: 60.0,
                      ),
                    ),

                    //Kode Pembayaran
                    if (!isSuccess) const Padding(
                      padding: EdgeInsets.only(
                        top: AppValues.padding
                      ),
                      child: Text("Kode Pembayaran",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600
                        )
                      ),
                    ),

                    if (!isSuccess) Padding(
                      padding: const EdgeInsets.only(
                        top: AppValues.buttonVerticalPadding
                      ),
                      child: Row(
                        children: [
                          const Text("8903910117976096",
                            style: TextStyle(
                              color: AppColors.colorRed,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600
                            )
                          ),

                          const SizedBox(
                            width: AppValues.halfPadding,
                          ),

                          InkWell(
                            onTap: () async {
                              await Clipboard.setData(const ClipboardData(
                                text: "8903910117976096")
                              );
                              showSnackBar(
                                title: "Berhasil",
                                message: "Kode pembayaran berhasil disalin"
                              );
                            },
                            borderRadius: BorderRadius.circular(AppValues.extraLargeRadius),
                            child: Ink(
                              padding: const EdgeInsets.all(AppValues.extraSmallPadding),
                              decoration: BoxDecoration(
                                color: AppColors.colorGrey,
                                borderRadius: BorderRadius.circular(AppValues.extraLargeRadius)
                              ),
                              child: SvgPicture.asset(icCopy),
                            ),
                          )
                        ],
                      ),
                    ),

                    //Bagaimana Cara Bayar
                    if (paymentDetailController.statusPayment == "waiting") Padding(
                      padding: const EdgeInsets.only(
                        top: AppValues.buttonVerticalPadding
                      ),
                      child: Row(
                        children: [
                          const Text("Bagaimana Cara Bayar? ",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500
                            )
                          ),
                          InkWell(
                            onTap: () {

                            },
                            borderRadius: BorderRadius.circular(AppValues.extraLargeRadius),
                            child: const Text("Klik Disini!",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline
                              )
                            ),
                          )
                        ],
                      ),
                    ),

                    //Divider
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppValues.padding
                      ),
                      child: DashLineWidget(),
                    ),

                    //Label Detail Pembayaran
                    const Text("Detail Pembayaran",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600
                      ),
                    ),

                    //Banner
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppValues.padding
                      ),
                      child: Image.asset(imBannerTicket),
                    ),

                    //Nama Acara
                    const PaymentLabelWidget(
                      title: "Nama Acara",
                      value: "Karawang Anicosmic 2024",
                      isTotal: true,
                    ),

                    //Nama Acara
                    const PaymentLabelWidget(
                      title: "Nama Tiket",
                      value: "Early Bird - Day 1 (X1)",
                      isTotal: true,
                    ),

                    //Divider
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppValues.padding
                      ),
                      child: DashLineWidget(),
                    ),

                    //Total Pembelian
                    const PaymentLabelWidget(
                      title: "Total Pembelian",
                      value: 45000,
                    ),

                    //Biaya Admin
                    const PaymentLabelWidget(
                      title: "Biaya Admin",
                      value: 5000,
                    ),

                    //Voucher Potongan
                    const PaymentLabelWidget(
                      title: "Voucher Potongan",
                      value: 15000,
                    ),

                    //Divider
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppValues.padding
                      ),
                      child: DashLineWidget(),
                    ),

                    //Total before discount
                    const PaymentLabelWidget(
                      title: "Total Bayar",
                      value: 50000,
                      isTotal: true,
                      isDiscount: true,
                    ),

                    //Total after discount
                    const PaymentLabelWidget(
                      title: "",
                      value: 35000,
                      isTotal: true,
                    ),
                  ],
                ),

                if (paymentDetailController.statusPayment != "waiting") Positioned(
                  top: 110.0,
                  right: 0.0,
                  child: Image.asset(isSuccess ? imStampSuccess : imStampFailed)
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(AppValues.padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              if (isSuccess) Padding(
                padding: const EdgeInsets.only(
                  bottom: AppValues.halfPadding
                ),
                child: ButtonPrimaryWidget(
                  height: 40.0,
                  backgroundColor: AppColors.colorRed,
                  title: "Download Tiket PDF",
                  icon: SvgPicture.asset(icDownload),
                  textStyle: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                  onPressed: () {

                  },
                ),
              ),

              ButtonPrimaryWidget(
                height: 40.0,
                title: "Lihat Transaksi",
                backgroundColor: AppColors.colorGreen,
                textStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500
                ),
                onPressed: () {
                  goto();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
