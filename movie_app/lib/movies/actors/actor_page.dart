import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ActorPage extends StatelessWidget {
  var actor = {};
  var userId = -1;
  var userData = {};
  ActorPage(actor, userData) {
    this.actor = actor;
    this.userData = userData;
    this.userId = userData['id'];
  }

  @override
  Widget build(BuildContext context) {
    print(actor);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _backButton(context),
            _loveItButton(actor['actor_id'], context),
            Center(
              child: SizedBox(
                child: Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(30),
                  elevation: 20,
                  child: Column(
                    children: <Widget>[
                      _actorName(actor['name']),
                      _birthday(actor['birth_date']),
                      _description(actor["description"]),
                      _movies(actor['movies'].join(", ")),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _backButton(context) {
    return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 30),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Back",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  Widget _loveItButton(id, context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: ElevatedButton.icon(
        icon: Icon(Icons.favorite),
        onPressed: () {
          http.post(Uri.parse('http://localhost:3000/preferences'),
              body: jsonEncode({
                'id': id.toString(),
                'type': 'actor',
                'userId': userId,
              }),
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
              }).then((value) {
            Map<String, dynamic> response = jsonDecode(value.body);

            if (response['message'] == 'success') {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                          children: [Text('Success'), Icon(Icons.verified)]),
                      content: Text('Actor added to your favorites'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  });
            } else if (response['message'] == 'duplicate') {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(children: [Text('Error'), Icon(Icons.error)]),
                      content: Text('Movie already exists in your favorites'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  });
            }
          });
        },
        label: Text(
          "Love it",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  Widget _actorName(String name) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Title(
        color: Color.fromARGB(255, 24, 32, 42),
        child: Text(
          name,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _birthday(String date) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: "Birthday: ",
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            TextSpan(
              text: date,
              style: TextStyle(fontSize: 20, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  Widget _description(String description) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        margin: EdgeInsets.all(10),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "Description: ",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              TextSpan(
                text: description,
                style: TextStyle(fontSize: 20, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _movies(movies) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20, top: 10),
      child: Container(
        margin: EdgeInsets.all(10),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "Movies: ",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              TextSpan(
                text: movies,
                style: TextStyle(fontSize: 20, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
