import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/teacher_model.dart';
import '../models/parent_account_model.dart';
import 'supabase_service.dart';

class AccountManagementService {
  static const _storage = FlutterSecureStorage();
  static const String _localTeachersKey = 'alqalam_local_teachers_v1';
  static const String _localParentsKey = 'alqalam_local_parents_v1';

  // ---------------------------------------------------------------------------
  // TEACHER ACCOUNTS
  // ---------------------------------------------------------------------------

  /// Fetches teachers from Supabase cloud table with local storage cache.
  static Future<List<TeacherModel>> getTeachers() async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        final res = await client
            .from('teachers')
            .select()
            .order('name', ascending: true);

        final list = (res as List)
            .map((r) => TeacherModel.fromJson(r as Map<String, dynamic>))
            .toList();

        // Update local cache
        await _saveTeachersToLocal(list);
        return list;
      } catch (e) {
        debugPrint('[AccountManagementService] Cloud fetch teachers error: $e');
      }
    }

    return _getTeachersFromLocal();
  }

  /// Saves or updates a teacher account in Supabase and local cache.
  static Future<void> saveTeacher(TeacherModel teacher) async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        await client.from('teachers').upsert(teacher.toJson());
      } catch (e) {
        debugPrint('[AccountManagementService] Cloud save teacher error: $e');
      }
    }

    // Always persist to local secure cache
    final current = await _getTeachersFromLocal();
    final index = current.indexWhere((t) => t.id == teacher.id);
    if (index >= 0) {
      current[index] = teacher;
    } else {
      current.add(teacher);
    }
    await _saveTeachersToLocal(current);
  }

  /// Deletes a teacher account.
  static Future<void> deleteTeacher(String id) async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        await client.from('teachers').delete().eq('id', id);
      } catch (e) {
        debugPrint('[AccountManagementService] Cloud delete teacher error: $e');
      }
    }

    final current = await _getTeachersFromLocal();
    current.removeWhere((t) => t.id == id);
    await _saveTeachersToLocal(current);
  }

  /// Verifies teacher login credentials against registered faculty accounts.
  static Future<TeacherModel?> authenticateTeacher({
    required String identifier,
    required String password,
  }) async {
    final cleanId = identifier.trim().toLowerCase();
    final cleanPass = password.trim();

    final teachers = await getTeachers();

    for (final t in teachers) {
      if (!t.isActive) continue;

      final loginIdMatch = t.loginId.toLowerCase() == cleanId;
      final emailMatch = t.email.toLowerCase() == cleanId;
      final phoneDigits = t.phone.replaceAll(RegExp(r'\D'), '');
      final inputDigits = cleanId.replaceAll(RegExp(r'\D'), '');
      final phoneMatch = inputDigits.isNotEmpty &&
          (phoneDigits == inputDigits || phoneDigits.endsWith(inputDigits));

      if (loginIdMatch || emailMatch || phoneMatch) {
        if (t.password == cleanPass) {
          return t;
        }
      }
    }
    return null;
  }

  static Future<List<TeacherModel>> _getTeachersFromLocal() async {
    try {
      final raw = await _storage.read(key: _localTeachersKey);
      if (raw != null && raw.isNotEmpty) {
        final decoded = jsonDecode(raw) as List;
        return decoded
            .map((j) => TeacherModel.fromJson(j as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {}
    return [];
  }

  static Future<void> _saveTeachersToLocal(List<TeacherModel> list) async {
    try {
      final encoded = jsonEncode(list.map((t) => t.toJson()).toList());
      await _storage.write(key: _localTeachersKey, value: encoded);
    } catch (_) {}
  }

  // ---------------------------------------------------------------------------
  // PARENT / GUARDIAN ACCOUNTS
  // ---------------------------------------------------------------------------

  /// Fetches parent accounts from Supabase cloud table with local cache fallback.
  static Future<List<ParentAccountModel>> getParents() async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        final res = await client
            .from('parent_accounts')
            .select()
            .order('created_at', ascending: false);

        final list = (res as List)
            .map((r) => ParentAccountModel.fromJson(r as Map<String, dynamic>))
            .toList();

        await _saveParentsToLocal(list);
        return list;
      } catch (e) {
        debugPrint('[AccountManagementService] Cloud fetch parents error: $e');
      }
    }

    return _getParentsFromLocal();
  }

  /// Saves or updates a parent login account.
  static Future<void> saveParent(ParentAccountModel parent) async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        await client.from('parent_accounts').upsert(parent.toJson());
      } catch (e) {
        debugPrint('[AccountManagementService] Cloud save parent error: $e');
      }
    }

    final current = await _getParentsFromLocal();
    final index = current.indexWhere((p) => p.id == parent.id);
    if (index >= 0) {
      current[index] = parent;
    } else {
      current.insert(0, parent);
    }
    await _saveParentsToLocal(current);
  }

  /// Deletes a parent login account.
  static Future<void> deleteParent(String id) async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        await client.from('parent_accounts').delete().eq('id', id);
      } catch (e) {
        debugPrint('[AccountManagementService] Cloud delete parent error: $e');
      }
    }

    final current = await _getParentsFromLocal();
    current.removeWhere((p) => p.id == id);
    await _saveParentsToLocal(current);
  }

  /// Verifies guardian/parent login credentials against registered accounts.
  static Future<ParentAccountModel?> authenticateParent({
    required String identifier,
    required String password,
  }) async {
    final cleanId = identifier.trim().toLowerCase();
    final cleanPass = password.trim();

    final parents = await getParents();

    for (final p in parents) {
      if (!p.isActive) continue;

      final loginIdMatch = p.loginId.toLowerCase() == cleanId;
      final phoneDigits = p.phone.replaceAll(RegExp(r'\D'), '');
      final inputDigits = cleanId.replaceAll(RegExp(r'\D'), '');
      final phoneMatch = inputDigits.isNotEmpty &&
          (phoneDigits == inputDigits || phoneDigits.endsWith(inputDigits));
      final rollMatch = cleanId == p.rollNo.toLowerCase();

      if (loginIdMatch || phoneMatch || rollMatch) {
        if (p.password == cleanPass) {
          return p;
        }
      }
    }
    return null;
  }

  static Future<List<ParentAccountModel>> _getParentsFromLocal() async {
    try {
      final raw = await _storage.read(key: _localParentsKey);
      if (raw != null && raw.isNotEmpty) {
        final decoded = jsonDecode(raw) as List;
        return decoded
            .map((j) => ParentAccountModel.fromJson(j as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {}
    return [];
  }

  static Future<void> _saveParentsToLocal(List<ParentAccountModel> list) async {
    try {
      final encoded = jsonEncode(list.map((p) => p.toJson()).toList());
      await _storage.write(key: _localParentsKey, value: encoded);
    } catch (_) {}
  }
}
