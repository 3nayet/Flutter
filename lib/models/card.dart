import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel{
  static const ID = 'id';
  static const USER_ID = 'userId';
  static const CARD_NUMBER = 'cardNumber';
  static const EXP_DATE = 'expiryDate';
  static const CARD_HOLDER_NAME = 'cardHolderName';
  static const CVV_CODE = 'cvvCode';
  static const SHOW_BACK = 'showBackView';

  String id;
  String userId;
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  bool showBackView;

  
  CardModel.fromSnapshot(DocumentSnapshot snapshot){
    id = snapshot.data[ID];
    userId = snapshot.data[USER_ID];
    cardNumber = snapshot.data[CARD_NUMBER];
    cardHolderName = snapshot.data[CARD_HOLDER_NAME];
    expiryDate = snapshot.data[EXP_DATE];
    cvvCode = snapshot.data[CVV_CODE];
    showBackView = snapshot.data[SHOW_BACK];

  }
  CardModel({this.id , this.userId , this.showBackView , this.cvvCode  ,this.expiryDate , this.cardHolderName , this.cardNumber});

  CardModel.fromMap(Map<String, dynamic> data, {String customerId}){
    id = data[ID];
    userId = data[USER_ID];
    cardNumber = data[CARD_NUMBER];
    cardHolderName = data[CARD_HOLDER_NAME];
    expiryDate = data[EXP_DATE];
    cvvCode = data[CVV_CODE];
    showBackView = data[SHOW_BACK];;
  }

  Map<String, dynamic> toMap(){
    return {
      ID: id,
      USER_ID: userId,
      CARD_NUMBER: cardNumber,
      CARD_HOLDER_NAME: cardHolderName,
      EXP_DATE: expiryDate,
      CVV_CODE: cvvCode,
      SHOW_BACK: showBackView
    };
  }



}