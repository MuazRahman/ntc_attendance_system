import 'package:ntc_sas/teacher_list/teacher_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetTeacherList {
  List<Map<String, dynamic>> teacherList = [];

  Future<void> getTeacherList() async{
    teacherList.clear();
    final response = await Supabase.instance.client
        .from('teacher')
        .select()
        .order('teacher_id', ascending: true);

    for (var i in response as List) {
      final data = Teacher.fromJson(i);

      teacherList.add({
        'teacher_id': data.teacherId.toString().trim(),
        'teacher_name': data.teacherName!.trim(),
      });
    }
    print(teacherList);
  }

}


