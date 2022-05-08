import "package:flutter/material.dart";

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              _title(),
              _usernameField(),
              _passwordField(),
              _submitButton()
            ],
          ),
        ),
      ),
    );
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

  Widget _usernameField() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Enter your username",
        icon: Icon(Icons.person),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        icon: Icon(Icons.security),
        hintText: 'Password',
      ),
    );
  }
}

Widget _submitButton() {
  return Padding(
    padding: EdgeInsets.all(16.0),
    child: ElevatedButton(
      child: Text("Login"),
      onPressed: () {},
    ),
  );
}
