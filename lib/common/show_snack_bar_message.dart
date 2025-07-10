import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, {String? title, required String subtitle, required bool isErrorMessage}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: isErrorMessage ? Colors.red : Colors.green,
      duration: Duration(seconds: 2),
      content: Center(
        child: RichText(
            text: TextSpan(
              text: title,
                style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18),
                children: [
                  TextSpan(
                      text: subtitle,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                  ),
        ],
            ),
        ),
      ),
    ),
  );
}
