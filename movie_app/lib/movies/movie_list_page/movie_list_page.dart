import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../movie_page/movie_page.dart';

class MovieListPage extends StatefulWidget {
  var movies = [];
  bool inPreferences = false;
  int userId = -1;
  var userData = {};

  MovieListPage(movies, inPreferences, userData) {
    final List<dynamic> dataList = jsonDecode(movies);
    this.movies = dataList;
    this.inPreferences = inPreferences;
    this.userData = userData;
    this.userId = userData['id'];
  }

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Movies"),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30),
        child: Center(
          child: Column(
              children: widget.movies.map((movie) {
            return Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(127, 208, 231, 0),
                      elevation: 10,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MoviePage(movie, widget.userData)));
                    },
                    child: _createCard(movie['name'], movie['director']),
                  ),
                ),
                widget.inPreferences
                    ? Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            _removePrefMovie(widget.userId, movie['id']);
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                      )
                    : Container()
              ]),
            );
          }).toList()),
        ),
      ),
    );
  }

  void _removePrefMovie(userId, id) {
    http.post(
      Uri.parse('http://localhost:3000/pref/remove'),
      body: jsonEncode({
        'id': id,
        'type': 'movie',
        "userId": userId,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ).then((result) {
      if (jsonDecode(result.body)['message'] == 'success') {
        setState(() {
          widget.movies.removeWhere((movie) => movie['id'] == id);
        });
      }
    });
  }

  //Create a card with the movie name and director
  Widget _createCard(String name, String director) {
    return Column(children: [
      Center(
        child: Text(
          name,
          style: TextStyle(fontSize: 21, color: Colors.blueGrey),
          textAlign: TextAlign.center,
        ),
      ),
      Center(
        child: Padding(
          child: Text(
            director,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                fontStyle: FontStyle.italic),
          ),
          padding: EdgeInsets.only(bottom: 5),
        ),
      ),
    ]);
  }
}
