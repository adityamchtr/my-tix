import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blitix/app/core/values/app_colors.dart';
import 'package:blitix/app/core/values/app_values.dart';
import 'package:blitix/app/core/widgets/dash_line_widget.dart';
import 'package:blitix/app/core/widgets/widgets.dart';
import 'package:blitix/app/modules/main/payment/payment_detail_page.dart';

class TransactionListWidget extends StatelessWidget {
  const TransactionListWidget({super.key,
    required this.statusPayment
  });

  final String statusPayment;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    Color bg;
    String statusLabel;
    if (statusPayment == "success") {
      bg = AppColors.colorGreen;
      statusLabel = "Sudah Bayar";
    } else if (statusPayment == "waiting") {
      bg = AppColors.colorOrange;
      statusLabel = "Tunggu Bayar";
    } else  {
      bg = AppColors.colorRed;
      statusLabel = "Kadaluarsa";
    }

    return ListView.builder(
      padding: const EdgeInsets.only(
        top: AppValues.padding
      ),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(AppValues.padding),
          margin: const EdgeInsets.only(
            left: AppValues.padding,
            right: AppValues.padding,
            bottom: AppValues.padding
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppValues.smallRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 4.0,
                offset: const Offset(0.0, 4.0)
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("23 Januari 2024",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  ButtonPrimaryWidget(
                    height: 32.0,
                    title: "     Lihat     ",
                    textStyle: const TextStyle(),
                    onPressed: () {
                      Get.toNamed(PaymentDetailPage.routeName,
                        arguments: statusPayment
                      );
                    },
                  )
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppValues.halfPadding
                ),
                child: Text("KAC 2024",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Text("Inv : 231911ZEL5RB6DGDWPKKJS",
                style: TextStyle(
                  color: theme.disabledColor,
                  fontSize: 16.0,
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppValues.padding
                ),
                child: DashLineWidget(),
              ),

              Row(
                children: [

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Total",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0
                        ),
                      ),

                      Text("Rp. 40.000",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppValues.halfPadding,
                      horizontal: AppValues.padding
                    ),
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(AppValues.smallRadius),
                    ),
                    child: Text(statusLabel,
                      style: const TextStyle(
                        color: Colors.white
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
