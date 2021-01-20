import 'package:flutter/material.dart';
import 'package:polimi/db/dbProvider.dart';

import 'package:polimi/models/cartItem.dart';

class CartProvider with ChangeNotifier{

   List<CartItem> _cartItems = <CartItem>[];
   String userId;

   CartProvider({this.userId}){
     _getDBCartItems(userId);
   }


  List<CartItem> get cartItems => _cartItems;

  set cartItems(List<CartItem> value) {
    _cartItems = value;

    notifyListeners();
  }

   addCartItem(CartItem item){

    _cartItems.add(item);
    notifyListeners();
  }

  updateCartItem(CartItem item , int qty)
  {
    int index = _cartItems.indexOf(item);
    _cartItems[index].qty = qty;
    notifyListeners();
  }



  _getDBCartItems(String userId) async{

    _cartItems = await DBProvider.db.getAllCartItems(userId);
  }

  removeCartItem(CartItem item){

    _cartItems.remove(item);
    notifyListeners();
  }
  
  @override
  void dispose() {
    DBProvider.db.deleteCartItems(userId);
    DBProvider.db.insertCartItems(cartItems,userId);
    super.dispose();
  }


}