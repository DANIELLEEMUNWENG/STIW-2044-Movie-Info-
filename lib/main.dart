import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Movie Info'),
    ); 
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchController = TextEditingController();
  String desc = "";
  var title = "";
  String year = "";
  String genre = "";
  String plot = "";
  var poster = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  _searchmovie(searchController.text);
                },
                child: const Text("Search movie")),
            Text(desc,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  void search() {
    setState(() {
      _searchmovie(searchController.text);
    });
  }

  void _searchmovie(String search) async {
    var apiid = "72834e27";
    var url = Uri.parse('http://www.omdbapi.com/?i=tt3896198&apikey=72834e27');
    var response = await http.get(url);
    var rescode = response.statusCode;
    print(response.body);
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      //print(response.body);
      title = parsedJson['Title'];
      year = parsedJson['Year'];
      genre = parsedJson['Genre'];
      plot = parsedJson['Plot'];
      poster = parsedJson['Poster'];
      setState(() {
        // (response.body);
        desc =
            "The name of movie is $title and year of this movie is $year and genre is $genre the plot are $plot. This is the poster of the movie $poster";
      });
    } else {
      setState(() {
        desc = "No record";
      });
    }
  }
}
