import 'package:flutter/material.dart';
import 'package:polimi/components/featutedCard.dart';
import 'package:polimi/components/loading.dart';
import 'package:polimi/db/products.dart';
import 'package:polimi/models/product.dart';
import 'package:polimi/providers/userProvider.dart';
import 'package:provider/provider.dart';

import '../home.dart';
import 'cart.dart';

class FavoriteProducts extends StatefulWidget {
  @override
  _FavoriteProductsState createState() => _FavoriteProductsState();
}

class _FavoriteProductsState extends State<FavoriteProducts> {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<UserProvider>(context);
    final ProductsDBService data = new ProductsDBService();
    return Scaffold(
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

      body: Column(
        children: <Widget>[
          Expanded(
              child: SizedBox(
                height: 420,
                child:app.favoriteProducts.isEmpty? Center(child: Text('Your favorites list is Empty.' , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600,color: Colors.grey),)):
                new FutureBuilder(
                    future: data.getProducstById(app.favoriteProducts) ,
                    builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot){

                      print('favorite product form favorite page size is ${app.favoriteProducts}');
                      return   snapshot.hasData?  GridView.builder(
                          itemCount: snapshot.data.length,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return FeaturedCard(
                              product: snapshot.data[index],
                            );
                          }):Loading();

                    })

                ,

              )

          )
        ],
      ),
    );
  }
}
