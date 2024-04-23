import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/text_field_widget.dart';
import 'package:mytix/app/core/widgets/widgets.dart';
import 'package:mytix/app/data/preference/session_manager.dart';
import 'package:mytix/app/modules/intro/forgot/forgot_password_page.dart';
import 'package:mytix/app/modules/intro/login/login_controller.dart';
import 'package:mytix/app/modules/intro/register/register_page.dart';
import 'package:mytix/app/modules/main/main_controller.dart';
import 'package:mytix/app/modules/main/main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final LoginController loginController = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppValues.padding),
        children: [

          //Logo
          Padding(
            padding: const EdgeInsets.only(
              top: kToolbarHeight
            ),
            child: Image.asset(imLogo,
              height: 50,
              alignment: Alignment.centerLeft,
            ),
          ),

          //Title
          const Padding(
            padding: EdgeInsets.only(
              top: AppValues.largePadding,
              bottom: AppValues.halfPadding
            ),
            child: Text("Masuk Pengguna",
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          //Subtitle
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Beli ",
                  style: TextStyle(
                    color: theme.disabledColor
                  )
                ),
                TextSpan(
                  text: "Tiket",
                  style: TextStyle(
                    color: theme.iconTheme.color
                  )
                ),
                TextSpan(
                  text: "? Di ",
                  style: TextStyle(
                    color: theme.disabledColor
                  )
                ),
                TextSpan(
                  text: "Match",
                  style: TextStyle(
                    color: theme.iconTheme.color
                  )
                ),
                TextSpan(
                  text: " Aja!",
                  style: TextStyle(
                    color: theme.disabledColor
                  )
                ),
              ],
            ),
          ),

          //Form
          Padding(
            padding: const EdgeInsets.only(
              top: AppValues.padding,
              bottom: AppValues.padding
            ),
            child: Form(
              key: loginController.formKey,
              child: Column(
                children: [

                  //Email
                  TextFieldWidget(
                    controller: loginController.emailTextController,
                    labelText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Silahkan masukan Email";
                      } else {
                        if (!value.isEmail) {
                          return "Format Email Salah";
                        } else {
                          return null;
                        }
                      }
                    },
                  ),

                  //Password
                  StatefulBuilder(
                    builder: (context, setState) {
                      return TextFieldWidget(
                        controller: loginController.passwordTextController,
                        obscureText: loginController.obscurePassword,
                        labelText: "Kata Sandi",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        suffixIcon: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            splashRadius: AppValues.radius,
                            onPressed: () {
                              setState(() {
                                loginController.obscurePassword = !loginController.obscurePassword;
                              });
                            },
                            icon: Icon(loginController.obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              size: AppValues.iconSize_20,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != "") return null;
                          return "Silahkan masukan Kata Sandi";
                        },
                      );
                    }
                  ),
                ],
              ),
            ),
          ),

          //Forgot Password
          Row(
            children: [
              Text("Lupa Kata Sandi? ",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: theme.disabledColor
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(ForgotPasswordPage.routeName);
                },
                child: Ink(
                  child: const Text(
                    "Klik Disini",
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

          //Button Login
          Padding(
            padding: const EdgeInsets.only(
              top: AppValues.padding,
              bottom: AppValues.padding
            ),
            child: ButtonPrimaryWidget(
              title: "Masuk",
              onPressed: () async {
                if (loginController.formKey.currentState!.validate()) {
                  await SessionManager.setAccessToken("oke");
                  await Get.delete<MainController>();
                  Get.offAllNamed(
                    MainPage.routeName,
                  );
                }
              },
            ),
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

          //Register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Belum Memiliki Akun? ",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: theme.disabledColor
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RegisterPage.routeName);
                },
                child: Ink(
                  child: const Text(
                    "Daftar Disini",
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
    );
  }
}