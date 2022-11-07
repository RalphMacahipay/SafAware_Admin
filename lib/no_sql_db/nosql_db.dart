import 'package:encrypt/encrypt.dart';

class UserModel {
  String? uid;
  String? password;
  String? email;
  String? fullname;
  String? gender;
  String? myNumber;
  String? contactPersonName;
  String? contactPersonNumber;

  UserModel({
    this.uid,
    this.email,
    this.fullname,
    this.gender,
    this.myNumber,
    this.contactPersonName,
  });

  //receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullname: map['fullname'],
      gender: map['gender'],
      myNumber: map['myNumber'],
      contactPersonName: map['contactPerson'],
    );
  }

  // sending data to our server
  // target: LatLng(9.740696, 118.7355555556),

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullname': fullname,
      'gender': gender,
      'myNumber': myNumber,
      'contactPerson': {
        "Name": contactPersonName,
        "contactNumber": contactPersonNumber,
      },
      "latitude": 9.740696,
      "longitude": 118.7355555556,
    };
  }
}

Encrypted encryptedData({required String data}) {
  final key = Key.fromUtf8('my 32 length key................');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));
  final encryptedData = encrypter.encrypt(data, iv: iv);
  return encryptedData;
}

String decryptedData({required String data}) {
  final key = Key.fromUtf8('my 32 length key................');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));
  final decryptedData = encrypter.decrypt64(data, iv: iv);
  return decryptedData.toString();
}


