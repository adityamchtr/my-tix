import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: theme.scaffoldBackgroundColor,
          foregroundColor: theme.iconTheme.color,
          title: const Text("Tiket"),
          systemOverlayStyle: systemUiOverlayStyle(theme),
          actions: [
            IconButton(
              icon: SvgPicture.asset(icSearchAppbar),
              splashRadius: AppValues.splashRadius,
              onPressed: () {

              },
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kMinInteractiveDimension),
            child: TabBar(
              labelColor: theme.iconTheme.color,
              unselectedLabelColor: theme.disabledColor,
              labelStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500
              ),
              indicatorPadding: const EdgeInsets.symmetric(
                horizontal: AppValues.padding
              ),
              tabs: const [
                Tab(text: "Akan Datang"),
                Tab(text: "Selesai"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [

            SizedBox(),

            SizedBox(),

          ],
        ),
      ),
    );
  }
}
