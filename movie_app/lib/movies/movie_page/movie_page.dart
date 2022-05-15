import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviePage extends StatelessWidget {
  var movie = {};
  MoviePage(this.movie);
  var show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _backButton(context),
            _loveItButton(movie['id'], context),
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
                      _movieTitle(movie['name']),
                      _director(movie['director']),
                      _releaseYear(movie['release_date'].split('-')[0]),
                      _plot(movie['plot']),
                      _actors(movie['actors'].join(', ')),
                      _producers(movie['producers'].join(', ')),
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

  Widget _loveItButton(id, context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: ElevatedButton.icon(
        icon: Icon(Icons.favorite),
        onPressed: () {
          http.post(Uri.parse('http://localhost:3000/preferences'),
              body: jsonEncode({
                'id': id.toString(),
                'type': 'movie',
                'userId': '1',
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
                      content: Text('Movie added to your favorites'),
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

Widget _movieTitle(String title) {
  return Title(
    color: Color.fromARGB(255, 24, 32, 42),
    child: Container(
      margin: EdgeInsets.all(10),
      child: Text(
        title,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _director(String name) {
  return Padding(
    padding: EdgeInsets.only(top: 15),
    child: Container(
      margin: EdgeInsets.all(10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: "Director: ",
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            TextSpan(
              text: name,
              style: TextStyle(fontSize: 20, color: Colors.black),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _releaseYear(String year) {
  return Padding(
    padding: EdgeInsets.only(bottom: 20, top: 10),
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: "Release year: ",
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          TextSpan(
            text: year,
            style: TextStyle(fontSize: 20, color: Colors.black),
          )
        ],
      ),
    ),
  );
}

Widget _plot(String plot) {
  return Padding(
    padding: EdgeInsets.only(bottom: 20),
    child: Container(
      margin: EdgeInsets.all(10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: "Plot: ",
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            TextSpan(
              text: plot,
              style: TextStyle(fontSize: 20, color: Colors.black),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _actors(String actors) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Container(
      margin: EdgeInsets.all(10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: "Actors: ",
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            TextSpan(
              text: actors,
              style: TextStyle(fontSize: 20, color: Colors.black),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _producers(String producers) {
  return Padding(
    padding: EdgeInsets.only(bottom: 20),
    child: Container(
      margin: EdgeInsets.all(10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: "Producers: ",
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            TextSpan(
              text: producers,
              style: TextStyle(fontSize: 20, color: Colors.black),
            )
          ],
        ),
      ),
    ),
  );
}
