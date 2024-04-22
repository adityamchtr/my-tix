import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:match/app/core/values/app_constants.dart';
import 'package:match/app/core/values/app_styles.dart';
import 'package:match/app/core/values/app_values.dart';
import 'package:match/app/core/widgets/text_field_widget.dart';
import 'package:match/app/core/widgets/widgets.dart';
import 'package:match/app/modules/intro/forgot/forgot_password_controller.dart';
import 'package:match/app/modules/intro/register/register_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  static const String routeName = "/forgot_password";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        titleSpacing: 0.0,
        title: const Text("Lupa Kata Sandi"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppValues.padding),
        children: [

          //Title
          const Padding(
            padding: EdgeInsets.only(
              bottom: AppValues.halfPadding
            ),
            child: Text("Lupa Kata Sandi",
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          //Subtitle
          Text("Silahkan masukan email untuk mereset kata sandi",
            style: TextStyle(
              fontSize: 18.0,
              color: theme.disabledColor
            ),
          ),

          //Form
          Form(
            key: forgotPasswordController.formKey,
            child: TextFieldWidget(
              controller: forgotPasswordController.emailTextController,
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
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
          ),

          //Button Reset
          Padding(
            padding: const EdgeInsets.only(
              top: AppValues.padding,
              bottom: AppValues.extraLargePadding
            ),
            child: ButtonPrimaryWidget(
              title: "Reset Kata Sandi",
              onPressed: () {
                if (forgotPasswordController.formKey.currentState!.validate()) {
                  Get.dialog(
                    AlertDialogWidget(
                      image: Padding(
                        padding: const EdgeInsets.only(
                          top: AppValues.padding
                        ),
                        child: SvgPicture.asset(imSuccess),
                      ),
                      title: "Reset Berhasil",
                      subTitle: "Silahkan cek link yang telah dikirim ke email ${forgotPasswordController.emailTextController.text}",
                      textConfirm: "Kembali",
                      onConfirm: () {
                        Get.back(
                          closeOverlays: true
                        );
                      },
                    )
                  );
                }
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
                  Get.toNamed(RegisterPage.routeName)!.then((value) {
                    if (value == "oke") Get.back();
                  });
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
