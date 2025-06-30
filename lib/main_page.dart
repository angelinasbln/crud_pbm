import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'student_form_page.dart';
import 'login_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key); // Tambahkan parameter key

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> _students = [];

  @override
  void initState() {
    super.initState();
    _refreshStudents();
  }

  Future<void> _refreshStudents() async {
    final data = await _dbHelper.getStudents();
    setState(() {
      _students = data;
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()), // Tambahkan const
    );
  }

  Future<void> _navigateToAddStudent() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudentFormPage()), // Tambahkan const
    );
    if (result == true) {
      _refreshStudents();
    }
  }

  Future<void> _navigateToEditStudent(Map<String, dynamic> student) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentFormPage(student: student)),
    );
    if (result == true) {
      _refreshStudents();
    }
  }

  void _deleteStudent(int id) async {
    await _dbHelper.deleteStudent(id);
    _refreshStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Mahasiswa'), // Tambahkan const
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // Tambahkan const
            onPressed: _logout,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_students[index]['name']),
            subtitle: Text(_students[index]['major']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit), // Tambahkan const
                  onPressed: () => _navigateToEditStudent(_students[index]),
                ),
                IconButton(
                  icon: const Icon(Icons.delete), // Tambahkan const
                  onPressed: () => _deleteStudent(_students[index]['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddStudent,
        child: const Icon(Icons.add), // Tambahkan const
      ),
    );
  }
}
