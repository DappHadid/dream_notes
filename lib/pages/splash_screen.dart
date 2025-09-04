import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Di sini nanti bisa ditambahkan logika pengecekan login
    // atau delay sebelum pindah ke halaman login.
    // Untuk sekarang, kita langsung tampilkan halaman login setelah build selesai.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, 'login_screen');
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
