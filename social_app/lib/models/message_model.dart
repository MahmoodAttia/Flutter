import 'package:firebase_auth/firebase_auth.dart';

class MessageModel {
  String? text;
  String? recieverId;
  String? senderId;
  String? dataTime;
  String? image;

  MessageModel(
      {this.dataTime, this.text, this.senderId, this.recieverId, this.image});

  MessageModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    recieverId = json['recieverId'];
    senderId = json['senderId'];
    dataTime = json['dataTime'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'recieverId': recieverId,
      'dataTime': dataTime,
      'image': image,
    };
  }
}
