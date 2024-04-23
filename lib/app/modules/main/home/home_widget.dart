import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:match/app/core/values/app_colors.dart';
import 'package:match/app/core/values/app_constants.dart';
import 'package:match/app/core/values/app_styles.dart';
import 'package:match/app/core/values/app_values.dart';
import 'package:match/app/core/widgets/widgets.dart';
import 'package:match/app/modules/intro/login/login_page.dart';
import 'package:match/app/modules/main/home/home_controller.dart';
import 'package:match/app/modules/main/main_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppBarHomeWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Obx(() {
      if (MainController.to.isGuest.value) {
        return AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: theme.scaffoldBackgroundColor,
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
                  Get.toNamed(LoginPage.routeName);
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
        backgroundColor: theme.scaffoldBackgroundColor,
        systemOverlayStyle: systemUiOverlayStyle(theme),
        foregroundColor: theme.iconTheme.color,
        leadingWidth: 70.0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppValues.extraSmallPadding
          ),
          child: CircleAvatar(
            backgroundColor: theme.colorScheme.primary,
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
            onPressed: () {

            },
            icon: SvgPicture.asset(icNotification),
            splashRadius: AppValues.splashRadius,
            tooltip: "Notifikasi",
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
    final HomeController homeController = Get.find();

    final List<Map<String, dynamic>> bannerList = [
      {"image": imBanner, "id": 1},
      {"image": imBanner, "id": 2},
      {"image": imBanner, "id": 3},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppValues.padding
      ),
      child: Obx(() {
        return Skeletonizer(
          enabled: homeController.isLoading.value,
          effect: shimmerEffect(),
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
                    homeController.bannerSelected.value = index;
                  },
                ),
                itemCount: bannerList.length,
                itemBuilder: (context, index, realIndex) {
                  String image = bannerList[index]["image"];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppValues.halfPadding
                    ),
                    child: Skeleton.replace(
                      width: double.infinity,
                      height: 150,
                      replacement: DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.background,
                          borderRadius: BorderRadius.circular(AppValues.radius),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {

                        },
                        borderRadius: BorderRadius.circular(AppValues.radius),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: homeController.isLoading.value ? AppColors.colorGrey :theme.colorScheme.background,
                            borderRadius: BorderRadius.circular(AppValues.radius),
                            image: homeController.isLoading.value ? null : DecorationImage(
                              image: AssetImage(image),
                              fit: BoxFit.cover
                            )
                          ),
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
                    activeIndex: homeController.bannerSelected.value,
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
      }),
    );
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final HomeController homeController = Get.find();

    final List<Map<String, dynamic>> locationList = [
      {"id": 0, "title": "Semua"},
      {"id": 1, "title": "Karawang"},
      {"id": 2, "title": "Bogor"},
      {"id": 3, "title": "Bandung"},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        vertical: AppValues.halfPadding
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppValues.padding,
        ),
        child: Row(
          children: locationList.map((e) {
            return Obx(() {
              bool isSelected = homeController.categorySelected.value == e["id"];
              return Skeletonizer(
                enabled: homeController.isLoading.value,
                effect: shimmerEffect(),
                containersColor: theme.colorScheme.background,
                child: FilterChipWidget(
                  title: e["title"],
                  isSelected: isSelected,
                  onSelected: (value) {
                    homeController.categorySelected.value = e["id"];
                    homeController.fetchData();
                  },
                ),
              );
            });
          }).toList(),
        ),
      ),
    );
  }
}

class LabelMoreWidget extends StatelessWidget {
  const LabelMoreWidget({super.key,
    required this.label,
    this.onTap,

  });

  final String label;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.0
          ),
        ),

        InkWell(
          onTap: onTap,
          child: Ink(
            child: const Text("Lihat Semua",
              style: TextStyle(
                color: AppColors.colorPurple,
                fontSize: 16.0
              ),
            ),
          ),
        )
      ],
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    double width = 260.0 - AppValues.padding;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.halfPadding,
        vertical: AppValues.padding
      ),
      child: InkWell(
        onTap: () {
          
        },
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppValues.radius),
          topRight: Radius.circular(AppValues.radius)
        ),
        child: Column(
          children: [

            //Image
            Stack(
              children: [
                Skeleton.replace(
                  width: width,
                  height: 140.0,
                  replacement: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.background,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppValues.radius),
                        topRight: Radius.circular(AppValues.radius)
                      ),
                    ),
                  ),
                  child: Ink(
                    width: width,
                    height: 140.0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppValues.radius),
                        topRight: Radius.circular(AppValues.radius)
                      ),
                      image: const DecorationImage(
                        image: AssetImage(imBannerEvent),
                        fit: BoxFit.cover
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.colorPurple.withOpacity(0.3),
                          spreadRadius: 8,
                          blurRadius: 16,
                        ),
                      ]
                    ),
                  ),
                ),

                Positioned(
                  top: AppValues.halfPadding,
                  right: AppValues.halfPadding,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppValues.largeRadius),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5.0,
                          sigmaY: 5.0
                        ),
                        child: Container(
                          color: Colors.white.withOpacity(0.2),
                          padding: const EdgeInsets.symmetric(
                            vertical: AppValues.halfPadding,
                            horizontal: AppValues.buttonVerticalPadding
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(icLocation),

                              const SizedBox(
                                width: AppValues.halfPadding,
                              ),
                              
                              const Text("Karawang",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),

            //Body
            Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                    colors: [
                      theme.colorScheme.background.withOpacity(0.0),
                      AppColors.colorGrey,
                      AppColors.colorGrey,
                    ]
                  )
              ),
              child: Column(
                children: [

                  //Title & Desc
                  Container(
                    width: width,
                    padding: const EdgeInsets.all(AppValues.padding),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.background,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(AppValues.radius),
                        bottomRight: Radius.circular(AppValues.radius)
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.colorScheme.background.withOpacity(0.0),
                          theme.colorScheme.background,
                        ]
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Karawang Anicosmic 2024",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                            top: AppValues.halfPadding
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: theme.disabledColor,
                              ),
                              children: const [
                                TextSpan(
                                  text: "Menghadirkan kembali acara japan di karawa..",
                                ),
                                TextSpan(
                                  text: "Selengkapnya",
                                  style: TextStyle(
                                    color: AppColors.colorBlue
                                  )
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  //Price
                  Container(
                    width: width,
                    padding: const EdgeInsets.all(AppValues.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mulai Dari",
                          style: TextStyle(
                            color: theme.disabledColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.only(
                            top: AppValues.halfPadding
                          ),
                          child: Text("Rp. 40.000",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({super.key,
    this.isEnded= false,
  });

  final bool isEnded;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        left: AppValues.padding,
        right: AppValues.padding,
        bottom: AppValues.padding
      ),
      child: InkWell(
        onTap: () {

        },
        borderRadius: BorderRadius.circular(AppValues.smallRadius),
        child: Ink(
          padding: const EdgeInsets.all(AppValues.halfPadding),
          decoration: BoxDecoration(
            color: isEnded ? theme.dividerColor : null,
            borderRadius: BorderRadius.circular(AppValues.smallRadius)
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Stack(
                  children: [
                    Skeleton.replace(
                      width: 100.0,
                      height: 120.0,
                      replacement: DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.background,
                          borderRadius: BorderRadius.circular(AppValues.radius_6),
                        ),
                      ),
                      child: Ink(
                        width: 100.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppValues.radius_6),
                          image: const DecorationImage(
                            image: AssetImage(imBannerEvent),
                            fit: BoxFit.cover
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.colorPurple.withOpacity(0.3),
                              spreadRadius: 10,
                              blurRadius: 16,
                            ),
                          ]
                        ),
                      ),
                    ),

                    if (isEnded) Positioned(
                      left: AppValues.extraSmallPadding,
                      right: AppValues.extraSmallPadding,
                      bottom: AppValues.extraSmallPadding,
                      child: Ink(
                        padding: const EdgeInsets.all(AppValues.extraSmallPadding),
                        decoration: BoxDecoration(
                          color: AppColors.colorRed,
                          borderRadius: BorderRadius.circular(AppValues.radius - AppValues.halfPadding),
                        ),
                        child: const Text("Berakhir",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                Flexible(
                  child: Ink(
                    padding: const EdgeInsets.only(
                      left: AppValues.padding
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Karawang Anicosmic 2024",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                            top: AppValues.halfPadding
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: theme.disabledColor,
                              ),
                              children: const [
                                TextSpan(
                                  text: "Menghadirkan kembali acara japan di karawa..",
                                ),
                                TextSpan(
                                  text: "Selengkapnya",
                                  style: TextStyle(
                                    color: AppColors.colorBlue
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Spacer(),

                        const Text("Rp. 35.000",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}