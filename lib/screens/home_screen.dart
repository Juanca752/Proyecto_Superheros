import 'package:flutter/material.dart';
import 'package:login_jc_2023/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:login_jc_2023/providers/providers.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:login_jc_2023/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchValue = '';
  TextEditingController _searchController = TextEditingController();
  String selectedCharacter = ''; // Nueva variable para almacenar la selección
  List<String>characters =[];
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
   bool _isCharacterAvailable(String character, List<String> availableCharacters) {
    return availableCharacters.contains(character);
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
          title: const Text('Characters'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.green.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      drawer: const DrawerProfile(),
      body: Column(
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Buscar personajes',
                    ),
                  ),
                ),
                IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
            if (searchValue.isNotEmpty) {
              // Verificar si el personaje está disponible
              
              bool isAvailable = _isCharacterAvailable(searchValue, CharacterListProvider.characters);

              if (isAvailable) {
                //Provider.of<SelectedValueNotifier>(context, listen: false).selectedValue = searchValue;
                //Navigator.pushNamed(context, 'details');
              } else {
                Utils.showSnackBar('Personaje no disponible');
              }
            }
          },
          )
              ],
            ),
          ),
          Expanded(
            child: CharacterListView(
              searchValue: searchValue,
              onCharacterSelected: (character) {
                
                // Al tocar un elemento del ListView, actualiza el TextField
               // _searchController.text = character;
                 _onCharacterSelected(character);
              }
            ),
            
          ),
        ],
      ),
    );
  }
}





