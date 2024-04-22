import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:match/app/core/values/app_constants.dart';
import 'package:match/app/core/values/app_styles.dart';
import 'package:match/app/core/values/app_values.dart';
import 'package:match/app/data/preference/session_manager.dart';
import 'package:match/app/modules/intro/login/login_page.dart';
import 'package:match/app/modules/main/home/home_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
        leadingWidth: 70.0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppValues.extraSmallPadding
          ),
          child: CircleAvatar(
            child: SvgPicture.asset(imAvatar),
          ),
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

            const SizedBox(
              height: AppValues.padding_4,
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
              Get.offNamed(LoginPage.routeName);
            },
            icon: SvgPicture.asset(icNotification),
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

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final BannerController bannerController = Get.put(BannerController());

    final List<Map<String, dynamic>> bannerList = [
      {"image": imBanner, "id": 1},
      {"image": imBanner, "id": 2},
      {"image": imBanner, "id": 3},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppValues.padding
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [

          CarouselSlider.builder(
            options: CarouselOptions(
              height: 150,
              enableInfiniteScroll: false,
              viewportFraction: 0.95,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              onPageChanged: (index, reason) {
                bannerController.selectedIndex.value = index;
              },
            ),
            itemCount: bannerList.length,
            itemBuilder: (context, index, realIndex) {
              String image = bannerList[index]["image"];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.halfPadding
                ),
                child: InkWell(
                  onTap: () {

                  },
                  borderRadius: BorderRadius.circular(AppValues.radius),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.background,
                      borderRadius: BorderRadius.circular(AppValues.radius),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                ),
              );
            },
          ),

          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppValues.extraLargePadding,
                vertical: AppValues.buttonVerticalPadding
              ),
              child: AnimatedSmoothIndicator(
                activeIndex: bannerController.selectedIndex.value,
                count: bannerList.length,
                effect: ExpandingDotsEffect(
                  dotColor: theme.colorScheme.background.withOpacity(0.5),
                  activeDotColor: theme.colorScheme.background,
                  dotHeight: 6.0,
                  dotWidth: 6.0,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

