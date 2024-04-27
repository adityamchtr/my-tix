import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blitix/app/core/values/app_styles.dart';
import 'package:blitix/app/core/values/app_values.dart';
import 'package:blitix/app/core/widgets/search_widget.dart';
import 'package:blitix/app/core/widgets/widgets.dart';
import 'package:blitix/app/modules/main/payment/payment_controller.dart';
import 'package:blitix/app/modules/main/payment/payment_widget.dart';

class PaymentVoucherPage extends StatelessWidget {
  const PaymentVoucherPage({super.key});

  static const String routeName = "/payment_voucher";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PaymentVoucherController paymentVoucherController = Get.put(PaymentVoucherController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        titleSpacing: 0.0,
        title: const Text("Pilih Voucher"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: AppValues.padding
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppValues.padding
              ),
              child: SearchWidget(
                controller: paymentVoucherController.searchTextController,
                hintText: "Masukan Kode",
                showSearchIcon: false,
              ),
            ),

            const Divider(
              indent: AppValues.padding,
              endIndent: AppValues.padding,
              height: AppValues.extraLargePadding,
            ),
            
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppValues.padding
              ),
              child: Text("Voucher spesial untuk kamu",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: AppValues.padding,
                top: AppValues.padding,
                bottom: AppValues.padding
              ),
              scrollDirection: Axis.horizontal,
              child: Row(
                children:List.generate(3, (index) {
                  return const VoucherItemWidget();
                }),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppValues.padding),
        child: Obx(() {
          return ButtonPrimaryWidget(
            height: 40.0,
            title: "Terapkan Voucher",
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500
            ),
            onPressed: paymentVoucherController.isUsedVoucher.value ? () {
              Get.back(
                result: paymentVoucherController.isUsedVoucher.value
              );
            } : null,
          );
        }),
      ),
    );
  }
}
