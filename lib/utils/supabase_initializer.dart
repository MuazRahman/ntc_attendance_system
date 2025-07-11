import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseInitializer {

  Future<void> initialize() async{

    await dotenv.load(fileName: '.env');


    final supabaseUrl = dotenv.env['SUPABASE_URL'];
    final supabaseKey = dotenv.env['SUPABASE_KEY'];

    await Supabase.initialize(
      url: supabaseUrl!,
      anonKey: supabaseKey!,
    );
  }
}