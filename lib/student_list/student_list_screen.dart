
// TODO: This dart file has not used yet. In future it will use in admin palen to see the student list


import 'package:flutter/material.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}



class _StudentListScreenState extends State<StudentListScreen> {
  final List<bool> _isPresentList = [false, false,false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NTC Attendance System')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 24,),
                Text('No.'),
                SizedBox(width: 14,),
                Text('Roll'),
                SizedBox(width: 44,),
                Text('Name'),
                SizedBox(width: 108,),
                Text('Attendance'),
              ],
            ),
            const Divider(color: Colors.black, thickness: 0.4, height: 10,),
            const SizedBox(height: 8,),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    child: SizedBox(
                      height: 48,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const SizedBox(width: 12,),
                            Text('${index+1}.'),
                            const SizedBox(width: 16,),
                            Text('3700'),
                            const SizedBox(width: 36,),
                            Text('Md. Shaon'),
                            const SizedBox(width: 96,),
                            IconButton(
                                onPressed: () {
                                  _isPresentList[index] = !_isPresentList[index];
                                  setState(() {});
                                  print(_isPresentList[index]);
                                },
                                icon: _isPresentList[index] ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank)
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
