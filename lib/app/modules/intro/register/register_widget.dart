import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/text_field_widget.dart';
import 'package:mytix/app/modules/intro/register/register_controller.dart';

class FormOneWidget extends StatelessWidget {
  const FormOneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final RegisterController registerController = Get.find();

    return Form(
      key: registerController.formOneKey,
      child: Column(
        children: [

          //Name
          TextFieldWidget(
            controller: registerController.nameTextController,
            labelText: "Nama Lengkap",
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value != "") return null;
              return "Silahkan masukan Nama Lengkap";
            },
          ),

          //Birth Place
          TextFieldWidget(
            controller: registerController.birthPlaceTextController,
            labelText: "Tempat Lahir",
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value != "") return null;
              return "Silahkan masukan Tempat Lahir";
            },
          ),

          //Birth Date
          TextFieldWidget(
            controller: registerController.birthDateTextController,
            labelText: "Tanggal Lahir",
            readOnly: true,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.calendar_today_outlined),
            onTap: () {
              showDatePicker(
                context: context,
                firstDate: DateTime(1990),
                lastDate: DateTime.now(),
                initialDate: registerController.birthDate,
                locale: const Locale("id", "ID")
              ).then((value) {
                if (value != null) registerController.setBirthDate(value);
              });
            },
            validator: (value) {
              if (value != "") return null;
              return "Silahkan masukan Tanggal Lahir";
            },
          ),

          //Gender
          Container(
            width: Get.width,
            margin: const EdgeInsets.only(
              top: AppValues.padding
            ),
            child: StatefulBuilder(
              builder: (context, setState) {
                return CupertinoSlidingSegmentedControl(
                  padding: const EdgeInsets.all(AppValues.extraSmallPadding),
                  groupValue: registerController.gender,
                  thumbColor: theme.colorScheme.primary,
                  children: {
                    0: ButtonGenderWidget(
                      label: "Laki-laki",
                      isSelected: registerController.gender == 0
                    ),
                    1: ButtonGenderWidget(
                      label: "Perempuan",
                      isSelected: registerController.gender == 1
                    ),
                  },
                  onValueChanged: (value) {
                    setState(() {
                      registerController.gender = value ?? 0;
                    });
                  },
                );
              }
            ),
          ),

          //WA
          TextFieldWidget(
            controller: registerController.waTextController,
            labelText: "No WhatsApp",
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            validator: (value) {
              if (value!.isEmpty) {
                return "Silahkan masukan No WhatsApp";
              } else {
                if (!value.isPhoneNumber) {
                  return "No WhatsApp tidak valid";
                } else {
                  return null;
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

class FormTwoWidget extends StatelessWidget {
  const FormTwoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController registerController = Get.find();

    return Form(
      key: registerController.formTwoKey,
      child: Column(
        children: [

          //Email
          TextFieldWidget(
            controller: registerController.emailTextController,
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
                controller: registerController.passwordTextController,
                obscureText: registerController.obscurePassword,
                labelText: "Kata Sandi",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                suffixIcon: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    splashRadius: AppValues.radius,
                    onPressed: () {
                      setState(() {
                        registerController.obscurePassword = !registerController.obscurePassword;
                      });
                    },
                    icon: Icon(registerController.obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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

          //Password Confirm
          StatefulBuilder(
            builder: (context, setState) {
              return TextFieldWidget(
                controller: registerController.confirmPasswordTextController,
                obscureText: registerController.obscureConfirmPassword,
                labelText: "Konfirmasi Kata Sandi",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                suffixIcon: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    splashRadius: AppValues.radius,
                    onPressed: () {
                      setState(() {
                        registerController.obscureConfirmPassword = !registerController.obscureConfirmPassword;
                      });
                    },
                    icon: Icon(registerController.obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: AppValues.iconSize_20,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Silahkan masukan Konfirmasi Kata Sandi";
                  } else {
                    if (value != registerController.passwordTextController.text && registerController.passwordTextController.text.isNotEmpty) {
                      return "Kata Sandi Tidak Sama";
                    } else {
                      return null;
                    }
                  }
                },
              );
            }
          ),
        ],
      ),
    );
  }
}

class ButtonGenderWidget extends StatelessWidget {
  const ButtonGenderWidget({super.key,
    required this.label,
    required this.isSelected
  });

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppValues.buttonVerticalPadding
      ),
      child: Text(label,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : Colors.black
        ),
      ),
    );
  }
}
