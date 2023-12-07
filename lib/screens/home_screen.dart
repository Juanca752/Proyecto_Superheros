import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superhero_beta/providers/providers.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:superhero_beta/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchValue = '';
  TextEditingController _searchController = TextEditingController();
  String selectedCharacter = ''; // Nueva variable para almacenar la selección

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      searchValue = _searchController.text;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    void _onCharacterSelected(String character) {
    setState(() {
      selectedCharacter = character;
    });
  }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador de personajes'),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar personajes',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                   Provider.of<SelectedValueNotifier>(context, listen: false).selectedValue = searchValue;
                    // Solo navega si se ha seleccionado un personaje
                    if (searchValue.isNotEmpty) {
                      Navigator.pushNamed(context, 'details');
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: CharacterListView(
              searchValue: searchValue,
              onCharacterSelected: (character) {
                // Al tocar un elemento del ListView, actualiza el TextField
                _searchController.text = character;
              }
            ),
            
          ),
        ],
      ),
    );
  }
}





