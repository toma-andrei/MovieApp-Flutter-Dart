import 'dart:convert';

import 'package:flutter/material.dart';
import './styles/styles.dart';
import 'package:http/http.dart' as http;
import './movie_list_page/movie_list_page.dart';
import '../movies/actors/actors_list_page.dart';

class MovieListMain extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

var genres = ["Fantasy", "Family", "Animation", "Drama", "Comedy", "Horror"];

class _MovieListState extends State<MovieListMain> {
  var movies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            _image(),
            _elevatedButton("All movies", 25, context),
            _elevatedButton("Actors", 20, context),
            _elevatedButton("Action", 20, context),
            _elevatedButton("Adventure", 20, context),
            _elevatedButton("Science Fiction", 20, context),
            _elevatedButton("Thriller", 20, context),
            _dropDownMenu(),
          ],
        ),
      ),
    ));
  }

  Widget _image() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Image(
        image: AssetImage("assets/cinema.png"),
        height: 220,
        width: 220,
      ),
    );
  }

  Widget _elevatedButton(String text, double size, context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: () {
          _elevatedButtonPressed(text, context);
        },
        child: Text(
          text,
          style: TextStyle(fontSize: size),
        ),
        style: LimeElevatedButtonStyle(),
      ),
    );
  }

  _elevatedButtonPressed(element, context) {
    if (element == "All movies") {
      http.get(Uri.parse('http://localhost:3000/movies')).then((response) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (
            context,
          ) {
            return MovieListPage(response.body);
          }),
        );
      });
    } else if (element == "Actors") {
      http.get(Uri.parse('http://localhost:3000/actors')).then((response) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (
            context,
          ) {
            return ActorsListPage(response.body);
          }),
        );
      });
    } else if (element == "Action") {
    } else if (element == "Adventure") {
    } else if (element == "Science Fiction") {
    } else if (element == "Thriller") {}
  }

  Widget _dropDownMenu() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: DropdownButton(
            isExpanded: false,
            value: genres[0],
            icon: Icon(Icons.arrow_drop_down_circle_outlined,
                color: Colors.deepPurple),
            items: genres
                .map((String name) => DropdownMenuItem(
                      value: name,
                      child: Text(name),
                    ))
                .toList(),
            onChanged: (String? value) {
              print(value);
            },
            elevation: 10,
          ),
        ),
      ),
    );
  }
}
