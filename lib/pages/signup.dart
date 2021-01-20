
import 'package:flutter/material.dart';
import 'package:polimi/commons/common.dart';
import 'package:polimi/db/user.dart';
import 'package:polimi/models/user.dart';
import 'package:polimi/pages/splash.dart';

import 'package:provider/provider.dart';
import 'package:polimi/providers/userProvider.dart';

import '../home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {


  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _Key = GlobalKey<ScaffoldState>();
    TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _confirm_password= new TextEditingController();
  TextEditingController _full_name = new TextEditingController();
  String _gender;
  String groupValue = "male";

  UserServices _services = new UserServices();


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);
    return Scaffold(

      key: _Key,

       body: user.status == Status.Authenticating ? Splash() : Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.8),

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
                        padding:EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
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
                                  border: InputBorder.none),



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
                      )
                      ,

                      //full name text field

                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _full_name,


                              decoration: InputDecoration(
                                  hintText: 'Full Name',
                                  icon: Icon(Icons.person_outline),
                                  border: InputBorder.none),



                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter you Name';
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
                                }
                                else{
                                  return null;
                                }

                              },

                            ),
                          ),
                        ),
                      ),

                      //confirm password

                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _confirm_password,
                              obscureText: true,


                              decoration: InputDecoration(

                                  hintText: 'confirm password',
                                  icon: Icon(Icons.lock),
                                  border: InputBorder.none),



                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter password';
                                }else if(value.length < 6){
                                  return 'Please enter valid password';
                                }else if(_password.text != value){
                                  return 'password desnt match';
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
                       child: Container(
                         color: Colors.white.withOpacity(0.5),
                         child:new Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                                child: Row(
                                   children: <Widget>[
                                     Text('male', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),),
                                     new Radio(value: "male", groupValue: groupValue, onChanged: (e) => groupvalueChanged(e))
                                   ],
                                 )
                               ,
                             ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                                   child: Row(
                                     children: <Widget>[
                                       Text('female', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),),
                                       new Radio(value: "female", groupValue: groupValue, onChanged: (e) => groupvalueChanged(e))
                                     ],

                               ),
                             )
                           ],
                         ),
                       ),
                     ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,

                            onPressed: () async{
                                if(_formKey.currentState.validate()){
                                if(!await user.signUp(UserModel(_full_name.text,_email.text,"",groupValue)  , _password.text)){
                                _Key.currentState.showSnackBar(SnackBar(content: Text("Sign up failed")));
                                return;
                                }
                                Common.changeScreenWithReplacement(context,HomePage());
                                }


                            },
                            child: Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 20 , fontWeight: FontWeight.bold),),
                          ),
                        ),
                      )
                    ],
                  ),

                ),
                //
                //
                // sign in
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: (){Navigator.of(context).pop();},
                        child: Text(
                          'Already have an account?', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height:  80,),
                Divider(color: Colors.white,),





              ],
            ),
          ),
        ],
      ),
    );
  }

  groupvalueChanged(e) {

    setState(() {
      if(e == "male"){
        groupValue = e;
        _gender = e;
      }else{
        groupValue = e;
        _gender = e;
      }
    });
  }

  }

