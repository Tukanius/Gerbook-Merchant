import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  final String _keyUserName = 'email';
  final String _keyPassWord = 'password';
  final String _isBiometric = 'biometric';

  Future setUserName(String email) async {
    await storage.write(key: _keyUserName, value: email);
  }

  Future<String?> getUserName() async {
    return await storage.read(key: _keyUserName);
  }

  Future deleteAll() async {
    await storage.deleteAll();
    print("ALL STORAGE DELETED");
  }

  Future setPassWord(String password) async {
    await storage.write(key: _keyPassWord, value: password);
  }

  Future<String?> getPassWord() async {
    return await storage.read(key: _keyPassWord);
  }

  Future setBioMetric(bool bioMetric) async {
    await storage.write(key: _isBiometric, value: "${bioMetric}");
  }

  Future<String?> getBioMetric() async {
    return await storage.read(key: _isBiometric);
  }
}
