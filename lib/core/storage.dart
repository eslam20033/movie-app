import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static const _storage = FlutterSecureStorage();
  static const String _key = 'auth_token';

  static Future<void> saveToken(String token) =>
      _storage.write(key: _key, value: token);

  static Future<String?> get() => _storage.read(key: _key);

  static Future<void> delete() => _storage.delete(key: _key);

  static Future<bool> get hasToken async => await get() != null;
}
