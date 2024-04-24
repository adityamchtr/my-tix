import 'package:flutter/material.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/modules/main/event/event_widget.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        title: const Text("Keinginan"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(
          top: AppValues.padding
        ),
        itemCount: 3,
        itemBuilder: (context, index) {
          return const EventItemWidget(
            showBadge: false,
          );
        },
      ),
    );
  }
}
