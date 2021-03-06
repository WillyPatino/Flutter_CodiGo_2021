import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nbapp/models/gamesView.dart';
import 'package:nbapp/models/playersView.dart';


import 'models/team.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Team> equipos;
  String urlLogo =
      "https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_500x500/";

  void getTeamsList() async {
    http.Response response =
    await http.get(Uri.parse("https://www.balldontlie.io/api/v1/teams"));
    String datos = response.body;
    List equiposMap = jsonDecode(datos)["data"];
    setState(() {
      equipos = equiposMap.map((m) => Team.fromJson(m)).toList();
    });
  }

  @override
  void initState() {
    getTeamsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/originals/e9/5f/56/e95f56d52fea3ab71221fdc5d10efbd0.jpg"),
                    fit: BoxFit.cover)),
          ),
          Center(
              child: equipos == null
                  ? CircularProgressIndicator()
                  : CarouselSlider(
                options: CarouselOptions(height: 600.0),
                items: equipos.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Card(
                            color: Colors.black.withOpacity(0.5),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    i.city,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0),
                                  ),
                                  Text(
                                    i.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40.0),
                                  ),
                                  Image.network(urlLogo +
                                      i.abbreviation.toLowerCase() +
                                      ".png"),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "${i.fullName}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Conferencia:",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18
                                          ),
                                        ),
                                        Text(
                                          "${i.conference}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Division:",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18
                                          ),
                                        ),
                                        Text(
                                          "${i.division}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => GamesView(i)));
                                  }, child: Text("Partidos")),
                                  SizedBox(height: 5,),
                                  ElevatedButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PlayersView()));
                                  }, child: Text("Jugadores")),
                                ],
                              ),
                            ),
                          ));
                    },
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }
}