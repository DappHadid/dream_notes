import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Ganti 'dream_notes' dengan nama project Anda
import 'package:dream_notes/utils/app_theme.dart';
import 'package:dream_notes/utils/dreamy_background.dart';
import 'package:dream_notes/pages/admin/dashboard_admin.dart';
import 'package:dream_notes/pages/user/dashboard_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _navigateBasedOnRole(String uid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (!mounted) return;

      if (userDoc.exists) {
        final role = userDoc['role'];
        if (role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardAdmin()),
          );
        } else if (role == 'user') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardUser()),
          );
        } else {
          throw 'Unknown role';
        }
      } else {
        throw 'User document not found';
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.warning,
          title: "Error",
          text: e.toString(),
        ),
      );
    }
  }

  void _loginUser() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.warning,
          title: "Login Failed",
          text: "Email and password must not be empty.",
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        await _navigateBasedOnRole(userCredential.user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.warning,
          title: "Login Failed",
          text: e.message ?? "An unknown error occurred.",
        ),
      );
    } catch (e) {
      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.warning,
          title: "Login Failed",
          text: e.toString(),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DreamyBackground(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.secondaryColor.withOpacity(0.5),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Log In',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 40.0),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Enter your Email',
                      prefixIcon: Icon(
                        FontAwesomeIcons.user,
                        color: AppTheme.secondaryColor,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter your Password',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.lock,
                        color: AppTheme.secondaryColor,
                        size: 18,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: AppTheme.secondaryColor,
                          size: 18,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  if (_isLoading)
                    Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: Colors.white,
                        size: 50,
                      ),
                    )
                  else
                    ElevatedButton(
                      onPressed: _loginUser,
                      child: const Text('LOGIN'),
                    ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'register_screen');
                    },
                    child: Text(
                      'Don’t have an account? Register here',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
