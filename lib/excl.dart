import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class DownloadExcelPage extends StatelessWidget {
  const DownloadExcelPage({Key? key}) : super(key: key);

  Future<void> downloadExcel() async {
    final url = 'http://192.168.132.100:80/smokefree/excl.php';

    try {
      // Request storage permission
      PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        // Define the Downloads directory
        final downloadsDirectory = Directory('/storage/emulated/0/Download');
        if (!downloadsDirectory.existsSync()) {
          downloadsDirectory.createSync(recursive: true);
        }

        // Download file
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          // Save file to Downloads directory
          final filePath = '${downloadsDirectory.path}/data.xlsx';
          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);

          print('File saved to $filePath');
        } else {
          print('Failed to download file: ${response.statusCode}');
        }
      } else {
        print('Storage permission denied');
      }
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Excel'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: downloadExcel,
          child: const Text('Download Excel'),
        ),
      ),
    );
  }
}
