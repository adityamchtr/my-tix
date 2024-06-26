import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:blitix/app/core/values/app_constants.dart';
import 'package:blitix/app/core/values/app_styles.dart';
import 'package:blitix/app/core/values/app_values.dart';
import 'package:blitix/app/modules/main/event/event_model.dart';
import 'package:blitix/app/modules/main/event/event_widget.dart';
import 'package:blitix/app/modules/main/wishlist/wishlist_controller.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final WishlistController wishlistController = Get.put(WishlistController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        title: const Text("Keinginan"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: Obx(() {
        if (wishlistController.wishlistItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SvgPicture.asset(ilEmpty),

                const SizedBox(
                  height: AppValues.extraLargePadding * 2,
                ),

                const Text("Tidak Tersedia",
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
                  child: Text("Lakukan pencarian untuk memasukan acara favorit kamu disini",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: theme.disabledColor
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(
            top: AppValues.padding
          ),
          itemCount: wishlistController.wishlistItems.length,
          itemBuilder: (context, index) {
            EventItemModel eventItem = wishlistController.wishlistItems[index];
            return EventItemWidget(
              eventItem: eventItem,
              showBadge: false,
              fromWishlist: true,
            );
          },
        );
      }),
    );
  }
}
