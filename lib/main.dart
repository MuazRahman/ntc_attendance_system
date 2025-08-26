import 'package:flutter/material.dart';
import 'app.dart';
import 'utils/supabase_initializer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseInitializer().initialize();
  runApp(const NtcSas());
}
