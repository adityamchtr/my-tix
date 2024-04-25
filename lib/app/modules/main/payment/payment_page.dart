import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/dash_line_widget.dart';
import 'package:mytix/app/core/widgets/widgets.dart';
import 'package:mytix/app/modules/main/payment/payment_controller.dart';
import 'package:mytix/app/modules/main/payment/payment_method_page.dart';
import 'package:mytix/app/modules/main/payment/payment_widget.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  static const String routeName = "/payment";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PaymentController paymentController = Get.put(PaymentController());

    void gotoPaymentMethod() {
      Get.toNamed(PaymentMethodPage.routeName,
        arguments: paymentController.childSelected.value
      )!.then((value) {
        if (value != null) {
          paymentController.childSelected.value = value;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        titleSpacing: 0.0,
        title: const Text("Pembayaran"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: AppValues.padding
        ),
        child: Column(
          children: [
            
            //Metode Pembayaran
            PaymentVoucherWidget(
              title: "Metode Pembayaran",
              subtitle: "Pilih Pembayaran",
              onTap: () {
                gotoPaymentMethod();
              },
              onTapChange: () {
                gotoPaymentMethod();
              },
            ),

            const SizedBox(
              height: AppValues.padding,
            ),

            //Voucher Dan Promo
            PaymentVoucherWidget(
              title: "Voucher Dan Promo",
              subtitle: "Hemat dengan voucher",
              isVoucher: true,
              onTap: () {

              },
            ),
            
            Container(
              padding: const EdgeInsets.all(AppValues.padding),
              margin: const EdgeInsets.only(
                top: AppValues.padding,
                left: AppValues.padding,
                right: AppValues.padding
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(AppValues.smallRadius)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

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

                  //Title
                  const Text("Karawang Anicosmic 2024",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  //Event Name
                  const Padding(
                    padding: EdgeInsets.only(
                      top: AppValues.largePadding,
                      bottom: AppValues.padding
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Nama Acara",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500
                          ),
                        ),

                        Text("Karawang Anicosmic 2024",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ),
                  ),

                  //Ticket Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Nama Tiket",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),

                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: paymentController.ticket.map((e) {
                            return Text("${e.name} (x${e.qty})",
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),

                  //Divider
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.padding
                    ),
                    child: DashLineWidget(),
                  ),

                  //Total Pembelian
                  PaymentLabelWidget(
                    title: "Total Pembelian",
                    value: paymentController.totalPrice,
                  ),

                  //Biaya Admin
                  const PaymentLabelWidget(
                    title: "Biaya Admin",
                    value: 5000,
                  ),

                  //Voucher Potongan
                  const PaymentLabelWidget(
                    title: "Voucher Potongan",
                    value: 15500,
                  ),

                  //Divider
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.padding
                    ),
                    child: DashLineWidget(),
                  ),

                  //Total Bayar
                  PaymentLabelWidget(
                    title: "Total Bayar",
                    value: paymentController.totalPrice + 5000 + 15500,
                    isTotal: true,
                  ),

                ],
              ),
            )


          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppValues.padding),
        child: ButtonPrimaryWidget(
          height: 40.0,
          title: "Bayar Sekarang",
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.0
          ),
          onPressed: () {

          },
        ),
      ),
    );
  }
}
