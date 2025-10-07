import 'package:intl/intl.dart';

const int expireLogOut = 5;

class Utils {
  formatCurrency(double value) {
    String result;
    if (value == '0.00' || value == '0' || value == "0.0") {
      return result = '0.00';
    }
    var formattedNumber = NumberFormat("#,###", "en_US").format(value);
    result = formattedNumber.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]}'");

    return result;
  }

  formatCurrencyDouble(double value) {
    String result;
    if (value == '0.00' || value == '0' || value == "0.0") {
      return result = '0.00';
    }
    var formattedNumber = NumberFormat("#,##0.00", "en_US").format(value);
    result = formattedNumber.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]}'");

    return result;
  }
  // String formatCurrencyCustom(num? value) {
  //   if (value == null) return '0.00';

  //   final NumberFormat formatter = NumberFormat('#,##0', 'en_US');
  //   return formatter.format(value);
  // }

  // String customThing(value) {
  //   if (value == null) return '0';
  //   final NumberFormat formatter = NumberFormat('#,##0', 'en_US');

  // }
  String formatCurrencyCustom(double value) {
    return value.toStringAsFixed(2);
  }

  static String formatUTC8(String utcDateString) {
    // Parse the UTC date string into a DateTime object
    DateTime utcDate = DateTime.parse(utcDateString).toUtc();

    // Convert UTC DateTime to UTC+8
    DateTime utc8Date = utcDate.add(const Duration(hours: 8));

    // Format the DateTime object to a string with the desired format
    return DateFormat("yyyy-MM-dd HH:mm").format(utc8Date).toString();
  }

  static String formatUTC8YDM(String utcDateString) {
    // Parse the UTC date string into a DateTime object
    DateTime utcDate = DateTime.parse(utcDateString).toUtc();

    // Convert UTC DateTime to UTC+8
    DateTime utc8Date = utcDate.add(const Duration(hours: 8));

    // Format the DateTime object to a string with the desired format
    return DateFormat("yyyy-MM-dd").format(utc8Date).toString();
  }

  static String formatYear(String utcDateString) {
    // Parse the UTC date string into a DateTime object
    DateTime utcDate = DateTime.parse(utcDateString).toUtc();

    // Convert UTC DateTime to UTC+8
    DateTime utc8Date = utcDate.add(const Duration(hours: 8));

    // Format the DateTime object to a string with the desired format
    return DateFormat("yyyy").format(utc8Date).toString();
  }
}
