import 'package:flutter/material.dart';
import 'package:polimi/commons/common.dart';
import 'package:polimi/home.dart';
import 'package:polimi/models/card.dart';
import 'package:polimi/models/cartItem.dart';
import 'package:polimi/models/stripe_transaction_response.dart';
import 'package:polimi/pages/existing_cards.dart';
import 'package:polimi/providers/cartItemProvider.dart';
import 'package:polimi/providers/userProvider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:polimi/services/payment_service.dart';
import 'package:provider/provider.dart';

import 'credit_card.dart';

class CheckOut extends StatefulWidget {
   List<CartItem> products;
   List<CardModel> cards;

   String userId;



  CheckOut.Init(List<CartItem> items){
    this.products = items;
  }
  CheckOut({Key key}) : super(key: key);

  @override
  CheckOutState createState() => CheckOutState();
}

class CheckOutState extends State<CheckOut> {

  onItemPress(BuildContext context, int index) async {

    switch(index) {
      case 0:
        payViaNewCard(context , widget.userId);
        break;
      case 1:
        //Navigator.pushNamed(context, '/existing-cards');
        payViaExistingCard(context);
        break;
    }
  }

  payViaNewCard(BuildContext context, String userId) async {

    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(
        message: 'Please wait...'
    );
    await dialog.show();
    var response = await StripeService.payWithNewCard(
        products: widget.products,
        currency: 'USD',
      userId: userId
    );
    await dialog.hide();
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          duration: new Duration(milliseconds: response.success == true ? 1200 : 3000),
        )
    ).closed.then((_) {
      Common.changeScreenWithReplacement(context, HomePage());
    });;
  }

  payViaExistingCard(BuildContext context) async {
    Common.changeScreen(context , ExistingCardsPage.Inint(widget.products , widget.userId ,widget.cards));
  }


  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);

    widget.userId = user.user.uid;
    widget.cards = user.cards;

    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              Icon icon;
              Text text;

              switch(index) {
                case 0:
                  icon = Icon(Icons.add_circle, color: theme.primaryColor);
                  text = Text('Pay via new card');
                  break;
                case 1:
                  icon = Icon(Icons.credit_card, color: theme.primaryColor);
                  text = Text('Pay via existing card');
                  break;
              }

              return InkWell(
                onTap: () {
                  onItemPress(context, index);
                },
                child: ListTile(
                  title: text,
                  leading: icon,
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: theme.primaryColor,
            ),
            itemCount: 2
        ),
      ),
    );;
  }
}