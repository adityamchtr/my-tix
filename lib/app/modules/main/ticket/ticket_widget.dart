import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_values.dart';
import 'package:mytix/app/core/widgets/dash_line_widget.dart';
import 'package:mytix/app/core/widgets/widgets.dart';

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
                      width: 120.0,
                      height: 110.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppValues.radius_6),
                        image: const DecorationImage(
                          image: AssetImage(imBannerEvent),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),

                    Positioned(
                      left: AppValues.smallPadding,
                      right: AppValues.smallPadding,
                      bottom: AppValues.smallPadding,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppValues.extraLargeRadius),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5.0,
                              sigmaY: 5.0
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(AppValues.extraSmallPadding),
                              decoration: BoxDecoration(
                                color: isEnded ? const Color(0x80F04438) : const Color(0x8012B76A),
                                borderRadius: BorderRadius.circular(AppValues.radius - AppValues.halfPadding),
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
