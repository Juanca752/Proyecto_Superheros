import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:superhero_beta/models/models.dart';
import 'package:superhero_beta/models/superheros.dart';

class SuperherosProvider extends ChangeNotifier {
  String _baseUrl = 'superheroapi.com';
  String _apiKey = '6842933985786684'; // Coloca aquí tu access token real.

  // List<Movie> onDisplayMovies = [];
  // List<Movie> popularMovies = [];
  // Charaters;
  List<Superheros> onCharaters = [];

  SuperherosProvider() {
    getOnCharacters();
  }

  getOnCharacters() async {
    var url = Uri.https(_baseUrl, 'api/$_apiKey/1');

    final response = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(response.body);

    //print(decodeData);
    //print(response.body);
    print(response.body);
    final superheros = Superheros.fromRawJson(response.body);
    //onCharaters = superheros.appearance;
    //Le comunicamos a todos los widgets que estan escuchando que se cambio la data por lo tanto se tienen que redibujar
    notifyListeners();
    // print(nowPLayingResponse.results[0].title);
  }
}
