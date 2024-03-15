import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final String username;

  const MainPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: Text('Welcome $username', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
