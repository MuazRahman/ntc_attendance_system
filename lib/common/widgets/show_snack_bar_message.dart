import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBarMessage({String? title, required String subtitle, required bool isErrorMessage}) {
  Get.showSnackbar(
    GetSnackBar(
      // message: 'No attendance data is selected!',
      backgroundColor: isErrorMessage ? Colors.red: Colors.green,
      duration: Duration(milliseconds: 1800),
      animationDuration: Duration(milliseconds: 500),
      messageText: Center(
        child: RichText(
          text: TextSpan(
            text: title,
            style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18),
            children: [
              TextSpan(
                text: subtitle,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
