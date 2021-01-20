import 'package:flutter/material.dart';

import 'package:polimi/components/HorizentalCategoryList.dart';
import 'package:polimi/components/featuredProducts.dart';
import 'package:polimi/pages/credit_card.dart';

import 'package:polimi/pages/favorite_products.dart';
import 'package:polimi/pages/cart.dart';
import 'package:polimi/pages/login.dart';
import 'package:polimi/pages/manage_card.dart';
import 'package:polimi/pages/purchase_history.dart';
import 'package:polimi/services/payment_service.dart';

import 'package:provider/provider.dart';
import 'package:polimi/providers/userProvider.dart';

import 'commons/common.dart';
import 'components/recent_bought.dart';




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeService.init();
  }
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);


    return Scaffold(
        appBar: new AppBar(
            backgroundColor: Colors.red,
            title: Text('Shopping App'),
            actions: <Widget>[
              new IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.white,),
                  onPressed: () =>
                      Navigator.of(context).push(
                          new MaterialPageRoute(builder: (context) {
                            return Cart();
                          })))
            ]


        ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              //header
              new  UserAccountsDrawerHeader(accountName: user.userModel == null? Text(""):Text(user.userModel.name),
                accountEmail: user.userModel == null? Text(""):Text(user.userModel.email),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white,)),
                ),
                decoration: new BoxDecoration(
                    color: Colors.red
                ),)
              ,
              //body


              InkWell(
                onTap: () {Common.changeScreen(context, HomePage());},
                child: ListTile(
                  title: Text('Home Page'),
                  leading: new Icon(Icons.home, color: Colors.red,),
                ),
              ),

              InkWell(
                onTap: () {
                  Common.changeScreen(context, CreditCard(title: "Add card",));
                },
                child: ListTile(
                  title: Text('Add credit Card'),
                  leading: new Icon(Icons.add, color: Colors.red,),
                ),
              ),


              InkWell(
                onTap: () {
                  Common.changeScreen(context, Purchases());

                },
                child: ListTile(
                  title: Text('My Orders'),
                  leading: new Icon(Icons.shopping_basket, color: Colors.red,),
                ),
              ),


              InkWell(
                onTap: () =>
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (context) {
                          return Cart();
                        })),
                child: ListTile(
                  title: Text('Cart'),
                  leading: new Icon(Icons.shopping_cart, color: Colors.red,),
                ),
              ),


              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) {
                        return FavoriteProducts();
                      }));

                },
                child: ListTile(
                  title: Text('Favorites'),
                  leading: new Icon(Icons.favorite, color: Colors.red,),
                ),
              ),

              Divider(),

              InkWell(
                onTap: () {

                  Common.changeScreen(context, ManagaCardsScreen());
                },
                child: ListTile(
                  title: Text('Manage credit cards'),
                  leading: new Icon(Icons.credit_card, color: Colors.red,),
                ),
              ),

              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('About'),
                  leading: new Icon(Icons.help, color: Colors.red,),
                ),
              ),

              InkWell(
                onTap: () {
                  user.signOut();
                  Common.changeScreenWithReplacement(context, LoginPage());
                },
                child: ListTile(
                  title: Text('Sign out'),
                  leading: new Icon(Icons.exit_to_app, color: Colors.red,),
                ),
              ),


            ],
          ),
        ),


        body: new Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(8.00),
              child: Text('featured products'),),

            // featured products
            Expanded(child: FeaturedProducts(),),


            // categories list horizental

            Padding(padding: const EdgeInsets.all(8.00),
              child: Text('Categories'),)

            ,
            Expanded(child:HorizentalCategoryList() ,)
            ,

            Padding(padding: const EdgeInsets.all(18.00),
              child: Text('Recent bought Products'),),

            Expanded(child: RecenetProducts(),)

            ,


          ],
        ),
      );
  }
}


