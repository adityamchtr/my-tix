import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:blitix/app/core/values/app_constants.dart';
import 'package:blitix/app/core/values/app_styles.dart';
import 'package:blitix/app/core/values/app_values.dart';
import 'package:blitix/app/core/widgets/widgets.dart';

class EventReviewPage extends StatelessWidget {
  const EventReviewPage({super.key});

  static const String routeName = "/event_review";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        titleSpacing: 0.0,
        title: const Text("Ulasan"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SvgPicture.asset(ilReview),

            const SizedBox(
              height: AppValues.extraLargePadding * 2,
            ),

            const Text("Belum Ada Ulasan",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: AppValues.largePadding,
                left: AppValues.extraLargePadding,
                right: AppValues.extraLargePadding,
                bottom: AppValues.padding
              ),
              child: Text("Fitur Ulasan Belum tersedia dan masih tahap perencanaan, harap sabar dan menunggu hingga fitur ini bisa digunakan dilain waktu.",
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
                height: 40.0,
                title: "Kembali",
                onPressed: () {
                  Get.back();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
