
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimi/models/cartItem.dart';
import 'package:polimi/models/purchase.dart';

class PurchaseServices{
  static const USER_ID = 'userId';

  String collection = "purchases";
  Firestore _firestore = Firestore.instance;

  void createPurchase({String id, List<CartItem> products, int amount, String userId, String date,String cardId }){
    _firestore.collection(collection).document(id).setData({
      PurchaseModel.ID:id,
      PurchaseModel.PRODUCTS:products.map((e) => e.toMap()).toList(),
      PurchaseModel.AMOUNT: amount,
      PurchaseModel.USER_ID: userId,
      PurchaseModel.DATE: DateTime.now().toString(),
      PurchaseModel.CARD_ID:cardId
    });
  }


  Future<List<PurchaseModel>> getPurchaseHistory({String userId})async{
      QuerySnapshot qsht = await _firestore.collection(collection).where(USER_ID, isEqualTo: userId).getDocuments();


      print('${qsht.documents.length} documents for purchase are found!');
      return qsht.documents.map((e) => PurchaseModel.fromSnapshot(e)).toList();

          }

}