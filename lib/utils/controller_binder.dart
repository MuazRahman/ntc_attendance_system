import 'package:get/get.dart';
import 'package:ntc_sas/admin_panel/controller/admin_panel_controller.dart';
import 'package:ntc_sas/attendance/controller/attendance_list_controller.dart';
import 'package:ntc_sas/lab_teacher_selection/controller/lab_teacher_selection_controller.dart';
import 'package:ntc_sas/student_list/controller/student_list_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(GetMaterialController());
    Get.put(StudentListController(), permanent: true);
    Get.put(LabTeacherSelectionController(), permanent: true);
    Get.put(AttendanceListController());
    Get.put(AdminPanelController());


  }
}