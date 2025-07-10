import 'package:ntc_sas/student_list/controller/student_list_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceListController {
  bool isSuccess = false;
  bool isAlreadySubmitted = false;

  Future<void> submitAttendanceList(
      List<Map<String, dynamic>> attendanceList,
      StudentListController studentListController,
      ) async {
    if (attendanceList.isEmpty) {
      isSuccess = false;
      return;
    }

    if (isAlreadySubmitted) {
      isSuccess = false; // Already submitted, do nothing
      return;
    }

    await Supabase.instance.client.from('attendance').insert(attendanceList);
    isSuccess = true;
    isAlreadySubmitted = true;

    // Reset student checkboxes
    studentListController.isPresentList =
        List.filled(studentListController.studentList.length, false);

    // Clear attendance list
    attendanceList.clear();

    // Update UI
    studentListController.update();
  }
}
