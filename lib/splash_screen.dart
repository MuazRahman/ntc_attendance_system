

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntc_sas/lab_teacher_selection/lab_teacher_selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

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
    await Future.delayed(const Duration(seconds: 2));
    Get.off(LabTeacherSelectionScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          SvgPicture.asset('assets/background.svg', fit: BoxFit.cover, height: double.maxFinite, width: double.maxFinite,),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/img.png',),
              ],
            ),
          ),
        ],
    );
  }
}