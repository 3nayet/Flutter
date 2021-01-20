
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimi/models/card.dart';
import 'package:polimi/models/cardDocument.dart';

class CardServices{
  static const USER_ID = 'userId';

  String collection = "cards";
  Firestore _firestore = Firestore.instance;

  Future createCard({String id, String userId, String cardHolderName, String cardNumber, String expDate, String cvv, bool showBack}) async{
    await _firestore.collection(collection).document(userId).setData({'cards': FieldValue.arrayUnion([{
      CardModel.ID: id,
      CardModel.USER_ID: userId,
      CardModel.CARD_HOLDER_NAME: cardHolderName,
      CardModel.CARD_NUMBER:cardNumber,
      CardModel.EXP_DATE: expDate,
      CardModel.CVV_CODE: cvv,
      CardModel.SHOW_BACK: showBack
    }])}, merge:  true);
  }

  Future updateDetails(CardModel cardModel) async{
    await _firestore.collection(collection).document(cardModel.userId).updateData(cardModel.toMap());
  }

  void deleteCard(CardModel cardModel){
    _firestore.collection(collection).document(cardModel.userId).delete();
  }


  Future<List<CardModel>> getCards({String userId})async {
      DocumentSnapshot snpshot = await _firestore.collection(collection).document(userId).get();



      if( snpshot.exists) {

       // print('cards loaded are ${List<CardModel>.from(snpshot["cards"].map((e) {return new CardModel.fromMap(e);})).map((e) => e.cardNumber)}');
        return List<CardModel>.from(snpshot["cards"].map((e) {return new CardModel.fromMap(e);}));

        }else
        return [];
      }
}