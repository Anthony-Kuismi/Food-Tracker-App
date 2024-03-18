import 'package:flutter/material.dart';
//import 'package:food_tracker_app/view/searchbar-view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_tracker_app/view/customNavBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            print("could not connect");
          }
          if(snapshot.connectionState== ConnectionState.done){
            return MaterialApp(
              title: 'Hotdog food dieting app',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepPurpleAccent,
                  brightness: Brightness.dark,
                ),
                useMaterial3: true,
              ),
              home: const MyHomePage(title: 'hotdog',),
            );
          }
          Widget loading = MaterialApp();
          return loading;
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Food Tracking: Hotdog Version",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavBar(key: Key('customNavBar')), // Integrate the CustomNavBar widget here
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
      //     BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search', ),
      //   ],
      //   currentIndex: currentIndex,
      //   onTap: (int index){
      //     currentIndex = index;
      //   },
      //
      // ),
      body: Center(
//children:[],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
