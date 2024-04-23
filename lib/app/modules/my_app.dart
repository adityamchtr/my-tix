import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_colors.dart';
import 'package:mytix/app/data/preference/session_manager.dart';
import 'package:mytix/app/modules/intro/boarding/boarding_page.dart';
import 'package:mytix/app/modules/main/main_page.dart';
import 'package:mytix/app/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String initialPage = BoardingPage.routeName;

    //Check boarding
    bool boarding = SessionManager.getBoarding() ?? false;
    if (boarding) {
      initialPage = MainPage.routeName;
    }

    return GetMaterialApp(
      title: "MyTix",
      initialRoute: initialPage,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: "inter",
        scaffoldBackgroundColor: AppColors.colorLightBg,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.colorPrimary,
          secondary: AppColors.colorPrimary,
          background: AppColors.colorLight,
          error: AppColors.colorRed,
          brightness: Brightness.light,
        ),
      ),
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaler.clamp(
          minScaleFactor: 0.8,
          maxScaleFactor: 0.9
        );
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: scale),
          child: ScrollConfiguration(behavior: _AppScrollBehavior(), child: child!)
        );
      },
    );
  }
}

class _AppScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(context, child, details) {
    return child;
  }
}