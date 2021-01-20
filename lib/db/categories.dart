import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:polimi/models/category.dart';

class CategoriesDBService with ChangeNotifier {

  String collection = 'categories';


  Future<List<Category>> getCategories() async {
    QuerySnapshot qShot = await Firestore.instance.collection(collection)
        .getDocuments();

    return qShot.documents.map(
            (doc) =>
            Category(
                id: doc.data["id"],
                name: doc.data["name"],
                picture: doc.data["picture"]
            )
    ).toList();
  }
}