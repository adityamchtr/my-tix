import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:match/app/core/values/app_values.dart';
import 'package:match/app/modules/main/home/home_controller.dart';
import 'package:match/app/modules/main/home/home_widget.dart';

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
                visible: homeController.isGuest.value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.padding
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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

            const BannerWidget(),
          ],
        ),
      ),
    );
  }
}
