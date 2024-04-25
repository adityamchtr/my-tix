import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_colors.dart';
import 'package:mytix/app/core/values/app_styles.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/expansion_panel_widget.dart';
import 'package:mytix/app/core/widgets/widgets.dart';
import 'package:mytix/app/modules/main/payment/payment_controller.dart';
import 'package:mytix/app/modules/main/payment/payment_model.dart';
import 'package:mytix/app/modules/main/payment/payment_widget.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  static const String routeName = "/payment_method";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PaymentMethodController paymentMethodController = Get.put(PaymentMethodController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        titleSpacing: 0.0,
        title: const Text("Metode Pembayaran"),
        systemOverlayStyle: systemUiOverlayStyle(theme),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppValues.padding),
        child: ExpansionPanelListWidget.radio(
          elevation: 0.0,
          initialOpenPanelValue: paymentMethodController.childSelected.value?.headerId,
          expansionCallback: (panelIndex, isExpanded) {
            if (isExpanded) {
              PaymentParentItemModel payment = paymentMethodController.paymentMethods[panelIndex];
              paymentMethodController.parentSelected.value = payment.id;
              if (payment.paymentChild.length == 1) {
                paymentMethodController.childSelected.value = payment.paymentChild.first;
              }
            } else {
              paymentMethodController.childSelected.value = null;
              paymentMethodController.parentSelected.value = null;
            }
          },
          children: paymentMethodController.paymentMethods.map((e) {
            return ExpansionPanelRadioWidget(
              value: e.id,
              headerBuilder: (context, isExpanded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //Title
                    Text(e.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0
                      ),
                    ),

                    //Logo Payment
                    Obx(() {
                      return Visibility(
                        visible: paymentMethodController.parentSelected.value != e.id,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: AppValues.padding
                          ),
                          child: Row(
                            children:e.paymentChild.map((e) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: AppValues.padding_2
                                ),
                                child: Image.asset(e.logo,
                                  width: 40.0,
                                  height: 10.0,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    })
                  ],
                );
              },
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.padding
                ),
                child: Column(
                  children: e.paymentChild.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppValues.padding
                      ),
                      child: InkWell(
                        onTap: () {
                          paymentMethodController.childSelected.value = e;
                        },
                        radius: AppValues.smallRadius,
                        child: Obx(() {
                          bool isSelected = paymentMethodController.childSelected.value?.id == e.id;
                          return Container(
                            padding: const EdgeInsets.all(AppValues.padding),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.background,
                              borderRadius: BorderRadius.circular(AppValues.smallRadius),
                              border: Border.all(
                                color: isSelected ? theme.colorScheme.primary : theme.dividerColor,
                                width: 1.0
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Image.asset(e.logo,
                                  width: 50.0,
                                  height: 15.0,
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                    );
                  }).toList(),
                ),
              )
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppValues.padding),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppValues.smallRadius),
            topRight: Radius.circular(AppValues.smallRadius)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4.0,
              offset: const Offset(0.4, 0.0)
            )
          ]
        ),
        child: Obx(() {
          bool isChildSelected = paymentMethodController.childSelected.value != null;
          return Row(
            children: [

              //Label payment
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: isChildSelected ? () {
                        Get.bottomSheet(
                          PaymentProvisionWidget(
                            paymentChildItem: paymentMethodController.childSelected.value!,
                          )
                        );
                      } : null,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(isChildSelected ? "Bayar melalui ${paymentMethodController.childSelected.value!.headerTitle}" : "-",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0
                              ),
                            ),
                          ),
                          if (isChildSelected) const Icon(Icons.keyboard_arrow_up_rounded,
                            size: AppValues.emoticonDefaultSize,
                            color: AppColors.colorBlue,
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: AppValues.extraSmallPadding,
                    ),

                    Text(isChildSelected ? paymentMethodController.childSelected.value!.name : "-",
                      style: TextStyle(
                        color: theme.disabledColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: AppValues.padding,
              ),

              //Button
              SizedBox(
                width: 140.0,
                child: ButtonPrimaryWidget(
                  height: 40.0,
                  title: "Pilih Metode",
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0
                  ),
                  onPressed: isChildSelected ? () {
                    Get.back(
                      result: paymentMethodController.childSelected.value
                    );
                  } : null,
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
