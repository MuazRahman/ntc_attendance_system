import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntc_sas/admin_teacher_selection_screen.dart';
import 'package:ntc_sas/auth/login_screen.dart';
import 'package:ntc_sas/lab_teacher_selection/lab_teacher_selection_screen.dart';
import 'package:ntc_sas/common/widgets/screen_background.dart';
import 'package:ntc_sas/utils/assets_paths.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  Future<void> moveToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    Get.off(() => AdminTeacherSelectorScreen());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
        child: Center(child: Image.asset(AssetsPath.ntcLogoPng)));
  }
}