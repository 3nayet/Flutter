import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NAME = 'userName';
  static const EMAIL = "useremail";
  static const ID = 'id';
  static const GENDER = 'gender';


  String _name;
  String _email;
  String _id;
  String _gender;

  String get gender => _gender; //  GETTERS
  String get name => _name;

  String get email => _email;

  String get id => _id;


  set name(String value) {
    _name = value;
  }

  UserModel.fromSnapshot(DocumentSnapshot snap){
    _email = snap.data[EMAIL];
    _name = snap.data[NAME];
    _id = snap.data[ID];
    _gender = snap.data[GENDER];
  }


  UserModel(this._name, this._email, this._id, this._gender,);

  set email(String value) {
    _email = value;
  }

  set id(String value) {
    _id = value;
  }

  set gender(String value) {
    _gender = value;
  }




  Map<String, dynamic> toMap() {
    return {
      ID: _id,
      NAME: _name,
      EMAIL: _email,
      GENDER: _gender,
    };
  }
}