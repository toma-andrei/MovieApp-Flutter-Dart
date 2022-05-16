import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../movie_page/movie_page.dart';
import '../actors/actor_page.dart';

class ActorListPage extends StatefulWidget {
  var actors = [];
  bool inPreferences = false;
  int userId = -1;
  var userData = {};
  ActorListPage(actors, inPreferences, userData) {
    List<dynamic> dataList = jsonDecode(actors);
    this.actors = dataList;
    this.inPreferences = inPreferences;
    this.userData = userData;
    this.userId = userData['id'];
  }

  @override
  _ActorListPageState createState() => _ActorListPageState();
}

class _ActorListPageState extends State<ActorListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Actors"),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30),
        child: Center(
          child: Column(
              children: widget.actors.map((actor) {
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
                      //get informations about actor
                      http
                          .get(
                        Uri.parse(
                            'http://localhost:3000/movie/' + actor['name']),
                      )
                          .then((result) {
                        List<String> movies = [];
                        List<dynamic> dataList = jsonDecode(result.body);

                        dataList.forEach((movie) {
                          movies.add(movie['name']);
                        });
                        actor['movies'] = movies;

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ActorPage(actor, widget.userData)));
                      });
                    },
                    child: _createCard(actor['name'], actor['birth_date']),
                  ),
                ),
                widget.inPreferences
                    ? Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            _removePrefActor(widget.userId, actor['actor_id']);
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

  void _removePrefActor(userId, id) {
    http.post(
      Uri.parse('http://localhost:3000/pref/remove'),
      body: jsonEncode({
        'id': id,
        'type': 'actor',
        "userId": userId,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ).then((result) {
      if (jsonDecode(result.body)['message'] == 'success') {
        setState(() {
          widget.actors.removeWhere((actor) => actor['actor_id'] == id);
        });
      }
    });
  }
}
