import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytix/app/modules/main/ticket/ticket_model.dart';

class TicketCheckoutController extends GetxController {

  static TicketCheckoutController get to => Get.find();

  List<TicketParentItemModel> ticketParents = [];

  var totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    ticketParents.addAll([
      TicketParentItemModel(
        id: "early",
        title: "Early Bird Tiket",
        ticketChild: [
          TicketChildItemModel(
            id: "1",
            name: "Early Bird - Day 1",
            date: "Minggu, 28 Januari 2024",
            price: 45000
          ),
          TicketChildItemModel(
            id: "2",
            name: "Early Bird - Day 2",
            date: "Minggu, 29 Januari 2024",
            price: 45000
          )
        ]
      ),
      TicketParentItemModel(
        id: "regular",
        title: "Regular",
        ticketChild: [
          TicketChildItemModel(
            id: "3",
            name: "Regular - Day 1",
            date: "Minggu, 28 Januari 2024",
            status: false,
            price: 40000
          ),
          TicketChildItemModel(
            id: "4",
            name: "Regular - Day 2",
            date: "Minggu, 29 Januari 2024",
            price: 40000
          )
        ]
      ),
      TicketParentItemModel(
        id: "presale",
        title: "Presale",
        ticketChild: []
      )
    ]);
  }

  void calculateTotalPrice() {
    double total = 0;

    for (TicketParentItemModel ticketParent in ticketParents) {
      for (TicketChildItemModel ticketChild in ticketParent.ticketChild) {
        total += ticketChild.price * ticketChild.qty;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      totalPrice.value = total;
    });
  }

}

class TicketParentItemController extends GetxController {

  var isExpanded = false.obs;

}

class TicketChildItemController extends GetxController {
  TicketChildItemController({required this.ticketChildItem});

  static TicketChildItemController to(String tag) {
    return Get.find(tag: tag);
  }

  final TicketChildItemModel ticketChildItem;
  final TextEditingController counterTextController = TextEditingController();

  var showQty = false.obs;

  @override
  void onInit() {
    super.onInit();

    counterTextController.addListener(() {
      if (counterTextController.text == "0") {
        showQty.value = false;
      }

      ticketChildItem.qty = int.parse(counterTextController.text);
      TicketCheckoutController.to.calculateTotalPrice();
    });
  }

  @override
  void onClose() {
    super.onClose();

    counterTextController.dispose();
  }
}