import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_colors.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/widgets.dart';
import 'package:mytix/app/data/preference/session_manager.dart';
import 'package:mytix/app/modules/intro/login/login_page.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (SessionManager.getAccessToken() == null) {
      return Container(
        padding: const EdgeInsets.all(AppValues.padding),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(AppValues.radius)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text("Masuk",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 26.0
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: AppValues.halfPadding,
                bottom: AppValues.largePadding
              ),
              child: Text("Untuk melanjutkan masuk profil silahkan masuk atau daftar terlebih dahulu",
                style: TextStyle(
                  color: theme.disabledColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 16.0
                ),
              ),
            ),

            ButtonPrimaryWidget(
              height: 40.0,
              title: "Masuk",
              textStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0
              ),
              onPressed: () {
                Get.toNamed(LoginPage.routeName);
              },
            )
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(AppValues.padding),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.circular(AppValues.radius)
      ),
      child: Row(
        children: [

          CircleAvatar(
            radius: 40,
            backgroundColor: theme.colorScheme.primary,
            child: SvgPicture.asset(imAvatar,
              height: 80,
            ),
          ),

          const SizedBox(
            width: AppValues.padding,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Timory Janson",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0
                ),
              ),

              const SizedBox(
                height: AppValues.padding,
              ),

              Text("Bergabung 1 Agustus 2023",
                style: TextStyle(
                  color: theme.disabledColor,
                  fontSize: 16.0
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget({super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing
  });

  final String icon;
  final String title;
  final GestureTapCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: AppColors.colorGrey,
            borderRadius: BorderRadius.circular(AppValues.radius_12)
          ),
          child: SvgPicture.asset(icon,
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Text(title,
          style: const TextStyle(
            color: Color(0xFF747688),
            fontWeight: FontWeight.w500,
            fontSize: 16.0
          ),
        ),
        trailing: trailing ?? const Icon(Icons.keyboard_arrow_right_rounded),
      ),
    );
  }
}

class DialogLogoutWidget extends StatelessWidget {
  const DialogLogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SimpleDialog(
      contentPadding: const EdgeInsets.all(AppValues.padding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppValues.radius)
      ),
      children: [

        //Icon
        const Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.info_outline_rounded,
            size: AppValues.iconLargeSize,
            color: AppColors.colorRed,
          )
        ),

        //Title
        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppValues.padding
          ),
          child: Text("Anda Akan Keluar",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
        ),

        //Subtitle
        const Text("Apakah anda yakin mau keluar akun?",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(
            top: AppValues.padding
          ),
          child: Row(
            children: [
              Expanded(
                child: ButtonPrimaryWidget(
                  height: 40,
                  backgroundColor: theme.disabledColor,
                  title: "Kembali",
                  isOutlined: true,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),

              const SizedBox(
                width: AppValues.padding,
              ),

              Expanded(
                child: ButtonPrimaryWidget(
                  height: 40,
                  backgroundColor: AppColors.colorRed,
                  title: "Ya, Keluar",
                  onPressed: () async {
                    await SessionManager.removeAccessToken();
                    Get.offNamed(LoginPage.routeName);
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}


