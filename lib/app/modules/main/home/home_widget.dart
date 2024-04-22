import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:match/app/core/values/app_constants.dart';
import 'package:match/app/core/values/app_styles.dart';
import 'package:match/app/core/values/app_values.dart';
import 'package:match/app/data/preference/session_manager.dart';
import 'package:match/app/modules/intro/login/login_page.dart';
import 'package:match/app/modules/main/home/home_controller.dart';

class AppBarHomeWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final HomeController homeController = Get.find();

    return Obx(() {
      if (homeController.isGuest.value) {
        return AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: systemUiOverlayStyle(theme),
          leadingWidth: 80.0 + AppValues.extraLargePadding,
          leading: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.padding
            ),
            child: Image.asset(imLogo,
              height: 32,
              alignment: Alignment.centerLeft,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(AppValues.halfPadding),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppValues.smallRadius),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.padding
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: theme.colorScheme.primary,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Get.toNamed(LoginPage.routeName)!.then((value) {
                    if (value == "oke") homeController.setGuest();
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login_rounded,
                      size: AppValues.iconSmallSize,
                    ),
                    SizedBox(
                      width: AppValues.extraSmallPadding,
                    ),
                    Text("Masuk"),
                  ],
                ),
              ),
            )
          ],
        );
      }

      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: systemUiOverlayStyle(theme),
        foregroundColor: theme.iconTheme.color,
        leadingWidth: 80.0,
        leading: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppValues.padding_4
          ),
          child: CircleAvatar(),
        ),
        titleSpacing: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //Title
            Text("Cari acara menarikmu disini!",
              style: TextStyle(
                color: theme.disabledColor,
                fontSize: 16.0,
              ),
            ),

            //Name
            const Text("Hai, hilmychan",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await SessionManager.removeAccessToken();
              Get.toNamed(LoginPage.routeName);
            },
            icon: const Icon(Icons.notifications_none_rounded),
            splashRadius: AppValues.splashRadius,
          )
        ],
      );
    });
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
