import 'package:cloud_firestore/cloud_firestore.dart';

import 'cartItem.dart';

class PurchaseModel{
  static const ID = 'id';
  static const PRODUCTS= 'products';
  static const AMOUNT = 'amount';
  static const USER_ID = 'userId';
  static const DATE = 'date';
  static const CARD_ID = "cardId";

  String _id;
  List<CartItem> _products;
  String _userId;
  String _date;
  String _cardId;
  int _amount;

//  getters
  String get id => _id;
  List<CartItem> get products => _products;
  String get userId => _userId;
  String get date => _date;
  String get cardId => _cardId;
  int get amount => _amount;

  PurchaseModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _products = snapshot[PRODUCTS].map<CartItem>((item){
      return CartItem.fromMap(item);
    }).toList();
    _userId = snapshot.data[USER_ID];
    _date = snapshot.data[DATE];
    _cardId = snapshot.data[CARD_ID];
    _amount = snapshot.data[AMOUNT];
  }

  PurchaseModel.fromMap(Map data){
    _id = data[ID];
    _products = data[PRODUCTS].map<CartItem>((item){
      return CartItem.fromMap(item);
    }).toList();
    _userId = data[USER_ID];
    _date = data[DATE];
    _cardId = data[CARD_ID];
    _amount = data[AMOUNT];
  }

  Map<String, dynamic> toMap(){
    List<Map> products = [];
    _products.forEach((element) {
      products.add(element.toMap());
    });
    return {
      ID: _id,
      PRODUCTS:products,
      USER_ID: _userId,
      DATE: _date,
      CARD_ID: _cardId,
      AMOUNT: _amount
    };
  }








}