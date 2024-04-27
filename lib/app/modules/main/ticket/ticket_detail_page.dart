import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/widgets.dart';
import 'package:mytix/app/modules/main/ticket/ticket_controller.dart';
import 'package:mytix/app/modules/main/ticket/ticket_widget.dart';

class TicketDetailPage extends StatelessWidget {
  const TicketDetailPage({super.key});

  static const String routeName = "/ticket_detail";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TicketDetailController ticketDetailController = Get.put(TicketDetailController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        titleSpacing: 0.0,
        title: const Text("Detail Tiket"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: PageView.builder(
        controller: ticketDetailController.pageController,
        onPageChanged: (value) {
          ticketDetailController.page.value = value;
        },
        itemCount: 2,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: TicketDetailItemWidget(index: index),
          );
        }
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppValues.padding),
        child: Obx(() {
          return ButtonPrimaryWidget(
            height: 40.0,
            title: "Unduh Gambar",
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500
            ),
            onPressed: ticketDetailController.isSaving.value ? null : () {
              TicketDetailItemController ticketDetailItemController = Get.find(
                tag: ticketDetailController.page.value.toString(),
              );
              ticketDetailController.saveImageToGallery(ticketDetailItemController.globalKey);
            },
          );
        }),
      ),
    );
  }
}
