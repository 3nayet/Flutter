import 'package:flutter/material.dart';
import 'package:polimi/db/products.dart';
import 'package:polimi/models/product.dart';


import 'package:polimi/pages/product_details.dart';
import 'package:polimi/components/loading.dart';
import 'package:provider/provider.dart';
class SimilarProduct extends StatefulWidget {
  List similarProducts;


  SimilarProduct({this.similarProducts});

  @override
  _SimilarProductState createState() => _SimilarProductState();
}

class _SimilarProductState extends State<SimilarProduct> {
  ProductsDBService _service = new ProductsDBService();


@override
Widget build(BuildContext context) {
  return
 SizedBox(
      height: 320,
      child: new FutureBuilder(
          future: _service.getProducstById(widget.similarProducts) ,
          builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot){
            return snapshot.hasData?
              GridView.builder(
                  itemCount: widget.similarProducts.length,

                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return Similar_Product(
                      product: snapshot.data[index],
                    );
                  }) : Loading();

          })


     ,
    );
}
}

class Similar_Product extends StatelessWidget {
  final Product product;

  Similar_Product({this.product});

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
