import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntc_sas/admin_teacher_selection_screen.dart';
import 'package:ntc_sas/utils/assets_paths.dart';
import 'package:ntc_sas/utils/supabase_initializer.dart';

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
    await SupabaseInitializer().initialize();
    Get.off(() => AdminTeacherSelectorScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          SvgPicture.asset(AssetsPath.backgroundImageSvg, fit: BoxFit.cover, height: double.maxFinite, width: double.maxFinite,),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetsPath.ntcLogoPng,),
              ],
            ),
          ),
        ],
    );
  }
}