import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/widgets.dart';
import 'package:mytix/app/modules/main/search/search_page_controller.dart';
import 'package:mytix/app/modules/main/search/search_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SearchPageController searchController = Get.put(SearchPageController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: theme.scaffoldBackgroundColor,
          foregroundColor: theme.iconTheme.color,
          title: const Text("Pencarian"),
          systemOverlayStyle: systemUiOverlayStyle(theme),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(112.0),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.padding,
                    vertical: AppValues.halfPadding
                  ),
                  child: SearchWidget(
                    controller: searchController.searchTextController,
                    hintText: "Cari disini",
                  ),
                ),

                TabBar(
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
                    Tab(text: "Berjalan"),
                    Tab(text: "Berakhir"),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [

            //List Berjalan
            SearchListWidget(),

            //List Berakhir
            SearchListWidget(
              isEnded: true,
            ),
          ],
        ),
      ),
    );
  }
}