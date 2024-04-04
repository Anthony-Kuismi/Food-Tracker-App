import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Service/auth_service.dart';
import '../viewmodel/settings_viewmodel.dart';
import 'component/navbar.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key, required String username});

  @override
  State<SettingsView> createState() => _SettingsView();
}

class _SettingsView extends State<SettingsView> {


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SettingsViewModel>(context, listen: true);
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
      body: FutureBuilder(
        future: viewModel.load(),
        builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black26,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${viewModel.firstName} ${viewModel.lastName}',
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.primaryContainer,
                            ),
                            child: Text(
                              'Weight: ${viewModel.weightInPounds}lbs',
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.titleSmall?.fontSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.primaryContainer,
                            ),
                            child: Text(
                              'Height: ${viewModel.heightInInches} in', // Replace with actual height
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.titleSmall?.fontSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.primaryContainer,
                            ),
                            child: Text(
                              'Gender: ${viewModel.gender}', // Replace with actual gender
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.titleSmall?.fontSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black26,
                ),
                child: ListTile(
                  title: const Text('Birthdate'),
                  subtitle: Text(viewModel.birthDate), // Add your description
                  leading: const Icon(Icons.cake),
                  onTap: () {
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black26,
                ),
                child: ListTile(
                  title: const Text('Logout'),
                  leading: const Icon(Icons.logout),
                  onTap: () {
                    Provider.of<AuthService>(context, listen: false).logout(context);
                  },
                ),
              ),
            ),
          ],
        ),
      );
     },
    ),
      bottomNavigationBar: const NavBar(key: Key('customNavBar')),
    );
  }
}