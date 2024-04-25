import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/utils/tools.dart';
import 'package:mytix/app/core/values/app_colors.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/widgets.dart';
import 'package:mytix/app/modules/main/payment/payment_controller.dart';
import 'package:mytix/app/modules/main/payment/payment_model.dart';

class PaymentVoucherWidget extends StatelessWidget {
  const PaymentVoucherWidget({super.key,
    required this.title,
    required this.subtitle,
    this.isVoucher = false,
    this.onTap,
    this.onTapChange,
  });

  final String title;
  final String subtitle;
  final bool isVoucher;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapChange;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PaymentController paymentController = Get.find();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.padding
      ),
      child: Ink(
        padding: const EdgeInsets.all(AppValues.padding),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(AppValues.smallRadius),
          border: Border.all(
            color: theme.dividerColor,
            width: 1.0
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600
              ),
            ),

            const SizedBox(
              height: AppValues.halfPadding,
            ),

            Obx(() {

              //Payment Selected
              if (paymentController.childSelected.value != null && !isVoucher) {
                PaymentChildItemModel payment = paymentController.childSelected.value!;
                return Container(
                  padding: const EdgeInsets.all(AppValues.padding),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBFEFA),
                    borderRadius: BorderRadius.circular(AppValues.smallRadius),
                    border: Border.all(
                      width: 1.0,
                      color: AppColors.colorGreen
                    )
                  ),
                  child: Row(
                    children: [

                      Image.asset(payment.logo,
                        width: 30,
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppValues.halfPadding
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(payment.headerTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              Row(
                                children: [
                                  Text(payment.name,
                                    style: TextStyle(
                                      color: theme.disabledColor
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.info_outline_rounded,
                                      size: 15.0,
                                      color: theme.disabledColor,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    splashRadius: AppValues.splashRadius,
                                    onPressed: () {
                                      Get.bottomSheet(
                                        PaymentProvisionWidget(paymentChildItem: payment)
                                      );
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: onTapChange,
                        child: const Text("Ubah",
                          style: TextStyle(
                            color: AppColors.colorBlue
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }

              //Not Selected
              return InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(AppValues.smallRadius),
                child: Ink(
                  padding: EdgeInsets.symmetric(
                      vertical: isVoucher ? AppValues.extraSmallPadding : AppValues.halfPadding,
                      horizontal: AppValues.padding
                  ),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(AppValues.smallRadius),
                  ),
                  child: Row(
                    children: [
                      if (isVoucher) Padding(
                        padding: const EdgeInsets.only(
                          right: AppValues.halfPadding
                        ),
                        child: Badge(
                          child: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: theme.colorScheme.background,
                            child: SvgPicture.asset(icVoucher),
                          ),
                        ),
                      ),

                      Text(subtitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0
                        ),
                      ),

                      const Spacer(),

                      const Icon(Icons.keyboard_arrow_right_rounded,
                        color: AppColors.colorBlue,
                      )
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class PaymentLabelWidget extends StatelessWidget {
  const PaymentLabelWidget({super.key,
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  final String title;
  final double value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppValues.smallPadding
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
            style: TextStyle(
              color: !isTotal ? theme.disabledColor : null,
              fontSize: 16.0,
              fontWeight: FontWeight.w500
            ),
          ),

          Text(convertToIdr(value, showSymbol: true),
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600
            ),
          )
        ],
      ),
    );
  }
}

class PaymentProvisionWidget extends StatelessWidget {
  const PaymentProvisionWidget({super.key,
    required this.paymentChildItem,
  });

  final PaymentChildItemModel paymentChildItem;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppValues.padding),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppValues.smallRadius),
          topRight: Radius.circular(AppValues.smallRadius)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Text(paymentChildItem.headerTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0
                ),
              ),

              IconButton(
                icon: const Icon(Icons.close_rounded),
                color: theme.disabledColor,
                padding: EdgeInsets.zero,
                splashRadius: AppValues.splashRadius,
                constraints: const BoxConstraints(),
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),

          const SizedBox(
            height: AppValues.padding,
          ),

          //Title Payment
          Row(
            children: [
              Image.asset(paymentChildItem.logo,
                width: 50,
              ),

              const SizedBox(
                width: AppValues.halfPadding,
              ),

              Text("${paymentChildItem.name} ${paymentChildItem.headerTitle}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0
                ),
              ),
            ],
          ),

          Divider(
            height: AppValues.extraLargePadding,
            color: theme.colorScheme.primary,
          ),

          const Text("Ketentuan:",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.0
            ),
          ),

          const SizedBox(
            height: AppValues.padding,
          ),

          SizedBox(
            height: 100,
            child: ListView(
              children: paymentProvision.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppValues.halfPadding
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("• ",
                        style: TextStyle(
                          color: theme.disabledColor
                        )
                      ),
                      Flexible(
                        child: Text(e,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: theme.disabledColor
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const Spacer(),

          ButtonPrimaryWidget(
            height: 40.0,
            title: "Pilih Metode",
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }
}



