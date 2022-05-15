import 'dart:convert';

import 'package:flutter/material.dart';
import './styles/styles.dart';
import 'package:http/http.dart' as http;
import './movie_list_page/movie_list_page.dart';
import '../movies/actors/actors_list_page.dart';
import '../movies/preferences/choose_pref.dart';

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
            _elevatedButton("All movies", 30, context),
            _elevatedButton("Actors", 25, context),
            _elevatedButton("Action", 25, context),
            _elevatedButton("Adventure", 25, context),
            _elevatedButton("Science Fiction", 25, context),
            _elevatedButton("Thriller", 25, context),
            _dropDownMenu(),
          ],
        ),
      ),
    ));
  }

  Widget _image() {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(0, 244, 241, 241), elevation: 0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Preferences()));
        },
        child: Image(
          image: AssetImage("assets/cinema.png"),
          height: 220,
          width: 220,
        ),
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
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Text(
            text,
            style: TextStyle(fontSize: size),
          ),
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
    } else {
      http.get(Uri.parse('http://localhost:3000/movies')).then((allMovies) {
        List<dynamic> movies = jsonDecode(allMovies.body);
        List<dynamic> filteredMovies = [];
        for (var i = 0; i < movies.length; i++) {
          if (movies[i]["genres"].contains(element)) {
            filteredMovies.add(movies[i]);
          }
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (
            context,
          ) {
            return MovieListPage(jsonEncode(filteredMovies));
          }),
        );
      });
    }
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
              if (value != null) {
                //get all movies
                http
                    .get(Uri.parse('http://localhost:3000/movies'))
                    .then((allMovies) {
                  List<dynamic> movies = jsonDecode(allMovies.body);
                  List<dynamic> filteredMovies = [];
                  for (var i = 0; i < movies.length; i++) {
                    if (movies[i]["genres"].contains(value)) {
                      filteredMovies.add(movies[i]);
                    }
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (
                      context,
                    ) {
                      return MovieListPage(jsonEncode(filteredMovies));
                    }),
                  );
                  /*              
                  get all movies with the selected genre
                  http
                      .get(Uri.parse('http://localhost:3000/' + value))
                      .then((response) {
                    List<dynamic> moviesByGenre = jsonDecode(response.body);

                    moviesByGenre.forEach((movie) {
                      bool found = true;
                      for (int i = 0; i < movies.length; i++) {
                        if (movies[i]["id"] == movie["id"]) {
                          found = false;
                          break;
                        }
                      }
                      if (!found) {
                        movies.removeWhere(
                            (moviee) => moviee["id"] == movie["id"]);
                      }
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (
                        context,
                      ) {
                        return MovieListPage(jsonEncode(movies));
                      }),
                    );
                  });*/
                });
              }
            },
            elevation: 10,
          ),
        ),
      ),
    );
  }
}
