import 'dart:convert';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:movie_app/movies/movie_list.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isValid = false;
  String reasonForRegisterFail = "";

  bool validateEmail(text) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);
  }

  void checkValidity() {
    setState(() {
      _isValid = _emailController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void setReasonForRegisterFail(String reason) {
    setState(() {
      reasonForRegisterFail = reason;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create an account"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _title(),
            _emailField(),
            _usernameField(),
            _passwordField(),
            _submitButton(context),
            reasonForRegisterFail.isNotEmpty
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
                          reasonForRegisterFail,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
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
            "Register",
            style: TextStyle(
                fontSize: 35,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _emailController,
      onChanged: (str) {
        checkValidity();
      },
      decoration: InputDecoration(
        hintText: "Enter your email",
        icon: Icon(Icons.email),
      ),
    );
  }

  Widget _usernameField() {
    return TextFormField(
      controller: _usernameController,
      onChanged: (str) {
        checkValidity();
      },
      decoration: InputDecoration(
        hintText: "Enter your username",
        icon: Icon(Icons.person),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: _passwordController,
      onChanged: (str) {
        checkValidity();
      },
      obscureText: true,
      decoration: const InputDecoration(
        icon: Icon(Icons.security),
        hintText: 'Password',
      ),
    );
  }

  Widget _submitButton(context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ElevatedButton(
        child: Text("Register"),
        onPressed: _isValid
            ? () {
                if (validateEmail(_emailController.text)) {
                  _register(context);
                } else {
                  setReasonForRegisterFail("Please enter a valid email");
                }
              }
            : null,
      ),
    );
  }

  void _register(context) {
    String email = _emailController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;
    http.post(Uri.parse("http://localhost:3000/register"),
        body: jsonEncode({
          "email": email,
          "username": username,
          "password": password,
        }),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        }).then((response) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      print(responseBody);
      if (responseBody["message"] == 'success') {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MovieListMain(responseBody['data']),
          ),
        );
      } else {
        setReasonForRegisterFail(responseBody["message"]);
      }
    });
  }
}
