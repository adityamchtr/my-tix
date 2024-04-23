import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:match/app/core/values/app_styles.dart';
import 'package:match/app/core/values/app_values.dart';
import 'package:match/app/core/widgets/widgets.dart';
import 'package:match/app/modules/main/home/home_controller.dart';
import 'package:match/app/modules/main/home/home_widget.dart';
import 'package:match/app/modules/main/main_controller.dart';
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

            Obx(() {
              return Visibility(
                visible: MainController.to.isGuest.value,
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
              );
            }),

            //Banner Slider
            const BannerWidget(),

            //Search
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppValues.padding
              ),
              child: SearchWidget(
                controller: homeController.searchTextController,
                hintText: "Cari event disini",
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
                return Skeletonizer(
                  enabled: homeController.isLoading.value,
                  effect: shimmerEffect(),
                  child: Row(
                    children: List.generate(3, (index) {
                      return const MenuItemWidget();
                    }),
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

                },
              ),
            ),

            //Event Ended
            Obx(() {
              return Skeletonizer(
                enabled: homeController.isLoading.value,
                effect: shimmerEffect(),
                child: Column(
                  children: List.generate(3, (index) {
                    return const EventItemWidget(
                      isEnded: true,
                    );
                  }),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}