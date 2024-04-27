import 'package:blitix/app/modules/main/event/event_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blitix/app/core/values/app_constants.dart';
import 'package:blitix/app/core/values/app_styles.dart';
import 'package:blitix/app/core/values/app_values.dart';
import 'package:blitix/app/core/widgets/search_widget.dart';
import 'package:blitix/app/data/preference/session_manager.dart';
import 'package:blitix/app/modules/main/event/event_widget.dart';
import 'package:blitix/app/modules/main/home/home_controller.dart';
import 'package:blitix/app/modules/main/home/home_widget.dart';
import 'package:blitix/app/modules/main/main_controller.dart';
import 'package:blitix/app/modules/main/search/search_page_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      appBar: const AppBarHomeWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Visibility(
              visible: SessionManager.getAccessToken() == null,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppValues.padding,
                  left: AppValues.padding,
                  right: AppValues.padding
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Title
                    Text("Cari acara menarikmu disini!",
                      style: TextStyle(
                        color: theme.disabledColor,
                        fontSize: 16.0,
                      ),
                    ),

                    //Subtitle
                    const Padding(
                      padding: EdgeInsets.only(
                        top: AppValues.halfPadding
                      ),
                      child: Text("Pesan tiket? yuk masuk dulu",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Banner Slider
            const BannerWidget(),

            //Search
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppValues.padding
              ),
              child: SearchWidget(
                hintText: "Cari event disini",
                onChanged: (value) {

                },
              ),
            ),

            //Location
            const LocationWidget(),

            //Label Pilihan Terbaik
            Padding(
              padding: const EdgeInsets.only(
                top: AppValues.halfPadding,
                left: AppValues.padding,
                right: AppValues.padding,
              ),
              child: LabelMoreWidget(
                label: "Pilihan Terbaik",
                onTap: () {
                  if (Get.isRegistered<MainController>()) MainController.to.selectedIndex = 1;
                  if (Get.isRegistered<SearchPageController>()) SearchPageController.to.tabController.animateTo(0);
                },
              ),
            ),

            //Menu
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppValues.halfPadding
              ),
              scrollDirection: Axis.horizontal,
              child: Obx(() {
                bool isEmpty = homeController.eventItems.isEmpty;

                return Skeletonizer(
                  enabled: homeController.isLoading.value,
                  effect: shimmerEffect(),
                  child: Row(
                    children: List.generate(isEmpty ? eventDummies.length : homeController.eventItems.length, (index) {
                      EventItemModel event = isEmpty ? eventDummies[index] : homeController.eventItems[index];
                      return MenuItemWidget(
                        eventItem: event,
                      );
                    })
                  ),
                );
              }),
            ),

            //Label Acara Berakhir
            Padding(
              padding: const EdgeInsets.only(
                top: AppValues.halfPadding,
                left: AppValues.padding,
                right: AppValues.padding,
                bottom: AppValues.padding
              ),
              child: LabelMoreWidget(
                label: "Acara Berakhir",
                onTap: () {
                  if (Get.isRegistered<MainController>()) MainController.to.selectedIndex = 1;
                  if (Get.isRegistered<SearchPageController>()) SearchPageController.to.tabController.animateTo(1);
                },
              ),
            ),

            //Event Ended
            Obx(() {
              bool isEmpty = homeController.eventEndedItems.isEmpty;

              return Skeletonizer(
                enabled: homeController.isLoading.value,
                effect: shimmerEffect(),
                child: Column(
                  children: List.generate(isEmpty ? eventEndedDummies.length : homeController.eventEndedItems.length, (index) {
                    EventItemModel event = isEmpty ? eventEndedDummies[index] : homeController.eventEndedItems[index];
                    return EventItemWidget(
                      eventItem: event,
                    );
                  })
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
