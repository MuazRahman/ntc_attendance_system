import 'package:get/get.dart';
import 'package:ntc_sas/lab_teacher_selection/controller/lab_teacher_selection_controller.dart';
import 'package:ntc_sas/student_list/controller/student_list_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(GetMaterialController());
    Get.put(StudentListController(), permanent: true);
    Get.lazyPut(() => LabTeacherSelectionController());


  }
}