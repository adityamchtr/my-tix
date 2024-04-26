import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/search_widget.dart';
import 'package:mytix/app/modules/main/search/search_page_controller.dart';
import 'package:mytix/app/modules/main/search/search_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SearchPageController searchPageController = Get.put(SearchPageController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        title: const Text("Pencarian"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(112.0 + 1),
          child: Column(
            children: [

              //Search
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.padding,
                  vertical: AppValues.halfPadding
                ),
                child: SearchWidget(
                  hintText: "Cari disini",
                  onChanged: (value) {

                  },
                  onSubmitted: (value) {
                    searchPageController.showEmpty.value = value.isNotEmpty;
                  },
                  onPressedClear: () {
                    searchPageController.showEmpty.value = false;
                  },
                ),
              ),

              TabBar(
                controller: searchPageController.tabController,
                labelColor: theme.iconTheme.color,
                unselectedLabelColor: theme.disabledColor,
                labelStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.padding
                ),
                tabs: const [
                  Tab(text: "Berjalan"),
                  Tab(text: "Berakhir"),
                ],
              ),

              const Divider(
                height: 1,
                indent: AppValues.padding,
                endIndent: AppValues.padding,
              )
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: searchPageController.tabController,
        children: const [

          //List Berjalan
          SearchListWidget(),

          //List Berakhir
          SearchListWidget(
            isEnded: true,
          ),
        ],
      ),
    );
  }
}
