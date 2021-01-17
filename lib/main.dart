
import 'package:ecogoals/ar.dart';
import 'package:ecogoals/pages/entry_confirmation_page.dart';
import 'package:ecogoals/pages/home_page.dart';

import 'package:ecogoals/pages/scan_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Center(
            child: Container(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: EntryConfirmationPage(),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
