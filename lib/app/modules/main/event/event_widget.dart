import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_colors.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/data/preference/session_manager.dart';
import 'package:mytix/app/modules/main/event/event_controller.dart';
import 'package:mytix/app/modules/main/event/event_model.dart';
import 'package:mytix/app/modules/main/event/event_page.dart';
import 'package:mytix/app/modules/main/wishlist/wishlist_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({super.key,
    required this.eventItem,
    this.showBadge = true,
    this.showLike = true,
    this.onTap,
  });

  final EventItemModel eventItem;
  final bool showBadge;
  final bool showLike;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final EventItemController eventItemController = Get.put(EventItemController(
      isLiked: eventItem.isLiked
    ),
      tag: eventItem.id
    );

    return Padding(
      padding: const EdgeInsets.only(
        left: AppValues.padding,
        right: AppValues.padding,
        bottom: AppValues.padding
      ),
      child: InkWell(
        onTap: onTap ?? () {
          Get.toNamed(EventPage.routeName,
            arguments: eventItem.isEnded
          );
        },
        borderRadius: BorderRadius.circular(AppValues.smallRadius),
        child: Ink(
          padding: const EdgeInsets.all(AppValues.halfPadding),
          decoration: BoxDecoration(
            color: eventItem.isEnded ? theme.dividerColor : null,
            borderRadius: BorderRadius.circular(AppValues.smallRadius)
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //Image
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
                              spreadRadius: 3.0,
                              blurRadius: 6.0,
                            ),
                          ]
                        ),
                      ),
                    ),

                    if (showBadge) Positioned(
                      left: AppValues.extraSmallPadding,
                      right: AppValues.extraSmallPadding,
                      bottom: AppValues.extraSmallPadding,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppValues.radius - AppValues.halfPadding),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5.0,
                              sigmaY: 5.0
                            ),
                            child: Ink(
                              padding: const EdgeInsets.all(AppValues.extraSmallPadding),
                              decoration: BoxDecoration(
                                color: eventItem.isEnded ? const Color(0xCCF04438) : const Color(0xCC12A92A),
                                borderRadius: BorderRadius.circular(AppValues.radius - AppValues.halfPadding),
                                gradient: LinearGradient(
                                  colors: [
                                    eventItem.isEnded ? const Color(0xCCF04438) : const Color(0xCC12A92A),
                                    eventItem.isEnded ? const Color(0xCCE85B50) : const Color(0xCC087C1A)
                                  ]
                                )
                              ),
                              child: Text(eventItem.isEnded ? "Berakhir" : "Berlangsung",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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

                //Body
                Flexible(
                  child: Ink(
                    padding: const EdgeInsets.only(
                      left: AppValues.padding
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(eventItem.title,
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("Rp. 35.000",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),

                            if (SessionManager.getAccessToken() != null && !eventItem.isEnded && showLike) Obx(() {
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
                                    } else {
                                      WishlistController.to.wishlistItems.remove(eventItem);
                                    }
                                  }
                                },
                              );
                            })
                          ],
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

class EventVenueWidget extends StatelessWidget {
  const EventVenueWidget({super.key,
    required this.icon,
    required this.title,
    required this.desc,
  });

  final String icon;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppValues.padding),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.circular(AppValues.smallRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //Icon
          Container(
            height: 50.0,
            width: 50.0,
            margin: const EdgeInsets.only(
              right: AppValues.padding
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(AppValues.radius_12)
            ),
            child: SvgPicture.asset(icon,
              fit: BoxFit.scaleDown,
            ),
          ),
          
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  height: AppValues.halfPadding,
                ),

                Text(desc,
                  style: TextStyle(
                    color: theme.disabledColor
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}

class EventLabelWidget extends StatelessWidget {
  const EventLabelWidget({super.key,
    required this.title
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppValues.padding,
        bottom: AppValues.halfPadding
      ),
      child: Text(title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}