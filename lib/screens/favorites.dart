import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_jc_2023/providers/providers.dart';
import 'package:login_jc_2023/utils/utils.dart';
import 'package:provider/provider.dart';

class FavoriteInfo {
  String name;
  String imageUrl;

  FavoriteInfo({required this.name, required this.imageUrl});
}

class MyScrollableCards extends StatefulWidget {
  const MyScrollableCards({super.key});

  @override
  _MyScrollableCardsState createState() => _MyScrollableCardsState();
}

class _MyScrollableCardsState extends State<MyScrollableCards> {
  final _auth = FirebaseAuth.instance;

   Future<List<FavoriteInfo>>? _favoriteNames;

  @override
  void initState() {
    super.initState();
    // Inicializar _auth aquí si lo consideras necesario
    _favoriteNames = getFavoriteNames();
  }

  Future<List<FavoriteInfo>> getFavoriteNames() async {
  List<FavoriteInfo> favoriteInfos = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    QuerySnapshot querySnapshot = await db
        .collection("favorites")
        .where("firebaseUserId", isEqualTo: _auth.currentUser?.uid)
        .get();

    for (var docSnapshot in querySnapshot.docs) {
      String favoriteName = docSnapshot.get('Favorite');
      
      // Obtén la información de la imagen usando el método de Provider
      final superherosProvider = Provider.of<SuperherosProvider>(context, listen: false);
      await superherosProvider.getOnCharacters(favoriteName);

      // Asegúrate de que haya al menos un superhéroe
      if (superherosProvider.character.isNotEmpty) {
        String imageUrl = superherosProvider.character[0].image.url;

        FavoriteInfo favoriteInfo = FavoriteInfo(name: favoriteName, imageUrl: imageUrl);
        favoriteInfos.add(favoriteInfo);
      }
    }

   // print("Successfully completed");
  } catch (e) {
    Utils.showSnackBar("Error completing: $e");
  }

  return favoriteInfos;
}

  void _removeFromFavorites(String favoriteName) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    await db
        .collection("favorites")
        .where("firebaseUserId", isEqualTo: _auth.currentUser?.uid)
        .where("Favorite", isEqualTo: favoriteName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // Elimina el documento que contiene el nombre favorito
        doc.reference.delete();
      });
    });

    // Vuelve a cargar la lista después de la eliminación
    setState(() {
      _favoriteNames = getFavoriteNames();
    });
    Utils.showSusSnackBar("Successfully removed from favorites");
    //print("Successfully removed from favorites");
  } catch (e) {
    print("Error removing from favorites: $e");
    Utils.showSnackBar("Error removing from favorites: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites Characters'),
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
      body:  Column(
          children: [
            Expanded(
              child:FutureBuilder<List<FavoriteInfo>>(
              future: _favoriteNames,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No hay favoritos disponibles.');
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        FavoriteInfo favoriteInfo = snapshot.data![index];

                        return ListTile(
                          title: Text(favoriteInfo.name),
                          leading: Image.network(favoriteInfo.imageUrl),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Agrega aquí la lógica para eliminar el elemento de la lista de favoritos
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Confirmación"),
                                    content: Text("¿Está seguro de que desea eliminar ${favoriteInfo.name} de sus favoritos?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Cierra el diálogo
                                        },
                                        child: Text("Cancelar"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Cierra el diálogo
                                          _removeFromFavorites(favoriteInfo.name); // Elimina el elemento de la lista de favoritos
                                        },
                                        child: Text("Eliminar"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          onTap: (){
                            Provider.of<SelectedValueNotifier>(context, listen: false).selectedValue = favoriteInfo.name;
                            Navigator.pushNamed(context, 'details');
                          } ,
                          // Puedes personalizar la apariencia y disposición según tus necesidades.
                        );
                      },
                    );
                }
              },
            )
            )
          ],
        
      ),
    );
  }
}
