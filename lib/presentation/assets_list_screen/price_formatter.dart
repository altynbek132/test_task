import 'package:intl/intl.dart';

mixin PriceFormatter {
  static String formatPrice(String priceUsd) {
    try {
      final double price = double.parse(priceUsd);
      return '\$${NumberFormat('#,##0.00').format(price)}';
    } catch (e) {
      return priceUsd;
    }
  }
}
