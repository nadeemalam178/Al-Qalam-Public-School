import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/school_provider.dart';
import 'screens/common/splash_screen.dart';
import 'services/supabase_service.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase with secure session storage (URL & Anon Key via --dart-define)
  await SupabaseService.initialize();

  runApp(const AlQalamSchoolApp());
}

class AlQalamSchoolApp extends StatelessWidget {
  const AlQalamSchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<SchoolProvider>(
          create: (_) => SchoolProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Al-Qalam Public School',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
