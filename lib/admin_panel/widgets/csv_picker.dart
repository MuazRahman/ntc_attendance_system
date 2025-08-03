import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

class PickCSVFile {
  List<Map<String, dynamic>>? records;

  Future<void> pickCSVFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      final Uint8List fileBytes = result.files.single.bytes!;
      final String csvString = utf8.decode(fileBytes);

      final List<List<dynamic>> csvData =
      const CsvToListConverter().convert(csvString);

      final headers = csvData.first.cast<String>();
      final rows = csvData.skip(1);

      records = rows.map((row) {
        final Map<String, dynamic> record = {};
        for (int i = 0; i < headers.length; i++) {
          record[headers[i]] = row[i];
        }
        return record;
      }).toList();

      print(records);

    }
  }
}

