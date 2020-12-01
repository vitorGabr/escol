import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserModel {
  String displayName;
  DocumentReference reference;
  String email;
  String phoneNumber;
  String photoURL;
  String providerId;
  String uid;
  int typeUser;
  DateTime data;

  FirebaseUserModel(
      {this.displayName,
      this.email,
      this.phoneNumber,
      this.reference,
      this.photoURL,
      this.providerId,
      this.uid,
      this.typeUser,
      this.data});

  factory FirebaseUserModel.fromJson(Map<String, dynamic> json,
          {bool dateToString = false}) =>
      FirebaseUserModel(
          displayName: json['displayName'] == null ? null : json['displayName'],
          email: json['email'] == null ? null : json['email'],
          phoneNumber: json['phoneNumber'] == null ? null : json['phoneNumber'],
          reference: json['reference'] == null ? null : json['reference'],
          photoURL: json['photoURL'] == null ? null : json['photoURL'],
          providerId: json['providerId'] == null ? null : json['providerId'],
          uid: json['uid'] == null ? null : json['uid'],
          typeUser: json['typeUser'] == null ? null : json['typeUser'],
          data: json['date'] == null
              ? null
              : dateToString
                  ? DateTime.tryParse(json['date'])
                  : (json['date'] as Timestamp).toDate());

  Map<String, dynamic> toJson({bool dateToString = false}) => {
        'displayName': displayName == null ? null : displayName,
        'email': email == null ? null : email,
        'phoneNumber': phoneNumber == null ? null : phoneNumber,
        'reference': reference == null ? null : reference,
        'photoURL': photoURL == null ? null : photoURL,
        'providerId': providerId == null ? null : providerId,
        'uid': uid == null ? null : uid,
        'date': data == null
            ? null
            : dateToString
                ? data.toIso8601String()
                : data,
        'typeUser': typeUser == null ? null : typeUser
      };
}
