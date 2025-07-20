import 'package:get/get.dart';
import 'package:ntc_sas/student_list/student_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentListController extends GetxController {
  List<Map<String, dynamic>> studentList = [];
  List<bool> isPresentList = [];
  bool inProgress = false;

  Future<void> getStudentList({
    required String labNo,
    required String classTime,
    required String classDay,
  }) async {
    studentList.clear();
    inProgress = true;
    update();

    final response = await Supabase.instance.client
        .from('student')
        .select()
        .eq('class_room', labNo)
        .eq('class_time', classTime)
        .eq('class_day', classDay)
        .order('student_roll', ascending: true);
    print(response);

    for (var i in response as List) {
      final data = Student.fromJson(i);

      studentList.add({
        'student_roll': data.studentRoll?.toString().trim(),
        'student_name': data.studentName?.trim(),
        'class_time': data.classtime?.trim(),
        'class_room': data.classroom?.trim(),
      });
    }

    isPresentList = List.filled(studentList.length, false);

    inProgress = false;
    update();
  }

  void resetAttendance() {
    isPresentList = List.filled(studentList.length, false);
    update();
  }
}
