import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_colors.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/data/preference/session_manager.dart';
import 'package:mytix/app/modules/intro/login/login_page.dart';
import 'package:mytix/app/modules/main/profile/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final List<Map<String, dynamic>> menuList = [
      {"icon": icProfileAccount, "title": "Informasi Akun", "action": () {}},
      {"icon": icProfilePassword, "title": "Ubah Kata Sandi", "action": () {}},
      {"icon": icProfileTransaction, "title": "Lihat Transaksi", "action": () {}},
      {"icon": icProfileTicket, "title": "Lihat Tiket", "action": () {}},
      {"icon": icProfileAbout, "title": "Tentang Kami", "action": () {}},
      {"icon": icProfileContact, "title": "Kontak Kami", "action": () {}},
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        title: const Text("Profil"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppValues.padding),
        child: Column(
          children: [

            //Avatar
            const ProfileHeaderWidget(),

            //Tertarik Kerja Sama
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: AppValues.padding
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(AppValues.radius)
              ),
              child: ProfileItemWidget(
                icon: icProfileInfo,
                title: "Tertarik Kerja Sama?",
                trailing: InkWell(
                  onTap: () {

                  },
                  child: Ink(
                    child: const Text("Klik Disini",
                      style: TextStyle(
                        color: AppColors.colorBlue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                )
              ),
            ),

            //Menu
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppValues.halfPadding
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(AppValues.radius)
              ),
              child: Column(
                children: [

                  ...menuList.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppValues.halfPadding
                      ),
                      child: ProfileItemWidget(
                        icon: e["icon"],
                        title: e["title"],
                        onTap: e["action"],
                      ),
                    );
                  }),


                  if (SessionManager.getAccessToken() != null) ...[
                    const Divider(
                      indent: AppValues.padding,
                      endIndent: AppValues.padding,
                    ),

                    ProfileItemWidget(
                      icon: icProfileLogout,
                      title: "Keluar Akun",
                      onTap: () async {
                        Get.dialog(const DialogLogoutWidget());
                      },
                    )
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
