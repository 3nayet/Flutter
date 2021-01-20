import 'package:flutter/material.dart';
import 'package:polimi/providers/userProvider.dart';
import 'package:provider/provider.dart';

class ManagaCardsScreen extends StatefulWidget {
  @override
  _ManagaCardsScreenState createState() => _ManagaCardsScreenState();
}

class _ManagaCardsScreenState extends State<ManagaCardsScreen> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.red),
          title: Text(
            "Cards",
            style: TextStyle(color: Colors.red),
          ),
        ),
        body: ListView.builder(
            itemCount: user.cards.length,
            itemBuilder: (_, index){
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            offset: Offset(2, 1),
                            blurRadius: 5
                        )
                      ]
                  ),
                  child: ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text(user.cards[index].cardNumber ),
                    subtitle: Text(user.cards[index].expiryDate),
                    onTap: (){

                    },
                  ),
                ),
              );

            })
    );
  }
}
