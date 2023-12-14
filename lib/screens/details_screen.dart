import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_jc_2023/models/models.dart';
import 'package:login_jc_2023/utils/utils.dart';
import 'package:login_jc_2023/widgets/flipable_card.dart';
import 'package:login_jc_2023/providers/providers.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key});

  

  @override
  Widget build(BuildContext context) {
    String? selectedItem = Provider.of<SelectedValueNotifier>(context).selectedValue;
    String name = selectedItem.toString();
    String? uid =FirebaseAuth.instance.currentUser?.uid;
   
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedItem ?? 'Default Value'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomFlipCard(name),
          ),
          SizedBox(height: 16), // Espacio entre el CustomFlipCard y el FloatingActionButton
          FloatingActionButton(
            onPressed: ()  async {
  var db = FirebaseFirestore.instance.collection("favorites");

  try {
    await db.where("firebaseUserId", isEqualTo: uid)
        .where("Favorite", isEqualTo: name)
    .get().then((snapshot) async {
      // Si el documento existe, se muestra el mensaje
      if (snapshot.docs.isNotEmpty) {
        Utils.showSnackBar('Personaje añadido a favoritos anteriormente');
      } else {
        await db.add({
          "firebaseUserId": uid.toString(),
          "Favorite": name.toString(),
        });
        Utils.showSusSnackBar("Se añadió a favoritos");
      }
    });
  } on FirebaseException catch (e) {
    print(e);
    Utils.showSnackBar(e.message);
  }
},
            child:  Icon(Icons.favorite_border),
          ),
        ],
      ),
    );
  }
}
