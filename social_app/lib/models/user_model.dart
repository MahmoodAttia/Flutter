import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? name;
  String? uid;
  String? phone;
  String? email;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uid,
    this.bio,
    this.cover,
    this.image,
    this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uid': uid,
      'cover': cover,
      'bio': bio,
      'image': image,
      'isEmailVerified': isEmailVerified,
    };
  }
}
