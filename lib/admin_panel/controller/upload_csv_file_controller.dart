import 'package:get/get.dart';
import 'package:ntc_sas/admin_panel/widgets/csv_picker.dart';
import 'package:ntc_sas/common/widgets/show_snack_bar_message.dart'; // Assuming your showSnackBarMessage is here
import 'package:supabase_flutter/supabase_flutter.dart';

class CsvFilePickerAndUploadController extends GetxController {
  var isLoading = false; // To show a loading indicator if needed

  Future<void> pickCsvFile(PickCSVFile csvFilePicker) async {
    await csvFilePicker.pickCSVFile();
  }

  Future<void> uploadCsvData(PickCSVFile csvFilePicker) async {
    if (csvFilePicker.records == null || csvFilePicker.records!.isEmpty) {
      Get.back(); // Close the dialog if it's open
      showSnackBarMessage(subtitle: 'No data found in CSV file!', isErrorMessage: true);
      return;
    }

    isLoading = true;
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.from('student').insert(csvFilePicker.records!).select();

      // The response from supabase insert with .select() is a List.
      // You might want to check if the list is not empty or if there were no errors.
      // Supabase often throws an error for failures, which is caught by the catch block.
      // So, if it reaches here, it's generally successful.

      Get.back(); // Close the dialog
      print(response); // Log the response for debugging
      showSnackBarMessage(subtitle: 'CSV file added successfully!', isErrorMessage: false);

    } catch (e) {
      Get.back(); // Close the dialog
      print("Error uploading CSV: $e");
      // Be more specific with error messages if possible
      String errorMessage = 'Upload failed. Please try again.';
      if (e is PostgrestException && e.message.contains('duplicate key value violates unique constraint')) {
        errorMessage = 'Upload failed. Some records already exist.';
      } else if (e.toString().contains("SocketException") || e.toString().contains("HandshakeException")) {
        errorMessage = 'Upload failed. Please check your internet connection.';
      }
      showSnackBarMessage(subtitle: errorMessage, isErrorMessage: true);
    } finally {
      isLoading = false;
      csvFilePicker.records = null; // Clear records after attempting upload
    }
  }
}
