import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mytix/app/core/values/app_constants.dart';
import 'package:mytix/app/core/values/app_styles.dart';
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

class TicketDetailController extends GetxController {

  final PageController pageController = PageController(
    viewportFraction: 0.9,
  );
  var page = 0.obs;
  var isSaving = false.obs;
  bool isExchanged = false;

  @override
  void onInit() {
    super.onInit();

    isExchanged = Get.arguments ?? false;
  }

  @override
  void onClose() {
    super.onClose();

    pageController.dispose();
  }

  saveImageToGallery(GlobalKey globalKey) async {
    isSaving.value = true;
    RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage();

    ByteData? byteData = await (image.toByteData(
      format: ui.ImageByteFormat.png)
    );

    if (byteData != null) {
      final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());

      if (result["isSuccess"]) {
        showSnackBar(
          title: "Berhasil",
          message: "Tiket berhasil disimpan di gallery"
        );
        isSaving.value = false;
        return;
      }
    }

    showSnackBar(
      title: "Gagal",
      message: "Tiket gagal disimpan di gallery",
      isSuccess: false
    );
    isSaving.value = false;
  }
}

class TicketDetailItemController extends GetxController {

  GlobalKey globalKey = GlobalKey();
}