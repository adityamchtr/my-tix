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