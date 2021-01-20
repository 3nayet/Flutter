import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polimi/models/cartItem.dart';
import 'package:polimi/providers/cartItemProvider.dart';
import 'package:provider/provider.dart';

class Cart_Products extends StatefulWidget {
  @override
  _Cart_ProductsState createState() => _Cart_ProductsState();
}

class _Cart_ProductsState extends State<Cart_Products> {

  @override
  Widget build(BuildContext context) {

    return Consumer<CartProvider>(builder:
    ( context,  provider,  child)
    {
    return  provider.cartItems.isNotEmpty && provider.cartItems != null ?   ListView.builder(
        itemCount: provider.cartItems.length,
        itemBuilder:(BuildContext context, int index) {
          return Cart_Product(
            cartItem: provider.cartItems[index],
          );
        }) : Center(child: Text("Cart is Empty" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600,color: Colors.grey),));
  });
  }

}

class Cart_Product extends StatefulWidget {
  final CartItem cartItem;

  Cart_Product(
  {
   this.cartItem,
  }
      );

  @override
  _Cart_ProductState createState() => _Cart_ProductState();
}

class _Cart_ProductState extends State<Cart_Product> {
  @override
  Widget build(BuildContext context) {


    var  cardProvider = Provider.of<CartProvider>(context);

    return Container(

      child: Card(

        child: Row(
          children: <Widget>[
            Container(
              height: 80,
              width: 80,
              child: Image.network(widget.cartItem.picture),
            ),

            Expanded(

              child: Column(
                children: <Widget>[

                  Text(widget.cartItem.name),



              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Text('Size:'),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(widget.cartItem.size),
                        ),

                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Text('Color:'),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(widget.cartItem.color),

                        ),
                      ],
                    ),
                  ),



                ],
              ),

              Container(
                alignment: Alignment.topLeft,
                child: Text('\$${widget.cartItem.price}', style: TextStyle(color: Colors.red , fontSize: 16),),
              ),
              ]



            )),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[



                      IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){
                        cardProvider.updateCartItem(widget.cartItem, widget.cartItem.qty+1);
                      }),

                      Text(widget.cartItem.qty.toString()),

                      IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){

                        if(widget.cartItem.qty > 0)
                          cardProvider.updateCartItem(widget.cartItem, widget.cartItem.qty-1);


                      }),
                    ]
              )),

                ],
              ),
            )
        );

  }
}

