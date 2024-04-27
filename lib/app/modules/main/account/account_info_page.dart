import 'package:flutter/material.dart';
import 'package:mytix/app/core/values/app_colors.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/widgets.dart';
import 'package:mytix/app/modules/main/payment/payment_widget.dart';
import 'package:mytix/app/modules/main/profile/profile_widget.dart';

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage({super.key});

  static const String routeName = "/account_info";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        titleSpacing: 0.0,
        title: const Text("Informasi Akun"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppValues.padding),
        child: Column(
          children: [

            const ProfileTileWidget(),

            Container(
              padding: const EdgeInsets.all(AppValues.padding),
              margin: const EdgeInsets.symmetric(
                vertical: AppValues.padding
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(AppValues.smallRadius)
              ),
              child: const Column(
                children: [

                  //Nama Lengkap (KTP)
                  PaymentLabelWidget(
                    title: "Nama Lengkap (KTP)",
                    value: "Tommy Jason",
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.padding
                    ),
                  ),

                  //Email
                  PaymentLabelWidget(
                    title: "Email",
                    value: "timoryjanson@gmailcom",
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.padding
                    ),
                  ),

                  //No Whatsapp
                  PaymentLabelWidget(
                    title: "No Whatsapp",
                    value: "087874336574",
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.padding
                    ),
                  ),

                  //Jenis Kelamin
                  PaymentLabelWidget(
                    title: "Jenis Kelamin",
                    value: "Pria",
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.padding
                    ),
                  ),

                  //Domisili
                  PaymentLabelWidget(
                    title: "Domisili",
                    value: "Karawang",
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.padding
                    ),
                  ),

                  //Tanggal, tahun lahir
                  PaymentLabelWidget(
                    title: "Tanggal, tahun lahir",
                    value: "14/10/1999",
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.padding
                    ),
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
          title: "Ubah Profil",
          backgroundColor: AppColors.colorGreen,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0
          ),
          onPressed: () {

          },
        ),
      ),
    );
  }
}
