class Student {
  int? studentRoll;
  String? studentName;
  String? classtime;
  String? classroom;
  bool? isPresent;
  String? teacherName;

  Student.fromJson(Map<String, dynamic> jsonData) {
    studentRoll = jsonData['student_roll'];
    studentName = jsonData['student_name'];
    classtime = jsonData['class_time'];
    classroom = jsonData['class_room'];
    isPresent = jsonData['is_present'];
  }

  Map<String, dynamic> toJson() {
    return {
      'student_roll': studentName,
      'student_name': studentName,
      'class_time': classtime,
      'class_room': classroom,
      'is_present': isPresent,
      'teacher_name': teacherName,
    };
  }
}