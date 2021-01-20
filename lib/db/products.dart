import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:polimi/models/product.dart';


class ProductsDBService with ChangeNotifier {


  String collection = 'products';

  // featured products
  Future<List<Product>> getFeaturedProducts() async {
    var db = Firestore.instance;
    QuerySnapshot qShot =  await db.collection(collection).where(
        "featured", isEqualTo: true).getDocuments();

    return qShot.documents.map(
            (doc) =>
            Product(
                id: doc.data["id"],
                name: doc.data["name"],
                brand: doc.data["brand"],
                category: doc.data["category"],
                picture: doc.data["picture"],
                price: doc.data["price"].toDouble(),
                quantity: doc.data["quantity"],
                colors: doc.data["colors"],
                sizes: doc.data["sizes"],
                onSale: doc.data["sale"],
                featured: doc.data["featured"],
                similarProducts: doc.data["similarProducts"]
            )
    ).toList();
  }


  // get products for specific id
  Future<List<Product>> getProducstById( List productId) async {
    QuerySnapshot qShot = await Firestore.instance.collection(collection).where(
        'id' , whereIn: productId).getDocuments();

    return qShot.documents.map(
            (doc) =>
            Product(
                id: doc.data["id"],
                name: doc.data["name"],
                brand: doc.data["brand"],
                category: doc.data["category"],
                picture: doc.data["picture"],
                price: doc.data["price"].toDouble(),
                quantity: doc.data["quantity"],
                colors: doc.data["colors"],
                sizes: doc.data["sizes"],
                onSale: doc.data["sale"],
                featured: doc.data["featured"],
                similarProducts: doc.data["similarProducts"]
            )
    ).toList();
  }


  //products for selected category
  Future<List<Product>> getProductsOfCategory(String category) async {
    QuerySnapshot qShot = await  Firestore.instance.collection(collection).where("category", isEqualTo: category).getDocuments();

    return qShot.documents.map(
            (doc) => Product(
            id: doc.data["id"],
            name: doc.data["name"],
            brand: doc.data["brand"],
            category: doc.data["category"],
            picture: doc.data["picture"],
            price: doc.data["price"].toDouble(),
            quantity: doc.data["quantity"],
            colors: doc.data["colors"],
            sizes: doc.data["sizes"],
            onSale: doc.data["sale"],
            featured: doc.data["featured"],
                similarProducts: doc.data["similarProducts"]
        )
    ).toList();




  }


}