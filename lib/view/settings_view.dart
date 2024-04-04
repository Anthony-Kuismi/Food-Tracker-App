import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Service/auth_service.dart';
import 'component/navbar.dart';


class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () {
              Provider.of<AuthService>(context, listen: false).logout(context);
            },
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(key: Key('customNavBar')),
    );
  }
}