import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_colors.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/widgets.dart';
import 'package:mytix/app/data/preference/session_manager.dart';
import 'package:mytix/app/modules/intro/login/login_page.dart';
import 'package:mytix/app/modules/main/event/event_controller.dart';
import 'package:mytix/app/modules/main/event/event_review_page.dart';
import 'package:mytix/app/modules/main/event/event_widget.dart';
import 'package:mytix/app/modules/main/ticket/ticket_checkout_page.dart';
import 'package:mytix/app/modules/main/wishlist/wishlist_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  static const String routeName = "/event";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final EventController eventController = Get.put(EventController());
    final EventItemController eventItemController = Get.put(EventItemController(
      isLiked: eventController.eventItem.isLiked
    ),
      tag: eventController.eventItem.id
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        titleSpacing: 0.0,
        title: const Text("Detail Acara"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppValues.padding),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Banner
              Skeletonizer(
                enabled: eventController.isLoading.value,
                effect: shimmerEffect(),
                child: Stack(
                  alignment: Alignment.center,
                  children: [

                    Container(
                      width: double.infinity,
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppValues.smallRadius),
                        image: const DecorationImage(
                          image: AssetImage(imBannerEvent),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),

                    if (eventController.eventItem.isEnded) Skeleton.ignore(
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(AppValues.smallRadius),
                        ),
                      ),
                    ),

                    if (eventController.eventItem.isEnded) Skeleton.ignore(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppValues.radius - AppValues.halfPadding),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5.0,
                              sigmaY: 5.0
                            ),
                            child: Container(
                              width: 150.0,
                              padding: const EdgeInsets.all(AppValues.halfPadding),
                              decoration: BoxDecoration(
                                color: const Color(0xF2F04438).withOpacity(0.8),
                                borderRadius: BorderRadius.circular(AppValues.radius - AppValues.halfPadding),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xF2F04438),
                                    Color(0xF2DF1708)
                                  ]
                                )
                              ),
                              child: const Text("Berakhir",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              //Share
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppValues.padding
                ),
                child: Row(
                  children: [

                    Expanded(
                      child: Text(
                        eventController.eventItem.title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),

                    IconButton(
                      icon: SvgPicture.asset(icShare),
                      constraints: const BoxConstraints(),
                      splashRadius: AppValues.splashRadius,
                      onPressed: () {
                        Share.share("https://mytix.com/event/karawang_anicosmi",
                          subject: "Bagikan ke temanmu"
                        );
                      },
                    ),

                    if (SessionManager.getAccessToken() != null && !eventController.eventItem.isEnded) Obx(() {
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
                              WishlistController.to.wishlistItems.add(eventController.eventItem);
                              showSnackBar(
                                title: "Berhasil",
                                message: "Event berhasil ditambahkan ke wishlist"
                              );
                            } else {
                              WishlistController.to.wishlistItems.remove(eventController.eventItem);
                            }
                          }
                        },
                      );
                    })
                  ],
                ),
              ),

              //Venue
              Skeletonizer(
                enabled: eventController.isLoading.value,
                effect: shimmerEffect(),
                child: const EventVenueWidget(
                  icon: icEventLocation,
                  title: "Gedung balai kartini, purwakarta",
                  desc: "Jl. Veteran No.8, Nagri Kaler, Kec. Purwakarta, Kabupaten Purwakarta, Jawa Barat 41115",
                ),
              ),

              const SizedBox(
                height: AppValues.halfPadding,
              ),

              //Date
              Skeletonizer(
                enabled: eventController.isLoading.value,
                effect: shimmerEffect(),
                child: const EventVenueWidget(
                  icon: icEventDate,
                  title: "10,11 Mei 2023",
                  desc: "Sabtu, 10 Mei 2024 - 10:00 WIB\nMinggu, 11 Mei 2024 - 10:00 WIB",
                ),
              ),

              //Label EventMaker
              const EventLabelWidget(
                title: "Pembuat Acara",
              ),

              //EventMaker
              Skeletonizer(
                enabled: eventController.isLoading.value,
                effect: shimmerEffect(),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    borderRadius: BorderRadius.circular(AppValues.smallRadius)
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: AppValues.halfPadding,
                      horizontal: AppValues.padding
                    ),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: theme.scaffoldBackgroundColor,
                      foregroundImage: const AssetImage(imEventMaker),
                    ),
                    title: Column(
                      children: [

                        //Title
                        const Row(
                          children: [
                            Text("Kwf Production",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600
                              ),
                            ),

                            SizedBox(
                              width: AppValues.extraSmallPadding,
                            ),

                            Icon(Icons.check_circle_rounded,
                              size: AppValues.iconSize_18,
                              color: AppColors.colorBlue,
                            )
                          ],
                        ),

                        const SizedBox(
                          height: AppValues.halfPadding,
                        ),

                        //Sub
                        Row(
                          children: [
                            const Text("Jumlah Acara : ",
                              style: TextStyle(
                                fontSize: 16.0
                              ),
                            ),
                            Text("4",
                              style: TextStyle(
                                color: theme.iconTheme.color,
                                fontSize: 16.0
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              //Label Deskripsi Acara
              const EventLabelWidget(
                title: "Deskripsi Acara",
              ),

              //Deskripsi Acara
              Skeletonizer(
                enabled: eventController.isLoading.value,
                effect: shimmerEffect(),
                child: Container(
                  padding: const EdgeInsets.all(AppValues.smallPadding),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.background,
                      borderRadius: BorderRadius.circular(AppValues.smallRadius)
                  ),
                  child: Text("Karawang Anicosmic merupakan acara berkonsep Japan Pop Culture yang ruang ingkup kegiatannya antara lain Comic Talkshow, Cosplay Competition, Tournament Game, Community Gathering, Bazar Merchandise, Anime & Toys Exhibition, dan masih banyak lagi. Acara ini bertujuan untuk memenuhi antusiasme para penggemar Anime, Cosplay, Toys dan Comic.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: theme.disabledColor,
                        fontSize: 16.0
                    ),
                  ),
                ),
              ),

              //Label Deskripsi Acara
              const EventLabelWidget(
                title: "Lokasi",
              ),

              Skeletonizer(
                enabled: eventController.isLoading.value,
                effect: shimmerEffect(),
                child: InkWell(
                  onTap: () async {
                    Uri googleUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=-6.200000,106.816666");
                    if (!await launchUrl(googleUrl)) {
                      throw 'Could not open the map.';
                    }
                  },
                  borderRadius: BorderRadius.circular(AppValues.smallRadius),
                  child: Ink(
                      child: Image.asset(imEventMap)
                  )
                )
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: Obx(() {

        if (eventController.eventItem.isEnded) {
          return Skeletonizer(
            enabled: eventController.isLoading.value,
            effect: shimmerEffect(),
            child: Padding(
              padding: const EdgeInsets.all(AppValues.padding),
              child: Skeleton.leaf(
                child: ButtonPrimaryWidget(
                  height: 40.0,
                  title: "Lihat Ulasan",
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0
                  ),
                  onPressed: () {
                    Get.toNamed(EventReviewPage.routeName);
                  },
                ),
              ),
            ),
          );
        }

        return Skeletonizer(
          enabled: eventController.isLoading.value,
          effect: shimmerEffect(),
          child: Container(
            padding: const EdgeInsets.all(AppValues.padding),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppValues.smallRadius),
                topRight: Radius.circular(AppValues.smallRadius)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4.0,
                  offset: const Offset(0.4, 0.0)
                )
              ]
            ),
            child: Row(
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Mulai Dari",
                      style: TextStyle(
                        color: theme.disabledColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0
                      ),
                    ),

                    const Text("Rp. 45.000",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22.0
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Skeleton.leaf(
                  child: SizedBox(
                    width: 140.0,
                    child: ButtonPrimaryWidget(
                      height: 40.0,
                      title: "Pesan Tiket",
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0
                      ),
                      onPressed: () {
                        if (SessionManager.getAccessToken() != null) {
                          Get.toNamed(TicketCheckoutPage.routeName);
                        } else {
                          Get.toNamed(LoginPage.routeName);
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
