import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superhero_beta/providers/providers.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:superhero_beta/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchValue = '';

  // Future<List<String>> _fetchSuggestions(String searchValue) async {
  //   await Future.delayed(const Duration(milliseconds: 750));

  //   return _suggestions.where((element) {
  //     return element.toLowerCase().contains(searchValue.toLowerCase());
  //   }).toList();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('Personajes'),
        onSearch: (value) {
          Provider.of<SelectedValueNotifier>(context, listen: false)
              .selectedValue = value;
          Navigator.pushNamed(context, 'details');
        },
        // asyncSuggestions: (value) async => await _fetchSuggestions(value),
      ),
      body: CharacterListView(),
    );
  }
}
