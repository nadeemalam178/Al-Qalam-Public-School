import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Secure session storage using [FlutterSecureStorage] for Supabase auth persistence.
class SecureLocalStorage extends LocalStorage {
  const SecureLocalStorage();

  static const _storage = FlutterSecureStorage();
  static const _sessionKey = 'supabase_auth_session';

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> hasAccessToken() async {
    return _storage.containsKey(key: _sessionKey);
  }

  @override
  Future<String?> accessToken() async {
    return _storage.read(key: _sessionKey);
  }

  @override
  Future<void> persistSession(String persistSessionString) async {
    await _storage.write(key: _sessionKey, value: persistSessionString);
  }

  @override
  Future<void> removePersistedSession() async {
    await _storage.delete(key: _sessionKey);
  }
}
