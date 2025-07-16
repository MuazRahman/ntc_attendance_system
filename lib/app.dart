import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_panel/admin_panel_screen.dart';
import 'package:ntc_sas/utils/controller_binder.dart';

class NtcSas extends StatelessWidget {
  const NtcSas({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinder(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade300,
        textTheme: TextTheme(
          titleMedium: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          titleSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      // home: const SplashScreen(),
      home: const AdminPanelScreen(),
    );
  }
}
