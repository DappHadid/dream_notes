import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dream_notes/firebase_options.dart';
import 'package:dream_notes/utils/app_theme.dart';
import 'package:dream_notes/utils/auth.gate.dart';
import 'package:dream_notes/pages/auth/login_page.dart';
import 'package:dream_notes/pages/auth/register_page.dart';
import 'package:dream_notes/pages/splash_screen.dart';
import 'package:dream_notes/pages/admin/dashboard_admin.dart';
import 'package:dream_notes/pages/user/dashboard_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Jalankan aplikasi dengan DevicePreview
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Hanya aktif saat mode debug
      builder: (context) => const MyApp(),
    ),
  );
}

// KODE YANG BENAR ✅
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Properti ini diperlukan untuk DevicePreview
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      theme: AppTheme.dreamyTheme,
      darkTheme: AppTheme.dreamyTheme,
      themeMode: ThemeMode.dark,
      // Menghilangkan banner debug
      debugShowCheckedModeBanner: false,

      home: const AuthGate(),

      routes: {
        'login_screen': (context) => const LoginPage(),
        'register_screen': (context) => const RegisterPage(),
        'dashboard_user': (context) => const DashboardUser(),
        'dashboard_admin': (context) => const DashboardAdmin(),
      },
    );
  }
}
