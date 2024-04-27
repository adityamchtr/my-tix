import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:blitix/app/core/values/app_constants.dart';
import 'package:blitix/app/core/values/app_values.dart';
import 'package:blitix/app/modules/main/event/event_model.dart';
import 'package:blitix/app/modules/main/event/event_widget.dart';
import 'package:blitix/app/modules/main/search/search_page_controller.dart';

class SearchListWidget extends StatelessWidget {
  const SearchListWidget({super.key,
    this.isEnded = false,
  });

  final bool isEnded;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SearchPageController searchPageController = Get.find();

    return Obx(() {
      if (searchPageController.showEmpty.value) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.only(
                  top: AppValues.padding * 3,
                  bottom: AppValues.padding,
                ),
                child: SvgPicture.asset(ilSearch),
              ),

              const Text("Pencarian Tidak Ditemukan",
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
                child: Text("Pencarian kota tidak ditemukan, silahkan cari kembali",
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
        itemCount: isEnded ? eventEndedDummies.length : eventDummies.length,
        itemBuilder: (context, index) {
          EventItemModel eventItem = isEnded ? eventEndedDummies[index] : eventDummies[index];
          return EventItemWidget(
            eventItem: eventItem,
          );
        },
      );
    });
  }
}
