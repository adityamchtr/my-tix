import 'package:flutter/material.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/modules/main/event/event_model.dart';
import 'package:mytix/app/modules/main/event/event_widget.dart';

class SearchListWidget extends StatelessWidget {
  const SearchListWidget({super.key,
    this.isEnded = false,
  });

  final bool isEnded;

  @override
  Widget build(BuildContext context) {
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
  }
}
