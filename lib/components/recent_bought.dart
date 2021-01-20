import 'package:flutter/material.dart';
import 'package:polimi/db/products.dart';
import 'package:polimi/models/product.dart';
import 'package:polimi/pages/product_details.dart';
import 'package:polimi/providers/userProvider.dart';
import 'package:provider/provider.dart';
import "dart:collection";

class RecenetProducts extends StatefulWidget {
  @override
  _RecenetProductsState createState() => _RecenetProductsState();
}

class _RecenetProductsState extends State<RecenetProducts> {
  @override
  Widget build(BuildContext context) {

    var user = Provider.of<UserProvider>(context);
    ProductsDBService productsDBService = new ProductsDBService();
    List<String> uniqueProducts = <String>[];
     user.purchaseHistory.forEach((purchase) => purchase.products.forEach((product) => uniqueProducts.add(product.id)));


     return
      new FutureBuilder(
          future: productsDBService.getProducstById(LinkedHashSet<String>.from(uniqueProducts).toList()) ,
          builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            return snapshot.hasData ?
            SizedBox(
                height: 360,
                child:
                GridView.builder(
                    itemCount: snapshot.data.length, gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(product: snapshot.data[index],);
                    })
            ) : Center(child:Text('No recent Products bought',style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600,color: Colors.grey),));
          }

      );
  }

}
class ProductCard extends StatelessWidget {

  final Product product;

  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      //child: Hero(
      //tag: product.name,
      child: Material(
        child: InkWell(
          onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(
              builder: (context)=> new ProductDetail(product: product,
              )
          )),
          child: GridTile(
            footer: Container(
              color: Colors.white70,
              child: ListTile(
                leading: Text(product.name),
                title: Text(
                  "\$${product.price}",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w900,
                      fontSize: 14),
                ),
              ),
            ),
            child: Image.network(product.picture,
              fit: BoxFit.cover,),
          ),
        ),
      ),
      // ),
    );
  }
}

