import 'package:flutter/foundation.dart';
import 'package:merchant_gerbook_flutter/api/auth_api.dart';
// import 'package:intl/intl.dart';

class LocalizationProvider extends ChangeNotifier {
  Map<String, String> _translations = {};
  // Currency currency = Currency();
  double value = 1;
  String? lang;

  Map<String, String> get translations => _translations;

  Future<void> loadTranslations(String language) async {
    lang = language;
    var res = await AuthApi().changeLanguage(language);
    if (res != null && res is List) {
      _translations = {
        for (var item in res)
          if (item.contains("|"))
            item.split("|")[0].trim(): item.split("|")[1].trim(),
      };
      notifyListeners();
    }
    // currency = await ProductApi().getPrice();
    // if (language == 'mn') {
    //   value = 1;
    // } else {
    //   value = currency.usd!.toDouble();
    // }
    notifyListeners();
  }

  String translate(String key) {
    return _translations[key] ?? key;
  }

  // String formatCurrency(double price) {
  //   double formattedValue;

  //   // Currency adjustment
  //   if (value == 1) {
  //     formattedValue = price;
  //   } else {
  //     formattedValue = price / value;
  //   }

  //   formattedValue = (formattedValue * 100).ceil() / 100;

  //   final numberFormat = NumberFormat("#,##0.00", "en_US");
  //   String formattedValueStr = numberFormat.format(formattedValue);

  //   // Check if value has decimal part
  //   if (formattedValue == formattedValue.toInt()) {
  //     // Remove decimals if value is a whole number
  //     formattedValueStr = numberFormat.format(formattedValue.toInt());
  //   }

  //   // Check if it's in Mongolian (₮) or other currency ($)
  //   if (value == 1) {
  //     return "₮$formattedValueStr"; // Mongolian Tugrik (₮)
  //   } else {
  //     return "\$${formattedValueStr}"; // USD ($)
  //   }
  // }
  // String formatCurrency(double price) {
  //   double formattedValue;

  //   if (value == 1) {
  //     formattedValue = price;
  //   } else {
  //     formattedValue = price / value;
  //   }
  //   formattedValue = (formattedValue * 100).ceil() / 100;

  //   if (formattedValue == formattedValue.toInt()) {
  //     return value == 1
  //         ? "₮${Utils().formatCurrency(formattedValue)}"
  //         : "\$${Utils().formatCurrency(formattedValue)}";
  //   } else {
  //     return value == 1
  //         ? "₮${Utils().formatCurrencyDouble(formattedValue)}"
  //         : "\$${Utils().formatCurrencyDouble(formattedValue)}";
  //   }
  //   // if (value == 1) {
  //   //   return "₮${formattedValue.toStringAsFixed(2)}";
  //   // } else {
  //   //   return "\$${formattedValue.toStringAsFixed(2)}";
  //   // }
  // }

  // String formatCurrency(double price) {
  //   if (value == 1) {
  //     return "₮${Utils().formatCurrencyCustom(price)}";
  //   } else {
  //     return "\$${Utils().formatCurrencyCustom(price / value)}";
  //     // currencyRate(lang!, price);
  //     //
  //   }
  // }

  // dynamic currencyRate(
  //   String language,
  //   num price, {
  //   int decimals = 2,
  //   bool isNumber = false,
  // }) {
  //   if (price.isNaN) return '0';
  //   // Parse rate, defaulting to 1 if invalid
  //   final rate = double.tryParse(currency.rate!.replaceAll(',', '')) ?? 1;
  //   // Calculate price based on language
  //   final calculatedPrice = language != 'mn' ? price / rate : price;
  //   // Round up to specified decimal places
  //   final factor = pow(10, decimals);
  //   final ceiledPrice = (calculatedPrice * factor).ceil() / factor;
  //   if (isNumber) return ceiledPrice;
  //   // Format with commas and currency symbol
  //   final formattedNumber = NumberFormat.decimalPattern()
  //       .format(ceiledPrice.toStringAsFixed(decimals));
  //   return '$formattedNumber${language != 'mn' ? '\$' : '₮'}';
  // }
}
