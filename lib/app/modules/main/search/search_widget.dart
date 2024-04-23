import 'package:flutter/material.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/modules/main/home/home_widget.dart';

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
      itemCount: 3,
      itemBuilder: (context, index) {
        return EventItemWidget(
          isEnded: isEnded,
        );
      },
    );
  }
}
