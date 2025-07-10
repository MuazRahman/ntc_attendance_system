import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  const supabaseUrl = 'https://haneelgbbdjymskathek.supabase.co';
  const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhhbmVlbGdiYmRqeW1za2F0aGVrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE1NTM4NzIsImV4cCI6MjA2NzEyOTg3Mn0.7mNCTk1qv2N7Jr8kdKPewZkBQxYPN7iSJ1EPjkVuYVA';

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(const NtcSas());
}
