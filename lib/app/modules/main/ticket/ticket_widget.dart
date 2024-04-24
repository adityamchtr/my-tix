import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/utils/tools.dart';
import 'package:mytix/app/core/values/app_colors.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/counter_widget.dart';
import 'package:mytix/app/core/widgets/dash_line_widget.dart';
import 'package:mytix/app/core/widgets/widgets.dart';
import 'package:mytix/app/modules/main/ticket/ticket_controller.dart';
import 'package:mytix/app/modules/main/ticket/ticket_model.dart';

class TicketListWidget extends StatelessWidget {
  const TicketListWidget({super.key,
    this.isEnded = false,
  });

  final bool isEnded;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        top: AppValues.padding
      ),
      itemCount: 1,
      itemBuilder: (context, index) {
        return TicketItemWidget(
          isEnded: isEnded,
        );
      },
    );
  }
}

class TicketItemWidget extends StatelessWidget {
  const TicketItemWidget({super.key,
    this.isEnded= false,
  });

  final bool isEnded;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(
        left: AppValues.padding,
        right: AppValues.padding,
        bottom: AppValues.padding
      ),
      padding: const EdgeInsets.all(AppValues.padding),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.circular(AppValues.smallRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            offset: const Offset(0.0, 0.4)
          )
        ]
      ),
      child: Column(
        children: [

          //Image
          IntrinsicHeight(
            child: Row(
              children: [

                //Image
                Stack(
                  children: [
                    Container(
                      width: 100.0,
                      height: 110.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppValues.radius_6),
                        image: const DecorationImage(
                          image: AssetImage(imBannerEvent),
                          fit: BoxFit.cover
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.colorPurple.withOpacity(0.3),
                            spreadRadius: 3.0,
                            blurRadius: 6.0,
                          ),
                        ]
                      ),
                    ),

                    Positioned(
                      left: AppValues.extraSmallPadding,
                      right: AppValues.extraSmallPadding,
                      bottom: AppValues.extraSmallPadding,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppValues.radius - AppValues.halfPadding),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5.0,
                              sigmaY: 5.0
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(AppValues.extraSmallPadding),
                              decoration: BoxDecoration(
                                color: isEnded ? const Color(0xCCF04438) : const Color(0xCC12A92A),
                                borderRadius: BorderRadius.circular(AppValues.radius - AppValues.halfPadding),
                                gradient: LinearGradient(
                                  colors: [
                                    isEnded ? const Color(0xCCF04438) : const Color(0xCC12A92A),
                                    isEnded ? const Color(0xCCE85B50) : const Color(0xCC087C1A)
                                  ]
                                )
                              ),
                              child: Text(isEnded ? "Selesai" : "Berlangsung",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                //Body
                Flexible(
                  child: Ink(
                    padding: const EdgeInsets.only(
                      left: AppValues.padding
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Early Bird - Day 1",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            top: AppValues.halfPadding
                          ),
                          child: Text("Minggu, 28 januari 2024",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                        ),

                        Spacer(),

                        Text("Total tiket: 2/2",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          //Dash line
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppValues.smallPadding
            ),
            child: DashLineWidget(),
          ),

          //Button
          Row(
            children: [

              //Ulasan
              if (isEnded) Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: AppValues.padding
                  ),
                  child: ButtonPrimaryWidget(
                    isOutlined: true,
                    height: 40.0,
                    title: "Berikan Ulasan",
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                    onPressed: () {

                    },
                  ),
                ),
              ),

              //Lihat Detail
              Expanded(
                child: ButtonPrimaryWidget(
                  height: 40.0,
                  title: "Lihat Detail",
                  textStyle: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                  onPressed: () {


                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class TicketParentItemWidget extends StatelessWidget {
  const TicketParentItemWidget({super.key,
    required this.ticketParentItemModel,
  });

  final TicketParentItemModel ticketParentItemModel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TicketParentItemController ticketOptionItemController = Get.put(TicketParentItemController(),
      tag: ticketParentItemModel.id
    );

    return Padding(
      padding: const EdgeInsets.only(
        top: AppValues.padding
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppValues.smallRadius),
        child: Obx(() {
          return ExpansionWidget(
            title: ticketParentItemModel.title,
            isExpanded: ticketOptionItemController.isExpanded.value,
            onExpansionChanged: (value) {
              ticketOptionItemController.isExpanded.value = value;

              for (TicketChildItemModel ticketChildItem in ticketParentItemModel.ticketChild) {
                if (Get.isRegistered<TicketChildItemController>(
                  tag: ticketChildItem.id
                )) {
                  TicketChildItemController.to(ticketChildItem.id).showQty.value = false;
                  TicketChildItemController.to(ticketChildItem.id).ticketChildItem.qty = 0;
                }
              }

              if (!value) TicketCheckoutController.to.calculateTotalPrice();
            },
            children: [
              
              if (ticketParentItemModel.ticketChild.isNotEmpty) ...ticketParentItemModel.ticketChild.map((e) {
                return TicketChildItemWidget(
                  ticketChildItemModel: e,
                );
              })
              
              else Padding(
                padding: const EdgeInsets.only(
                  left: AppValues.padding,
                  right: AppValues.padding,
                  bottom: AppValues.padding
                ),
                child: Column(
                  children: [
                    const Text("Tiket Tidak Tersedia",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0
                      ),
                    ),
                    const SizedBox(
                      height: AppValues.halfPadding,
                    ),
                    Text("Saat ini, tiket untuk presale belum tersedia, silahkan menunggu info update dari acara tersebut",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.disabledColor
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class TicketChildItemWidget extends StatelessWidget {
  const TicketChildItemWidget({super.key,
    required this.ticketChildItemModel,
  });

  final TicketChildItemModel ticketChildItemModel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TicketChildItemController ticketChildItemController = Get.put(TicketChildItemController(
      ticketChildItem: ticketChildItemModel
    ),
      tag: ticketChildItemModel.id
    );

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppValues.padding,
        vertical: AppValues.halfPadding
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppValues.padding
      ),
      decoration: BoxDecoration(
        color: ticketChildItemModel.status ? theme.colorScheme.background : theme.disabledColor,
        borderRadius: BorderRadius.circular(AppValues.smallRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //Info
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.padding
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                SvgPicture.asset(icMainTicket),

                //Button Info
                IconButton(
                  icon: SvgPicture.asset(icInfo),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.dialog(
                      SimpleDialog(
                        contentPadding: const EdgeInsets.all(AppValues.padding),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppValues.smallRadius)
                        ),
                        children: [

                          Row(
                            children: [
                              SvgPicture.asset(icInfo),

                              const SizedBox(
                                width: AppValues.halfPadding,
                              ),

                              const Text("Rincian Benefit",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600
                                ),
                              ),

                              const Spacer(),

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

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppValues.halfPadding
                            ),
                            child: Text("Kamu akan mendapatkan hak ekslusif tiket berupa:",
                              style: TextStyle(
                                color: theme.disabledColor,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              const Text("Freebies",
                                style: TextStyle(
                                  fontSize: 16.0,
                                )
                              ),

                              Text("x1",
                                style: TextStyle(
                                  color: theme.disabledColor,
                                  fontSize: 16.0,
                                )
                              ),
                              
                            ],
                          ),

                          const SizedBox(
                            height: AppValues.halfPadding,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              const Text("Komik",
                                style: TextStyle(
                                  fontSize: 16.0,
                                )
                              ),

                              Text("x1",
                                style: TextStyle(
                                  color: theme.disabledColor,
                                  fontSize: 16.0,
                                )
                              ),

                            ],
                          )
                        ],
                      )
                    );
                  },
                )
              ],
            ),
          ),

          const SizedBox(
            height: AppValues.halfPadding,
          ),

          //Title
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.padding
            ),
            child: Text(ticketChildItemModel.name,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600
              ),
            ),
          ),

          //Date
          Padding(
            padding: const EdgeInsets.symmetric(
             horizontal: AppValues.padding
            ),
            child: Text(ticketChildItemModel.date,
              style: TextStyle(
                color: theme.disabledColor
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppValues.halfPadding
            ),
            child: DividerCutterWidget(),
          ),

          //Price & QTY
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.padding
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Expanded(
                  flex: 4,
                  child: Text(convertToIdr(ticketChildItemModel.price,
                    showSymbol: true
                  ),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),

                Flexible(
                  flex: 3,
                  child: Column(
                    children: [

                      if (ticketChildItemModel.status) const Text("Max 5 tiket",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),

                      const SizedBox(
                        height: AppValues.padding_2,
                      ),

                      Obx(() {
                        if (ticketChildItemController.showQty.value) {
                          return CounterWidget(
                            textEditingController: ticketChildItemController.counterTextController
                          );
                        }

                        return ButtonPrimaryWidget(
                          backgroundColor: ticketChildItemModel.status ? null : AppColors.colorRed,
                          disabledBackgroundColor: ticketChildItemModel.status ? null : AppColors.colorRed,
                          disabledForegroundColor: Colors.white,
                          height: 32.0,
                          title: ticketChildItemModel.status ? "Beli" : "Habis",
                          textStyle: const TextStyle(),
                          onPressed: ticketChildItemModel.status ? () {
                            ticketChildItemController.showQty.value = true;
                          } : null,
                        );
                      })
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}