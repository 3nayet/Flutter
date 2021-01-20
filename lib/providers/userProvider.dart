import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:polimi/db/card.dart';
import 'package:polimi/db/favoriteProducts.dart';
import 'package:polimi/db/purchase.dart';
import 'package:polimi/db/user.dart';
import 'package:polimi/models/card.dart';
import 'package:polimi/models/purchase.dart';
import 'package:polimi/models/user.dart';

enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class UserProvider with ChangeNotifier{
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Status get status => _status;
  FirebaseUser get user => _user;
  Firestore _firestore = Firestore.instance;
  UserServices _userServices = UserServices();
  CardServices _cardServices  = CardServices();
  PurchaseServices _purchaseServices = PurchaseServices();
  FavoriteProducts _favoriteProductsService = FavoriteProducts();


  UserModel _userModel;
  List<CardModel> cards = [];
  List<PurchaseModel> purchaseHistory = [];
  List _favoriteProducts= [];






  set favoriteProducts(List value) {
    _favoriteProducts = value;
  }

//  getters
  List get favoriteProducts => _favoriteProducts;
  UserModel get userModel => _userModel;




  Future<void> loadCardsAndPurchase()async{
    cards = await _cardServices.getCards(userId: user.uid);
    purchaseHistory = await _purchaseServices.getPurchaseHistory(userId: user.uid);
  }




  UserProvider.initialize():

        _auth = FirebaseAuth.instance{

    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn(String email, String password)async{
    try{
      _status = Status.Authenticating;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> handleSigninWtihGoogle() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();

      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      GoogleSignIn googleSignIn = new GoogleSignIn();

      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
          .authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final FirebaseUser firebaseUser = (await firebaseAuth
          .signInWithCredential(
          credential)).user;

      //if google user user exists

      if (firebaseUser != null) {
        _userModel = await _userServices.getUserById(firebaseUser.uid);


        //new user
        if (_userModel == null) {
          _userModel = new UserModel(
              firebaseUser.displayName, firebaseUser.email, firebaseUser.uid,
              "");
          _userServices.createUser(_userModel);


          // setting the shared preferences after creating the user in DB,  it speed up user loading next time

          //sharedPreferences.setString("userid", firebaseUser.uid);
          //sharedPreferences.setString("username", firebaseUser.displayName);
          //sharedPreferences.setString("userphoto", firebaseUser.photoUrl);
        }


        _status = Status.Authenticated;
        notifyListeners();
        return true;
      }
      else {
        return false;
      }
    }catch(e){

      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }


  Future<bool> signUp(UserModel user, String password)async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
        await _auth.createUserWithEmailAndPassword(email: user.email, password: password).then((result){
        user.id = result.user.uid;
        _userServices.createUser(user);
      });
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut()async{
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }


  Future<int> addFavorite(String user, String favorite) async{
    if(favoriteProducts.contains(favorite)){
      return 1;
    }else {
      _favoriteProductsService.createFavorite(user, favorite);
      favoriteProducts.add(favorite);
      notifyListeners();
      return 0;
    }
  }


  Future<void> _onStateChanged(FirebaseUser user) async{
    if(user == null){
      _status = Status.Unauthenticated;
    }else{
      _user = user;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(user.uid);
      print("loading data in user provider");
      favoriteProducts =  await _favoriteProductsService.getfavoriteProducts(user.uid);
      cards = await _cardServices.getCards(userId: user.uid);
      purchaseHistory = await _purchaseServices.getPurchaseHistory(userId: user.uid);

    }
    notifyListeners();
  }
}