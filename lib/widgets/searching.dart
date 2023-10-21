import 'package:flutter/material.dart';
import 'package:easy_search_bar/easy_search_bar.dart';

class Searching extends StatefulWidget {
  const Searching({Key? key}) : super(key: key);

  @override
  State<Searching> createState() => _Searching();
}

class _Searching extends State<Searching> {
  String searchValue = '';
  final List<String> _suggestions = [
    'Batman',
    'A-Bomb',
    'Algeria',
    'Australia',
    'Brazil',
    'German',
    'Madagascar',
    'Mozambique',
    'Portugal',
    'Zambia'
  ];

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Example',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: Scaffold(
            appBar: EasySearchBar(
                title: const Text('Example'),
                onSearch: (value) => setState(() => searchValue = value),
                actions: [
                  IconButton(icon: const Icon(Icons.person), onPressed: () {})
                ],
                asyncSuggestions: (value) async =>
                    await _fetchSuggestions(value)),
            body: Center(child: Text('Value: $searchValue'))));
  }
}
