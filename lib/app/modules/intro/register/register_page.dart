import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:blitix/app/core/values/app_constants.dart';
import 'package:blitix/app/core/values/app_styles.dart';
import 'package:blitix/app/core/values/app_values.dart';
import 'package:blitix/app/core/widgets/widgets.dart';
import 'package:blitix/app/modules/intro/register/register_controller.dart';
import 'package:blitix/app/modules/intro/register/register_widget.dart';
import 'package:blitix/app/modules/intro/verification/verification_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const String routeName = "/register";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final RegisterController registerController = Get.put(RegisterController());
    
    bool isBack() {
      if (registerController.step.value == 1) {
        registerController.actionStep(false);
        return false;
      } else {
        return true;
      }
    }
    
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        if (isBack()) {
          Get.back();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: theme.scaffoldBackgroundColor,
          foregroundColor: theme.iconTheme.color,
          titleSpacing: 0.0,
          title: const Text("Daftar Pengguna"),
          systemOverlayStyle: systemUiOverlayStyle(theme),
        ),
        body: ListView(
          padding: const EdgeInsets.all(AppValues.padding),
          children: [
      
            //Logo
            Image.asset(imLogo,
              height: 50,
              alignment: Alignment.centerLeft,
            ),
      
            //Title
            const Padding(
              padding: EdgeInsets.only(
                top: AppValues.largePadding,
                bottom: AppValues.halfPadding
              ),
              child: Text("Daftar Pengguna",
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
      
            //Subtitle
            Text("Daftar untuk jejalahi acaramu lebih dalam",
              style: TextStyle(
                fontSize: 18.0,
                color: theme.disabledColor
              ),
            ),

            //Indicator Step
            Row(
              children: List.generate(2, (index) {
                return Obx(() {
                  return Container(
                    margin: const EdgeInsets.only(
                      top: AppValues.padding,
                      right: AppValues.halfPadding
                    ),
                    width: 80.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: index == registerController.step.value ? theme.colorScheme.primary : theme.dividerColor,
                      borderRadius: BorderRadius.circular(AppValues.smallRadius)
                    ),
                  );
                });
              }),
            ),
      
            //Form
            Padding(
              padding: const EdgeInsets.only(
                top: AppValues.padding,
                bottom: AppValues.padding
              ),
              child: Obx(() {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    if (child.key == ValueKey(registerController.step.value)) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: registerController.isNext ? const Offset(1, 0) : const Offset(-1, 0),
                          end: Offset.zero
                        ).animate(animation),
                        child: child,
                      );
                    } else {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: !registerController.isNext ? const Offset(1, 0) : const Offset(-1, 0),
                          end: Offset.zero
                        ).animate(animation),
                        child: child,
                      );
                    }
                  },
                  child: _pages()[registerController.step.value],
                );
              }),
            ),
      
            //Button Next / Register
            Padding(
              padding: const EdgeInsets.only(
                top: AppValues.padding,
                bottom: AppValues.padding
              ),
              child: Obx(() {
                bool lastStep = registerController.step.value == 1;
                return ButtonPrimaryWidget(
                  title: lastStep? "Daftar Sekarang" : "Lanjutkan",
                  onPressed: () {
                    if (lastStep) {
                      if (registerController.formTwoKey.currentState!.validate()) {
                        Get.toNamed(VerificationPage.routeName,
                          arguments: registerController.emailTextController.text
                        );
                      }
                    } else {
                      if (registerController.formOneKey.currentState!.validate()) {
                        registerController.actionStep(true);
                      }
                    }
                  },
                );
              }),
            ),
      
            //Divider
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    thickness: 1.0,
                  ),
                ),
      
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.padding
                  ),
                  child: Text("Atau",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: theme.disabledColor
                    )
                  ),
                ),
      
                const Expanded(
                  child: Divider(
                    thickness: 1.0,
                  ),
                ),
              ],
            ),
      
            //Button Google
            Padding(
              padding: const EdgeInsets.only(
                top: AppValues.padding,
                bottom: AppValues.extraLargePadding
              ),
              child: ButtonPrimaryWidget(
                title: "Masuk Dengan Google",
                isOutlined: true,
                icon: SvgPicture.asset(icGoogle),
                textStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500
                ),
                onPressed: () {
      
                },
              ),
            ),
      
            //Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sudah Memiliki Akun? ",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: theme.disabledColor
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back(
                      result: "oke"
                    );
                  },
                  child: Ink(
                    child: const Text(
                      "Masuk",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> _pages() {
  return [
    const FormOneWidget(
      key: ValueKey(0),
    ),
    const FormTwoWidget(
      key: ValueKey(1),
    ),
  ];
}