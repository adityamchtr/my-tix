import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/modules/main/ticket/ticket_model.dart';

class TicketCheckoutController extends GetxController {

  static TicketCheckoutController get to => Get.find();

  List<TicketParentItemModel> ticketParents = [];

  var totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    fetchTicket();
  }

  void fetchTicket() {
    List<TicketParentItemModel> data = List<TicketParentItemModel>.from(
      ticketDummies["data"]!.map((item) {
        return TicketParentItemModel.fromMap(item);
      })
    );

    ticketParents.addAll(data);
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

  List<TicketChildItemModel> getTicketSelected() {
    List<TicketChildItemModel> ticket = [];

    for (TicketParentItemModel ticketParent in ticketParents) {
      for (TicketChildItemModel ticketChild in ticketParent.ticketChild) {
        if (ticketChild.qty > 0) {
          ticket.add(ticketChild);
        }
      }
    }

    return ticket;
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