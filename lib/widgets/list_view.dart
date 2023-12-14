import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_jc_2023/providers/providers.dart';
import 'package:provider/provider.dart';

class CharacterListView extends StatelessWidget {
  final String searchValue;
    final Function(String) onCharacterSelected;
   const CharacterListView({Key? key, required this.searchValue, required this.onCharacterSelected})
      : super(key: key);
   
  
  @override
  Widget build(BuildContext context) {
    
    final List<String> characters = CharacterListProvider.characters;

     List<String> filteredCharacters = characters
        .where((character) => character.toLowerCase().contains(searchValue.toLowerCase()))
        .toList();
     
     

    return Scaffold(
      body: ListView.builder(
        itemCount: filteredCharacters.length,
        itemBuilder: (context, index) {
          // final superherosProvider = Provider.of<SuperherosProvider>(context, listen: false);
          // superherosProvider.getOnCharacters(filteredCharacters[index]);
          return ListTile(
            title: Text(filteredCharacters[index]),
            //leading: Image.network(superherosProvider.character[0].image.url),
            onTap: () {
              // Llama a la función de selección cuando se toca un personaje
              onCharacterSelected(filteredCharacters[index]);
              Provider.of<SelectedValueNotifier>(context, listen: false).selectedValue = filteredCharacters[index];
              Navigator.pushNamed(context, 'details');
            },
          );
        },
      ),
    );
  }
}

