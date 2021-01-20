import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:polimi/components/featutedCard.dart';
import 'package:polimi/db/products.dart';
import 'package:polimi/models/product.dart';
import 'package:polimi/components/loading.dart';
import 'package:provider/provider.dart';

import '../home.dart';

class ProductsforCategory extends StatefulWidget {

  final String category;

  ProductsforCategory({this.category});


  @override
  _ProductsforCategoryState createState() => _ProductsforCategoryState();
}

class _ProductsforCategoryState extends State<ProductsforCategory> {
  @override
  Widget build(BuildContext context) {
    final ProductsDBService data = new ProductsDBService();
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.red,
          title: InkWell(child: Text('Shopping App'), onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new HomePage())),),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            new IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {})
          ]),

      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
    height: 420,
    child:
    new FutureBuilder(
        future: data.getProductsOfCategory(widget.category) ,
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot){

         return   snapshot.data == null  ||snapshot.data.isEmpty? Loading() :  GridView.builder(
              itemCount: snapshot.data.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return FeaturedCard(
                  product: snapshot.data[index],
                );
              });

    })
    
   ,

    )

          )
        ],
      ),
    );
  }
}
