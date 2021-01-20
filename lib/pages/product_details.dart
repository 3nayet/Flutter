import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimi/commons/common.dart';
import 'package:polimi/home.dart';
import 'package:polimi/models/cartItem.dart';
import 'package:polimi/models/product.dart';
import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';
import 'package:polimi/components/similar_product.dart';
import 'package:polimi/providers/cartItemProvider.dart';
import 'package:polimi/providers/userProvider.dart';

import 'cart.dart';
import 'checkout.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  final String user;

  ProductDetail(
      {this.product , this.user});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  String selectedColor;
  String selectedSize ;
  int selectedQTY = 1;
  var uuid  = new Uuid();




  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);


    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
        // AppBar
        appBar: new AppBar(
            backgroundColor: Colors.red,
            title: InkWell(child: Text('Shopping App'), onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new HomePage())),),
            actions: <Widget>[

              new IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (context) {
                          return Cart();
                        }));

                  })
            ]),

        //Prduct detail body
        body: ListView(
          children: <Widget>[
            // product image

            new Container(
              height: 300,
              child: GridTile(
                child: Container(
                    color: Colors.white,
                    child: Image.network(widget.product.picture)),

                // product name and price , old price footer

                footer: new Container(
                  color: Colors.white70,
                  child: new ListTile(
                    leading: Text(
                      widget.product.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    title: new Row(
                      children: <Widget>[

                        Expanded(
                            child: Text(
                          widget.product.price.toString(),
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),


            // size , colour and quantity buttons


            new Row(

              children: <Widget>[
                //color
                Expanded(
                    child: new MaterialButton(
                  textColor: Colors.grey,
                  color: Colors.white,
                  child: new Row(
                    children: <Widget>[
                      Container(
                          child: Expanded(child:Text('Color'))
                      ),


                      new DropdownButton <String>(
                        hint: Text("select color"),
                        value: selectedColor,
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),

                        onChanged: (String newValue) {
                          setState(() {

                            selectedColor = newValue;

                          });
                        },
                        items: widget.product.colors.map<DropdownMenuItem<String>>((value) =>

                        new DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        )
                        ).toList(),
                      ),



                    ],
                  ),
                )),

                // size

                Expanded(
                    child: new MaterialButton(
                  textColor: Colors.grey,
                  color: Colors.white,
                  child: new Row(
                    children: <Widget>[
                      Expanded(child:

                      Text('Size'))
                      ,
                      DropdownButton <String>(
                        hint: Text("select size"),
                        value: selectedSize,
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        onChanged: (String newValue) {
                          setState(() {

                            selectedSize = newValue;

                          });
                        },
                        items: widget.product.sizes.map<DropdownMenuItem<String>>((value) =>

                        new DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        )
                        ).toList(),
                      ),
                    ],
                  ),
                )),

                // quantity

              ],
            ),
            Row(

              children: <Widget>[


               Expanded(
                 child: new MaterialButton(

                        onPressed: () {},
                        textColor: Colors.grey,
                        color: Colors.white,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(child: Text('Qty')),

                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[



                                  IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){
                                    setState(() {
                                      ++selectedQTY;
                                    });
                                  }),

                                  Text(selectedQTY.toString()),

                                  IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){
                                    if(selectedQTY> 1)
                                      setState(() {
                                        --selectedQTY;
                                      });
                                  }),
                                ]
                            )
                          ],
                        ),
                      ),
               )
              ],

            )

            // buy , add to cart row

            , Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // buy button
                Expanded(
                  child: MaterialButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      if(selectedColor == null || selectedSize == null){
                        Fluttertoast.showToast(msg: "Select quantity size and color");
                      }else {
                        List <CartItem> products = [];
                        products.add(
                            new CartItem(

                                id: widget.product.id,
                                name: widget.product.name,
                                price: widget.product.price,
                                picture: widget.product.picture,
                                brand: widget.product.brand,
                                category: widget.product.category,
                                qty: selectedQTY,
                                color: selectedColor,
                                size: selectedSize
                            )
                        );
                        Common.changeScreen(context, CheckOut.Init(products));
                      }


                    },
                    child: (Text('Buy')),
                  ),
                ),

                IconButton(
                  icon: new Icon(Icons.add_shopping_cart),
                  color: Colors.red,
                  onPressed: () {
                    if(selectedColor == null || selectedSize == null){
                      Fluttertoast.showToast(msg: "Select quantity size and color");
                    }else {
                      cartProvider.addCartItem(new CartItem(

                          id: widget.product.id,
                          name: widget.product.name,
                          price: widget.product.price,
                          picture: widget.product.picture,
                          brand: widget.product.brand,
                          category: widget.product.category,
                          qty: selectedQTY,
                          color: selectedColor,
                          size: selectedSize
                      ));

                      Fluttertoast.showToast(msg: "Product added to cart");
                    }

                  },
                ),

                IconButton(
                  icon: new Icon(Icons.favorite),
                  color: Colors.red,
                  onPressed: () async{

                   int responce =  await user.addFavorite(user.user.uid, widget.product.id);
                   if(responce == 0){
                     Fluttertoast.showToast(msg: "Product added to favorites");
                   }else{

                     Fluttertoast.showToast(msg: "already liked the product");
                   }

                  },
                )
              ],
            ),

            // product description

            Divider(),
            new ListTile(
              title: new Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Production Description',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              subtitle: new Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            ),

            // more description

            new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    'Brand',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text('Brand X'),
                )
              ],
            ),

            new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    'Condition',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text('Brand New'),
                )
              ],
            ),


            //similar products

            Divider(),

            Padding(padding: const EdgeInsets.all(8),
            child: Text('Similar Products'),),

            Container(
              height: 340,
              color: Colors.white,
              child: new SimilarProduct(similarProducts: widget.product.similarProducts,),
            )
          ],
        ));
  }

  Color getColor(String selectedColor) {
    switch (selectedColor) {
      case "red":
        return Colors.red;
        break;

      case "white":
        return Colors.white;
        break;

      case "black":
        return Colors.black;
        break;

      case "green":
        return Colors.green;
        break;

      case "yellow":
        return Colors.yellow;
        break;

      case "blue":
        return Colors.blue;
        break;

      case "orange":
        return Colors.orange;
        break;

      case "brown":
        return Colors.brown;
        break;

      default:
        return Colors.black;
        break;
    }

  }
}
