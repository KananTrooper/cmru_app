import 'dart:convert';

import 'package:cmru_app/config/app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _email = TextEditingController();
  final _password = TextEditingController();

  Future<void> CheckLogin() async {
    final prefs = await _prefs;
    final token = prefs.getString('token');
    if (token != null) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  void initState() {
    super.initState();
    CheckLogin();
  }

  Future<void> login() async {
    final resonse = await http.post(
      Uri.parse('${API_URL}/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': _email.text,
        'password': _password.text,
      }),
    );
    print(resonse.body);

    if (resonse.statusCode == 200) {
      final prefs = await _prefs;
      await prefs.setString('token', jsonDecode(resonse.body)['token']);
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('โปรดเข้าสู่ระบบ'),
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: 'อีเมล',
              ),
            ),
            TextField(
              controller: _password,
              decoration: const InputDecoration(
                labelText: 'รหัสผ่าน',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text('เข้าสู่ระะบบ'),
            ),
          ],
        ),
      ),
    );
  }
}
