import 'package:flutter/material.dart';

class AddSingleStudentScreen extends StatefulWidget {
  const AddSingleStudentScreen({super.key});

  @override
  State<AddSingleStudentScreen> createState() => _AddSingleStudentScreenState();
}

class _AddSingleStudentScreenState extends State<AddSingleStudentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Add single student form'),
      ),
    );
  }
}
