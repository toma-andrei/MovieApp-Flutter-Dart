import 'package:flutter/material.dart';

class ActorPage extends StatelessWidget {
  var actor = {};

  ActorPage(this.actor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _backButton(context),
            _loveItButton(actor['actor_id']),
            Center(
              child: SizedBox(
                child: Card(
                  margin: EdgeInsets.all(30),
                  elevation: 20,
                  child: Column(
                    children: <Widget>[
                      _actorName(actor['name']),
                      _birthday(actor['birth_date']),
                      _description(actor["description"]),
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

Widget _loveItButton(id) {
  return Padding(
    padding: EdgeInsets.only(bottom: 20),
    child: ElevatedButton.icon(
      icon: Icon(Icons.favorite),
      onPressed: () {
        print(id);
      },
      label: Text(
        "Love it",
        style: TextStyle(fontSize: 30),
      ),
    ),
  );
}

Widget _actorName(String name) {
  return Title(
    color: Color.fromARGB(255, 24, 32, 42),
    child: Text(
      name,
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
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
    padding: EdgeInsets.only(bottom: 20, top: 10),
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
  );
}
