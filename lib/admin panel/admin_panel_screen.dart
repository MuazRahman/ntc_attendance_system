import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/admin_panel_controller.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  static const ButtonStyle _buttonStyle = ButtonStyle(
    textStyle: WidgetStatePropertyAll(
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final AdminPanelController adminPanelController = Get.find<AdminPanelController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 28),
            const Center(
              child: Text(
                'Admin Dashboard',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Card(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = MediaQuery.of(context).size.width;

                    // Example threshold: make card wider if screen is > 1200 px
                    final cardWidth = screenWidth > 1200
                        ? screenWidth * 0.9
                        : null;

                    return SizedBox(
                      width: cardWidth,
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
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder
                                    (borderRadius: BorderRadius.circular(12,),),
                                  fixedSize: Size(256, 40),
                                backgroundColor: Colors.blueGrey.shade200,
                              ),
                              child: Text(
                                'Show Data', style: TextTheme.of(context).titleMedium!.copyWith(fontSize: 18, fontWeight: FontWeight.w600,),),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
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
                      style: _buttonStyle,
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
                  style: _buttonStyle,
                ),
                DropdownMenuEntry(
                  value: 'Lab2',
                  label: 'Lab2',
                  style: _buttonStyle,
                ),
                DropdownMenuEntry(
                  value: 'Lab3',
                  label: 'Lab3',
                  style: _buttonStyle,
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
                  style: _buttonStyle,
                  label: 'Saturday',
                ),
                DropdownMenuEntry(
                  value: 'Sunday',
                  style: _buttonStyle,
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
