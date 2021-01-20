import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimi/models/user.dart';

class UserServices{

  String collection = "users";
  Firestore _firestore = Firestore.instance;

  void createUser(UserModel user){
    _firestore.collection(collection).document(user.id).setData(user.toMap());
  }

  void updateDetails(Map<String, dynamic> values){
    _firestore.collection(collection).document(values["id"]).updateData(values);
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).document(id).get().then((doc){
        return UserModel.fromSnapshot(doc);
      }).catchError((e)=>  null);
}

