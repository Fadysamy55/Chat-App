
import 'package:chat3/Constans/Const.dart';
import 'package:flutter/services.dart';


class Message {
  final String message;
  Message(this.message);

  factory Message.fromJson( jsonData) {
    return Message(jsonData[kMessage]);
  }
}