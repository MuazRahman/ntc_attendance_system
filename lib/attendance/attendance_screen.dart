import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntc_sas/attendance/controller/attendance_list_controller.dart';
import 'package:ntc_sas/common/widgets/show_snack_bar_message.dart';
import 'package:ntc_sas/lab_teacher_selection/widgets/day_selector.dart';
import 'package:ntc_sas/student_list/controller/student_list_controller.dart';

class AttendanceScreen extends StatefulWidget {
  final String labNo;
  final String classTime;
  final List<String> teachers;
  final String selectedTeacher;
  final String classDay;

  const AttendanceScreen({
    super.key,
    required this.labNo,
    required this.classTime,
    required this.teachers,
    required this.selectedTeacher,
    required this.classDay,
  });

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final StudentListController _studentListController = Get.find<StudentListController>();
  final List<Map<String, dynamic>> attendanceList = [];
  final AttendanceListController _attendanceListController = Get.find<AttendanceListController>();

  @override
  void initState() {
    super.initState();
    _studentListController.getStudentList(
      labNo: widget.labNo,
      classTime: widget.classTime,
      classDay: widget.classDay,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _studentListController.dispose();
    attendanceList.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: buildAppBar(),
      body: GetBuilder<StudentListController>(
        builder: (controller) {
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.studentList.isEmpty) {
            return const Center(child: Text('No students found.'));
          }

          return RefreshIndicator(
            onRefresh: () => controller.getStudentList(
              labNo: widget.labNo,
              classTime: widget.classTime,
              classDay: widget.classDay,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // teacherName, LabNo, ClassTime shows here
                  _buildHeader(),
                  const SizedBox(height: 8),
                  // No, Roll & Name, Attendance
                  _buildTableHeader(),
                  const Divider(thickness: 0.5, color: Colors.black),
                  // Student List
                  buildStudentList(controller),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const Center(
        child: Text(
          'NTC Attendance System',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildStudentList(StudentListController controller) {
    return Expanded(
                  child: ListView.builder(
                    itemCount: controller.studentList.length,
                    itemBuilder: (context, index) {
                      final student = controller.studentList[index];
                      final isPresent = controller.isPresentList[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          leading: SizedBox(
                            width: 24,
                            child: Text(
                              '${index + 1}.',
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                          title: Text('${student['student_roll']} - ${student['student_name']}'),
                          trailing: SizedBox(
                            width: 88,
                            child: IconButton(
                              icon: Icon(
                                isPresent ? Icons.check_box : Icons.check_box_outline_blank,
                                color: isPresent ? Colors.green : Colors.red,
                              ),
                              onPressed: () {
                                controller.isPresentList[index] = !isPresent;

                                final studentRoll = student['student_roll'];
                                final teacherID = widget.teachers.indexOf(widget.selectedTeacher) + 1;

                                attendanceList.removeWhere(
                                      (e) =>
                                  e['teacher_id'] == teacherID &&
                                      e['student_roll'] == studentRoll &&
                                      e['class_time'] == widget.classTime &&
                                      e['class_room'] == widget.labNo,
                                );

                                if (controller.isPresentList[index]) {
                                  attendanceList.add({
                                    'teacher_id': teacherID,
                                    'student_roll': studentRoll,
                                    'attendance_date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                    'is_present': true,
                                    'class_time': widget.classTime,
                                    'class_room': widget.labNo,
                                    'class_day': widget.classDay,
                                  });
                                }

                                controller.update();
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
  }

  Widget _buildHeader() {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateFormat('MMM d, yyyy').format(DateTime.now())),
              Text(widget.classTime, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(DaySelector.selectWeekDay(), style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.labNo, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(widget.selectedTeacher, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Row(
        children: const [
          SizedBox(
            width: 40,
            child: Text('No.', style: TextStyle(fontWeight: FontWeight.bold)),
          ),

          SizedBox(
            width: 194,
            child: Text('Roll & Name', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: 96,
            child: Text(
              'Attendance',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                _studentListController.isPresentList = List.filled(_studentListController.studentList.length, false);
                attendanceList.clear();
                _studentListController.update();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Cancel', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () async {
                if (attendanceList.isEmpty) {
                  showSnackBarMessage(
                    subtitle: 'No attendance data is selected!',
                    isErrorMessage: true,
                  );
                  return;
                }

                if (_attendanceListController.isAlreadySubmitted) {
                  showSnackBarMessage(
                    subtitle: 'Already submitted!',
                    isErrorMessage: true,
                  );
                  return;
                }

                // 👉 Store the count BEFORE submit
                final submittedCount = attendanceList.length;

                await _attendanceListController.submitAttendanceList(
                  attendanceList,
                  _studentListController,
                );

                if (_attendanceListController.isSuccess) {
                  showSnackBarMessage(
                    title: '$submittedCount',
                    subtitle: ' Attendance submitted successfully!',
                    isErrorMessage: false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

}
