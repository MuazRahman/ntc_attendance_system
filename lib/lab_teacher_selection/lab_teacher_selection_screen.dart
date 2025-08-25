import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntc_sas/attendance/attendance_screen.dart';
import 'package:ntc_sas/common/widgets/screen_background.dart';
import 'package:ntc_sas/common/widgets/show_snack_bar_message.dart';
import 'controller/lab_teacher_selection_controller.dart';

class LabTeacherSelectionScreen extends StatefulWidget {
  const LabTeacherSelectionScreen({super.key});

  @override
  State<LabTeacherSelectionScreen> createState() => _LabTeacherSelectionScreenState();
}

class _LabTeacherSelectionScreenState extends State<LabTeacherSelectionScreen> {
  final LabTeacherSelectionController labTeacherSelectionController = Get.find<LabTeacherSelectionController>();

  @override
  void initState() {
    super.initState();
    // Run after first frame to avoid UI blocking
    Future.delayed(Duration.zero, () {
      labTeacherSelectionController.fetchTeachers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final titleMedium = Theme.of(context).textTheme.titleMedium;
    final titleSmall = Theme.of(context).textTheme.titleSmall;

    return Scaffold(
      // backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined,),
        ),
        title: Text('NTC Attendance System', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),),
      ),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // const SizedBox(height: 164),
                const SizedBox(height: 72,),
                const Text(
                  'Select Attendance Info',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                    _buildLabCard(titleMedium, titleSmall),
                    const SizedBox(height: 24),
                    _buildTeacherCard(titleMedium, titleSmall),
                  ],
                ),
                const SizedBox(height: 64),
                SizedBox(
                  height: 44,
                  width: 256,
                  child: Obx(() => ElevatedButton(
                    onPressed: labTeacherSelectionController.isValid
                        ? () => _showStudentList(context)
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: labTeacherSelectionController.isValid
                          ? Colors.green
                          : Colors.blueGrey.shade200,
                    ),
                    child: const Text(
                      'Show Student List',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                ),
                const SizedBox(height: 28),
                const Text('Please select lab & class time carefully!'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabCard(TextStyle? titleMedium, TextStyle? titleSmall) {
    return Obx(() => SizedBox(
      height: 170,
      width: 256,
      child: GestureDetector(
        onTap: () => Get.dialog(
          AlertDialog(
            backgroundColor: Colors.green.shade50,
            title: Text('Select Lab No:', style: titleMedium?.copyWith(fontSize: 24, fontWeight: FontWeight.w600)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: ['Lab1', 'Lab2', 'Lab3'].map((lab) {
                  return TextButton(
                    onPressed: () {
                      labTeacherSelectionController.selectLab(lab);
                      Get.back();
                    },
                    child: Card(
                      color: Colors.green.shade200,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                        child: Text(lab, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20,),),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          transitionDuration: const Duration(milliseconds: 100),
          barrierDismissible: true,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFC2185B), // Dark Pink (Crimson-like)
                Color(0xFF4A148C), // Deep Purple
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Select Lab',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  labTeacherSelectionController.labNo.value ?? 'Lab is not selected',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildTeacherCard(TextStyle? titleMedium, TextStyle? titleSmall) {
    return Obx(() => SizedBox(
      height: 170,
      width: 256,
      child: GestureDetector(
        onTap: () => Get.dialog(
          AlertDialog(
            backgroundColor: Colors.green.shade50,
            title: Text('Select Teacher', style: titleMedium?.copyWith(fontSize: 24)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: labTeacherSelectionController.teachers.map((teacher) {
                  return TextButton(
                    onPressed: () {
                      labTeacherSelectionController.selectTeacher(teacher);
                      Get.back();
                    },
                    child: Card(
                        color: Colors.green.shade200,
                        child: SizedBox(
                          height: 48, width: 180,
                            child: Center(child: Text(teacher, style: titleSmall)))),
                  );
                }).toList(),
              ),
            ),
          ),
          transitionDuration: const Duration(milliseconds: 100),
          barrierDismissible: true,
        ),
        child: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF4A148C), // Deep Purple
                Color(0xFFC2185B), // Dark Pink (Crimson-like)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Select Teacher',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  labTeacherSelectionController.selectedTeacher.value ?? 'Teacher is not selected',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _showStudentList(BuildContext context) {
    if (!labTeacherSelectionController.isValid) {
      showSnackBarMessage(subtitle: 'Please complete all fields', isErrorMessage: true);
      return;
    }

    Get.to(() => AttendanceScreen(
      labNo: labTeacherSelectionController.labNo.value!,
      classTime: labTeacherSelectionController.selectedTimeSlot.value!,
      teachers: labTeacherSelectionController.teachers,
      selectedTeacher: labTeacherSelectionController.selectedTeacher.value!,
      classDay: labTeacherSelectionController.classDay.value!,
    ))?.then((_) => labTeacherSelectionController.resetSelections());
  }
}
