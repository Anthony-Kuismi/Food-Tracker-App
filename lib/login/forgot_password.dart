import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _usernameController = TextEditingController();
  String _passwordStatus = '';


  final List<Map<String, String>> _users = [
    {'username': 'user1', 'password': 'pass1'},
    {'username': 'user2', 'password': 'pass2'},

  ];

  void _retrievePassword() {
    String password = _users.firstWhere(
          (user) => user['username'] == _usernameController.text,
      orElse: () => {'password': 'User does not exist'},
    )['password']!;

    setState(() {
      _passwordStatus = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),
              Image.asset('assets/images/team-hot-dog-logo.png', height: 100),
              const SizedBox(height: 40),
              Text(
                'Retrieve Your Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _retrievePassword,
                child: const Text('Retrieve Password'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _passwordStatus,
                style: TextStyle(color: Colors.blue, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}