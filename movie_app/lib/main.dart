//dart looks into main.dart and looks for a main function
///Movie App. This app should give the user the possibility to browse through movies, and
///for every movie he can see details about plot, actors, producers. Each user should have
///the possibility to have a list of favorite actors and movies. The user can also see the
///movies grouped by genre. */

import 'package:flutter/material.dart';
import './authentication/login_view.dart';
import './authentication/register_view.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Roboto", primarySwatch: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Movie App"),
        ),
        body: LoginView(),
      ),
    );
  }
}
