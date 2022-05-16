import 'dart:html';

import 'package:flutter/material.dart';
import 'package:movie_app/authentication/login/login_view.dart';
import 'package:movie_app/authentication/register/register_view.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _title(),
          _buttons(context),
        ],
      ),
    );
  }
}

Widget _buttonLogin(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(right: 30.0),
    child: ElevatedButton(
      onPressed: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginView()))
      },
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Text(
          "Login",
          style: TextStyle(fontSize: 30.0),
        ),
      ),
    ),
  );
}

Widget _buttonRegister(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => RegisterView()),
        ),
      );
    },
    child: Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Text(
        "Register",
        style: TextStyle(fontSize: 30.0),
      ),
    ),
  );
}

Widget _title() {
  return Padding(
    padding: EdgeInsets.only(top: 140.0, bottom: 90.0),
    child: Image.asset('assets/authentication.png', width: 200, height: 200),
  );
}

Widget _buttons(BuildContext context) {
  return Center(
    child: Row(
      children: <Widget>[_buttonLogin(context), _buttonRegister(context)],
      mainAxisAlignment: MainAxisAlignment.center,
    ),
  );
}
