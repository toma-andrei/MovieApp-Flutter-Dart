import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget {
  var movie = {};

  MoviePage(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _backButton(context),
            _loveItButton(movie['id']),
            Center(
              child: SizedBox(
                child: Card(
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

Widget _movieTitle(String title) {
  return Title(
    color: Color.fromARGB(255, 24, 32, 42),
    child: Text(
      title,
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _director(String name) {
  return Padding(
    padding: EdgeInsets.only(top: 15),
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
  );
}

Widget _actors(String actors) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
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
  );
}

Widget _producers(String producers) {
  return Padding(
    padding: EdgeInsets.only(bottom: 20),
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
  );
}
