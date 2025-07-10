import 'package:get/get.dart';
import 'package:ntc_sas/lab_teacher_selection/widgets/auto_select_time_slot.dart';
import 'package:ntc_sas/lab_teacher_selection/widgets/day_selector.dart';
import 'package:ntc_sas/teacher_list/get_teacher_list.dart';

class LabTeacherSelectionController extends GetxController {
  final labNo = RxnString();
  final selectedTeacher = RxnString();
  final selectedTimeSlot = RxnString();
  final classDay = RxnString();
  final teachers = <String>[].obs;

  final GetTeacherList _getTeacherList = GetTeacherList();

  // Removed fetchTeachers() from here to avoid blocking UI
  @override
  void onInit() {
    super.onInit();
    classDay.value = DaySelector.selectClassDay();
    selectedTimeSlot.value = TimeSlotUtils.autoSelectTimeSlot(isTest: true);
  }

  Future<void> fetchTeachers() async {
    await _getTeacherList.getTeacherList();
    teachers.assignAll(
      _getTeacherList.teacherList.map((e) => e['teacher_name'] as String).toList(),
    );
  }

  void selectLab(String lab) => labNo.value = lab;
  void selectTeacher(String teacher) => selectedTeacher.value = teacher;

  bool get isValid =>
      labNo.value != null &&
          selectedTeacher.value != null &&
          selectedTimeSlot.value != null;

  void resetSelections() {
    labNo.value = null;
    selectedTeacher.value = null;
  }
}
