import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/utils.dart';

class FavoriteService {
  final String? firebaseUserId;
  final String? favoriteId;

  FavoriteService({
    this.firebaseUserId,
    this.favoriteId,
  });

  static Future<void> addFavorite(FavoriteService favoriteService) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final favoritesCollection = FirebaseFirestore.instance.collection('favorites');

    try {
      await favoritesCollection
          .doc(currentUser?.uid) // Usamos el UID del usuario como ID del documento
          .collection('user_favorites')
          .doc(favoriteService.favoriteId) // Usamos el ID del favorito como ID del subdocumento
          .set({
            'timestamp': FieldValue.serverTimestamp(),
            // Otros campos relevantes para tu aplicación

          });
          Utils.showSusSnackBar('Se agrego exitosamente');
    } catch (e) {
      print("Error adding favorite: $e");
    }
  }



  // Eliminar favorito
  static Future<void> removeFavorite(FavoriteService favoriteService) async {
    final userCollection = FirebaseFirestore.instance.collection('favorites');

    try {
      final querySnapshot = await userCollection
          .where('firebaseUserId', isEqualTo: favoriteService.firebaseUserId)
          .where('favoriteId', isEqualTo: favoriteService.favoriteId)
          .get();

      for (final doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  // Obtener lista de favoritos para un usuario
  static Future<List<FavoriteService>> getFavorites(
      String firebaseUserId) async {
    final userCollection = FirebaseFirestore.instance.collection('favorites');

    try {
      final querySnapshot = await userCollection
          .where('firebaseUserId', isEqualTo: firebaseUserId)
          .get();

      return querySnapshot.docs.map((doc) {
        return FavoriteService(
          firebaseUserId: doc['firebaseUserId'],
          favoriteId: doc['favoriteId'],
        );
      }).toList();
    } catch (e) {
      Utils.showSnackBar(e.toString());
      return [];
    }
  }
}

