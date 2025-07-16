import 'package:flutter/material.dart';

class AddCsvFileScreen extends StatefulWidget {
  const AddCsvFileScreen({super.key});

  @override
  State<AddCsvFileScreen> createState() => _AddCsvFileScreenState();
}

class _AddCsvFileScreenState extends State<AddCsvFileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Add CSV file screen'),
      ),
    );
  }
}
