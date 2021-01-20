import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteProducts{

  var db = Firestore.instance;
  String collection = 'favorites';

  void createFavorite(String user , String product ) async {

    await db.collection(collection)
        .document(user).setData({'products': FieldValue.arrayUnion([product])}, merge:  true);


  }

   Future<List> getfavoriteProducts(String user) async {
    DocumentSnapshot qShot =  await db.collection(collection).document(user).get();
    return qShot.exists? qShot["products"] : [];

  }



}