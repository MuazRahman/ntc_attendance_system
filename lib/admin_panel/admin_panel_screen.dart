import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntc_sas/admin_panel/add_csv_file_screen.dart';
import 'package:ntc_sas/admin_panel/add_single_student_screen.dart';
import 'package:ntc_sas/student_list/controller/student_list_controller.dart';
import 'controller/admin_panel_controller.dart';

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

  final AdminPanelController adminPanelController = Get.find<AdminPanelController>();
  final StudentListController studentListController = Get.find<StudentListController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Example threshold: make card wider if screen is > 1200 px
    final cardWidth = screenWidth > 1200
        ? screenWidth * 0.9
        : null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          color: Colors.red,
          icon: Icon(Icons.arrow_back_ios_new_outlined,),
        ),
      ),
      // full screen padding
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 32),
            const Center(
              child: Text(
                'Admin Dashboard',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 4),
            // Day, lab, time selection
            Center(
              child: Card(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      // cardWidth will be double.maxfinite but for full screen padding it shrink some space.
                      width: cardWidth,
                      // card content padding.
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Wrap(
                              spacing: 32,
                              runSpacing: 32,
                              alignment: WrapAlignment.spaceAround,
                              children: [
                                // ✅ Class Day
                                buildClassDaySelector(adminPanelController),

                                // ✅ Lab Number
                                buildLabNoSelector(adminPanelController),

                                // ✅ Class Time
                                buildClassTimeSelector(adminPanelController),
                              ],
                            ),
                            const SizedBox(height: 24,),

                            Wrap(
                              spacing: 32,
                              runSpacing: 32,
                              alignment: WrapAlignment.spaceAround,
                              children: [
                                // Add single student button
                                ElevatedButton(
                                  onPressed: () {
                                    // TODO: Add Single student button functionality
                                    Get.to(const AddSingleStudentScreen());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder
                                      (borderRadius: BorderRadius.circular(12,),),
                                    fixedSize: Size(256, 40),
                                    backgroundColor: Colors.green.shade500,
                                  ),
                                  child: Text(
                                    'Add a student', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18, fontWeight: FontWeight.w600,),),
                                ),
                                // Show Data button
                                ElevatedButton(
                                  onPressed: () async{
                                    // TODO: Show student list functionality
                                    //  await studentListController.getStudentList(
                                    //     labNo: adminPanelController.selectedLabNo.toString(),
                                    //     classTime: adminPanelController.selectedClassTime.toString(),
                                    //     classDay: adminPanelController.selectedClassDay.toString(),
                                    // );
                                    await studentListController.getStudentList(
                                        labNo: adminPanelController.selectedLabNo.toString(),
                                        classTime: adminPanelController.selectedClassTime.toString(),
                                        classDay: adminPanelController.selectedClassDay.toString());
                                     setState(() {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder
                                      (borderRadius: BorderRadius.circular(12,),),
                                    fixedSize: Size(256, 40),
                                    backgroundColor: Colors.blueGrey.shade200,
                                  ),
                                  child: Text(
                                    'Show Data', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18, fontWeight: FontWeight.w600,),),
                                ),
                                // Add student csv button
                                ElevatedButton(
                                  onPressed: () {
                                    // TODO: Add student csv button functionality
                                    Get.to(const AddCsvFileScreen());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder
                                      (borderRadius: BorderRadius.circular(12,),),
                                    fixedSize: Size(256, 40),
                                    backgroundColor: Colors.red.shade500,
                                  ),
                                  child: Text(
                                    'Add CSV file', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18, fontWeight: FontWeight.w600,),),
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

            // Show student list
            buildShowStudentList(cardWidth),
          ],
        ),
      ),
    );
  }

  Widget buildShowStudentList(double? cardWidth) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Card(
          child: SizedBox(
            width: cardWidth,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: cardWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(32),
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
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text('Enrolled Student',
                                  style: TextStyle(fontSize: 18,
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
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text('${studentListController.studentList.length} Students',
                                  style: TextStyle(fontSize: 18,
                                    fontWeight: FontWeight.w600,),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // list of student
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: studentListController.studentList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Text('${index+1}. ', style: TextStyle(fontSize: 16),),
                                title: Text('${studentListController.studentList[index]['student_roll']}'),
                                subtitle: Text('${studentListController.studentList[index]['student_name']}'),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildClassTimeSelector(AdminPanelController controller) {
    return SizedBox(
      width: 256,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Class Time',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Obx(
            () => DropdownMenu<String>(
              width: double.infinity,
              menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300),
                fixedSize: WidgetStatePropertyAll(Size(256, double.nan)),
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

  SizedBox buildLabNoSelector(AdminPanelController controller) {
    return SizedBox(
      width: 256,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Lab Number',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Obx(
            () => DropdownMenu<String>(
              width: double.infinity,
              menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300),
                fixedSize: WidgetStatePropertyAll(Size(256, double.nan)),
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

  SizedBox buildClassDaySelector(AdminPanelController controller) {
    return SizedBox(
      width: 256,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Class Day',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Obx(
            () => DropdownMenu<String>(
              width: double.infinity,
              menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300),
                fixedSize: WidgetStatePropertyAll(Size(256, double.nan)),
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