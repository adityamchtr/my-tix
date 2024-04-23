import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:match/app/core/values/app_constants.dart';
import 'package:match/app/core/values/app_values.dart';
import 'package:match/app/core/widgets/widgets.dart';
import 'package:match/app/modules/intro/login/login_page.dart';
import 'package:match/app/modules/main/home/home_page.dart';
import 'package:match/app/modules/main/main_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const String routeName = "/main";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SystemUiOverlayWidget(
      isBackground: true,
      child: GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return Scaffold(
            body: IndexedStack(
              index: controller.selectedIndex,
              children: _pages,
            ),
            bottomNavigationBar: NavigationBar(
              height: 70,
              selectedIndex: controller.selectedIndex,
              backgroundColor: theme.colorScheme.background,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              indicatorColor: theme.colorScheme.primary,
              indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppValues.smallRadius),
              ),
              destinations: [
                _navigationDestination(icMainHome, icMainHomeSelected, "Home"),
                _navigationDestination(icMainSearch, icMainSearchSelected, "Pencarian"),
                _navigationDestination(icMainWatchlist, icMainWatchlistSelected, "Watchlist"),
                _navigationDestination(icMainTicket, icMainTicketSelected, "Ticket"),
                _navigationDestination(icMainProfile, icMainProfileSelected, "Profile"),
              ],
              onDestinationSelected: (value) {
                if (value > 0 && controller.isGuest.value) {
                  Get.toNamed(LoginPage.routeName);
                } else {
                  controller.selectedIndex = value;
                }
              },
            ),
          );
        }
      ),
    );
  }
}

List<Widget> _pages = [
  const HomePage(),
  const SizedBox(),
  const SizedBox(),
  const SizedBox(),
  const SizedBox(),
];

NavigationDestination _navigationDestination(String icon, String selectedIcon, String label) {
  return NavigationDestination(
    icon: SvgPicture.asset(icon),
    selectedIcon: SvgPicture.asset(selectedIcon),
    label: label,
  );
}