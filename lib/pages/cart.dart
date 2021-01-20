import 'package:flutter/material.dart';
import 'package:polimi/commons/common.dart';
import 'package:polimi/components/cart_products.dart';
import 'package:polimi/models/cartItem.dart';
import 'package:polimi/providers/cartItemProvider.dart';
import 'package:provider/provider.dart';

import 'checkout.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  double total = 0;
  @override
  Widget build(BuildContext context) {
    var cartProvider  = Provider.of<CartProvider>(context);
    if (cartProvider.cartItems.isNotEmpty && cartProvider.cartItems != null)
      total = 0;
      cartProvider.cartItems.forEach((element) {
        total += element.price* element.qty;
      });
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
          backgroundColor: Colors.red,
          title: Text('Cart'),
          actions: <Widget>[

          ]


      ),

      body:
      Cart_Products(),

      bottomNavigationBar:  Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text('Total'),
                subtitle: Text('\$${total}'),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: (){
                 if (cartProvider.cartItems.isEmpty)
                 {
                   _displaySnackBar(context , 'Your cart is Empty');
                 }
                  else {

                    List<CartItem> cart = cartProvider.cartItems;
                    Common.changeScreenWithReplacement(context, CheckOut.Init(cartProvider.cartItems));
                   }
                },
                child: Text('check out'),
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
  _displaySnackBar(BuildContext context,String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
