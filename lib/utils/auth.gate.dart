// lib/utils/auth_gate.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dream_notes/pages/admin/dashboard_admin.dart';
import 'package:dream_notes/pages/user/dashboard_user.dart';
import 'package:dream_notes/pages/auth/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginPage();
        }
        // Jika sudah login, gunakan FutureBuilder untuk cek role
        return FutureBuilder<DocumentSnapshot>(
          future:
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(snapshot.data!.uid)
                  .get(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (userSnapshot.hasError || !userSnapshot.data!.exists) {
              // Jika ada error atau data tidak ada, logout saja
              FirebaseAuth.instance.signOut();
              return const LoginPage();
            }

            final userRole = userSnapshot.data!['role'];
            if (userRole == 'admin') {
              return const DashboardAdmin();
            } else {
              return const DashboardUser();
            }
          },
        );
      },
    );
  }
}
