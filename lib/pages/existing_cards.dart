import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:polimi/commons/common.dart';
import 'package:polimi/models/cartItem.dart';
import 'package:polimi/services/payment_service.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:polimi/models/card.dart';

import '../home.dart';

class ExistingCardsPage extends StatefulWidget {
  List<CartItem> products;
  List <CardModel> cards;
  String user;
  ExistingCardsPage.Inint(List<CartItem> products , String user, List<CardModel> cards){
    this.products = products;
    this.user = user;
    this.cards = cards;
  }
  ExistingCardsPage({Key key}) : super(key: key);

  @override
  ExistingCardsPageState createState() => ExistingCardsPageState();
}

class ExistingCardsPageState extends State<ExistingCardsPage> {

  payViaExistingCard(BuildContext context, CardModel card) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(
        message: 'Please wait...'
    );
    await dialog.show();
    var expiryArr = card.expiryDate.split('/');
    CreditCard stripeCard = CreditCard(
      name: card.cardHolderName,
      number: card.cardNumber,
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]),
    );
    var response = await StripeService.payViaExistingCard(
        products: widget.products,
        currency: 'USD',
        card: stripeCard,
      userId: widget.user
    );
    await dialog.hide();
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          duration: new Duration(milliseconds: 1200),
        )
    ).closed.then((_) {
     Common.changeScreenWithReplacement(context, HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose existing card'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: widget.cards.length,
          itemBuilder: (BuildContext context, int index) {
            var card = widget.cards[index];
            return InkWell(
              onTap: () {
                payViaExistingCard(context, card);
              },
              child: CreditCardWidget(
                cardNumber: widget.cards[index].cardNumber,
                expiryDate: widget.cards[index].expiryDate,
                cardHolderName: widget.cards[index].cardHolderName,
                cvvCode: widget.cards[index].cvvCode,
                showBackView: false,
              ),
            );
          },
        ),
      ),
    );
  }
}