
import 'package:flutter/material.dart';
import 'package:polimi/pages/login.dart';
import 'package:polimi/pages/splash.dart';
import 'package:polimi/providers/cartItemProvider.dart';
import 'package:polimi/providers/userProvider.dart';
import 'package:provider/provider.dart';

import 'home.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(

        MultiProvider(providers: [ChangeNotifierProvider<UserProvider>(create: (context)=> UserProvider.initialize()),
        ],
        child:

        Consumer<UserProvider>(
          builder : (context, user, child) {
            return
              ChangeNotifierProvider<CartProvider>(create: (context)=> CartProvider(userId: user.user.uid),
            child:
            MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primaryColor: Colors.deepOrange
              ),
              home: user.status == Status.Authenticated? HomePage():user.status == Status.Uninitialized?Splash():
                  LoginPage()
            ));

          })
          )


  );
}

class ScreensController extends StatefulWidget {
  @override
  _ScreensControllerState createState() => _ScreensControllerState();
}

class _ScreensControllerState extends State<ScreensController> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginPage();
      case Status.Authenticated:
        return HomePage();

      default: return LoginPage();
    }
  }
}

