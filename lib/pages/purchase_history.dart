import 'package:flutter/material.dart';
import 'package:polimi/db/purchase.dart';
import 'package:polimi/models/purchase.dart';
import 'package:polimi/providers/userProvider.dart';
import 'package:provider/provider.dart';

import '../home.dart';
import 'cart.dart';


class Purchases extends StatefulWidget {

  @override
  _PurchasesState createState() => _PurchasesState();
}

class _PurchasesState extends State<Purchases> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    PurchaseServices data = new PurchaseServices();

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
        body:

        new FutureBuilder(
        future: data.getPurchaseHistory(userId: user.user.uid) ,
        builder: (BuildContext context, AsyncSnapshot<List<PurchaseModel>> snapshot){
    return snapshot.hasData?
    ListView.builder(
    itemCount: snapshot.data.length,
    itemBuilder: (_, index){
    return  PurchaseViewer(
      purchase: snapshot.data[index],
    );
    }):Center(child: Text('No Orders History yet!',style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600,color: Colors.grey)), );
    }
    ));

  }
}

class PurchaseViewer extends StatefulWidget {
  final PurchaseModel purchase;

  PurchaseViewer(
      {
        this.purchase,
      }
      );

  @override
  _PurchaseViewerState createState() => _PurchaseViewerState();
}

class _PurchaseViewerState extends State<PurchaseViewer> {
  @override
  Widget build(BuildContext context) {


    return Container(

      height: 150,
        child: Card(


          child: Column(
            children: <Widget>[

              Expanded(

                  child: ListView.builder(itemCount : widget.purchase.products.length,itemBuilder:(BuildContext context , int index){

                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[




                          Padding(
                      padding:EdgeInsets.all(8),
                          child:
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[



                          Expanded(

                          child:Row(
                              children: <Widget>[


                          Text(widget.purchase.products[index].name, style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 16)),
                        ]
                      )

                      ),

                      Expanded(

                      child:Row(
                      children: <Widget>[

                      Text('Qty:')
                      ,
                      Text(widget.purchase.products[index].qty.toString()),
                      ]
                      )

                      ),



                      Expanded(

                      child:Row(
                      children: <Widget>[

                      Text('price:')
                      ,
                      Text(widget.purchase.products[index].price.toString(),style: TextStyle(color: Colors.red , fontSize: 16)),
                      ]
                      )

                      ),

                      ],
                      ),
                          ),


                          Row(
                            children: <Widget>[
                              Expanded(
                                child:
                                Row(

                                  children: <Widget>[

                                    Text('Date:'),
                                    Text(widget.purchase.date)
                                  ],
                                )
                                ,
                              )
                            ],
                          ),






                        ],
                      ),
                    )

                    ;



                  })

              ),


              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,


                      children: <Widget>[

                        Text('Total:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold , fontSize: 16)),
                        Text(widget.purchase.amount.toString(), style: TextStyle(color: Colors.red , fontWeight: FontWeight.bold, fontSize: 20))
                      ],
                    ),
                  )
                ],
              )

            ],
          ),


        )
    );

  }
}


