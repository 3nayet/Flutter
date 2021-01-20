import 'package:flutter/material.dart';
import 'package:polimi/commons/common.dart';

import 'package:polimi/home.dart';

import 'package:polimi/commons/custom_Text.dart';


class Success extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomText(msg: "Purchase successful", color: Colors.red,),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(onPressed: (){Common.changeScreenWithReplacement(context, HomePage());}, icon: Icon(Icons.home), label: CustomText(msg: "Go back home")),
            ],
          )
        ],
      ),
    );
  }
}
