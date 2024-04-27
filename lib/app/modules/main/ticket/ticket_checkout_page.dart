import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:blitix/app/core/utils/tools.dart';
import 'package:blitix/app/core/values/app_constants.dart';
import 'package:blitix/app/core/values/app_styles.dart';
import 'package:blitix/app/core/values/app_values.dart';
import 'package:blitix/app/core/widgets/widgets.dart';
import 'package:blitix/app/modules/main/event/event_model.dart';
import 'package:blitix/app/modules/main/event/event_widget.dart';
import 'package:blitix/app/modules/main/payment/payment_page.dart';
import 'package:blitix/app/modules/main/ticket/ticket_controller.dart';
import 'package:blitix/app/modules/main/ticket/ticket_widget.dart';

class TicketCheckoutPage extends StatelessWidget {
  const TicketCheckoutPage({super.key});

  static const String routeName = "/ticket_checkout";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TicketCheckoutController ticketCheckoutController = Get.put(TicketCheckoutController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        titleSpacing: 0.0,
        title: const Text("Pilih Tiket"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: AppValues.padding
        ),
        child: Column(
          children: [

            EventItemWidget(
              eventItem: EventItemModel(
                id: "1",
                image: "",
                desc: "",
                title: "Karawang Anicosmic 2023",
                isLiked: true,
              ),
              showLike: false,
              showBadge: false,
              onTap: () {
                Get.back();
              },
            ),

            Container(
              padding: const EdgeInsets.all(AppValues.padding),
              margin: const EdgeInsets.symmetric(
                horizontal: AppValues.padding
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(AppValues.smallRadius)
              ),
              child: Column(
                children: [

                  //Title
                  Row(
                    children: [

                      SvgPicture.asset(icTicket),

                      const SizedBox(
                        width: AppValues.padding,
                      ),

                      const Text("Pilihan Tiket",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )

                    ],
                  ),

                  ...ticketCheckoutController.ticketParents.map((e) {
                    return TicketParentItemWidget(
                      ticketParentItemModel: e,
                    );
                  }),

                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppValues.padding),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppValues.smallRadius),
            topRight: Radius.circular(AppValues.smallRadius)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4.0,
              offset: const Offset(0.4, 0.0)
            )
          ]
        ),
        child: Row(
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Total Harga",
                  style: TextStyle(
                    color: theme.disabledColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0
                  ),
                ),

                Obx(() {
                  return Text(convertToIdr(ticketCheckoutController.totalPrice.value),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0
                    ),
                  );
                }),
              ],
            ),

            const Spacer(),

            SizedBox(
              width: 140.0,
              child: Obx(() {
                return ButtonPrimaryWidget(
                  height: 40.0,
                  title: "Bayar Sekarang",
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0
                  ),
                  onPressed: ticketCheckoutController.totalPrice.value != 0 ? () {
                    Get.toNamed(PaymentPage.routeName,
                      arguments: [
                        ticketCheckoutController.getTicketSelected(),
                        ticketCheckoutController.totalPrice.value
                      ]
                    );
                  } : null,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
