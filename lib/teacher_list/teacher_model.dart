class Teacher {
  int? teacherId;
  String? teacherName;

  Teacher.fromJson(Map<String, dynamic> jsonData) {
    teacherId = jsonData['teacher_id'];
    teacherName = jsonData['teacher_name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'teacher_id': teacherId,
      'teacher_name': teacherName,
    };
  }
}