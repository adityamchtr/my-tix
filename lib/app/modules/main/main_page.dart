import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:blitix/app/core/values/app_constants.dart';
import 'package:blitix/app/core/values/app_values.dart';
import 'package:blitix/app/core/widgets/widgets.dart';
import 'package:blitix/app/data/preference/session_manager.dart';
import 'package:blitix/app/modules/intro/login/login_page.dart';
import 'package:blitix/app/modules/main/home/home_page.dart';
import 'package:blitix/app/modules/main/main_controller.dart';
import 'package:blitix/app/modules/main/profile/profile_page.dart';
import 'package:blitix/app/modules/main/search/search_page.dart';
import 'package:blitix/app/modules/main/ticket/ticket_page.dart';
import 'package:blitix/app/modules/main/wishlist/wishlist_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const String routeName = "/main";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MainController mainController = Get.put(MainController());

    return SystemUiOverlayWidget(
      isBackground: true,
      child: Obx(() {
        return Scaffold(
          body: IndexedStack(
            index: mainController.selectedIndex.value,
            children: _pages,
          ),
          bottomNavigationBar: NavigationBar(
            height: 70,
            selectedIndex: mainController.selectedIndex.value,
            backgroundColor: theme.colorScheme.surface,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            indicatorColor: theme.colorScheme.primary,
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppValues.smallRadius),
            ),
            destinations: [
              _navigationDestination(icMainHome, icMainHomeSelected, "Home"),
              _navigationDestination(icMainSearch, icMainSearchSelected, "Pencarian"),
              _navigationDestination(icMainWishlist, icMainWishlistSelected, "Keinginan"),
              _navigationDestination(icMainTicket, icMainTicketSelected, "Ticket"),
              _navigationDestination(icMainProfile, icMainProfileSelected, "Profile"),
            ],
            onDestinationSelected: (value) {
              if (SessionManager.getAccessToken() == null) {
                if (value != 0 && value != 1 && value != 4) {
                  Get.toNamed(LoginPage.routeName);
                  return;
                }
              }

              mainController.selectedIndex.value = value;
            },
          ),
        );
      }),
    );
  }
}

List<Widget> _pages = [
  const HomePage(),
  const SearchPage(),
  const WishlistPage(),
  const TicketPage(),
  const ProfilePage(),
];

NavigationDestination _navigationDestination(String icon, String selectedIcon, String label) {
  return NavigationDestination(
    icon: SvgPicture.asset(icon),
    selectedIcon: SvgPicture.asset(selectedIcon),
    label: label,
  );
}
