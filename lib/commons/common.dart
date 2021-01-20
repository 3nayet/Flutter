

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Common{

  static void  changeScreen (BuildContext context,  Widget widget){

    Navigator.push(context, new MaterialPageRoute(builder: (context)  => widget));
  }

  static void changeScreenWithReplacement (BuildContext context,  Widget widget){

    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)  => widget));
  }

}