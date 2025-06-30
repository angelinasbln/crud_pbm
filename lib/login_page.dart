import 'package:flutter/material.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key); // Tambahkan parameter key

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String adminUsername = 'admin';
  final String adminPassword = 'password';

  void _login() {
    if (_usernameController.text == adminUsername && _passwordController.text == adminPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()), // Tambahkan const
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')), // Tambahkan const
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')), // Tambahkan const
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Tambahkan const
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'), // Tambahkan const
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'), // Tambahkan const
              obscureText: true,
            ),
            const SizedBox(height: 20), // Tambahkan const
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'), // Tambahkan const
            ),
          ],
        ),
      ),
    );
  }
}
