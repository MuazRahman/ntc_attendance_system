import 'package:get/get.dart';

class AdminPanelController extends GetxController {
  final List<String> classTimes = [
    '8:00 - 10:00',
    '10:00 - 12:00',
    '12:00 - 2:00',
    '2:00 - 4:00',
    '4:00 - 6:00',
    '6:00 - 8:00',
  ];

  final RxnString selectedClassDay = RxnString();
  final RxnString selectedLabNo = RxnString();
  final RxnString selectedClassTime = RxnString();
}
