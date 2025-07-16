import 'dart:ui'; // ✅ Needed for ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntc_sas/lab_teacher_selection/lab_teacher_selection_screen.dart';
import 'admin_panel/admin_login_screen.dart';

class AdminTeacherSelectorScreen extends StatelessWidget {
  const AdminTeacherSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Glassmorphic card with BackdropFilter
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 50),
                      _ModernLoginButton(
                        text: 'Admin Login',
                        icon: Icons.admin_panel_settings_outlined,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF4A00E0).withOpacity(0.5),
                            const Color(0xFF8E2DE2).withOpacity(0.5)
                          ],
                        ),
                        onTap: () {
                          Get.to(() => const AdminLoginScreen());
                        },
                      ),
                      const SizedBox(height: 20),
                      _ModernLoginButton(
                        text: 'Take Attendance',
                        icon: Icons.person_outline,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF11998E).withOpacity(0.5),
                            const Color(0xFF38EF7D).withOpacity(0.5)
                          ],
                        ),
                        onTap: () {
                          Get.to(() => const LabTeacherSelectionScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModernLoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;

  const _ModernLoginButton({
    required this.text,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Colors.black.withOpacity(0.8), // ✅ Visible border
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
