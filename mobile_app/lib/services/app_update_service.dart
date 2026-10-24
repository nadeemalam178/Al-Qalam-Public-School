import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class AppUpdateInfo {
  final String version;
  final String releaseName;
  final String notes;
  final String downloadUrl;
  final bool hasUpdate;

  const AppUpdateInfo({
    required this.version,
    required this.releaseName,
    required this.notes,
    required this.downloadUrl,
    required this.hasUpdate,
  });
}

class AppUpdateService {
  static const String currentVersion = '1.2.2';
  static const int currentBuildNumber = 5;

  static const String _githubLatestReleaseApi =
      'https://api.github.com/repos/nadeemalam178/Al-Qalam-Public-School/releases/latest';

  static const String directApkFallbackUrl =
      'https://github.com/nadeemalam178/Al-Qalam-Public-School/releases/latest/download/Al-Qalam-Public-School-Release.apk';

  /// Checks GitHub releases API for newer APK builds using Dart's native HttpClient.
  static Future<AppUpdateInfo?> checkLatestRelease() async {
    HttpClient? client;
    try {
      client = HttpClient();
      final request = await client.getUrl(Uri.parse(_githubLatestReleaseApi));
      request.headers.set('Accept', 'application/vnd.github.v3+json');
      request.headers.set('User-Agent', 'Al-Qalam-School-App');

      final response = await request.close().timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final bodyString = await response.transform(utf8.decoder).join();
        final data = jsonDecode(bodyString) as Map<String, dynamic>;

        final tagName = (data['tag_name'] as String? ?? 'v1.1.0').replaceAll('v', '').trim();
        final releaseName = data['name'] as String? ?? 'Al-Qalam App Update';
        final notes = data['body'] as String? ?? 'Performance improvements and bug fixes.';

        String apkUrl = directApkFallbackUrl;
        final assets = data['assets'] as List<dynamic>?;
        if (assets != null && assets.isNotEmpty) {
          final apkAsset = assets.firstWhere(
            (a) => (a['name'] as String? ?? '').endsWith('.apk'),
            orElse: () => assets.first,
          );
          if (apkAsset != null && apkAsset['browser_download_url'] != null) {
            apkUrl = apkAsset['browser_download_url'] as String;
          }
        }

        final isNewer = _isVersionNewer(tagName, currentVersion);

        return AppUpdateInfo(
          version: tagName,
          releaseName: releaseName,
          notes: notes,
          downloadUrl: apkUrl,
          hasUpdate: isNewer,
        );
      }
    } catch (e) {
      debugPrint('[AppUpdateService] Check update error: $e');
    } finally {
      client?.close();
    }
    return null;
  }

  static bool _isVersionNewer(String latest, String current) {
    try {
      final lParts = latest.split('.').map((p) => int.tryParse(p) ?? 0).toList();
      final cParts = current.split('.').map((p) => int.tryParse(p) ?? 0).toList();

      for (int i = 0; i < 3; i++) {
        final l = i < lParts.length ? lParts[i] : 0;
        final c = i < cParts.length ? cParts[i] : 0;
        if (l > c) return true;
        if (l < c) return false;
      }
    } catch (_) {}
    return false;
  }

  /// Triggers direct OTA APK download & install via Android Package Manager.
  static Future<void> downloadAndInstallApk(String apkUrl) async {
    final uri = Uri.parse(apkUrl.isNotEmpty ? apkUrl : directApkFallbackUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// Displays an in-app OTA Update BottomSheet modal.
  static void showUpdateDialog(BuildContext context, AppUpdateInfo info) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppTheme.forestTint,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppTheme.forestPrimary.withValues(alpha: 0.2)),
                    ),
                    child: const Icon(Icons.system_update_rounded,
                        color: AppTheme.forestPrimary, size: 26),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'App Update Available',
                              style: GoogleFonts.outfit(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.forestDeep,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.goldPrimary,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'v${info.version}',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.forestDeep,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Current: v$currentVersion • Fast Over-The-Air Update',
                          style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What\'s New in this Build:',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      info.notes,
                      style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textMuted, height: 1.4),
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text('Later', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        Navigator.pop(ctx);
                        await downloadAndInstallApk(info.downloadUrl);
                      },
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: Text(
                        '1-Tap Update',
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.forestPrimary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// Manually checks for updates from the side panel drawer.
  static Future<void> checkFromDrawer(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Checking for updates...'),
        duration: Duration(seconds: 1),
      ),
    );

    final info = await checkLatestRelease();

    if (!context.mounted) return;

    if (info != null && info.hasUpdate) {
      showUpdateDialog(context, info);
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(Icons.check_circle_outline, color: AppTheme.forestPrimary),
              const SizedBox(width: 8),
              Text('Up to Date', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(
            'You are running the latest version of Al-Qalam Mobile Suite (v$currentVersion).',
            style: GoogleFonts.inter(fontSize: 13),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
