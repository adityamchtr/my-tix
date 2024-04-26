import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/search_widget.dart';
import 'package:mytix/app/modules/main/main_page.dart';
import 'package:mytix/app/modules/main/transaction/transaction_widget.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  static const String routeName = "/transaction";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    bool isFromBooking =  Get.arguments != null;

    void goto() async {
      if (isFromBooking) {
        Get.offAllNamed(MainPage.routeName);
      } else {
        Get.back();
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
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: theme.scaffoldBackgroundColor,
            foregroundColor: theme.iconTheme.color,
            titleSpacing: 0.0,
            title: const Text("Lihat Transaksi"),
            systemOverlayStyle: systemUiOverlayStyle(theme),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(112.0 + 1),
              child: Column(
                children: [

                  //Search
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppValues.padding,
                      vertical: AppValues.halfPadding
                    ),
                    child: SearchWidget(
                      hintText: "Cari disini",
                      onChanged: (value) {

                      },
                      onSubmitted: (value) {

                      },
                      onPressedClear: () {

                      },
                    ),
                  ),

                  TabBar(
                    labelColor: theme.iconTheme.color,
                    unselectedLabelColor: theme.disabledColor,
                    labelStyle: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppValues.padding
                    ),
                    tabs: const [
                      Tab(text: "Sudah Bayar"),
                      Tab(text: "Tunggu Bayar"),
                      Tab(text: "Kadaluarsa"),
                    ],
                  ),

                  const Divider(
                    height: 1,
                    indent: AppValues.padding,
                    endIndent: AppValues.padding,
                  )
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [

              TransactionListWidget(
                statusPayment: "success",
              ),

              TransactionListWidget(
                statusPayment: "waiting",
              ),

              TransactionListWidget(
                statusPayment: "failed",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
