import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLocale(String locale) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('NEXT_LOCALE', locale);
}

Future<String?> getLocale() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('NEXT_LOCALE');
}
