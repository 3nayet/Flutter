import 'package:flutter/material.dart';
import 'package:polimi/commons/common.dart';
import 'package:polimi/home.dart';
import 'package:polimi/pages/signup.dart';
import 'package:polimi/pages/splash.dart';


import 'package:provider/provider.dart';
import 'package:polimi/providers/userProvider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isLoading = false;
  bool isSignedIn = false;

  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _password = new TextEditingController();
  TextEditingController _email = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // uncomment this comment
    //isLoggedin();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);

    return Scaffold(



      key: _key,
      body: user.status == Status.Authenticating ? Splash() : Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.4),
            alignment: Alignment.center,

            child: Image.asset('images/background2.webp', fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,),
          ),
          Center(

            child: ListView(

              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 80,),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                     borderRadius: new BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _email,



                              decoration: InputDecoration(
                                hintText: 'Email address',
                                icon: Icon(Icons.email),
                                  border: InputBorder.none,
                              ),


                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }else{
                                  Pattern pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(value))
                                    return 'Please make sure your email address is valid';
                                  else
                                    return null;
                                }

                              },

                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _password,
                              obscureText: true,


                              decoration: InputDecoration(
                                  hintText: 'password',
                                  icon: Icon(Icons.lock),
                                  border: InputBorder.none),


                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter password';
                                }else if(value.length < 6){
                                  return 'Please enter valid password';
                                }else{
                                  return null;
                                }

                              },

                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,

                            onPressed: () async{
                              if(_formKey.currentState.validate()){
                                if(!await user.signIn(_email.text, _password.text)){
                                  _key.currentState.showSnackBar(SnackBar(content: Text("Sign in failed")));
                                return ;}
                                else{
                                 Common.changeScreenWithReplacement(context, HomePage());
                                }

                              }
                            },
                            child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 20 , fontWeight: FontWeight.bold),),
                          ),
                        ),
                      )
                    ],
                  ),

                ),
            //
                //
                // forget password
                Padding(
                  padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: (){},
                        child: Text(
                          'Forget Password?', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                        ),
                      )
                    ],
                  ),
                ),

              //Sign up
                Padding(
                  padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Don\'t have an account?' , style: TextStyle(fontWeight: FontWeight.w800 , fontSize: 16),),
                      InkWell(
                        onTap: (){Navigator.of(context).push( new MaterialPageRoute(builder: (context) => new SignUp()));},
                        child: Text(
                          'Signup' , style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold  , fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              SizedBox(height: 80,),
                Divider(color: Colors.white,),



                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          color: Colors.red,
                          onPressed: () async {
                            if( ! await user.handleSigninWtihGoogle()){
                            _key.currentState.showSnackBar(SnackBar(content: Text("Sign in failed")));
                            return ;}
                            else{
                              Common.changeScreenWithReplacement(context, HomePage());
                            }
                          },
                          child: Text(
                            'Sign/signup in with Google',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),



              ],
            ),
          ),
        ],
      ),
    );
  }

  // sign in handler


}
