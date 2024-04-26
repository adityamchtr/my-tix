import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String convertToIdr(dynamic number, {bool showSymbol = false, int decimalDigits = 0}) {
  if(number is String) {
    number = double.parse(number);
  }

  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: showSymbol ? 'Rp. ' : '',
    decimalDigits: decimalDigits,
  );
  return currencyFormatter.format(number);
}

Route fadePageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return page;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}