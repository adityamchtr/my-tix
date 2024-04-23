import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/widgets.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  static const String routeName = "/notification";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        titleSpacing: 0.0,
        title: const Text("Notifikasi"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppValues.radius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 10,
                    offset: const Offset(0.0, 5.0)
                  ),
                ]
              ),
              child: SvgPicture.asset(ilNotification)
            ),

            const SizedBox(
              height: AppValues.extraLargePadding * 2,
            ),

            const Text("Masih Dalam Pemeliharaan",
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
              child: Text("Pengembangan Fitur notifikasi sedang dalam tahap perencanaan. harap sabar dan menunggu fitur ini berjalan di lain waktu",
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
                title: "Kembali Ke Beranda",
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
