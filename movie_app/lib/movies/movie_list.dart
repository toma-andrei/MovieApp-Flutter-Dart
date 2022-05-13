import 'package:flutter/material.dart';
import './styles/styles.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

var genres = ["Fantasy", "Family", "Animation", "Drama", "Comedy", "Horror"];

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            _image(),
            _elevatedButton("All movies", 25),
            _elevatedButton("Actors", 20),
            _elevatedButton("Action", 20),
            _elevatedButton("Adventure", 20),
            _elevatedButton("Science Fiction", 20),
            _elevatedButton("Thriller", 20),
            _dropDownMenu(),
          ],
        ),
      ),
    );
  }
}

Widget _image() {
  return Padding(
    padding: EdgeInsets.only(top: 20),
    child: Image(
      image: AssetImage("assets/cinema.png"),
      height: 250,
      width: 250,
    ),
  );
}

Widget _elevatedButton(String text, double size) {
  return Padding(
    padding: EdgeInsets.only(top: 20),
    child: ElevatedButton(
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(fontSize: size),
      ),
      style: LimeElevatedButtonStyle(),
    ),
  );
}

Widget _dropDownMenu() {
  return Padding(
    padding: EdgeInsets.only(top: 20),
    child: Card(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: DropdownButton(
          value: genres[0],
          icon: Icon(Icons.arrow_drop_down_circle_outlined,
              color: Colors.deepPurple),
          items: genres
              .map((String name) => DropdownMenuItem(
                    value: name,
                    child: Text(name),
                  ))
              .toList(),
          onChanged: (String? value) {},
          elevation: 10,
        ),
      ),
    ),
  );
}
