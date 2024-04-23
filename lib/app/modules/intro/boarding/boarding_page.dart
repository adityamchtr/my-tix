import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/data/preference/session_manager.dart';
import 'package:mytix/app/modules/intro/boarding/boarding_controller.dart';
import 'package:mytix/app/modules/main/main_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingPage extends StatelessWidget {
  const BoardingPage({super.key});

  static const String routeName = "/boarding";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final BoardingController boardingController = Get.put(BoardingController());

    final List<Map<String, dynamic>> boardingList = [
      {"image": imBoarding1, "title": "Mencari acara favoritmu\ndengan mudah", "desc": "Hanya dengan sntuhan klik, kamu akan menemukan acara sesuai dengan referensi yang kamu cari tanpa perlu ribet."},
      {"image": imBoarding2, "title": "Mencari acara favoritmu\ndengan mudah", "desc": "Hanya dengan sntuhan klik, kamu akan menemukan acara sesuai dengan referensi yang kamu cari tanpa perlu ribet."},
      {"image": imBoarding3, "title": "Mencari acara favoritmu\ndengan mudah", "desc": "Hanya dengan sntuhan klik, kamu akan menemukan acara sesuai dengan referensi yang kamu cari tanpa perlu ribet."},
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: systemUiOverlayStyle(theme, isBackground: true),
      ),
      body: PageView(
        controller: boardingController.pageController,
        onPageChanged: (value) {
          boardingController.page.value = value;
        },
        children: boardingList.map((e) {
          return Image.asset(e["image"]);
        }).toList()
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppValues.padding),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppValues.radius),
            topRight: Radius.circular(AppValues.radius)
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            //Title & Desc
            Obx(() {
              String title = boardingList[boardingController.page.value]["title"];
              String desc = boardingList[boardingController.page.value]["desc"];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppValues.padding
                    ),
                    child: Text(title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppValues.extraLargePadding
                    ),
                    child: Text(desc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.disabledColor,
                        fontSize: 16.0,
                      )
                    ),
                  ),
                ],
              );
            }),

            //Indicator
            Material(
              color: Colors.transparent,
              child: Row(
                children: [

                  //Skip
                  Obx(() {
                    return Visibility(
                      visible: boardingController.page.value < (boardingList.length - 1),
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: InkWell(
                        onTap: () {
                          boardingController.pageController.animateToPage(boardingList.length - 1,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut
                          );
                        },
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppValues.padding_2,
                            vertical: 11.0
                          ),
                          child: const Text("Lewati",
                            style: TextStyle(
                              fontSize: 18.0
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

                  //Indicator
                  Expanded(
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: boardingController.pageController,
                        count: boardingList.length,
                        effect: ExpandingDotsEffect(
                          dotColor: theme.dividerColor,
                          activeDotColor: theme.colorScheme.primary,
                          dotHeight: 10.0,
                          dotWidth: 10.0,
                        ),
                      ),
                    ),
                  ),

                  //Next
                  Obx(() {
                    return Visibility(
                      visible: boardingController.page.value < (boardingList.length - 1),
                      replacement: InkWell(
                        onTap: () {
                          SessionManager.setBoarding(true);
                          Get.offNamed(MainPage.routeName);
                        },
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppValues.padding_2,
                            vertical: 11.0
                          ),
                          child: const Text("Mulai",
                            style: TextStyle(
                              fontSize: 18.0
                            ),
                          ),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          boardingController.pageController.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut
                          );
                        },
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.arrow_forward_rounded),
                        splashRadius: AppValues.splashRadius,
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
