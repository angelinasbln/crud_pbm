import 'package:flutter/material.dart';
import 'login_page.dart';
import 'database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelper = DatabaseHelper.instance;
  final db = await dbHelper.database;

  runApp(const MyApp()); // Tambahkan const
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Tambahkan parameter key

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(), // Tambahkan const
    );
  }
}
