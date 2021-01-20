import 'package:flutter/material.dart';
import 'package:polimi/db/categories.dart';
import 'package:polimi/db/products.dart';
import 'package:polimi/models/category.dart';
import 'package:provider/provider.dart';
import 'package:polimi/pages/productsforCategory.dart';

import 'loading.dart';


class  HorizentalCategoryList extends StatelessWidget {



  CategoriesDBService _service = new CategoriesDBService();
  @override
  Widget build(BuildContext context) {
    return Container(
     height: 100,
      child:

      FutureBuilder(
        future: _service.getCategories() ,
    builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot){
    return snapshot.hasData?
    ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data.length,
    itemBuilder: (_, index) {
    return InkWell(
    onTap: (){},
    child: CategoryViewer(
    category: snapshot.data[index],
    )

    );
    }):Loading();
    })


    );
  }
}

class CategoryViewer extends StatelessWidget {


    final Category category;

    CategoryViewer({
    this.category
});
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ChangeNotifierProvider<ProductsDBService>(
        create: (context) => ProductsDBService(),
        child: InkWell(
          onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (context){return new
          ProductsforCategory(category: category.id ,);})),
          child: Container(
            width: 100,
            child: ListTile(
            title: Image.network(category.picture , width:  100 , height:  80,),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(category.name),
            )
    ),
          ),
        ),
      ),);
  }
}

