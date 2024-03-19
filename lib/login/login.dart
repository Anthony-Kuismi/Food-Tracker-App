import 'package:flutter/material.dart';
import '../main.dart';
import '../service/navigator.dart';
import '../view/homepage_view.dart';
import 'main_page.dart';
import 'signup.dart';
import 'forgot_password.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hot Dog Food Tracking Login',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurpleAccent,
          brightness: Brightness.dark,
        ),
        primarySwatch: Colors.blue,
      ),
      home: const MyLoginPage(title: 'Login Page'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPage();
}

class _MyLoginPage extends State<MyLoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  String _loginStatus = '';

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  final List<Map<String, String>> _users = [
    {'username': 'user1', 'password': 'pass1'},
    {'username': 'user2', 'password': 'pass2'},
    // Add more mock users as needed
  ];

  bool _validateUser(String username, String password) {
    for (var user in _users) {
      if (user['username'] == username && user['password'] == password) {
        return true;
      }
    }
    return false;
  }

  void _handleSubmitted(String value) {
    _login();
  }

  void _login() {
    if (_validateUser(_usernameController.text, _passwordController.text)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(username: _usernameController.text, title: '',)),      );
    } else {
      setState(() {
        _loginStatus = 'Incorrect username or password';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.primary,
        title: const Text(
          'Food Tracking: Hotdog Version',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Image.asset('assets/images/TeamHotDogLogo.PNG', height: 140),
              SizedBox(height: 30),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, FocusScope.of(context), _passwordFocusNode);
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                focusNode: _passwordFocusNode,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                onFieldSubmitted: _handleSubmitted,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _loginStatus,
                style: TextStyle(color: _loginStatus == 'You have been logged in' ? Colors.green : Colors.red),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                  );
                },
                child: const Text('Forgot Password?'),
              ),
              const SizedBox(height: 20),
              Divider(),
              const SizedBox(height: 20),
              Text('Don\'t have an account?'),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
