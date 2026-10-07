import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'secure_local_storage.dart';

/// Central Supabase service manager handling client initialization,
/// secure session persistence, client access, storage, and audit logging.
class SupabaseService {
  static const String _defaultUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://zarvozaaexpblrhjsfzq.supabase.co',
  );
  static const String _defaultAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InphcnZvemFhZXhwYmxyaGpzZnpxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTA3MzUyNDUsImV4cCI6MjEwNjMxMTI0NX0.wKeHy1cUddFjeoVIZc4uUioFFImicSjL3-TuaRJl8oc',
  );

  static bool _isInitialized = false;

  /// Whether Supabase client was successfully initialized.
  static bool get isInitialized => _isInitialized;

  /// Returns the SupabaseClient if initialized, null otherwise.
  static SupabaseClient? get client {
    if (!_isInitialized) return null;
    return Supabase.instance.client;
  }

  /// Get current authenticated user ID if signed in.
  static String? get currentUserId {
    return client?.auth.currentUser?.id;
  }

  /// Initialize Supabase with secure session storage.
  /// URL and Anon Key can be provided via `--dart-define` or passed explicitly.
  static Future<void> initialize({
    String? url,
    String? anonKey,
  }) async {
    final supabaseUrl = (url != null && url.isNotEmpty) ? url : _defaultUrl;
    final supabaseAnonKey =
        (anonKey != null && anonKey.isNotEmpty) ? anonKey : _defaultAnonKey;

    if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
      try {
        await Supabase.initialize(
          url: supabaseUrl,
          // ignore: deprecated_member_use
          anonKey: supabaseAnonKey,
          authOptions: const FlutterAuthClientOptions(
            authFlowType: AuthFlowType.pkce,
            localStorage: SecureLocalStorage(),
          ),
        );
        _isInitialized = true;
        debugPrint('Supabase initialized successfully with SecureLocalStorage.');
      } catch (e) {
        debugPrint('Supabase initialization failed: $e');
        _isInitialized = false;
      }
    } else {
      debugPrint(
        'Supabase credentials not configured. '
        'Application will run in demo/offline mode with full role-security validation.',
      );
    }
  }

  /// Record an administrative or operational event into Supabase `audit_logs` table.
  static Future<void> logAudit({
    required String action,
    required String entityType,
    String? entityId,
    Map<String, dynamic>? metadata,
  }) async {
    final c = client;
    if (c == null || !_isInitialized) return;

    try {
      final actorId = c.auth.currentUser?.id;
      await c.from('audit_logs').insert({
        'actor_id': actorId,
        'action': action,
        'entity_type': entityType,
        'entity_id': entityId,
        'metadata': metadata ?? {},
        'created_at': DateTime.now().toIso8601String(),
      });
      debugPrint('[AuditLog] $action on $entityType recorded.');
    } catch (e) {
      debugPrint('[AuditLog Error] Could not record audit log: $e');
    }
  }

  /// Upload file binary to Supabase Storage bucket and return public URL.
  static Future<String?> uploadStorageFile({
    required String bucket,
    required String path,
    required Uint8List bytes,
    String contentType = 'image/jpeg',
  }) async {
    final c = client;
    if (c == null || !_isInitialized) return null;

    try {
      await c.storage.from(bucket).uploadBinary(
            path,
            bytes,
            fileOptions: FileOptions(contentType: contentType, upsert: true),
          );
      final publicUrl = c.storage.from(bucket).getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      debugPrint('[Storage Error] Failed to upload to $bucket/$path: $e');
      return null;
    }
  }
}
