import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:movie_app/authentication/login/login_view.dart';
import 'package:movie_app/authentication/register/register_view.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/movies/actors/actors_list_page.dart';
import '../movie_list_page/movie_list_page.dart';

class Preferences extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _backButton(context),
          _title(),
          _buttons(context),
        ],
      ),
    );
  }
}

Widget _buttonMovies(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(right: 30.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(0, 208, 231, 0),
        elevation: 10,
      ),
      onPressed: () => {
        http.get(Uri.parse('http://localhost:3000/movies')).then((allMovies) {
          http
              .get(Uri.parse('http://localhost:3000/movie/preferences/1'))
              .then((prefMovies) {
            print(prefMovies.body);
            // print(allMovies.body);

            List<dynamic> prefMoviesList = jsonDecode(prefMovies.body);
            List<dynamic> allMoviesList = jsonDecode(allMovies.body);

            List<dynamic> movies = [];

            allMoviesList.forEach((movie) {
              for (int i = 0; i < prefMoviesList.length; i++) {
                if (movie['id'] == prefMoviesList[i]['element_id']) {
                  movies.add(movie);
                  break;
                }
              }
            });

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieListPage(jsonEncode(movies))));
          });
        }),
      },
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Image.asset(
          'assets/film-reel.png',
          width: 150,
          height: 150,
        ),
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

Widget _buttonActors(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Color.fromARGB(0, 208, 231, 0),
      elevation: 10,
    ),
    onPressed: () {
      http.get(Uri.parse('http://localhost:3000/actors')).then((allActors) {
        http
            .get(Uri.parse('http://localhost:3000/actor/preferences/1'))
            .then((prefActors) {
          print(prefActors.body);
          // print(allMovies.body);

          List<dynamic> prefActorsList = jsonDecode(prefActors.body);
          List<dynamic> allActorsList = jsonDecode(allActors.body);

          List<dynamic> actors = [];

          allActorsList.forEach((actor) {
            for (int i = 0; i < prefActorsList.length; i++) {
              if (actor['actor_id'] == prefActorsList[i]['element_id']) {
                actors.add(actor);
                break;
              }
            }
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActorsListPage(jsonEncode(actors)),
            ),
          );
        });
      });
    },
    child: Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Image.asset(
        'assets/actor.png',
        width: 150,
        height: 150,
      ),
    ),
  );
}

Widget _title() {
  return Padding(
    padding: EdgeInsets.only(top: 150.0, bottom: 120.0),
    child: Text(
      "Preferences",
      style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
    ),
  );
}

Widget _buttons(BuildContext context) {
  return Center(
    child: Row(
      children: <Widget>[_buttonActors(context), _buttonMovies(context)],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    ),
  );
}
