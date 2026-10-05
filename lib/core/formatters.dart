import 'package:intl/intl.dart';

// Utility formatters for currency and dates
class AppFormatters {
  static final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  static final NumberFormat _decimalCurrencyFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  // Formats amounts like ₹1,500
  static String formatRupee(num amount) {
    return _currencyFormat.format(amount);
  }

  // Formats fractional amounts like ₹7,425.50
  static String formatRupeeDecimal(num amount) {
    return _decimalCurrencyFormat.format(amount);
  }

  // Formats dates into human readable strings like 05 Oct 2026
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  // Formats timestamps into time strings like 10:15 AM
  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  // Formats timestamps into strings like 24 Oct, 6:40 PM
  static String formatDateTime(DateTime date) {
    return DateFormat('dd MMM, hh:mm a').format(date);
  }
}
