import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntc_sas/admin_teacher_selection_screen.dart';
import 'package:ntc_sas/common/widgets/screen_background.dart';
import 'package:ntc_sas/common/widgets/show_snack_bar_message.dart';
import 'package:ntc_sas/lab_teacher_selection/lab_teacher_selection_screen.dart';
import 'package:ntc_sas/auth/signup_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    setState(() { _isLoading = true; });
    final ok = await _authController.login(email: email, password: password);
    if (mounted) setState(() { _isLoading = false; });
    if (ok) Get.offAll(() => const LabTeacherSelectionScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        title: const Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        leading: IconButton(
          onPressed: () => Get.to(() => const AdminTeacherSelectorScreen()),
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
        ),
      ),
      body: ScreenBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF43A047), // Green
                      Color(0xFF8E24AA), // Purple
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome Back', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text('Sign in to continue', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _GradientInput(
                label: 'Email',
                icon: Icons.email_outlined,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _GradientInput(
                label: 'Password',
                icon: Icons.lock_outline,
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                    backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
                    elevation: const WidgetStatePropertyAll(0),
                  ),
                  onPressed: _isLoading ? null : _handleLogin,
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF43A047), Color(0xFF8E24AA)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: _isLoading
                          ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white))
                          : const Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () => Get.to(() => const SignupScreen()),
                    child: const Text('Sign Up', style: TextStyle(color: Color(0xFF8E24AA), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _GradientInput extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;

  const _GradientInput({
    required this.label,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  State<_GradientInput> createState() => _GradientInputState();
}

class _GradientInputState extends State<_GradientInput> {
  bool _obscure = false;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFE8F5E9), Color(0xFFF3E5F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, color: Colors.black54),
          labelText: widget.label,
          labelStyle: const TextStyle(color: Colors.black54),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: Colors.black54),
                  onPressed: () => setState(() { _obscure = !_obscure; }),
                )
              : null,
        ),
      ),
    );
  }
}


