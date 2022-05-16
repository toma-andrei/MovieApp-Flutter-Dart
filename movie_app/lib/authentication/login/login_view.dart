import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import '../../movies/movie_list.dart';
import '../../movies/movie_list_page/movie_list_page.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isValid = false;
  String reasonForLoginFail = "";

  void stateModifier() {
    setState(() {
      _isValid = _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void setReasonForLoginFail(String reason) {
    setState(() {
      reasonForLoginFail = reason;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              _title(),
              _usernameField(_usernameController),
              _passwordField(_passwordController),
              _submitButton(_isValid, _usernameController, _passwordController,
                  setReasonForLoginFail),
              reasonForLoginFail.isNotEmpty
                  ? Card(
                      elevation: 0,
                      color: Theme.of(context).colorScheme.background,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.error, color: Colors.red)),
                          Text(
                            reasonForLoginFail,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _title() {
    return Padding(
      padding: EdgeInsets.only(top: 50.0, bottom: 80.0),
      child: Title(
          color: Colors.deepPurple,
          child: Center(
              child: Text(
            "Login",
            style: TextStyle(
                fontSize: 35,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold),
          ))),
    );
  }

  Widget _usernameField(
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      onChanged: (str) {
        checkValidity();
      },
      decoration: InputDecoration(
        hintText: "Enter your username",
        icon: Icon(Icons.person),
      ),
    );
  }

  Widget _passwordField(
    TextEditingController controller,
  ) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      onChanged: (value) {
        checkValidity();
      },
      decoration: const InputDecoration(
        icon: Icon(Icons.security),
        hintText: 'Password',
      ),
    );
  }

  Widget _submitButton(
    bool isValid,
    TextEditingController usernameController,
    TextEditingController passwordController,
    setReasonForLoginFail,
  ) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ElevatedButton(
        child: Text("Login"),
        onPressed: isValid
            ? () => _login(usernameController, passwordController, context,
                setReasonForLoginFail)
            : null,
      ),
    );
  }

  void checkValidity() {
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        _isValid = true;
      });
    } else {
      setState(() {
        _isValid = false;
      });
    }
  }
}

_login(TextEditingController usernameController,
    TextEditingController passwordController, context, setReasonForLoginFail) {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  http
      .post(
    Uri.parse('http://localhost:3000/login'),
    body: jsonEncode({
      "username": usernameController.text,
      "password": passwordController.text,
    }),
    headers: requestHeaders,
  )
      .then((response) {
    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (responseBody['message'] == "success") {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MovieListMain(responseBody['data'])),
      );
    } else {
      setReasonForLoginFail(jsonDecode(response.body)["message"]);
    }
  });
}
