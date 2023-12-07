import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:superhero_beta/models/superheros.dart';

class SuperherosProvider extends ChangeNotifier {
  final String _baseUrl = 'superheroapi.com';
  final String _apiKey = '6842933985786684';

  List<Result> character = [];

  SuperherosProvider(String? name) {
    getOnCharacters(name);
  }

  getOnCharacters(String? name) async {
    if (name != null) {
      var url = Uri.https(_baseUrl, 'api/$_apiKey/search/$name');

      final response = await http.get(url);
      if (response.statusCode == 200) {
        //print(response.body);
        //final Map<String, dynamic> decodeData = json.decode(response.body);
      final superheros = Superheros.fromRawJson(response.body);
      character = superheros.results;
      //print(superheros.results[0].image.url);
      //print(character);
      notifyListeners();
      }
}
notifyListeners();
} 
}