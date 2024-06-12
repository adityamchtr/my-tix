import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:blitix/app/core/values/app_colors.dart';
import 'package:blitix/app/core/values/app_constants.dart';
import 'package:blitix/app/core/values/app_styles.dart';
import 'package:blitix/app/core/values/app_values.dart';
import 'package:blitix/app/core/widgets/widgets.dart';
import 'package:blitix/app/data/preference/session_manager.dart';
import 'package:blitix/app/modules/intro/login/login_page.dart';
import 'package:blitix/app/modules/main/event/event_controller.dart';
import 'package:blitix/app/modules/main/event/event_model.dart';
import 'package:blitix/app/modules/main/event/event_page.dart';
import 'package:blitix/app/modules/main/home/home_controller.dart';
import 'package:blitix/app/modules/main/notication/notification_page.dart';
import 'package:blitix/app/modules/main/wishlist/wishlist_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppBarHomeWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (SessionManager.getAccessToken() == null) {
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
          const Text("Hai, John Doe",
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
            Get.toNamed(NotificationPage.routeName);
          },
          icon: SvgPicture.asset(icNotification),
          splashRadius: AppValues.splashRadius,
          tooltip: "Notifikasi",
        )
      ],
    );
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
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(AppValues.radius),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {

                        },
                        borderRadius: BorderRadius.circular(AppValues.radius),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: homeController.isLoading.value ? AppColors.colorGrey :theme.colorScheme.surface,
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
                      dotColor: theme.colorScheme.surface.withOpacity(0.5),
                      activeDotColor: theme.colorScheme.surface,
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
                containersColor: theme.colorScheme.surface,
                child: FilterChipWidget(
                  title: e["title"],
                  isSelected: isSelected,
                  onSelected: (value) {
                    homeController.categorySelected.value = e["id"];
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
  const MenuItemWidget({super.key,
    required this.eventItem,
  });

  final EventItemModel eventItem;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final EventItemController eventItemController = Get.put(EventItemController(
      isLiked: eventItem.isLiked
    ),
      tag: eventItem.id
    );

    double width = 260.0 - AppValues.padding;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.halfPadding,
        vertical: AppValues.padding
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(EventPage.routeName,
            arguments: eventItem
          );
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
                      color: theme.colorScheme.surface,
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
                          spreadRadius: 3.0,
                          blurRadius: 6.0,
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
                      theme.colorScheme.surface.withOpacity(0.0),
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
                      color: theme.colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(AppValues.radius),
                        bottomRight: Radius.circular(AppValues.radius)
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.colorScheme.surface.withOpacity(0.0),
                          theme.colorScheme.surface,
                        ]
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(eventItem.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                            top: AppValues.halfPadding
                          ),
                          child: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
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

                        if (SessionManager.getAccessToken() != null) Obx(() {
                          return IconButton(
                            icon: SvgPicture.asset(eventItemController.isLike.value ? icLiked : icLike),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minHeight: 40.0,
                              minWidth: 40.0
                            ),
                            splashRadius: AppValues.splashRadius,
                            onPressed: () {
                              eventItemController.isLike.value = !eventItemController.isLike.value;

                              if (Get.isRegistered<WishlistController>()) {
                                if (eventItemController.isLike.value) {
                                  WishlistController.to.wishlistItems.add(eventItem);
                                  showSnackBar(
                                    title: "Berhasil",
                                    message: "Event berhasil ditambahkan ke wishlist"
                                  );
                                } else {
                                  int index = WishlistController.to.wishlistItems.indexWhere((element) {
                                    return element.id == eventItem.id;
                                  });
                                  WishlistController.to.wishlistItems.removeAt(index);
                                }
                              }
                            },
                          );
                        })
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