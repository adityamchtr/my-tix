import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/utils/tools.dart';
import 'package:mytix/app/core/values/app_colors.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/dash_line_widget.dart';
import 'package:mytix/app/core/widgets/widgets.dart';
import 'package:mytix/app/modules/main/payment/payment_widget.dart';
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
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: ticketDetailController.globalKey,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppValues.padding
              ),
              margin: const EdgeInsets.all(AppValues.padding),
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(AppValues.smallRadius)
              ),
              child: Column(
                children: [

                  //Logo
                  Image.asset(imLogo,
                    height: 50.0,
                    width: 125.0,
                  ),

                  //Title
                  const Padding(
                    padding: EdgeInsets.only(
                      top: AppValues.padding,
                      bottom: AppValues.extraSmallPadding
                    ),
                    child: Text("Scan QrCode",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600
                      )
                    ),
                  ),

                  //Subtitle
                  Text("Silahkan Pindai Qrcode ini untuk masuk",
                    style: TextStyle(
                      color: theme.disabledColor
                    )
                  ),

                  //QR code
                  SizedBox.square(
                    dimension: 250.0,
                    child: PageView(
                      controller: ticketDetailController.pageController,
                      onPageChanged: (value) {
                        ticketDetailController.page.value = value;
                      },
                      children: List.generate(2, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(AppValues.padding),
                          child: Hero(
                            tag: "ticket-$index",
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  PageController pageController = PageController(
                                    initialPage: ticketDetailController.page.value,
                                  );

                                  Navigator.of(context).push(fadePageRoute(
                                    TicketPreviewWidget(
                                      pageController: pageController,
                                      tag: "ticket",
                                    )
                                  )).then((value) {
                                    pageController.dispose();
                                  });
                                },
                                child: Image.asset(imQrCode)
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  //Indicator Ticket
                  Obx(() {
                    return Text("Tiket ${ticketDetailController.page.value+1}/2",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                      )
                    );
                  }),

                  //Divicer
                  const DividerCutterWidget(),

                  //Detail 1
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppValues.padding
                    ),
                    child: Column(
                      children: [

                        //Nama
                        PaymentLabelWidget(
                          title: "Nama Lengkap",
                          value: "Tommy Jason",
                        ),

                        //Tipe
                        PaymentLabelWidget(
                          title: "Tipe Tiket",
                          value: "Early Bird - Day 1",
                        ),

                        //Masa Berlaku
                        PaymentLabelWidget(
                          title: "Masa Berlaku",
                          value: "1 Hari\n(Sabtu, 23 Januari 2023)",
                        ),

                        //No Tiket
                        PaymentLabelWidget(
                          title: "Masa Berlaku",
                          value: "240104YOIVTYDV",
                        ),
                      ],
                    ),
                  ),

                  //Divicer
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.padding,
                      horizontal: AppValues.padding
                    ),
                    child: DashLineWidget(),
                  ),

                  //Detail 2
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppValues.padding
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        //Nama Acara
                        const PaymentLabelWidget(
                          title: "Nama Acara",
                          value: "Karawang Anicosmic 2024",
                        ),

                        //Lokasi
                        const PaymentLabelWidget(
                          title: "Lokasi",
                          value: "Gedung Balai Kartini,\nPurwakarta",
                        ),

                        //Status
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppValues.smallPadding
                          ),
                          child: Text("Status",
                            style: TextStyle(
                              color:theme.disabledColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppValues.buttonVerticalPadding,
                            horizontal: AppValues.padding
                          ),
                          decoration: BoxDecoration(
                            color: ticketDetailController.isExchanged ? const Color(0xFF797979) : AppColors.colorGreen,
                            borderRadius: BorderRadius.circular(AppValues.smallRadius),
                          ),
                          child: Text(ticketDetailController.isExchanged ? "Sudah Ditukar" : "Belum Ditukar",
                            style: const TextStyle(
                              color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
              ticketDetailController.saveImageToGallery();
            },
          );
        }),
      ),
    );
  }
}
