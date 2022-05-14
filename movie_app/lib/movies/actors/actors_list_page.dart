import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../movie_page/movie_page.dart';
import '../actors/actor_page.dart';

class ActorsListPage extends StatelessWidget {
  var actors = [];

  ActorsListPage(actors) {
    List<dynamic> dataList = jsonDecode(actors);
    this.actors = dataList;
    print(this.actors);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("All Movies"),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30),
        child: Center(
          child: Column(
              children: actors.map((actor) {
            return Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: SizedBox(
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
                              builder: (context) => ActorPage(actor)));
                    },
                    child: _createCard(actor['name'], actor['birth_date']),
                  ),
                ));
          }).toList()),
        ),
      ),
    );
  }
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
