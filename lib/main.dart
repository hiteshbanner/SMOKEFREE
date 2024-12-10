import 'package:flutter/material.dart';
import 'package:smokefree/firstpage.dart';
import 'package:smokefree/tnt.dart';

import 'excl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: DownloadExcelPage(),
    );
  }
}





