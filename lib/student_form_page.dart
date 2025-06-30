import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'login_page.dart';

class StudentFormPage extends StatefulWidget {
  final Map<String, dynamic>? student;

  const StudentFormPage({Key? key, this.student}) : super(key: key);

  @override
  _StudentFormPageState createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _originController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _nameController.text = widget.student!['name'];
      _emailController.text = widget.student!['email'];
      _majorController.text = widget.student!['major'];
      _originController.text = widget.student!['origin'];
    }
  }

  void _saveStudent() async {
    try {
      final student = {
        'name': _nameController.text,
        'email': _emailController.text,
        'major': _majorController.text,
        'origin': _originController.text,
      };

      print('Saving student: $student');

      if (widget.student == null) {
        await _dbHelper.insertStudent(student);
        print('Student inserted');
      } else {
        // student['id'] = widget.student!['id'] is int ? widget.student!['id'] : int.parse(widget.student!['id'].toString());
        // student['id'] = int.parse(widget.student!['id']);
        student['id'] = widget.student!['id'].toString(); // Konversi id ke String
        print('Student ID: ${student['id']}, Type: ${student['id'].runtimeType}');
        await _dbHelper.updateStudent(student);
        print('Student updated');
      }

      Navigator.pop(context, true); // Berikan true sebagai hasil untuk memperbarui data di halaman sebelumnya
    } catch (e) {
      print('Error saving student: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan data mahasiswa')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? 'Tambah Mahasiswa' : 'Edit Mahasiswa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _majorController,
              decoration: const InputDecoration(labelText: 'Jurusan'),
            ),
            TextField(
              controller: _originController,
              decoration: const InputDecoration(labelText: 'Asal'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveStudent,
              child: Text(widget.student == null ? 'Tambah' : 'Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
