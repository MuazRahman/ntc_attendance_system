import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntc_sas/admin_panel/admin_login_screen.dart';
import 'package:ntc_sas/admin_panel/widgets/csv_picker.dart';
import 'package:ntc_sas/common/widgets/show_snack_bar_message.dart';
import 'package:ntc_sas/student_list/controller/student_list_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'controller/day_time_lab_selection_controller.dart';
import 'controller/upload_csv_file_controller.dart';

class AdminPanelScreen extends StatefulWidget {
   const AdminPanelScreen({super.key});

  static const ButtonStyle _buttonStyle = ButtonStyle(
    textStyle: WidgetStatePropertyAll(
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {

  final DayTimeLabSelectionController showStudentListInAdminController = Get.find<DayTimeLabSelectionController>(tag: 'showStudentsInAdmin');
  final DayTimeLabSelectionController moveStudentRoutineController = Get.find<DayTimeLabSelectionController>(tag: 'moveStudentInAdmin');
  final StudentListController studentListController = Get.find<StudentListController>();
  final CsvFilePickerAndUploadController csvUploadController = Get.find<CsvFilePickerAndUploadController>();
  List<Map<String, dynamic>> selectedStudents = [];

  @override
  void initState() {
    super.initState();
    showStudentListInAdminController.selectedLabNo.value = null;
    showStudentListInAdminController.selectedClassTime.value = null;
    showStudentListInAdminController.selectedClassDay.value = null;
    studentListController.studentList.clear();
    moveStudentRoutineController.selectedLabNo.value = null;
    moveStudentRoutineController.selectedClassTime.value = null;
    moveStudentRoutineController.selectedClassDay.value = null;
    selectedStudents.clear();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Example threshold: make card wider if screen is > 1200 px
    final cardWidth = screenWidth > 1200
        ? screenWidth * 0.9
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Admin Dashboard',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: Colors.grey.shade300,
        leading: IconButton(
          onPressed: () {
            Get.offAll(AdminLoginScreen());
          },
          color: Colors.red,
          icon: Icon(Icons.arrow_back_ios_new_outlined,),
          tooltip: 'Log out',
        ),
      ),
      // full screen padding
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Day, lab, time selection
            Center(
              child: Card(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      // cardWidth will be double.maxFinite but for full screen padding it shrink some space.
                      width: cardWidth,
                      // card content padding.
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              children: [
                                // day, time, lab dropdown
                                Wrap(
                                  spacing: 32,
                                  runSpacing: 32,
                                  alignment: WrapAlignment.spaceAround,
                                  children: [
                                    // ✅ Class Day
                                    buildClassDaySelector(showStudentListInAdminController),

                                    // ✅ Lab Number
                                    buildLabNoSelector(showStudentListInAdminController),

                                    // ✅ Class Time
                                    buildClassTimeSelector(showStudentListInAdminController),
                                  ],
                                ),
                                const SizedBox(height: 8,),

                                // add student, show data, add CSV buttons
                                Wrap(
                                  spacing: 32,
                                  runSpacing: 32,
                                  alignment: WrapAlignment.spaceAround,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    // Add single student button
                                    ElevatedButton(
                                      onPressed: () {
                                        // TODO: Add Single student button functionality
                                        final TextEditingController studentRollController = TextEditingController();
                                        final TextEditingController studentNameController = TextEditingController();
                                        final String? selectedLabNo = showStudentListInAdminController.selectedLabNo.value;
                                        final String? selectedClassTime = showStudentListInAdminController.selectedClassTime.value;
                                        final String? selectedClassDay = showStudentListInAdminController.selectedClassDay.value;
                                        if(selectedLabNo == null || selectedLabNo.isEmpty ||
                                        selectedClassTime == null || selectedClassTime.isEmpty ||
                                        selectedClassDay == null || selectedClassDay.isEmpty) {
                                          showSnackBarMessage(subtitle: 'Select Lab No, Class Time & Day first.', isErrorMessage: true);
                                        }
                                        else {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text('Add a student'),
                                              actions: [
                                                TextField(
                                                  controller: studentRollController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Student Roll(e.g. 3600)',
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 16,),
                                                TextField(
                                                  controller: studentNameController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Student Name(e.g. Shaon)',
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  spacing: 16,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder
                                                          (borderRadius: BorderRadius.circular(12,),),
                                                        backgroundColor: Colors.red.shade500,

                                                      ),
                                                      child: Text('Cancel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, ),),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () async{
                                                        final studentData = {
                                                          'student_roll' : studentRollController.text,
                                                          'student_name' : studentNameController.text,
                                                          'class_room' : showStudentListInAdminController.selectedLabNo.toString(),
                                                          'class_time' : showStudentListInAdminController.selectedClassTime.toString(),
                                                          'class_day' : showStudentListInAdminController.selectedClassDay.toString(),
                                                        };
                                                        if(studentRollController.text.isNotEmpty && studentNameController.text.isNotEmpty) {
                                                          await Supabase.instance.client.from('student').insert(studentData);
                                                          Get.back();
                                                          studentRollController.clear();
                                                          studentNameController.clear();
                                                          showSnackBarMessage(subtitle: 'Student added successfully!', isErrorMessage: false);

                                                          await studentListController.getStudentList(
                                                            labNo: showStudentListInAdminController.selectedLabNo.toString(),
                                                            classTime: showStudentListInAdminController.selectedClassTime.toString(),
                                                            classDay: showStudentListInAdminController.selectedClassDay.toString(),
                                                          );
                                                          setState(() {});

                                                        }
                                                        else {
                                                          showSnackBarMessage(subtitle: 'Enter Student Roll and Name.', isErrorMessage: true);
                                                        }
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder
                                                          (borderRadius: BorderRadius.circular(12,),),
                                                        backgroundColor: Colors.green.shade500,
                                                      ),
                                                      child: Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, ),),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }

                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder
                                          (borderRadius: BorderRadius.circular(8,),),
                                        fixedSize: Size(200, 36),
                                        backgroundColor: Colors.green.shade500,
                                      ),
                                      child: Text(
                                        'Add a student', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16, fontWeight: FontWeight.w600,),),
                                    ),
                                    // Show Data button
                                    ElevatedButton(
                                      onPressed: () async{
                                        // TODO: Show student list functionality
                                        selectedStudents.clear();
                                        await studentListController.getStudentList(
                                            labNo: showStudentListInAdminController.selectedLabNo.toString(),
                                            classTime: showStudentListInAdminController.selectedClassTime.toString(),
                                            classDay: showStudentListInAdminController.selectedClassDay.toString());
                                         setState(() {});
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder
                                          (borderRadius: BorderRadius.circular(8,),),
                                        fixedSize: Size(200, 36),
                                        backgroundColor: Colors.blueGrey.shade200,
                                      ),
                                      child: Text(
                                        'Show Data', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16, fontWeight: FontWeight.w600,),),
                                    ),
                                    // Add student csv button
                                    ElevatedButton(
                                      onPressed: () async{
                                        // TODO: Add student csv button functionality
                                        final PickCSVFile csvFilePicker = PickCSVFile();

                                        showDialog(context: context, builder: (context) => AlertDialog(
                                          title: Text('Add CSV file'),
                                          // pick csv file
                                          content: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              backgroundColor: Colors.blue,
                                            ),
                                              onPressed: () {
                                                csvUploadController.pickCsvFile(csvFilePicker);
                                              },
                                              child: Text('Select CSV file', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),),),
                                          actions: [
                                            // cancel csv upload
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder
                                                  (borderRadius: BorderRadius.circular(12,),),
                                                backgroundColor: Colors.red.shade500,
                                              ),
                                              child: Text('Cancel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, ),),
                                            ),
                                            // upload csv file in database
                                            ElevatedButton(
                                              onPressed: () {
                                                csvUploadController.uploadCsvData(csvFilePicker);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                backgroundColor: Colors.green.shade500,
                                              ),
                                              child: Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, ),),
                                            ),

                                          ],
                                        ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder
                                          (borderRadius: BorderRadius.circular(8,),),
                                        fixedSize: Size(200, 36),
                                        backgroundColor: Colors.blue,
                                      ),
                                      child: Text(
                                        'Add CSV file', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16, fontWeight: FontWeight.w600,),),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                            const SizedBox(width: 16,),
                            TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                minimumSize: WidgetStatePropertyAll(Size(150, 48)),
                                  backgroundColor: WidgetStatePropertyAll(Colors.amber.shade500),
                                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                  fixedSize: WidgetStatePropertyAll(Size(72, 8))
                              ),
                              child: Text('Search student', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Show student list
            buildShowStudentList(cardWidth),
          ],
        ),
      ),

      // change student class day, lab, time or delete student from student list.
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Card(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: cardWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                  child: Wrap(
                    spacing: 32,
                    runSpacing: 32,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text('Move to:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                      buildClassDaySelector(moveStudentRoutineController),
                      buildLabNoSelector(moveStudentRoutineController),
                      buildClassTimeSelector(moveStudentRoutineController),
                      Column(
                        spacing: 8,
                        children: [
                          // move student
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(Colors.green),
                                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                fixedSize: WidgetStatePropertyAll(Size(72, 8))
                            ),
                            onPressed: () async{
                              final updatedData = {
                                'class_day' : moveStudentRoutineController.selectedClassDay.toString(),
                                'class_room' : moveStudentRoutineController.selectedLabNo.toString(),
                                'class_time' : moveStudentRoutineController.selectedClassTime.toString(),
                              };

                              for(int i = 0; i<selectedStudents.length; i++) {
                                await Supabase.instance.client.from('student').update(updatedData).eq('student_roll', selectedStudents[i]['student_roll']);
                              }

                              selectedStudents.clear();

                              await studentListController.getStudentList(
                                labNo: showStudentListInAdminController.selectedLabNo.toString(),
                                classTime: showStudentListInAdminController.selectedClassTime.toString(),
                                classDay: showStudentListInAdminController.selectedClassDay.toString(),
                              );
                              setState(() {});
                            },
                            child: Text('Move', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),),
                          ),
                          // delete student
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(Colors.red),
                                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                fixedSize: WidgetStatePropertyAll(Size(72, 8))
                            ),
                            onPressed: () async {
                              for(int i = 0; i<selectedStudents.length; i++) {
                                await Supabase.instance.client.from('student').delete().eq('student_roll', selectedStudents[i]['student_roll']);
                              }

                              selectedStudents.clear();

                              await studentListController.getStudentList(
                                labNo: showStudentListInAdminController.selectedLabNo.toString(),
                                classTime: showStudentListInAdminController.selectedClassTime.toString(),
                                classDay: showStudentListInAdminController.selectedClassDay.toString(),
                              );
                              setState(() {});
                            },
                            child: Text('Delete', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }


  Widget buildShowStudentList(double? cardWidth) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Card(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: cardWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: Column(
                    children: [
                      // student list header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade300,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              child: Text('Enrolled Student',
                                style: TextStyle(fontSize: 16,
                                  fontWeight: FontWeight.w600,),
                              ),
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade300,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              child: Text('${studentListController.studentList.length} Students',
                                style: TextStyle(fontSize: 16,
                                  fontWeight: FontWeight.w600,),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // list of student
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: studentListController.studentList.length,
                          itemBuilder: (context, index) {
                           final isSelected = studentListController.isPresentList[index];
                            return ListTile(
                              leading: Text('${index+1}. ', style: TextStyle(fontSize: 16),),
                              title: Text('${studentListController.studentList[index]['student_roll']} - ${studentListController.studentList[index]['student_name']}'),
                              trailing: IconButton(
                                  onPressed: () {
                                    studentListController.isPresentList[index] = !isSelected;
                                    selectedStudents.removeWhere(
                                            (e) =>
                                            e['student_roll'] == studentListController.studentList[index]['student_roll']);
                                    if(studentListController.isPresentList[index]) {
                                      selectedStudents.add({
                                        'student_roll' : studentListController.studentList[index]['student_roll']
                                      });
                                    }

                                    print(selectedStudents);
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                                    color: isSelected ? Colors.green : null,
                                  ),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  SizedBox buildClassTimeSelector(DayTimeLabSelectionController controller) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => DropdownMenu<String>(
              width: double.infinity,
              menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300),
                fixedSize: WidgetStatePropertyAll(Size(200, double.nan)),
              ),
              label: const Text('Select Time'),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(width: 2),
                ),
              ),
              initialSelection: controller.selectedClassTime.value,
              onSelected: (value) => controller.selectedClassTime.value = value,
              dropdownMenuEntries: controller.classTimes
                  .map(
                    (time) => DropdownMenuEntry(
                      value: time,
                      label: time,
                      style: AdminPanelScreen._buttonStyle,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildLabNoSelector(DayTimeLabSelectionController controller) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => DropdownMenu<String>(
              width: double.infinity,
              menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300),
                fixedSize: WidgetStatePropertyAll(Size(200, double.nan)),
              ),
              label: const Text('Select Lab'),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(width: 2),
                ),
              ),
              initialSelection: controller.selectedLabNo.value,
              onSelected: (value) => controller.selectedLabNo.value = value,
              dropdownMenuEntries: const [
                DropdownMenuEntry(
                  value: 'Lab1',
                  label: 'Lab1',
                  style: AdminPanelScreen._buttonStyle,
                ),
                DropdownMenuEntry(
                  value: 'Lab2',
                  label: 'Lab2',
                  style: AdminPanelScreen._buttonStyle,
                ),
                DropdownMenuEntry(
                  value: 'Lab3',
                  label: 'Lab3',
                  style: AdminPanelScreen._buttonStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildClassDaySelector(DayTimeLabSelectionController controller) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => DropdownMenu<String>(
              width: double.infinity,
              menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300),
                fixedSize: WidgetStatePropertyAll(Size(200, double.nan)),
              ),
              label: const Text('Select Day'),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(width: 2),
                ),
              ),
              initialSelection: controller.selectedClassDay.value,
              onSelected: (value) => controller.selectedClassDay.value = value,
              dropdownMenuEntries: const [
                DropdownMenuEntry(
                  value: 'Saturday',
                  style: AdminPanelScreen._buttonStyle,
                  label: 'Saturday',
                ),
                DropdownMenuEntry(
                  value: 'Sunday',
                  style: AdminPanelScreen._buttonStyle,
                  label: 'Sunday',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}