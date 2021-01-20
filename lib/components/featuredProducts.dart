import 'package:flutter/material.dart';
import 'package:polimi/components/loading.dart';
import 'package:polimi/db/products.dart';
import 'package:polimi/models/product.dart';
import 'featutedCard.dart';


class FeaturedProducts extends StatefulWidget {
  @override
  _FeaturedProductsState createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {

  ProductsDBService _service = new ProductsDBService();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 230,
        child:
        FutureBuilder(
        future: _service.getFeaturedProducts() ,
    builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot){
    return snapshot.hasData?
       ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.length,
            itemBuilder: (_, index) {
              return FeaturedCard(
                product: snapshot.data[index],
              );
            }): Loading();
        }));
    }
  }

